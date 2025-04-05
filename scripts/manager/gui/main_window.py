#!/usr/bin/env python
import json
import os, re, json, subprocess, threading, gi
gi.require_version('Gtk', '3.0')
from gi.repository import Gtk, GLib, Gdk
from utils.fs import get_directory_tree
from gui.build_dialog import BuildAdvancedDialog

# Charger définitions externes
with open("scripts/manager/config/options.json") as f:
    GLOBAL_OPTIONS_DEF = json.load(f)

_PROGRESS_RE = re.compile(r'\[\s*(\d+)\s*/\s*(\d+)\s*\]')

def traverse(store, parent=None, path=""):
    result = []
    child = store.iter_children(parent)
    while child:
        name = store.get_value(child,1)
        if store.get_value(child,0):
            full = name if not path else f"{path}/{name}"
            result.append(full)
        result += traverse(store, child, name if not path else f"{path}/{name}")
        child = store.iter_next(child)
    return result

def is_build_done():
    return os.path.exists("build/build.ninja")

def run_cmd(cmd, parse_prog, mainwin, log_cb):
    proc = subprocess.Popen(cmd, stdout=subprocess.PIPE,
                            stderr=subprocess.STDOUT, text=True)
    mainwin.processes.append(proc)
    for line in proc.stdout:
        GLib.idle_add(log_cb, line)
        if parse_prog and not mainwin.stop_event.is_set():
            m = _PROGRESS_RE.search(line)
            if m:
                cur, tot = map(int, m.groups())
                frac = cur/tot if tot else 0
                GLib.idle_add(mainwin.update_progress, frac, f"{cur}/{tot}")
        if mainwin.stop_event.is_set():
            proc.kill()
            break
    proc.wait()
    if proc.returncode:
        raise subprocess.CalledProcessError(proc.returncode, cmd)

class LoadingDialog(Gtk.Dialog):
    def __init__(self, parent, message):
        super().__init__(title=message, transient_for=parent, flags=0)
        self.set_default_size(300, 120)
        self.processes = []
        self.stop_event = threading.Event()
        box = self.get_content_area()
        self.progressbar = Gtk.ProgressBar(show_text=True)
        self.progressbar.set_size_request(-1, 24)
        self.progressbar.set_margin_bottom(10)
        box.add(self.progressbar)
        btn = Gtk.Button(label="Cancel")
        btn.connect("clicked", lambda b: self.stop_event.set())
        box.add(btn)
        self.show_all()
    def update(self, frac, txt):
        self.progressbar.set_fraction(frac)
        self.progressbar.set_text(txt)
    def set_complete(self):
        self.progressbar.set_fraction(1.0)
        self.progressbar.set_text("100%")
        self.destroy()

# CSS minimal
css = b"""
window { background: #f0f0f0; }
button { font-size: 14px; }
progressbar { min-height: 24px; }
"""
cp = Gtk.CssProvider()
cp.load_from_data(css)
Gtk.StyleContext.add_provider_for_screen(
    Gdk.Screen.get_default(), cp, Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION
)

class MainWindow(Gtk.Window):
    def __init__(self):
        super().__init__(title="Manager")
        self.set_default_size(800, 600)
        self.connect("destroy", Gtk.main_quit)
        self.processes = []
        self.stop_event = threading.Event()

        vbox = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=5)
        self.add(vbox)

        btn_box = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL, spacing=5)
        vbox.pack_start(btn_box, False, False, 0)
        for lbl, cb in [
            ("Build", self.on_build),
            ("Build Advanced", self.on_build_adv),
            ("Cosimulation", self.on_cosim),
            ("Simulation", lambda b: self.append_log("Simulation non implémentée\n")),
            ("Profile", lambda b: self.append_log("Profile non implémenté\n")),
            ("Quitter", Gtk.main_quit),
        ]:
            btn = Gtk.Button(label=lbl)
            btn.connect("clicked", cb)
            btn_box.pack_start(btn, True, True, 0)

        sw = Gtk.ScrolledWindow()
        sw.set_policy(Gtk.PolicyType.NEVER, Gtk.PolicyType.AUTOMATIC)
        sw.set_vexpand(True)
        vbox.pack_start(sw, True, True, 0)
        self.logbuf = Gtk.TextBuffer()
        self.logview = Gtk.TextView(buffer=self.logbuf,
                                    editable=False,
                                    wrap_mode=Gtk.WrapMode.WORD)
        self.logview.set_margin_bottom(10)
        sw.add(self.logview)

        # Barre de progression intégrée avec marges
        ph = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL, spacing=5)
        ph.set_margin_top(10)
        ph.set_margin_start(10)
        ph.set_margin_end(10)
        vbox.pack_start(ph, False, False, 0)
        self.progress = Gtk.ProgressBar(show_text=True)
        self.progress.set_size_request(-1, 24)
        self.progress.set_margin_bottom(10)
        self.progress.set_margin_start(10)
        self.progress.set_margin_end(10)
        ph.pack_start(self.progress, True, True, 0)
        self.cancel_btn = Gtk.Button(label="Cancel")
        self.cancel_btn.connect("clicked", lambda b: self.stop_event.set())
        ph.pack_start(self.cancel_btn, False, False, 0)
        self.progress.hide(); self.cancel_btn.hide()

        self.src_tree = get_directory_tree("src") if os.path.isdir("src") else {}
        self.cos_tree = get_directory_tree("cosim") if os.path.isdir("cosim") else {}
        self.show_all()

    def append_log(self, text):
        GLib.idle_add(self._append_log, text)
    def _append_log(self, text):
        buf = self.logbuf
        end = buf.get_end_iter()
        buf.insert(end, text)
        mark = buf.create_mark(None, buf.get_end_iter(), False)
        self.logview.scroll_to_mark(mark, 0.0, True, 0.0, 1.0)

    def show_progress(self):
        self.progress.set_fraction(0.0)
        self.progress.show()
        self.cancel_btn.show()
        self.stop_event.clear()
        self.processes.clear()

    def update_progress(self, frac, text):
        self.progress.set_fraction(frac)
        self.progress.set_text(text)

    def hide_progress(self):
        self.progress.hide()
        self.cancel_btn.hide()

    def prepare_clean_build(self):
        if os.path.isdir("build"):
            dlg = Gtk.MessageDialog(
                transient_for=self, flags=0,
                message_type=Gtk.MessageType.QUESTION,
                buttons=Gtk.ButtonsType.YES_NO,
                text="Le dossier 'build' existe déjà.\nArchiver et repartir à zéro ?"
            )
            resp = dlg.run(); dlg.destroy()
            if resp == Gtk.ResponseType.YES:
                i = 1
                while os.path.exists(f"build.old{i}"):
                    i += 1
                os.rename("build", f"build.old{i}")

    def on_build(self, _):
        if not os.path.exists("build_config.cmake"):
            self.append_log("ERROR: run Build Advanced first\n"); return
        self.prepare_clean_build()
        self.show_progress()
        def job():
            try:
                run_cmd(["cmake","-S.", "-Bbuild","-GNinja"], False, self, self.append_log)
                run_cmd(["cmake","--build","build"], True, self, self.append_log)
            except Exception as e:
                GLib.idle_add(self.append_log, f"Error: {e}\n")
            GLib.idle_add(self.hide_progress)
        threading.Thread(target=job).start()

    def on_build_adv(self, _):
        dlg = BuildAdvancedDialog(self)
        if dlg.run() == Gtk.ResponseType.OK:
            # Construire le dictionnaire des options globales à partir de GLOBAL_OPTIONS_DEF
            global_opts = {}
            for opt in GLOBAL_OPTIONS_DEF:
                name = opt["name"]
                default = opt["default"]
                if opt["type"] == "bool":
                    global_opts[name] = "ON" if default else "OFF"
                else:
                    global_opts[name] = default
            dlg.generate_build_config(global_opts)
            self.prepare_clean_build()
            self.append_log("Advanced config saved, launching build...\n")
            self.on_build(None)  # Lance le build
        dlg.destroy()

    def on_cosim(self, _):
        if not is_build_done():
            self.append_log("Build missing, running build first\n")
            self.prepare_clean_build()
            self.on_build(None)
        self.show_progress()
        def job():
            try:
                run_cmd(["./build/cosim/Vgate-tests"], False, self, self.append_log)
            except Exception as e:
                GLib.idle_add(self.append_log, f"Error: {e}\n")
            GLib.idle_add(self.hide_progress)
        threading.Thread(target=job).start()

class BuildAdvanced(Gtk.Dialog):
    def __init__(self, parent):
        super().__init__(title="Build Advanced", transient_for=parent, flags=0)
        self.add_buttons("OK", Gtk.ResponseType.OK, "Back", Gtk.ResponseType.CANCEL)
        self.set_default_size(600,400)
        box = self.get_content_area()
        h = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL, spacing=5)
        box.add(h)
        for data,name in [(parent.src_tree,"src"),(parent.cos_tree,"cosim")]:
            store = Gtk.TreeStore(bool, str)
            def fill(p,d):
                for k,v in d.items():
                    it = store.append(p,[False,k]); fill(it,v)
            fill(None,data)
            tv = Gtk.TreeView(model=store)
            r = Gtk.CellRendererToggle()
            r.connect("toggled", lambda w,p,s=store: s.set_value(s.get_iter(p),0,not s.get_value(s.get_iter(p),0)))
            tv.append_column(Gtk.TreeViewColumn("", r, active=0))
            tv.append_column(Gtk.TreeViewColumn(name, Gtk.CellRendererText(), text=1))
            h.pack_start(tv, True, True, 0)
        self.show_all()

if __name__=="__main__":
    MainWindow(); Gtk.main()

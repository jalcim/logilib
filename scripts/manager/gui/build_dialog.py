from gi.repository import Gtk
from utils.fs import scan_directories

class BuildAdvancedDialog(Gtk.Dialog):
    """
    Sélection interactive des modules dans src/ et cosim/.
    """
    def __init__(self, parent):
        super().__init__(title="Build Advanced",
                         transient_for=parent, flags=0)
        self.add_buttons("OK", Gtk.ResponseType.OK,
                         "Back", Gtk.ResponseType.CANCEL)
        self.set_default_size(600, 400)
        box = self.get_content_area()
        hbox = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL, spacing=5)
        box.add(hbox)

        for data,label in [(scan_directories("src"),"src"),
                           (scan_directories("cosim"),"cosim")]:
            store = Gtk.TreeStore(bool,str)
            self._fill(store,None,data)
            tv = Gtk.TreeView(model=store)
            r = Gtk.CellRendererToggle()
            r.connect("toggled", self._on_toggle, store)
            tv.append_column(Gtk.TreeViewColumn("",r,active=0))
            tv.append_column(Gtk.TreeViewColumn(label,
                                               Gtk.CellRendererText(),
                                               text=1))
            hbox.pack_start(tv,True,True,0)
        self.show_all()

    def _fill(self, store, parent, data: dict):
        for k,v in data.items():
            it=store.append(parent,[False,k])
            self._fill(store,it,v)

    def _on_toggle(self, cell, path, store):
        it = store.get_iter(path)
        store.set_value(it,0,not store.get_value(it,0))

from gi.repository import Gtk
from utils.fs import scan_directories

def traverse(store, parent=None, path=""):
    result = []
    child = store.iter_children(parent)
    while child:
        name = store.get_value(child, 1)
        if store.get_value(child, 0):
            full = name if not path else f"{path}/{name}"
            result.append(full)
        result += traverse(store, child, name if not path else f"{path}/{name}")
        child = store.iter_next(child)
    return result

class BuildAdvancedDialog(Gtk.Dialog):
    """
    Sélection interactive des modules dans 'src' et 'cosim'.
    Le nœud racine est explicitement défini pour chaque arbre.
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

        # Création des arbres avec un nœud racine explicite ("src" ou "cosim")
        self.stores = {}
        for data, label in [(scan_directories("src"), "src"),
                            (scan_directories("cosim"), "cosim")]:
            store = Gtk.TreeStore(bool, str)
            root_iter = store.append(None, [False, label])  # nœud racine
            self._fill(store, root_iter, data)
            self.stores[label] = store
            tv = Gtk.TreeView(model=store)
            r = Gtk.CellRendererToggle()
            r.connect("toggled", self._on_toggle, store)
            tv.append_column(Gtk.TreeViewColumn("", r, active=0))
            tv.append_column(Gtk.TreeViewColumn("Répertoire", Gtk.CellRendererText(), text=1))
            hbox.pack_start(tv, True, True, 0)
        self.show_all()

    def _fill(self, store, parent, data: dict):
        for k, v in data.items():
            it = store.append(parent, [False, k])
            self._fill(store, it, v)

    @staticmethod
    def propagate_down(store, tree_iter, value):
        child = store.iter_children(tree_iter)
        while child:
            store.set_value(child, 0, value)
            BuildAdvancedDialog.propagate_down(store, child, value)
            child = store.iter_next(child)

    @staticmethod
    def propagate_up(store, tree_iter):
        parent = store.iter_parent(tree_iter)
        if parent:
            if not store.get_value(parent, 0):
                store.set_value(parent, 0, True)
            BuildAdvancedDialog.propagate_up(store, parent)

    def _on_toggle(self, cell, path, store):
        it = store.get_iter(path)
        new_value = not store.get_value(it, 0)
        store.set_value(it, 0, new_value)
        if new_value:
            BuildAdvancedDialog.propagate_down(store, it, True)
            BuildAdvancedDialog.propagate_up(store, it)
        else:
            BuildAdvancedDialog.propagate_down(store, it, False)

    def generate_build_config(self, global_opts):
        """
        Génère build_config.cmake à partir des répertoires cochés
        dans les arbres "src" et "cosim", et des options globales fournies.
        """
        src_selected = traverse(self.stores["src"])
        cosim_selected = traverse(self.stores["cosim"])
        module_options = []
        for node in src_selected:
            opt = "ENABLE_" + node.upper().replace("/", "_")
            desc = f"Activer {node}"
            module_options.append(f'option({opt} "{desc}" ON)')
        for node in cosim_selected:
            opt = "ENABLE_" + node.upper().replace("/", "_")
            desc = f"Activer {node}"
            module_options.append(f'option({opt} "{desc}" ON)')
        config_lines = []
        if global_opts:
            if "LOG_LEVEL" in global_opts:
                config_lines.append(f'set(LOG_LEVEL "{global_opts["LOG_LEVEL"]}" CACHE STRING "Set the log level")')
                config_lines.append(f'set(MAX_WAYS "{global_opts["MAX_WAYS"]}" CACHE STRING "Max number of gates ways generated")')
                config_lines.append(f'set(VERILATOR_TIME_STEP "{global_opts["VERILATOR_TIME_STEP"]}" CACHE STRING "Time between each verilator evaluation")')
                config_lines.append("")
                config_lines.append(f'set(Boost_USE_STATIC_LIBS {global_opts["Boost_USE_STATIC_LIBS"]})')
                config_lines.append(f'set(Boost_USE_DEBUG_LIBS {global_opts["Boost_USE_DEBUG_LIBS"]})')
                config_lines.append(f'set(Boost_USE_RELEASE_LIBS {global_opts["Boost_USE_RELEASE_LIBS"]})')
                config_lines.append(f'set(Boost_USE_MULTITHREADED {global_opts["Boost_USE_MULTITHREADED"]})')
                config_lines.append(f'set(Boost_USE_STATIC_RUNTIME {global_opts["Boost_USE_STATIC_RUNTIME"]})')
                config_lines.append("")
                config_lines.append(f'option(ENABLE_VCD "Enable VCD trace file generation" {global_opts["ENABLE_VCD"]})')
                config_lines.append(f'option(STATIC_BUILD "Compiles into one binary with no dynamic dependencies" {global_opts["STATIC_BUILD"]})')
        with open("build_config.cmake", "w") as f:
            f.write("# Fichier de configuration généré automatiquement\n")
            for line in module_options:
                f.write(line + "\n")
            f.write("\n# Options globales\n")
            for line in config_lines:
                f.write(line + "\n")

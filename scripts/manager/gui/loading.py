import threading
from gi.repository import Gtk

class LoadingDialog(Gtk.Dialog):
    """
    Boîte de progression intégrée dans la fenêtre principale.
    """
    def __init__(self, parent, message: str):
        super().__init__(title=message, transient_for=parent, flags=0)
        self.set_default_size(300, 120)
        self.processes = []
        self.stop_event = threading.Event()
        box = self.get_content_area()
        self.progressbar = Gtk.ProgressBar(show_text=True)
        self.progressbar.set_size_request(-1, 24)
        self.progressbar.set_margin_bottom(10)
        box.add(self.progressbar)
        cancel = Gtk.Button(label="Cancel")
        cancel.connect("clicked", lambda b: self.stop_event.set())
        box.add(cancel)
        self.show_all()

    def update(self, fraction: float, text: str):
        self.progressbar.set_fraction(fraction)
        self.progressbar.set_text(text)

    def set_complete(self):
        self.progressbar.set_fraction(1.0)
        self.progressbar.set_text("100%")
        self.destroy()

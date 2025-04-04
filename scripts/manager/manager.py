#!/usr/bin/env python3
"""
Entrée principale.
"""
import gi
gi.require_version('Gtk','3.0')
from gui.main_window import MainWindow
from gi.repository import Gtk

if __name__=="__main__":
    MainWindow()
    Gtk.main()

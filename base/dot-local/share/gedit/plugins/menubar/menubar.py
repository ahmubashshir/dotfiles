from gi.repository import Gtk, GObject, Gedit


def find_widget(widget, name, disable_bin=False):
    if Gtk.Buildable.get_name(widget) == name:
        return widget
    if isinstance(widget, (Gtk.Bin, )) and not disable_bin:
        return find_widget(widget.get_child(), name)
    if isinstance(widget, (Gtk.Container,)):
        for child in widget.get_children():
            found = find_widget(child, name)
            if found:
                return found
    return None


class toggleMenuPlugin(GObject.Object, Gedit.AppActivatable):
    app = GObject.property(type=Gedit.App)
    menu = None
    gear = None
    handler = None

    def __init__(self):
        GObject.Object.__init__(self)

    def do_activate(self):
        self.handler = self.app.connect('window-added',
                                        self.window_added_handler)

    def window_added_handler(self, app, window):
        if window.__class__.find_property('show-menubar'):
            container = find_widget(window, "content_box")
            window.set_property('show-menubar', False)
            menubar = Gtk.MenuBar.new_from_model(app.get_menubar())
            menubar.show_all()
            container.pack_start(menubar, False, False, 0)
            container.reorder_child(menubar, 0)
        pass

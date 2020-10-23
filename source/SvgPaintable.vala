public class Gtk4Demo.SvgPaintable : GLib.Object, Gdk.Paintable {
    Rsvg.Handle handle;

    public SvgPaintable.from_file (GLib.File file_name) {
        try {
            handle = new Rsvg.Handle.from_gfile_sync (file_name, Rsvg.HandleFlags.FLAGS_NONE);
         } catch (Error err) {
            error ("Failed to load file: %s\n", err.message);
        }
    }

    public SvgPaintable.from_resource (string resource) {
        try {
            var data = resources_lookup_data (resource, GLib.ResourceLookupFlags.NONE);
            handle = new Rsvg.Handle.from_data (data.get_data ());
         } catch (Error err) {
            error ("Failed to load file: %s\n", err.message);
        }
    }

    protected int get_intrinsic_height () {
        return handle.height;
    }

    protected int get_intrinsic_width () {
        return handle.width;
    }

    protected void snapshot (Gdk.Snapshot snapshot, double width, double height) {
        var gtk_snapshot = (Gtk.Snapshot)snapshot;
        var cairo = gtk_snapshot.append_cairo ({ { 0, 0 }, { (float) width, (float) height } });

        try {
            handle.render_document (cairo, { 0, 0, width, height });
        } catch (Error err) {
            error ("Couldn't render file: %s\n", err.message);
        }
    }
}
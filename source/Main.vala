// Copyright (c) 2020 Ahmed Eldemery
//
// This software is released under the MIT License.
// https://opensource.org/licenses/MIT

int main (string[] args) {
    var app = new Gtk4Demo.WeatherApp ();
    return app.run (args);
}

public class Gtk4Demo.WeatherApp : Gtk.Application {
    public WeatherApp () {
        Object (application_id: "github.aeldemery.gtk4_list_weather", flags : GLib.ApplicationFlags.FLAGS_NONE);
    }

    protected override void activate () {
        var win = this.active_window;
        if (win == null) {
            win = new Gtk4Demo.MainWindow (this);
        }
        win.present ();
    }
}
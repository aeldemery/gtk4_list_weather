// Copyright (c) 2020 Ahmed Eldemery
//
// This software is released under the MIT License.
// https://opensource.org/licenses/MIT

public class Gtk4Demo.MainWindow : Gtk.ApplicationWindow {
    Gtk.ListView list_view;
    Gtk.SignalListItemFactory factory;
    Gtk.NoSelection model;
    Gtk.ScrolledWindow sw;

    public MainWindow (Gtk.Application app) {
        Object (application: app);
        this.title = "Weather Info List";
        this.default_width = 400;
        this.default_height = 800;

        model = new Gtk.NoSelection (new WeatherListModel ());
        factory = new Gtk.SignalListItemFactory ();
        factory.setup.connect (setup_list_view);
        factory.bind.connect (bind_list_view);

        list_view = new Gtk.ListView (model, factory);
        list_view.show_separators = true;
        // list_view.orientation = Gtk.Orientation.HORIZONTAL;
        sw = new Gtk.ScrolledWindow ();
        sw.set_child (list_view);
        this.set_child (sw);
    }

    void setup_list_view (Gtk.SignalListItemFactory factory, Gtk.ListItem list_item) {
        var box = new Gtk.Box (Gtk.Orientation.VERTICAL, 12);

        var label = new Gtk.Label ("");
        label.width_chars = 5;
        box.append (label);

        var image = new Gtk.Image ();
        image.set_size_request (120, 120);
        box.append (image);

        label = new Gtk.Label ("");
        label.vexpand = true;
        label.valign = Gtk.Align.END;
        label.width_chars = 4;
        box.append (label);

        list_item.set_child (box);
    }

    void bind_list_view (Gtk.SignalListItemFactory factory, Gtk.ListItem list_item) {
        var box = (Gtk.Box)list_item.get_child ();
        var weather_info = (WeatherInfo) list_item.get_item ();

        var label = (Gtk.Label)box.get_first_child ();
        label.label = "Date: " + weather_info.time_stamp.format ("%Y %a %b %R");

        var image = (Gtk.Image)label.get_next_sibling ();

        switch (weather_info.weather_type) {
            case WeatherInfo.WeatherType.CLEAR:
                var svg_paintable = new SvgPaintable.from_resource ("/github/aeldemery/gtk4_list_weather/icons/weather-clear-symbolic.svg");
                image.paintable = svg_paintable;
                break;
            case WeatherInfo.WeatherType.FEW_CLOUDS:
                var svg_paintable = new SvgPaintable.from_resource ("/github/aeldemery/gtk4_list_weather/icons/weather-few-clouds-symbolic.svg");
                image.paintable = svg_paintable;
                break;
            case WeatherInfo.WeatherType.FOG:
                var svg_paintable = new SvgPaintable.from_resource ("/github/aeldemery/gtk4_list_weather/icons/weather-fog-symbolic.svg");
                image.paintable = svg_paintable;
                break;
            case WeatherInfo.WeatherType.OVERCAST:
                var svg_paintable = new SvgPaintable.from_resource ("/github/aeldemery/gtk4_list_weather/icons/weather-overcast-symbolic.svg");
                image.paintable = svg_paintable;
                break;
            case WeatherInfo.WeatherType.SCATTERED_SHOWERS:
                var svg_paintable = new SvgPaintable.from_resource ("/github/aeldemery/gtk4_list_weather/icons/weather-showers-scattered-symbolic.svg");
                image.paintable = svg_paintable;
                break;
            case WeatherInfo.WeatherType.SHOWERS:
                var svg_paintable = new SvgPaintable.from_resource ("/github/aeldemery/gtk4_list_weather/icons/weather-showers-symbolic.svg");
                image.paintable = svg_paintable;
                break;
            case WeatherInfo.WeatherType.SNOW:
                var svg_paintable = new SvgPaintable.from_resource ("/github/aeldemery/gtk4_list_weather/icons/weather-snow-symbolic.svg");
                image.paintable = svg_paintable;
                break;
            case WeatherInfo.WeatherType.STORM:
                var svg_paintable = new SvgPaintable.from_resource ("/github/aeldemery/gtk4_list_weather/icons/weather-storm-symbolic.svg");
                image.paintable = svg_paintable;
                break;
            default:
                image.clear ();
                break;
        }

        label = (Gtk.Label)image.get_next_sibling ();
        label.label = "Temp: " + weather_info.temperature.to_string ();
    }
}
// Copyright (c) 2020 Ahmed Eldemery
//
// This software is released under the MIT License.
// https://opensource.org/licenses/MIT

public class Gtk4Demo.WeatherListModel : GLib.Object, GLib.ListModel {
    WeatherInfo[] weather_info_array;
    construct {
        try {
            var data = resources_lookup_data (
                "/github/aeldemery/gtk4_list_weather/data/listview_weather.txt",
                ResourceLookupFlags.NONE);

            var text = (string) data.get_data ();
            var lines = text.strip ().split ("\n");        //split ("\n");

            weather_info_array = new WeatherInfo[lines.length];
            int i = 0;
            foreach (var line in lines) {
                var fields = line.split (",");
                if (fields[0] == null) continue;
                weather_info_array[i] = new WeatherInfo (fields[0], fields[1], fields[2], fields[3]);
                ++i;
            }
        } catch (Error err) {
            error ("Couldn't load resource %s\n", err.message);
        }
    }
    public uint get_n_items () {
        return weather_info_array.length;
    }

    public GLib.Type get_item_type () {
        return typeof (WeatherInfo);
    }

    public GLib.Object ? get_item (uint position) {
        if (position > weather_info_array.length) {
            warning ("Trying to index outside bounds\n");
            var index = uint.max (position, weather_info_array.length);
            return weather_info_array[index];
        } else {
            return weather_info_array[position];
        }
    }
}
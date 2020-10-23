public class Gtk4Demo.WeatherInfo : GLib.Object {

    public enum WeatherType {
        CLEAR,
        FEW_CLOUDS,
        FOG,
        OVERCAST,
        SCATTERED_SHOWERS,
        SHOWERS,
        SNOW,
        STORM,
    }

    public GLib.DateTime time_stamp { get; private set; }
    public int temperature { get; private set; }
    public WeatherType weather_type { get; private set; }

    public GLib.DateTime parse_time_stamp (string from, GLib.TimeZone time_zone) {
        var time = from + ":00";
        return new GLib.DateTime.from_iso8601 (time, time_zone);
    }

    public int parse_temperature (string from) {
        return int.parse (from);
    }

    public WeatherType parse_weather_type (string clouds, string precipitation) {
        if (precipitation == "SN") {
            return WeatherType.SNOW;
        } else if (precipitation == "TS") {
            return WeatherType.STORM;
        } else if (precipitation == "DZ") {
            return WeatherType.SCATTERED_SHOWERS;
        } else if (precipitation == "SH" || precipitation == "RA") {
            return WeatherType.SHOWERS;
        } else if (precipitation == "FG") {
            return WeatherType.FOG;
        } else if (clouds == "M" || clouds == "") {
            return WeatherType.CLEAR;
        } else if (clouds == "OVC" || clouds == "BKN") {
            return WeatherType.OVERCAST;
        } else if (clouds == "BKN" || clouds == "SCT") {
            return WeatherType.FEW_CLOUDS;
        } else if (clouds == "VV") {
            return WeatherType.FOG;
        } else {
            return WeatherType.CLEAR;
        }
    }

    public WeatherInfo (string timestamp, string temperature, string clouds, string precipitation, GLib.TimeZone? timezone = null) {
        this.time_stamp = parse_time_stamp (timestamp, timezone != null? timezone: new GLib.TimeZone.utc());
        this.temperature = parse_temperature (temperature);
        this.weather_type = parse_weather_type (clouds, precipitation);
    }
}
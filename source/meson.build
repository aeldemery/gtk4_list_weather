sources = files (
    'Main.vala',
    'MainWindow.vala',
    'WeatherInfo.vala',
    'WeatherListModel.vala',
    'SvgPaintable.vala',
)

sources += proj_resources

dependencies = [
    dependency ('glib-2.0'),
    dependency ('gobject-2.0'),
    dependency ('gtk4'),
    dependency ('librsvg-2.0'),
]

executable (
    meson.project_name (),
    sources: sources,
    dependencies: dependencies,
    install: true,
)
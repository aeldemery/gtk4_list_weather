gnome = import ('gnome')

proj_resources = gnome.compile_resources (
    meson.project_name (),
    files (meson.project_name () + '.gresource.xml'),
    c_name: 'proj_resources',
    source_dir: '.',
)
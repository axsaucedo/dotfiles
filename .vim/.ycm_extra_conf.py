
def Settings(**kwargs):
    print("hello")
    return {
            'interpreter_path': '/home/alejandro/anaconda3/bin/python'
            }

flags = [
'-Wall',
'-Wextra',
'-std=c++11',
'c++',

#Standard includes
'-isystem',
'/usr/include/c++/4.7',



#GTK includes
'-isystem',
'/usr/include/gtk-3.0',
'-isystem',
'/usr/include/glib-2.0',
'-isystem',
'/usr/include/glib-2.0/glib',
'-isystem',
'/usr/lib/i386-linux-gnu/glib-2.0/include',
'-isystem',
'/usr/include/pango-1.0',
'-isystem',
'/usr/include/cairo',
'-isystem',
'/usr/include/gdk-pixbuf-2.0',
'-isystem',
'/usr/include/atk-1.0',
'-isystem',
'-I/usr/include/gio-unix-2.0',
'-isystem',
'-I/usr/include/freetype2',
'-isystem',
'-I/usr/include/pixman-1',
'-isystem',
'-I/usr/include/libpng12',

#current dir
'-I',
'.',

#custom libraries
'-I',
'/opt/boost_1_55_0',
'-I',
'/opt/cryptopp-5.6.2',
'-I',
'/opt/llvm_install/include'
]

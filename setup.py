#!/usr/bin/env python

from setuptools import setup, Extension
#from distutils.core import setup, Extension

import os.path
import sys

# Best to use GCC. Symbols are misnamed using clang.
os.environ["CC"] = "gcc"
os.environ["CXX"] = "g++"

# sys.executable = '/usr/bin/env python'

libspud = Extension('libspud',
            sources = [
                'spud/python/libspud.c',
                'spud/src/spud.cpp',
                'spud/src/spud_interfaces.cpp',
                'spud/src/tinystr.cpp',
                'spud/src/tinyxml.cpp',
                'spud/src/tinyxmlerror.cpp',
                'spud/src/tinyxmlparser.cpp'
            ],
            library_dirs=[os.path.abspath("spud")],
            include_dirs=[os.path.abspath("spud/include")],
            extra_link_args=['-lstdc++']
            #extra_link_args=['-flat_namespace', '-lstdc++']
)

#libspud = Extension('libspud',
#    sources = ['spud/python/libspud.c'],
#    libraries=["spudcore"],
#    library_dirs=[os.path.abspath("spud")],
#    include_dirs=[os.path.abspath("spud/include")],
#    extra_link_args=['-flat_namespace', '-lstdc++'],
#)

#setup(name = 'libspud',
#       version = '1.1.3',
#       description = 'Python bindings for libspud',
#       ext_modules = [libspud]
#)

setup(name='shingle',
    version='2.1',
    description='Generation of boundary representation and mesh spatial discretisations from arbitrary geophysical fields.',
    author = 'Adam S. Candy',
    author_email='contact@shingleproject.org',
    license = "LGPLv3",
    url = 'https://shingleproject.org',
    classifiers=[
        # How mature is this project? Common values are
        #   3 - Alpha
        #   4 - Beta
        #   5 - Production/Stable
        #'Development Status :: 3 - Alpha',
        'Development Status :: 4 - Beta',

        # Indicate who your project is intended for
        'Intended Audience :: Science/Research',
        "Intended Audience :: Developers",
        'Operating System :: OS Independent',
        'Programming Language :: Python',
        'Programming Language :: Python :: 2',
        'Topic :: Scientific/Engineering :: Physics',
        'Topic :: Scientific/Engineering :: Mathematics',
        'Topic :: Scientific/Engineering :: Atmospheric Science',
        'Topic :: Scientific/Engineering :: GIS',
        "Topic :: Software Development :: Libraries",

        # Pick your license as you wish (should match "license" above)
        "License :: OSI Approved :: GNU Lesser General Public License v3 (LGPLv3)",

        # Specify the Python versions you support here. In particular, ensure
        # that you indicate whether you support Python 2, Python 3 or both.
        'Programming Language :: Python :: 2.7',
        'Programming Language :: C'
    ],
    keywords = 'geophysics, meshing, boundary representation, unstructured meshes, mulit-scale modelling, mesh generation, oceanography',
    library_dirs=[os.path.abspath("spud")],
    include_dirs=[os.path.abspath("spud/include")],
    packages = ['shingle'],
    #scripts=['src/shingle'],
    entry_points = {
        'console_scripts': ['shingle=shingle.CommandLine:main'],
    },
    options = {
        'build_scripts': {
            'executable': '/usr/bin/env python',
        },
    },     
    data_files = [('', [
        'schema/shingle_options.rng',
        'README.md',
        'AUTHORS',
        'COPYING',
        'LICENSE',
    ])],
    package_data={
        'shingle':[
             'schema/shingle_options.rng',
             'README.md',
             'AUTHORS',
             'COPYING',
             'LICENSE',
             ],
    },
#    install_requires = [
#        'libspud',
#        'numpy',
#        'ScientificPython',
#        'matplotlib',
#        'shapely',
#        'GDAL',
#        'Pillow',
#    ],
    ext_modules = [libspud],
    include_package_data=True,
)




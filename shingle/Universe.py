#!/usr/bin/env python
# -*- coding: utf-8 -*-

##############################################################################
#
#  Copyright (C) 2011-2018 Dr Adam S. Candy and others.
#  
#  Shingle:  An approach and software library for the generation of
#            boundary representation from arbitrary geophysical fields
#            and initialisation for anisotropic, unstructured meshing.
#  
#            Web: http://www.shingleproject.org
#  
#            Contact: Dr Adam S. Candy, contact@shingleproject.org
#  
#  This file is part of the Shingle project.
#  
#  Please see the AUTHORS file in the main source directory for a full list
#  of contributors.
#  
#  Shingle is free software: you can redistribute it and/or modify
#  it under the terms of the GNU Lesser General Public License as published by
#  the Free Software Foundation, either version 3 of the License, or
#  (at your option) any later version.
#  
#  Shingle is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU Lesser General Public License for more details.
#  
#  You should have received a copy of the GNU Lesser General Public License
#  along with Shingle. If not, see <http://www.gnu.org/licenses/>.
#
##############################################################################

import os

colour = {
    'red', None,
    'green', None,
    'blue', None,
    'cyan', None,
    'magenta', None,
    'brightred', None,
    'brightgreen', None,
    'brightmagenta', None,
    'brightyellow', None,
    'brightcyan', None,
    'yellow', None,
    'bred', None,
    'bcyan', None,
    'bblue', None,
    'bmagenta', None,
    'byellow', None,
    'bgreen', None,
    'bwhite', None,
    'grey', None,
    'fred', None,
    'end', None,
}

class universe():
    verbose = True
    debug = False
    optiontreesource = None
    testfolder = None
    call = None

    # Extra options
    plotcontour = False
    plotcontouronly = False
    cache = False
    generatemetric = False
    generate_mesh = False
    generate_mesh_image = False
    verification_update = False
    stages = None
    tags = []
    use_counter_prefix = False
    _all_stages = ['path', 'brep', 'mesh', 'metric', 'verify', 'post']
    pickup = False
    download_database = {}

    # Log
    root = './'
    logfilename = 'shingle.log'
    log_active = False
    log = None

    class default():
        # Global
        name = 'shingle'
        planet_radius = 6.37101e+06
        physical_lines_separate = False

        # Surface Geoid Representation
        fileid = ''
        more_bsplines = False
        open = True
        bounding_lat = None
        extendtolatitude = None
        closewithparallels = False

        # Brep
        boundaries = []
        boundariestoexclude = []
        region = 'True'
        minarea = 0
        dx = 1.0E4
        exclude_iceshelf_ocean_cavities = False
        projection = 'Automatic'
        contourtype = 'iceshelfcavity'
        compound = False

        # Metric
        elementlength = 1.0E5

        # Accuracy of coordinate positions in output file
        output_accuracy = 8
        # Default output format is plain text, binry type produces smaller files
        output_mesh_binary = False

        #smooth_data = False
        #smooth_degree = 100

        class boundary:
            contour = 3
            open    = 4
            surface = 9

        plot_backend = None

    class legacy():
        source  = os.path.expanduser('~/tmp/dataset/rtopo/RTopo105b_50S.nc')
        output = './shorelines.geo'
        legacy = False


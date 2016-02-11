#!/usr/bin/env python

##########################################################################
#  
#  Generation of boundary representation from arbitrary geophysical
#  fields and initialisation for anisotropic, unstructured meshing.
#  
#  Copyright (C) 2011-2013 Dr Adam S. Candy, adam.candy@imperial.ac.uk
#  
#  This program is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 3 of the License, or
#  (at your option) any later version.
#  
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#  
#  You should have received a copy of the GNU General Public License
#  along with this program.  If not, see <http://www.gnu.org/licenses/>.
#  
##########################################################################

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
  cache = False
  generatemesh = False 
  generatemetric = False
  stage = None

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
    bounding_lat = -50.0
    extendtolatitude = None
    closewithparallels = False
    
    # Brep
    boundaries = []
    boundariestoexclude = []
    region = 'True'
    minarea = 0
    dx = 0.1
    exclude_iceshelf_ocean_cavities = True
    projection = 'cartesian'
    contourtype = 'iceshelfcavity'
    compound = False

    # Metric
    elementlength = 1.0E5

    class boundary:
      contour = 3
      open    = 4
      surface = 9
  
  class legacy():
    source  = os.path.expanduser('~/tmp/dataset/rtopo/RTopo105b_50S.nc')
    output = '.shorelines.geo'
    legacy = False


  #smooth_data = False
  #smooth_degree = 100




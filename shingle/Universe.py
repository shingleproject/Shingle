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
  verbose = None
  debug = None
  
  reportcache = None
  reportline = None

  logfile = None

  # Arguments
  input  = None
  picklefile = None
  output = None
  boundaries = None
  boundariestoexclude = None
  region = None
  box = None
  minarea = None
  dx = None
  extendtolatitude = None
  open = None
  bounding_lat = None
  smooth_data = None
  smooth_degree = None
  include_iceshelf_ocean_cavities = None
  projection = None
  contourtype = None
  plotcontour = None
  #call = None
  call = None
  cache = None
  closewithparallels = None
  elementlength = None
  generatemesh = None
  generatemetric = None

  #### IMPORT START
  planet_radius = None
  dx_default = None
  #fileid = 'G'
  fileid = None
  compound = None
  #compound = True
  more_bsplines = None
  # Interestingly, if the following is true, gmsh generates a nice mesh, but complains (rightly so) on multiple definitions of a physical line id.  If false, the mesh contains extra 1d elements, which need parsing out!
  physical_lines_separate = None
  #### IMPORT END
  





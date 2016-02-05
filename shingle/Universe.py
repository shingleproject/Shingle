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


class universe():
  #### IMPORT START
  earth_radius = 6.37101e+06
  dx_default = 0.1
  #fileid = 'G'
  fileid = ''
  compound = False
  #compound = True
  more_bsplines = False
  # Interestingly, if the following is true, gmsh generates a nice mesh, but complains (rightly so) on multiple definitions of a physical line id.  If false, the mesh contains extra 1d elements, which need parsing out!
  physical_lines_separate = False
  #### IMPORT END

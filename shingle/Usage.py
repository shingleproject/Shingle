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

import sys
import os

def usage(unknown = None):
  if unknown:
    print 'Unknown option ' + unknown
  print '''Usage for %(cmdname)s
 %(cmdname)s [options]
- Options ---------------------\ 
   -n filename                 | Input netCDF file
   -f filename                 | Output Gmsh file
                               |______________________________________________
   -h                          | Help
   -v                          | Verbose
   -vv                         | Very verbose (debugging)
   -q                          | Quiet
                               \_____________________________________________
  Legacy options --------------\ 
                               |
   -p path1 (path2)..          | Specify paths to include
   -pn path1 (path2)..         | Specify paths to exclude
   -r function                 | Function specifying region of interest
   -b box1 (box2)..            | Boxes with regions of interest
   -a minarea                  | Minimum area of islands
   -dx dist                    | Distance of steps when drawing parallels and meridians (currently in degrees - need to project)
   -m projection               | Projection type (default 'cartesian', 'longlat')
   -bounding_latitude latitude | Latitude of boundary to close the domain
   -bl latitude                | Short form of -bounding_latitude
   -t type                     | Contour type (default: iceshelfcavity) icesheet gsds
   -c                          | Force cache refresh
   -exclude_iceshelves         | Excludes iceshelf ocean cavities from mesh (default behaviour includes region)
   -smooth_data degree         | Smoothes boundaries
   -no                         | Do not include open boundaries
   -mesh                       | Mesh geometry
   -lat latitude               | Latitude to extend open domain to
   -s scenario                 | Select scenario (in development)
   -plot                       | Plot contour before geo generation 
   -el                         | Element length (default 1.0E5)
   -metric                     | Generate background metric based on bathymetry
                               \_____________________________________________
Example usage:
Include only the main Antarctic mass (path 1), and only parts which lie below 60S
  rtopo_mask_to_stereographic.py -r 'latitude <= -60.0' -p 1
Filchner-Ronne extended out to the 65S parallel
  rtopo_mask_to_stereographic.py -no -b -85.0:-20.0,-89.0:-75.0 -64.0:-30.0,-89.0:-70.0 -30.0:-20.0,-89.0:-75.0 -lat '-65.0'
Antarctica, everything below the 60S parallel, coarse approximation to open boundary
  rtopo_mask_to_stereographic.py -dx 2 -r 'latitude <= -60'
Small region close to the Filcher-Ronne ice shelf
  rtopo_mask_to_stereographic.py -no -b -85.0:-20.0,-89.0:-75.0 -64.0:-30.0,-89.0:-70.0 -30.0:-20.0,-89.0:-75.0 -p 1 -r 'latitude <= -83'
Amundsen Sea
  rtopo_mask_to_stereographic.py -no -b -130.0:-85.0,-85.0:-60.0 -lat -64.0

Small islands, single out, or group with -p
  312, 314
  79 - an island on 90W 68S''' % { 'cmdname': os.path.       basename(sys.argv[0]) }
  sys.exit(1)

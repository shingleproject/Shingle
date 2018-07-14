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

import sys
import os
from Universe import universe

def usage(unknown = None):
    if unknown:
        print 'Unknown option ' + unknown
    print '''Usage for %(cmdname)s
 %(cmdname)s [options] (filename)
- Options ---------------------\
   filename                    | Option tree file fully specifying the
                               |   surface geoid representation and spatial discretisation
   -t (testfolder)             | Run all tests located in testfolder (defaults to the source test folder)
   -l (logfile)                | Log messages to file (optional filename, default shingle.log in project folder)
   -c                          | Use cache
                               |_________________________________________________________________________________
   --stage stagename           | Partial processing, up to given stage from: %(stages)s
   --tag tagname               | Specify test cases to include by tag, can add multiple --tag (tagname)
                               |   prefix a tag with '-' to exclude cases with the tag
   --pickup                    | Use existing generated output if exists and  where possible
   --plot                      | Plot contour before representation generation
   --image                     | Generate image of mesh (forced).
                               |   combine with Xvfb :5 -screen 0 2560x1440x8 to run in the background
   --mesh                      | Mesh geometry (forced)
   --update                    | Update verification test files
                               |_________________________________________________________________________________
   --legacy                    | Enable legacy options
                               |  combine with -h for further details
                               |_________________________________________________________________________________
   -h                          | Help
   -v                          | Verbose
   --debug                     | Very verbose (debugging)
   -q                          | Quiet
                               \__________________________________________________________________________________''' % { 'cmdname': os.path.basename(sys.argv[0]), 'stages':' '.             join(universe._all_stages) }
    if universe.legacy.legacy:
        print '''Legacy options ----------------\
 %(cmdname)s [options]
   -n filename                 | Input netCDF file
   -f filename                 | Output Gmsh file
                               |
   -p path1 (path2)..          | Specify paths to include
   -pn path1 (path2)..         | Specify paths to exclude
   -r function                 | Function specifying region of interest
   -b box1 (box2)..            | Boxes with regions of interest
   -a minarea                  | Minimum area of islands
   -dx dist                    | Distance of steps when drawing parallels and meridians (currently in degrees - need to project)
   -m projection               | Projection type (default 'Cartesian', 'LongLat')
   -bounding_latitude latitude | Latitude of boundary to close the domain
   -bl latitude                | Short form of -bounding_latitude
   -t type                     | Contour type (default: iceshelfcavity) icesheet gsds
   -exclude_iceshelves         | Excludes iceshelf ocean cavities from mesh (default behaviour includes region)
   -smooth_data degree         | Smoothes boundaries
   -no                         | Do not include open boundaries
   -lat latitude               | Latitude to extend open domain to
   -el                         | Element length (default 1.0E5)
   -metric                     | Generate background metric based on bathymetry
                               \_________________________________________________________________________________
Example usage:
Include only the main Antarctic mass (path 1), and only parts which lie below 60S
  %(cmdname)s --legacy -r 'latitude <= -60.0' -p 1
Filchner-Ronne extended out to the 65S parallel
  %(cmdname)s --legacy -no -b -85.0:-20.0,-89.0:-75.0 -64.0:-30.0,-89.0:-70.0 -30.0:-20.0,-89.0:-75.0 -lat '-65.0'
Antarctica, everything below the 60S parallel, coarse approximation to open boundary
  %(cmdname)s --legacy -dx 2 -r 'latitude <= -60'
Small region close to the Filcher-Ronne ice shelf
  %(cmdname)s --legacy -no -b -85.0:-20.0,-89.0:-75.0 -64.0:-30.0,-89.0:-70.0 -30.0:-20.0,-89.0:-75.0 -p 1 -r 'latitude <= -83'
Amundsen Sea
  %(cmdname)s --legacy -no -b -130.0:-85.0,-85.0:-60.0 -lat -64.0''' % { 'cmdname': os.path.basename(sys.argv[0]), 'stages':' '.join(universe._all_stages) }
    sys.exit(1)


#Small islands, single out, or group with -p
#  312, 314
#  79 - an island on 90W 68S


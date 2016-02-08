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
import shutil
import math
import os.path

import Spud
#import libspud

#libspud.load_options('test.flml')
#libspud.print_options()

#### IMPORT START
import matplotlib
matplotlib.use('Agg')
from pylab import contour
#### IMPORT END
#import matplotlib
#matplotlib._cntr.Cntr
#from matplotlib import contour
#matplotlib.use('Agg')
from numpy import zeros, array, append, arange, exp, size, concatenate, ceil, asarray, exp

#contour = matplotlib.pyplot.contour

from Mathematical import norm, normalise, smoothGaussian, area_enclosed, segments

from Reporting import printvv


from StringOperations import expand_boxes

from specific.Pig import pig_sponge

from Import import read_rtopo, read_raster, read_shape, read_paths

from Projection import project
from Projection import longitude_diff, point_diff, point_diff_cartesian, compare_points, p2

from MeshGeneration import generate_mesh, generate_mesh2
from MetricGeneration import generatemetric

from RepresentationTools import array_to_gmsh_points

from StringOperations import list_to_comma_separated, list_to_space_separated 

from Usage import usage


from SurfaceGeoidDomainRepresentation import SurfaceGeoidDomainRepresentation



# #### IMPORT START
# earth_radius = 6.37101e+06
# dx_default = 0.1
# #fileid = 'G'
# fileid = ''
# compound = False
# #compound = True
# more_bsplines = False
# # Interestingly, if the following is true, gmsh generates a nice mesh, but complains (rightly so) on multiple definitions of a physical line id.  If false, the mesh contains extra 1d elements, which need parsing out!
# physical_lines_separate = False
# #### IMPORT END


def main():

  from Universe import universe
  from Support import globalsInit

  # TODO
  # Add repo version number/release in geo header
  #
  # Calculate area in right projection
  # Add region selection function
  # Ensure all islands selected
  # Identify Open boundaries differently
  # Export command line to geo file
  # If nearby, down't clode with parallel

  #   #### IMPORT START
  #   earth_radius = 6.37101e+06
  #   dx_default = 0.1
  #   #fileid = 'G'
  #   fileid = ''
  #   compound = False
  #   #compound = True
  #   more_bsplines = False
  #   # Interestingly, if the following is true, gmsh generates a nice mesh, but complains (rightly so) on multiple definitions of a physical line id.  If false, the mesh contains extra 1d elements, which need parsing out!
  #   physical_lines_separate = False
  #   #### IMPORT END





  #def scenario(name):
  #  filcher_ronne = argument

  argv = sys.argv[1:]
  globalsInit(argv)


  while (len(argv) > 0):
    argument = argv.pop(0).rstrip()
    if   (argument == '-h'): usage()
    elif (argument == '-s'): universe.scenario = str(argv.pop(0).rstrip()); universe=scenario(universe.scenario)
    elif (argument == '-n'): universe.input  = argv.pop(0).rstrip()
    elif (argument == '-f'): universe.output = argv.pop(0).rstrip()
    elif (argument == '-t'): universe.contourtype = argv.pop(0).rstrip()
    elif (argument == '-r'): universe.region = argv.pop(0).rstrip()
    elif (argument == '-m'): universe.projection = argv.pop(0).rstrip()
    elif (argument == '-dx'): universe.dx = float(argv.pop(0).rstrip())
    elif (argument == '-lat'): universe.extendtolatitude = float(argv.pop(0).rstrip()); universe.closewithparallels = True
    elif (argument == '-a'): universe.minarea = float(argv.pop(0).rstrip())
    elif (argument == '-bounding_latitude'): universe.bounding_lat =float(argv.pop(0).rstrip())
    elif (argument == '-bl'): universe.bounding_lat = float(argv.pop(0).rstrip())
    elif (argument == '-smooth_data'):
      universe.smooth_degree = int(argv.pop(0).rstrip())
      universe.smooth_data = True
    elif (argument == '-no'): universe.open = False
    elif (argument == '-exclude_ice_shelves'): universe.include_iceshelf_ocean_cavities = False
    elif (argument == '-c'): universe.cache = True
    elif (argument == '-plot'): universe.plotcontour = True
    elif (argument == '-mesh'): universe.generatemesh = True
    elif (argument == '-m'): universe.projection = argv.pop(0).rstrip()
    elif (argument == '-el'): universe.elementlength = argv.pop(0).rstrip()
    elif (argument == '-metric'): universe.generatemetric = True
    elif (argument == '-v'): universe.verbose = True
    elif (argument == '-vv'): universe.verbose = True; universe.debug = True; 
    elif (argument == '-q'): universe.verbose = False
    elif (argument == '-p'):
      while ((len(argv) > 0) and (argv[0][0] != '-')):
        universe.boundaries.append(int(argv.pop(0).rstrip()))
    elif (argument == '-pn'):
      while ((len(argv) > 0) and (argv[0][0] != '-')):
        universe.boundariestoexclude.append(int(argv.pop(0).rstrip()))
    elif (argument == '-b'):
      while ((len(argv) > 0) and ((argv[0][0] != '-') or ( (argv[0][0] == '-') and (argv[0][1].isdigit()) ))):
        universe.box.append(argv.pop(0).rstrip())

  universe.region = expand_boxes(universe.region, universe.box)

  print universe.dx,  universe.dx_default


  if (universe.generatemetric):
    print('Generating metric...')
    generatemetric(universe.input)
    sys.exit(0)

  rep = SurfaceGeoidDomainRepresentation()

  #source = file(universe.input,'r')
  #output = file(universe.output,'w')
  rep.filehandleOpen(universe.output)

  rep.gmsh_comment('Arguments: ' + universe.call)
  if (not(os.path.isfile(universe.input))):
    print('Source netCDF ' + universe.input + ' not found!')
    sys.exit(1)
  rep.report('Source netCDF located at ' + universe.input)
  universe.picklefile = universe.input + '.' + universe.contourtype + '.pkl'
  if (not(os.path.isfile(universe.picklefile))):
    print('Contour cache ' + universe.picklefile + ' not found, forcing generation.')
    universe.cache = True
  rep.report('Output to ' + universe.output)
  rep.report('Projection type ' + universe.projection)
  if (len(universe.boundaries) > 0):
    rep.report('Boundaries restricted to ' + str(universe.boundaries))
  if (universe.region is not 'True'):
    rep.report('Region defined by ' + str(universe.region))
  if (universe.dx != universe.dx_default):
    rep.report('Open contours closed with a line formed by points spaced %(dx)g degrees apart' % {'dx':universe.dx} )
  if (universe.extendtolatitude is not None):
    rep.report('Extending region to meet parallel on latitude ' + str(universe.extendtolatitude))

  rep.gmsh_comment('')




  rep.output_boundaries(filename=universe.input, paths=universe.boundaries, minarea=universe.minarea, region=universe.region, dx=universe.dx, latitude_max=universe.extendtolatitude)

  if (universe.open):
    rep.output_open_boundaries()
  rep.output_surfaces()

  #from specific.AntarcticCircumpolarCurrent import draw_acc
  #index = draw_acc(index, boundary, universe.dx)

  rep.gmsh_section('End of contour definitions')

  rep.output_fields()


  if (len(rep.index.skipped) > 0):
    rep.report('Skipped (because no point on the boundary appeared in the required region, or area enclosed by the boundary was too small):\n'+' '.join(rep.index.skipped))
  rep.filehandleClose()
  #output.close()

  generate_mesh2(universe.output)


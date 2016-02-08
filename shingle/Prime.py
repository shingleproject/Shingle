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



from specific.Pig import pig_sponge

from Import import read_rtopo, read_raster, read_shape, read_paths

from Projection import project
from Projection import longitude_diff, point_diff, point_diff_cartesian, compare_points, p2

from MeshGeneration import generate_mesh
from MetricGeneration import generatemetric

from RepresentationTools import array_to_gmsh_points

from StringOperations import list_to_comma_separated, list_to_space_separated 

from Usage import usage




def main():

  from Universe import universe
  from Support import globalsInit, ReadArguments
  from SurfaceGeoidDomainRepresentation import SurfaceGeoidDomainRepresentation


  globalsInit()
  ReadArguments()
  


  if (universe.generatemetric):
    print('Generating metric...')
    generatemetric(universe.input)
    sys.exit(0)

  rep = SurfaceGeoidDomainRepresentation()

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
  rep.output_open_boundaries()
  rep.output_surfaces()

  #from specific.AntarcticCircumpolarCurrent import draw_acc
  #index = draw_acc(index, boundary, universe.dx)

  rep.gmsh_section('End of contour definitions')

  rep.output_fields()

  rep.reportSkipped()
  rep.filehandleClose()

  generate_mesh(universe.output)


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

def main():
  """ Main routine 
  """

  from Universe import universe
  from Support import InitialiseGlobals, ReadArguments
  from SurfaceGeoidDomainRepresentation import SurfaceGeoidDomainRepresentation

  from Raster import Raster
  from MeshGeneration import Mesh
  from MetricGeneration import Metric

  from ReadOptionTree import ReadOptionTree

  InitialiseGlobals()
  ReadArguments()

  ReadOptionTree()

  h = Metric(output = './metric.pos')
  h.Generate(sourcefile = universe.source)

  if universe.optiontreesource is None:
    universe.dataset['legacy'] = Raster(location=universe.source, cache=universe.cache)
  #s = universe.surface_geoid_rep[surface_geoid_rep_names[0]]
  #r = Raster(source=universe.source, cache=universe.cache)
  #r.Generate()

  try:
    surface_geoid_rep_names = universe.surface_geoid_rep.keys()
    name = universe.surface_geoid_rep[surface_geoid_rep_names[0]].name
  except:
    name = ''
    pass

  rep = SurfaceGeoidDomainRepresentation(name=name)
  #import sys; sys.exit()
  #rep.AddPath(r)
  rep.Generate()

  m = Mesh(source = universe.output)
  m.Generate()


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
from Universe import universe
from Reporting import report, error
from Spud import libspud
from Raster import Dataset, Raster


class ReadMultipleInstance(object):

  _prefix = None
  _number = None
  _path = None
  name = None
  
  def __init__(self, prefix, number):
    self._prefix = prefix
    self._number = number
    self._path = None
    self.name = None
    self.Read()

  def Read(self):
    self.name = libspud.get_option('%(prefix)s[%(number)d]/name' % {'prefix':self._prefix, 'number':self._number} )
    self._path = '%(prefix)s::filchner_ronne_ice_ocean::%(name)s' % {'prefix':self._prefix, 'name':self.name} 

  def Show(self):
    report('  %(blue)s%(number)s.%(end)s %(name)s', var = {'number':self._number, 'name':self.name })
    report('      %(blue)spath:      %(end)s%(path)s', var = {'path':self._path} )


def ReadOptionTree(case=None):
  """ Read options from the supplied .shml file
  """

  if case is None:
    return

  libspud.load_options(case)

  #universe.optiontreecontent = libspud.write_options()
  # Read file directly into content, add '//'
  
  universe.name = libspud.get_option('initialisation_name')

  if libspud.have_option('/global_parameters/planet_radius'):
    universe.planet_radius = libspud.get_option('/global_parameters/planet_radius')

  if libspud.have_option('/global_parameters/spacing_default'):
    universe.dx_default = libspud.get_option('/global_parameters/spacing_default')

  universe.physical_lines_separate = libspud.have_option('/global_parameters/physical_lines_separate')

  dataset = universe.dataset

  for number in range(libspud.option_count('/dataset')):
    d = Dataset(number=number)
    if d.form == 'Raster':
      d = Raster(number=number)
    elif d.form == 'Polyline':
      raise NotImplementedError
    else:
      raise NotImplementedError
    dataset[d.name] = d
  report('Found %(number)d datasets:' % { 'number':len(dataset) })
  for d in dataset.keys():
    dataset[d].Show()

  surface_geoid_rep = universe.surface_geoid_rep

  for number in range(libspud.option_count('/surface_geoid_representation')):
    if len(surface_geoid_rep) > 0:
      error('More than one surface geoid representation in the same initialisaiton currently not supported. Will examine the first for now.', fatal=False)
      break
    d = ReadMultipleInstance('/surface_geoid_representation', number)
    surface_geoid_rep[d.name] = d

  report('Found %(number)d surface geoid representations:' % { 'number':len(surface_geoid_rep) })
  for d in surface_geoid_rep.keys():
    surface_geoid_rep[d].Show()


def old():
  assert libspud.get_option('/timestepping/timestep') == 0.025

  assert libspud.get_number_of_children('/geometry') == 5
  assert libspud.get_child_name('geometry', 0) == "dimension"

  assert libspud.option_count('/problem_type') == 1
  assert libspud.have_option('/problem_type')

  assert libspud.get_option_type('/geometry/dimension') is int
  assert libspud.get_option_type('/problem_type') is str

  assert libspud.get_option_rank('/geometry/dimension') == 0
  assert libspud.get_option_rank('/physical_parameters/gravity/vector_field::GravityDirection/prescribed/value/constant') == 1

  assert libspud.get_option_shape('/geometry/dimension') == (-1, -1)
  assert libspud.get_option_shape('/problem_type')[0] > 1
  assert libspud.get_option_shape('/problem_type')[1] == -1

  assert libspud.get_option('/problem_type') == "multimaterial"
  assert libspud.get_option('/geometry/dimension') == 2
  libspud.set_option('/geometry/dimension', 3)


  assert libspud.get_option('/geometry/dimension') == 3

  list_path = '/material_phase::Material1/scalar_field::MaterialVolumeFraction/prognostic/boundary_conditions::LetNoOneLeave/surface_ids'
  assert libspud.get_option_shape(list_path) == (4, -1)
  assert libspud.get_option_rank(list_path) == 1
  assert libspud.get_option(list_path) == [7, 8, 9, 10]

  libspud.set_option(list_path, [11, 12, 13, 14, 15])
  assert libspud.get_option_shape(list_path) == (5, -1)
  assert libspud.get_option_rank(list_path) == 1
  assert libspud.get_option(list_path)==[11, 12, 13, 14, 15]

  tensor_path = '/material_phase::Material1/tensor_field::DummyTensor/prescribed/value::WholeMesh/anisotropic_asymmetric/constant'
  assert libspud.get_option_shape(tensor_path) == (2, 2)
  assert libspud.get_option_rank(tensor_path) == 2

  assert libspud.get_option(tensor_path)==[[1.0,2.0],[3.0,4.0]]

  libspud.set_option(tensor_path, [[5.0,6.0,2.0],[7.0,8.0,1.0]])
  assert libspud.get_option_shape(tensor_path) == (2,3)
  assert libspud.get_option_rank(tensor_path) == 2

  assert(libspud.get_option(tensor_path)==[[5.0, 6.0, 2.0],[7.0, 8.0, 1.0]])

  try:
    libspud.add_option('/foo')
    assert False
  except libspud.SpudNewKeyWarning, e:
    pass

  assert libspud.option_count('/foo') == 1

  libspud.set_option('/problem_type', 'helloworld')
  assert libspud.get_option('/problem_type') == "helloworld"

  try:
    libspud.set_option_attribute('/foo/bar', 'foobar')
    assert False
  except libspud.SpudNewKeyWarning, e:
    pass

  assert libspud.get_option('/foo/bar') == "foobar"
    
  libspud.delete_option('/foo')
  assert libspud.option_count('/foo') == 0

  try:
    libspud.get_option('/foo')
    assert False
  except libspud.SpudKeyError, e:
    pass

  try:
    libspud.get_option('/geometry')
    assert False
  except libspud.SpudTypeError, e:
    pass

  libspud.write_options('test_out.flml')

  libspud.set_option('/test',4)

  assert libspud.get_option('/test') == 4

  libspud.set_option('/test',[[4.0,2.0,3.0],[2.0,5.0,6.6]]) 

  assert libspud.get_option('/test') == [[4.0,2.0,3.0],[2.0,5.0,6.6]]

  libspud.set_option('/test',"Hallo")

  assert libspud.get_option('/test') == "Hallo"

  libspud.set_option('/test',[1,2,3])

  assert libspud.get_option('/test') == [1,2,3] 

  libspud.set_option('/test',[2.3,3.3])

  assert libspud.get_option('/test') == [2.3,3.3]

  try:
    libspud.set_option('/test')
    assert False
  except libspud.SpudError, e:
    pass
    

  print "All tests passed!"


#  def Show(self):
#    report('  %(blue)s%(number)s.%(end)s %(name)s', var = {'number':self._number, 'name':self.name })
#    report('        %(blue)spath:      %(end)s%(path)s', var = {'path':self._path} )
#    report('        %(blue)sform:      %(end)s%(form)s', var = {'form':self.form} )
#    report('        %(blue)ssource:    %(end)s%(source)s', var = {'source':self.source} )
#    report('        %(blue)slocation:  %(end)s%(location)s', var = {'location':self.location} )
#    report('        %(blue)sprojection:%(end)s%(projection)s', var = {'projection':self.projection} )



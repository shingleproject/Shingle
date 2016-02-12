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
from Reporting import report, error, Log
from Spud import libspud
from Raster import Dataset, Raster


class ReadMultipleInstance(object):

  _prefix = None
  _number = None
  _path = None
  name = None
  
  def __init__(self, prefix, number, name=None):
    self._prefix = prefix
    self._number = number
    self._path = None
    if name is None:
      self.name = None
      self.Read()
    else:
      self.name = name
      self.path = prefix

  def Read(self):
    self.name = libspud.get_option('%(prefix)s[%(number)d]/name' % {'prefix':self._prefix, 'number':self._number} )
    self._path = '%(prefix)s::filchner_ronne_ice_ocean::%(name)s' % {'prefix':self._prefix, 'name':self.name} 

  def Show(self):
    report('  %(blue)s%(number)s.%(end)s %(name)s', var = {'number':self._number, 'name':self.name })
    report('      %(blue)spath:      %(end)s%(path)s', var = {'path':self._path} )


class Scenario(object):
  """ Read options from the supplied .shml file

    Name()
    PlanetRadius()
    Spacing()
    PhysicalLinesSeparate()
    Dataset()
    SurfaceGeoidRep()

    RawContent()


  """

  _loaded = False
  _dataset_read = False
  _surface_geoid_rep_read = False
  _filename = None

  _dataset = {}
  _surface_geoid_rep = {}

  def __init__(self, case = None):
    if (case is None) and universe.legacy.legacy:
      case = self.Legacy()
    self._filename = case
    self.LoadOptions()
    self.Dataset()
    self.SurfaceGeoidRep()
    log = Log(on=universe.log_active)
    self.Generate()

  def Name(self):
    if self._loaded and libspud.have_option('/initialisation_name'):
      return libspud.get_option('/initialisation_name')
    else:
      return universe.default.name

  def Root(self):
    return os.path.realpath(os.path.dirname(self._filename))

  def PathRelative(self, path):
    if path.startswith('/'):
      return path
    return os.path.realpath(os.path.join(self.Root(), path))

  def LoadOptions(self):
    if universe.legacy.legacy:
      return
    libspud.load_options(case)
    self._loaded = True

  def PlanetRadius(self):
    if self._loaded and libspud.have_option('/global_parameters/planet_radius'):
      return libspud.get_option('/global_parameters/planet_radius')
    else:
      return universe.default.planet_radius

  def Spacing(self):
    if self._loaded and libspud.have_option('/global_parameters/spacing_default'):
      return libspud.get_option('/global_parameters/spacing_default')
    else:
      return universe.default.dx_default

  def PhysicalLinesSeparate(self):
    if self._loaded and libspud.have_option('/global_parameters/physical_lines_separate'):
      return libspud.get_option('/global_parameters/physical_lines_separate')
    else:
      return universe.default.physical_lines_separate

  def Dataset(self):
    # Handle legacy
    if not self._dataset_read:
      self._ReadDataset()
    return self._dataset

  def SurfaceGeoidRep(self):
    # Handle legacy
    if not self._surface_geoid_rep_read:
      self._ReadSurfaceGeoidRep()
    return self._surface_geoid_rep

  def _ReadDataset(self):
    self._dataset = {} 

    for number in range(libspud.option_count('/dataset')):
      d = Dataset(scenario=self, number=number)
      if d.form == 'Raster':
        d = Raster(scenario=self, number=number)
      elif d.form == 'Polyline':
        raise NotImplementedError
      else:
        raise NotImplementedError
      #print d.SourceExists()
      #print d.location
      if d.SourceExists():
        self._dataset[d.name] = d
      else:
        error('Dataset %(name)s source not available at: %(location)s' % {'name':d.name, 'location':d.LocationFull()})
    report('DATASETS: Found %(number)d datasets:' % { 'number':len(self._dataset) })
    for d in self._dataset.keys():
      self._dataset[d].Show()
    self._dataset_read = True

  def _ReadSurfaceGeoidRep(self):
    self._surface_geoid_rep = {} 

    for number in range(libspud.option_count('/surface_geoid_representation')):
      if len(self._surface_geoid_rep) > 0:
        error('More than one surface geoid representation in the same initialisaiton currently not supported. Will examine the first for now.', fatal=False)
        break
      d = ReadMultipleInstance('/surface_geoid_representation', number)
      self._surface_geoid_rep[d.name] = d

    report('SURFACE GEOID REPRESENTATIONS: Found %(number)d surface geoid representations:' % { 'number':len(self._surface_geoid_rep) })
    for d in self._surface_geoid_rep.keys():
      self._surface_geoid_rep[d].Show()
    self._surface_geoid_rep_read = True

  def _ReadRawContent(self):
    f = open(self._filename, 'r')
    raw_content = f.read()
    f.close()
    return raw_content

  def RawContent(self, comment=False):
    raw_content = self._ReadRawContent()
    if not comment:
      return raw_content
    else:
      prefix = '//  '
      return ''.join([ ( prefix + line ) for line in raw_content.splitlines(True) ])

  def Legacy(self):
    self._dataset['legacy'] = Raster(location=universe.legacy.source, scenario=self)
    self._dataset_read = True
    self._surface_geoid_rep['legacy'] = ReadMultipleInstance('/legacy', 1, name='legacy')

    self._surface_geoid_rep_read = True
    return universe.legacy.output

  def SurfaceGeoidRepFirstName(self):
    if len(self.SurfaceGeoidRep()) == 0:
      return ''
    else:
      names = self.SurfaceGeoidRep().keys()
      return self.SurfaceGeoidRep()[names[0]].name

  def Generate(self):

    from Universe import universe
    from Test import VerificationTests
    from SurfaceGeoidDomainRepresentation import SurfaceGeoidDomainRepresentation

    from Scenario import Scenario

    from Raster import Raster
    from MeshGeneration import Mesh
    from MetricGeneration import Metric

    # For now limit to the first surface geoid representation
    name = self.SurfaceGeoidRepFirstName()

    rep = SurfaceGeoidDomainRepresentation(scenario=self, name=name)
    # #import sys; sys.exit()
    # #rep.AddPath(r)
    rep.Generate()

    #print s.RawContent(comment=True)

    #s = universe.surface_geoid_rep[surface_geoid_rep_names[0]]
    #r = Raster(source=universe.legacy.source, cache=universe.cache)
    #r.Generate()

  
    # name = s.SurfaceGeoidRepFirstName()

    # rep = SurfaceGeoidDomainRepresentation(name=name)
    # #import sys; sys.exit()
    # #rep.AddPath(r)
    # rep.Generate()

    # Bring into Scenario
    #h = Metric()
    #h.Generate()

    m = Mesh(source = universe.legacy.output)
    m.Generate()

    VerificationTests(rep)









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



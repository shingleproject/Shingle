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

# gmsh_header
# gmsh_footer
# gmsh_remove_projection_points
# gmsh_format_point
# gmsh_loop
# output_boundaries
# define_point
# draw_parallel
# close_path
# draw_parallel_explicit
# output_open_boundaries
# output_surfaces
# output_fields

from Universe import universe
from Reporting import report, error, addcolour
from RepresentationTools import draw_parallel_explicit
from Spud import libspud
from BRepComponent import BRepComponent

class SurfaceBRepIndexes(object):
  point = 0
  path = 0
  contour = []
  contournodes= []
  open = []
  skipped = []
  start = 0
  pathsinloop = []
  physicalgroup = []
  loop = 0
  loops = []
  physicalcontour = []
  physicalopen = []

  def _InitialiseIndexes(self):
    self.point = 0
    self.path = 0
    self.contour = []
    self.contournodes= []
    self.open = []
    self.skipped = []
    self.start = 0
    self.pathsinloop = []
    self.physicalgroup = []
    self.loop = 0
    self.loops = []
    self.physicalcontour = []
    self.physicalopen = []

  def __init__(self):
    self._InitialiseIndexes()

class SurfaceGeoidDomainRepresentation(object):

  _cacheFiletype = '.shc'
  _brep_components = None
  _path = None
  _filehandle = None
  _pathall = None
  
  name = None 
  scenario = None
  content = None
  index = None
  
  def __init__(self, scenario=None, name='SurfaceGeoidDomainRepresentation'):
    self.name = name
    self.scenario = scenario
    self._path = '/surface_geoid_representation::%(name)s/' % {'name':self.name}
    self.content = ''
    self.report('Initialising surface geoid representation %(name)s', var = {'name':self.name}, include=False, indent=1)
    self.index = SurfaceBRepIndexes()

    self.AppendArguments()
    self.AppendParameters()

  def SurfaceId(self):
    if libspud.have_option(self._path + 'id'):
      return libspud.get_option(self._path + 'id')
    else:
      return universe.default.boundary.surface
      
  def Fileid(self):
    if libspud.have_option(self._path + 'id_internal_suffix'):
      return libspud.get_option(self._path + 'id_internal_suffix')
    else:
      return universe.default.fileid

  # ------------------------------------------------------------ 

  def Output(self, *args, **kwargs):
    return self.scenario.Output(*args, **kwargs)

  def Projection(self, *args, **kwargs):
    return self.scenario.Projection(*args, **kwargs)

  # ------------------------------------------------------------ 

  def MoreBSplines(self):
    if libspud.have_option(self._path):
      return libspud.have_option(self._path + 'more_bsplines')
    else:
      return universe.default.more_bsplines

  def Open(self):
    if libspud.have_option(self._path):
      return not libspud.have_option(self._path + 'closure/no_open')
    else:
      return universe.default.open

  def CloseWithParallels(self):
    if libspud.have_option(self._path):
      return libspud.have_option(self._path + 'closure/close_with_parallels')
    else:
      return universe.default.closewithparallels

  def OpenId(self):
    if libspud.have_option(self._path + 'closure/open_id'):
      return libspud.get_option(self._path + 'closure/open_id')
    else:
      return universe.default.boundary.open

  def BoundingLatitude(self):
    if libspud.have_option(self._path + 'closure/bounding_latitude'):
      return libspud.get_option(self._path + 'closure/bounding_latitude')
    else:
      return universe.default.bounding_lat

  def ExtendToLatitude(self):
    if libspud.have_option(self._path + 'closure/extend_to_latitude'):
      return libspud.get_option(self._path + 'closure/extend_to_latitude')
    else:
      return universe.default.extendtolatitude

  def AddPath(self, source):
    #self.AddContent(source.log)
    self._pathall = source._pathall

  def BRepComponents(self):
    if self._brep_components is None:
      self._brep_components = {}

      if universe.legacy.legacy:
        b = BRepComponent(self, 1)
        self._brep_components[b.Name()] = b

      path = '/surface_geoid_representation::%(name)s/' % {'name':self.name}
      for number in range(libspud.option_count(path + 'brep_component')):
        if len(self._brep_components) > 0:
          error('More than one boundary representation component in the same initialisaiton currently not supported. Will examine the first for now.', fatal=False)
          break
        b = BRepComponent(self, number)
        self._brep_components[b.Name()] = b

      if len(self._brep_components) == 0:
        error('No component boundary representations found', fatal=True)
      report('COMPONENT BOUNDARY REPRESENTATIONS: Found %(number)d component boundary representations:' % { 'number':len(self._brep_components) })
      for b in self._brep_components.keys():
        self._brep_components[b].Show()
    return self._brep_components
    
  def BRepComponentFirst(self):
    if len(self.BRepComponents()) == 0:
      return ''
    else:
      names = self.BRepComponents().keys()
      return self.BRepComponents()[names[0]]

  def filehandleOpen(self):
    fullpath = self.scenario.PathRelative(self.Output())
    report('%(blue)sWriting surface geoid representation to file:%(end)s %(yellow)s%(filename)s%(end)s %(grey)s(%(fullpath)s)%(end)s', var={'filename':self.Output(), 'fullpath':fullpath})
    self._filehandle = file(fullpath,'w')

  def filehandleClose(self):
    self._filehandle.close()

  def WriteContent(self):
    self.filehandleOpen()
    self._filehandle.write(self.content)
    self.filehandleClose()

  def AddContent(self, string=''):
    from os import linesep
    #self._filehandle.write( string + linesep)
    self.content = self.content + string + linesep

  def report(self, *args, **kwargs):
    self.scenario.report(*args, **kwargs)

    linclude = True
    ldebug = False
    if 'include' in kwargs:
      linclude = kwargs['include']
    if 'debug' in kwargs:
      ldebug = kwargs['debug']
      if ldebug and not universe.debug:
        return
    if linclude:
      lvar = {}
      if 'var' in kwargs:
        lvar = kwargs['var']
      self.gmsh_comment(comment=args[0] % addcolour(lvar, colourful = False))


  def reportSkipped(self):
    from os import linesep
    if len(self.index.skipped) > 0:
      self.report('Skipped (because no point on the boundary appeared in the required region, or area enclosed by the boundary was too small):'+linesep+' '.join(rep.index.skipped))

  def AppendArguments(self):
    self.gmsh_comment('Arguments: ' + universe.call)

  def AppendParameters(self):
    self.report('Output to ' + self.Output(), indent=1)
    self.report('Projection type ' + self.Projection(), indent=1)
    if self.ExtendToLatitude() is not None:
      self.report('Extending region to meet parallel on latitude ' + str(self.ExtendToLatitude()))
    self.gmsh_comment('')

  

  def gmsh_comment(self, comment, newline=False):
    if newline:
      self.AddContent()
    if (len(comment) > 0):
      self.AddContent( '// ' + comment )

  def gmsh_section(self, title):
    line = '='
    self.gmsh_comment('%s %s %s' % ( line * 2, title, line * (60 - len(title))), True)


  def Generate(self):
#   from specific.Pig import pig_sponge
    brep = self.BRepComponentFirst()
    r = brep.Generate()
    #brepsource = brep.Source()

    # Temp
    #return

    #if brepsource not in self.scenario.Dataset().keys():
    #  error('Dataset %(dataset)s required for surface geoid representation %(rep)s' % {'dataset':brepsource, 'rep':self.name}, fatal=True)

    #r = self.scenario.Dataset()[brepsource]
    #r.Generate()
    self.AddPath(brep)
    

    brep.output_boundaries()
    brep.output_open_boundaries()
    brep.output_surfaces()

    #from specific.AntarcticCircumpolarCurrent import draw_acc
    #index = draw_acc(index, boundary, self.dx)

    brep.gmsh_section('End of contour definitions')

    brep.output_fields()

    self.reportSkipped()
    self.WriteContent()
    




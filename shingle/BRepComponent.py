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
from Reporting import report, error
from Import import read_paths
from StringOperations import expand_boxes, bound_by_latitude, list_to_comma_separated, list_to_space_separated
from RepresentationTools import draw_parallel_explicit
from Spud import libspud
from Plot import PlotContours

class BRepComponent():

  _name = None
  _path = None
  _formpath = None
  _form_type = None
  _surface_rep = None
  _representation_type = None
 
  _region = None
  _boundary = None
  _boundary_to_exclude = None

  index = None

  def __init__(self, surface_rep, number):
    self.number = number
    self._surface_rep = surface_rep
    self._surface_rep.report('Reading boundary representation %(name)s', var = {'name':self.Name()}) 
    self._path = '/surface_geoid_representation::%(name)s/brep_component::%(brep_name)s/' % {'name':self._surface_rep.name, 'brep_name':self.Name()}
    self.index = self._surface_rep.index
    self.AppendParameters()


  # Imports:
  def report(self, *args, **kwargs):
    return self._surface_rep.report(*args, **kwargs)

  #def report(self, text, include = True, debug = False, var = {}):
  #  self._surface_rep.report(text = text, include = include, debug = debug, var = var)

  def gmsh_comment(self, *args, **kwargs):
    return self._surface_rep.gmsh_comment(*args, **kwargs)

  def gmsh_section(self, *args, **kwargs):
    return self._surface_rep.gmsh_section(*args, **kwargs)

  def ExtendToLatitude(self, *args, **kwargs):
    return self._surface_rep.ExtendToLatitude(*args, **kwargs)
  
  def Fileid(self, *args, **kwargs):
    return self._surface_rep.Fileid(*args, **kwargs)
  
  def Projection(self, *args, **kwargs):
    return self._surface_rep.Projection(*args, **kwargs)
  
  def AddContent(self, *args, **kwargs):
    return self._surface_rep.AddContent(*args, **kwargs)
  
  def MoreBSplines(self, *args, **kwargs):
    return self._surface_rep.MoreBSplines(*args, **kwargs)
  
  def OpenId(self, *args, **kwargs):
    return self._surface_rep.OpenId(*args, **kwargs)
  
  def Open(self, *args, **kwargs):
    return self._surface_rep.Open(*args, **kwargs)
  
  def BoundingLatitude(self, *args, **kwargs):
    return self._surface_rep.BoundingLatitude(*args, **kwargs)

  def SurfaceId(self, *args, **kwargs):
    return self._surface_rep.SurfaceId(*args, **kwargs)

  def CloseWithParallels(self, *args, **kwargs):
    return self._surface_rep.CloseWithParallels(*args, **kwargs)

  def BoundingLatitude(self, *args, **kwargs):
    return self._surface_rep.BoundingLatitude(*args, **kwargs)

  # ---------------------------------------- 



  def Show(self):
    self.report('  %(blue)s%(number)s.%(end)s %(name)s', var = {'number':self.number, 'name':self.Name() })
    self.report('      %(blue)spath:       %(end)s%(path)s', var = {'path':self._path} )
    self.report('      %(blue)sform:       %(end)s%(form)s', var = {'form':self.FormType()} )

  def Name(self):
    if self._name is None:
      if libspud.have_option('/surface_geoid_representation::%(name)s/brep_component[%(number)d]/name' % {'name':self._surface_rep.name, 'number':self.number}):
        self._name = libspud.get_option('/surface_geoid_representation::%(name)s/brep_component[%(number)d]/name' % {'name':self._surface_rep.name, 'number':self.number})
      else:
        self._name = 'legacy'
    return self._name

  def Id(self): 
    if libspud.have_option(self._path + 'id'):
      return libspud.get_option(self._path + 'id')
    else:
      return universe.default.boundary.contour

  # To be moved to MetricGeneration
  def BaseEdgeLength(self):
    if libspud.have_option('/metric_options/element_length'):
      return libspud.get_option('/metric_options/element_length')
    else:
      return universe.default.elementlength
  
  def Spacing(self):
    if libspud.have_option(self._path + 'spacing'):
      return libspud.get_option(self._path + 'spacing')
    else:
      return universe.default.dx

  def RepresentationType(self):
    if self._representation_type is None:
      if libspud.have_option(self._path + 'representation_type[0]/name'):
        self._representation_type = libspud.get_option(self._path + 'representation_type[0]/name')
      else:
        return 'Raster'
    return self._representation_type
  
  def isCompound(self):
    return self.RepresentationType() == 'CompoundBSplines'

  def FormType(self):
    if self._form_type is None:
      if libspud.have_option(self._path + 'form[0]/name'):
        self._form_type = libspud.get_option(self._path + 'form[0]/name')
      else:
        self._form_type = 'Raster'
    # Useful to catch this at the moment:
    if self._form_type == 'Polyline':
      raise NotImplementedError
    elif not self._form_type == 'Raster':
      raise NotImplementedError
    return self._form_type
  
  def isRaster(self):
    return self.FormType() == 'Raster'

  def FormPath(self):
    if self._formpath is None:
      self._formpath = '%(path)s/form::%(form)s/' % {'path':self._path, 'form':self.FormType()}
    return self._formpath

  def Source(self):
    if libspud.have_option(self.FormPath() + 'source[0]/name'):
      return libspud.get_option(self.FormPath() + 'source[0]/name')
    else:
      return 'legacy'

  # Raster options
  #if form == 'Raster':
  def Region(self):
    if self._region is None:
      region = universe.default.region
      if libspud.have_option(self.FormPath() + 'region'):
        region = libspud.get_option(self.FormPath() + 'region')
      if libspud.have_option(self.FormPath() + 'box'):
        box = libspud.get_option(self.FormPath() + 'box').split()
        from os import linesep
        self.gmsh_comment('Imposing box region: ' + (linesep + '//    ').join([''] + box))
        region = expand_boxes(region, box )
      bounding_latitude = self.BoundingLatitude()
      if bounding_latitude is not None:
        self.gmsh_comment('Bounding by latitude: ' + str(bounding_latitude))
        region = bound_by_latitude(region, bounding_latitude)
      self.gmsh_comment('Region of interest: ' + region)
      self._region = region
    return self._region

  def MinimumArea(self):
    if libspud.have_option(self.FormPath() + 'minimum_area'):
      return libspud.get_option(self.FormPath() + 'minimum_area')
    else:
      return universe.default.minarea

  def ContourType(self):
    if libspud.have_option(self.FormPath() + 'contourtype[0]'):
      return libspud.get_option(self.FormPath() + 'contourtype[0]/name')
    else:
      return universe.default.contourtype

  def ExcludeIceshelfCavities(self):
    path = '%(form)scontourtype::%(contour)s/exclude_iceshelf_ocean_cavities' % {'form':self.FormPath(), 'contour':self.ContourType()}
    if libspud.have_option(path):
      return libspud.have_option(path)
    else:
      return universe.default.exclude_iceshelf_ocean_cavities

  def Boundary(self):
    if self._boundary is None:
      if libspud.have_option(self.FormPath() + 'boundary'):
        boundaries = libspud.get_option(self.FormPath() + 'boundary').split()
        self._boundary = [int(i) for i in boundaries]
      else:
        self._boundary = universe.default.boundaries
    return self._boundary

  def BoundaryToExclude(self):
    if self._boundary_to_exclude is None:
      if libspud.have_option(self.FormPath() + 'boundary_to_exclude'):
        boundaries = libspud.get_option(self.FormPath() + 'boundary_to_exclude').split()
        self._boundary_to_exclude = [int(i) for i in boundaries]
      else:
        self._boundary_to_exclude = universe.default.boundariestoexclude
    return self._boundary_to_exclude

  def AppendParameters(self):
    if len(self.Boundary()) > 0:
      self.report('Boundaries restricted to ' + str(self.Boundary()))
    if self.Region() is not 'True':
      self.report('Region defined by ' + str(self.Region()))
    self.report('Open contours closed with a line formed by points spaced %(dx)g degrees apart' % {'dx':self.Spacing()} )
    self.gmsh_comment('')

  def Dataset(self):
    name = self.Source()
    return self._surface_rep.scenario.Dataset()[name]


  def GGenerateContour(self):
    self.report('Generating contours', include = False)
    self._pathall = read_paths(self, self.ContourType())


  def GenerateContour(self):
    from Import import read_paths
    dataset = self.Dataset()
    self.report('Generating contours, from raster: ' + dataset.LocationFull(), include = False)
    self._pathall = read_paths(self, dataset, dataset.LocationFull())

  def Generate(self):
    import os
    dataset = self.Dataset()

    dataset.AppendParameters()
    dataset.CheckSource()

    if dataset.cache and os.path.exists(dataset.cachefile):
      dataset.CacheLoad()
    else:
      self.GenerateContour()
      dataset.CacheSave()

    self.report('Paths found: ' + str(len(self._pathall)))








  def gmsh_header(self):
    self.gmsh_section('Header')
    if self.isCompound():
      edgeindex = ' + 1000000'
    else:
      edgeindex = ''
    if not self.isCompound():
      header = '''\
IP%(fileid)s = newp;
IL%(fileid)s = newl;
ILL%(fileid)s = newll;
IS%(fileid)s = news;
IFI%(fileid)s = newf;
''' % { 'fileid':self.Fileid(), 'edgeindex':edgeindex }
    else:
      header = '''\
IP%(fileid)s = 0;
IL%(fileid)s = 0%(edgeindex)s;
ILL%(fileid)s = 0;
IS%(fileid)s = news;
IFI%(fileid)s = newf;
''' % { 'fileid':self.Fileid(), 'edgeindex':edgeindex }
    header_polar = '''
Point ( IP%(fileid)s + 0 ) = { 0, 0, 0 };
Point ( IP%(fileid)s + 1 ) = { 0, 0, %(planet_radius)g };
PolarSphere ( IS%(fileid)s + 0 ) = { IP%(fileid)s, IP%(fileid)s + 1 };
''' % { 'planet_radius': self._surface_rep.scenario.PlanetRadius(), 'fileid': self.Fileid() }
    
    if (self.Projection() not in ['longlat','proj_cartesian'] ):
      header = header + header_polar
    self.AddContent(header)
    self.gmsh_remove_projection_points()


  def gmsh_footer(self, loopstart, loopend):
    # Note used?
    self.AddContent()
    self.AddContent( '''Field [ IFI%(fileid)s + 0 ]  = Attractor;
Field [ IFI%(fileid)s + 0 ].NodesList  = { IP + %(loopstart)i : IP + %(loopend)i };''' % { 'loopstart':loopstart, 'loopend':loopend, 'fileid':self.Fileid() } )

  def gmsh_remove_projection_points(self):
    if self.Projection() == 'longlat':
      return
    self.AddContent( '''Delete { Point{ IP%(fileid)s + 0}; }
Delete { Point{ IP%(fileid)s + 1}; }''' % { 'fileid':self.Fileid() } )


  def gmsh_format_point(self, index, loc, z):
    accuracy = '.8'
    format = 'Point ( IP%(fileid)s + %%i ) = { %%%(dp)sf, %%%(dp)sf, %%%(dp)sf };' % { 'dp': accuracy, 'fileid':self.Fileid() }
    self.AddContent(format % (index, loc[0], loc[1], z))
    #return "Point ( IP + %i ) = { %f, %f, %f }\n" % (index, x, y, z)

  def gmsh_loop(self, index, loopstartpoint, last, open,  cachephysical):
    if (index.point <= index.start):
      return index
    #pointstart = indexstart
    #pointend   = index.point
    #loopnumber = index.loop
    if (last):
      closure = ', IP%(fileid)s + %(pointstart)i' % { 'pointstart':loopstartpoint, 'fileid':self.Fileid() }
    else:
      closure = ''
    if (open):
      index.open.append(index.path)
      type = 'open'
      boundaryid = self.OpenId()
      index.physicalopen.append(index.path)
    else:
      index.contour.append(index.path)
      type = 'contour'
      boundaryid = self.Id()
      index.physicalcontour.append(index.path)

    index.pathsinloop.append(index.path)

  #//Line Loop( ILL + %(loopnumber)i ) = { IL + %(loopnumber)i };
  #// Identified as a %(type)s path
    self.AddContent( '''LoopStart%(loopnumber)i = IP + %(pointstart)i;
LoopEnd%(loopnumber)i = IP + %(pointend)i;''' % { 'pointstart':index.start, 'pointend':index.point, 'loopnumber':index.path, 'loopstartpoint':closure, 'type':type, 'boundaryid':boundaryid } )
    
    if not self.isCompound():
      self.AddContent( '''BSpline ( IL%(fileid)s + %(loopnumber)i ) = { IP%(fileid)s + %(pointstart)i : IP%(fileid)s + %(pointend)i%(loopstartpoint)s };''' % { 'pointstart':index.start, 'pointend':index.point, 'loopnumber':index.path, 'loopstartpoint':closure, 'type':type, 'boundaryid':boundaryid, 'fileid':self.Fileid() } )

    index.physicalgroup.append(index.path)
  #  self.AddContent( '''
  #Physical Line( %(boundaryid)i ) = { %(loopnumbers)s };
  #''' % { 'boundaryid':boundaryid , 'loopnumbers':list_to_comma_separated(index.pathsinloop, prefix = 'IL + ') } )
  #  self.AddContent( '''
  #Physical Line( ILL + %(loop)i ) = { %(loopnumbers)s };
  #''' % { 'loop':index.loop , 'loopnumbers':list_to_comma_separated(index.pathsinloop, prefix = 'IL + ') } )


    if (not(cachephysical)):
      #self.AddContent( '''
  #Physical Line( %(boundaryid)i ) = { %(loopnumbers)s };
  #''' % { 'boundaryid':boundaryid, 'loopnumbers':list_to_comma_separated(index.physicalgroup, prefix = 'IL + ') } )
      index.physicalgroup = []

    compoundpoints = False
    if (last):
      if self.isCompound():
        for i in range(index.start, index.point+1):
          if i == index.point:
            end = index.start
          else:
            end = i + 1
          self.AddContent( '''Line ( ILL%(fileid)s + %(loopnumber)i + 100000 ) = { IP%(fileid)s + %(pointstart)i, IP%(fileid)s + %(pointend)i };
''' % { 'pointstart':i, 'pointend':end, 'loopnumber':i, 'fileid':self.Fileid() } )
        self.AddContent( '''Compound Line ( IL%(fileid)s + %(loopnumber)i ) = { ILL%(fileid)s + %(pointstart)i + 100000 : ILL%(fileid)s + %(pointend)i + 100000 };
''' % { 'pointstart':index.start, 'pointend':index.point, 'loopnumber':index.loop, 'fileid':self.Fileid() } )
        self.AddContent( '''Line Loop( ILL%(fileid)s + %(loop)i ) = { IL%(fileid)s + %(loopnumber)i};''' % { 'loop':index.loop, 'fileid':self.Fileid(), 'loopnumber': index.loop } )

      else:
        self.AddContent()
        self.AddContent( '''Line Loop( ILL%(fileid)s + %(loop)i ) = { %(loopnumbers)s };''' % { 'loop':index.loop, 'fileid':self.Fileid(), 'loopnumbers':list_to_comma_separated(index.pathsinloop, prefix = 'IL%(fileid)s + ' % { 'fileid':self.Fileid() }) } )
      index.loops.append(index.loop)
      index.loop += 1
      index.pathsinloop = []
    
    self.AddContent()

    index.path +=1
    index.start = index.point
    return index

    self.report('Closed boundaries (id %i): %s' % (self.Id(), list_to_space_separated(self.index.contour, add=1)))
    self.report('Open boundaries   (id %i): %s' % (self.OpenId(), list_to_space_separated(self.index.open, add=1)))

  def output_boundaries(self):
    import pickle
    import os
    from numpy import zeros
    from Mathematical import area_enclosed
    from RepresentationTools import array_to_gmsh_points
    from StringOperations import strplusone

    paths = self.Boundary()
    minarea = self.MinimumArea()
    region = self.Region()
    dx = self.Spacing()
    latitude_max = self.ExtendToLatitude()

    self.gmsh_header()
    splinenumber = 0
    indexbase = 1
    self.index.point = indexbase

    ends = zeros([len(self._pathall),4])
    for num in range(len(self._pathall)):
      ends[num,:] = [ self._pathall[num].vertices[0][0], self._pathall[num].vertices[0][1], self._pathall[num].vertices[-1][0], self._pathall[num].vertices[-1][1]] 
    
    dateline=[]
    for num in range(len(self._pathall)):
      if (abs(ends[num,0]) == 180) and (abs(ends[num,2]) == 180):
        if (ends[num,1] != ends[num,3]):
          dateline.append(num)

    matched = []
    appended = []
    for num in dateline:
      if num in matched:
        continue
      matches = []
      for i in dateline:
        if (i == num):
          continue
        if ( ends[num,1] == ends[i,1] ) and ( ends[num,3] == ends[i,3] ):
          # match found, opposite orientation
          matches.append((i, True))
        if ( ends[num,1] == ends[i,3] ) and ( ends[num,3] == ends[i,1] ):
          # match found, same orientation
          matches.append((i, False))
      if (len(matches) > 1):
        error('Matches:')
        print matches
        error('More than one match found for path %d' % num, fatal=True)
        sys.exit(1)
      elif (len(matches) == 0):
        self.report('No match found for path %d' % num)
        #sys.exit(1)

      report('Path %d crosses date line' % (num + 1), debug=True)
      if (len(matches) > 0):
        match = matches[0][0]
        orientation = matches[0][1]
        report('  match %d - %d (%s)' % (num + 1, match + 1, str(orientation)), debug=True)
        #print self._pathall[num].vertices
        #print self._pathall[num].vertices
        #print self._pathall[match].vertices
        #print self._pathall[match].vertices[::-1]
        if orientation:
          self._pathall[num].vertices = concatenate((self._pathall[num].vertices[:-2,:], self._pathall[match].vertices[::-1]), axis=0) 
        else:
          self._pathall[num].vertices = concatenate((self._pathall[num].vertices[:-2,:], self._pathall[match].vertices), axis=0) 
        self._pathall[match] = None
        matched.append(match)
        appended.append(num)

    self.report('Merged paths that cross the date line: ' + ' '.join(map(strplusone,appended)))

    if ((paths is not None) and (len(paths) > 0)):
      pathids=paths
    else:
      pathids=range(len(self._pathall)+1)[1:]

    def maxlat(points):
      maxlat = max(points[:,1])
      maxlat = points[0][1]
      for point in points:
        maxlat = max(maxlat, point[1])

    pathvalid = []
    for num in pathids: 
      if (self._pathall[num-1] == None):
        continue
      area = area_enclosed(self._pathall[num-1].vertices)
      if (area < minarea):
        continue
      #if (max(self._pathall[num-1].vertices[:,1]) > -55):
      #  continue
      if num in self.BoundaryToExclude():
        continue
      pathvalid.append(num)  
    self.report('Paths found valid: ' + str(len(pathvalid)) + ', including ' + ' '.join(map(str, pathvalid)))
    #print ends
    if (len(pathvalid) == 0):
      self.report('No valid paths found.')
      sys.exit(1)

    #if universe.smooth_data:
    #  for num in pathvalid:
    #    if (self._pathall[num-1] == None):
    #      continue
    #    xy=self._pathall[num-1].vertices
    #    origlen=len(xy)
    #    x = smoothGaussian(xy[:,0], degree=universe.smooth_degree)
    #    y = smoothGaussian(xy[:,1], degree=universe.smooth_degree)
    #    xy = zeros([len(x),2])
    #    xy[:,0] = x
    #    xy[:,1] = y
    #    self._pathall[num-1].vertices = xy
    #    self.report('Smoothed path %d, nodes %d from %d' % (num, len(xy), origlen))


    if (universe.plotcontour):
      PlotContours(self._pathall, pathvalid)

    for num in pathvalid:
      if (self._pathall[num-1] == None):
        continue
      xy=self._pathall[num-1].vertices
      self.index = array_to_gmsh_points(self, num, self.index, xy, minarea, region, dx, latitude_max)


    #for i in range(-85, 0, 5):
    #  indexend += 1
    #  self.AddContent( self.gmsh_format_point(indexend, project(0, i), 0) )
    #for i in range(-85, 0, 5):
    #  indexend += 1
    #  self.AddContent( self.gmsh_format_point(indexend, project(45, i), 0) )
    #self.gmsh_remove_projection_points()
    #return index

  def define_point(self, name, location):
    # location [long, lat]
    self.AddContent('''
//Point %(name)s is located at, %(longitude).2f deg, %(latitude).2f deg.
Point_%(name)s_longitude_rad = (%(longitude)f + (00/60))*(Pi/180);
Point_%(name)s_latitude_rad  = (%(latitude)f + (00/60))*(Pi/180);
Point_%(name)s_stereographic_y = Cos(Point_%(name)s_longitude_rad)*Cos(Point_%(name)s_latitude_rad)  / ( 1 + Sin(Point_%(name)s_latitude_rad) );
Point_%(name)s_stereographic_x = Cos(Point_%(name)s_latitude_rad) *Sin(Point_%(name)s_longitude_rad) / ( 1 + Sin(Point_%(name)s_latitude_rad) );''' % { 'name':name, 'longitude':location[0], 'latitude':location[1] } )

  def draw_parallel(self, startn, endn, start, end, points=200):
    startp = project(start)
    endp = project(end)
    
    self.AddContent('''
pointsOnParallel = %(points)i;
parallelSectionStartingX = %(start_x)g;
parallelSectionStartingY = %(start_y)g;
firstPointOnParallel = IP + %(start_n)i;
parallelSectionEndingX = %(end_x)g;
parallelSectionEndingY = %(end_y)g;
lastPointOnParallel = IP + %(end_n)i;
newParallelID = IL + 10100;
Call DrawParallel;''' % { 'start_x':startp[0], 'start_y':startp[1], 'end_x':endp[0], 'end_y':endp[1], 'start_n':startn, 'end_n':endn, 'points':points })







  def output_open_boundaries(self):
    if not self.Open():
      return

    index = self.index

    dx = self.Spacing()
    parallel = self.BoundingLatitude()
    index.start = index.point + 1
    loopstartpoint = index.start
    index = draw_parallel_explicit(self, [   -1.0, parallel], [ 179.0, parallel], index, None, dx)
    index = draw_parallel_explicit(self, [-179.0,  parallel], [   1.0, parallel], index, None, dx)
    
    index = self.gmsh_loop(index, loopstartpoint, True, True, False)

  def output_surfaces(self):
    index = self.index

    self.gmsh_section('Physical entities')


    if self._surface_rep.scenario.PhysicalLinesSeparate():
      for l in index.physicalcontour:
        self.AddContent( '''Physical Line( %(boundaryid)i ) = { %(loopnumbers)s };''' % { 'boundaryid':self.Id(), 'loopnumbers':list_to_comma_separated([l], prefix = 'IL%(fileid)s + ' % { 'fileid':self.Fileid() } ) } )
    else: 
      self.AddContent( '''Physical Line( %(boundaryid)i ) = { %(loopnumbers)s };''' % { 'boundaryid':self.Id(), 'loopnumbers':list_to_comma_separated(index.physicalcontour, prefix = 'IL%(fileid)s + ' % { 'fileid':self.Fileid() } ) } )

    self.AddContent( '''Physical Line( %(boundaryid)i ) = { %(loopnumbers)s };''' % { 'boundaryid':self.OpenId(), 'loopnumbers':list_to_comma_separated(index.physicalopen, prefix = 'IL%(fileid)s + ' % { 'fileid':self.Fileid() } ) } )


    self.report('Open boundaries   (id %i): %s' % (self.OpenId(), list_to_space_separated(index.open, add=1)))
    self.report('Closed boundaries (id %i): %s' % (self.Id(), list_to_space_separated(index.contour, add=1)))
    boundary_list = list_to_comma_separated(index.contour + index.open)
  #//Line Loop( ILL + %(loopnumber)i ) = { %(boundary_list)s };
  #//Plane Surface( %(surface)i ) = { ILL + %(loopnumber)i };
    if (len(index.loops) > 0):
      self.AddContent('''Plane Surface( %(surface)i ) = { %(boundary_list)s };
Physical Surface( %(surface)i ) = { %(surface)i };''' % { 'loopnumber':index.path, 'surface':self.SurfaceId() + 1, 'boundary_list':list_to_comma_separated(index.loops, prefix = 'ILL%(fileid)s + ' % { 'fileid':self.Fileid() } ) } )
    else:
      self.report('Warning: Unable to define surface - may need to define Line Loops?')



  def output_fields(self):
    index = self.index
    edgeindex = ''

    self.gmsh_section('Field definitions')
    if (index.contour is not None):
      self.AddContent('''
Printf("Assigning characteristic mesh sizes...");

// Field[ IFI + 1] = Attractor;
// Field[ IFI + 1].EdgesList = { 999999, %(boundary_list)s };
// Field [ IFI + 1 ].NNodesByEdge = 5e4;
// 
// Field[ IFI + 2] = Threshold;
// Field[ IFI + 2].DistMax = 2e6;
// Field[ IFI + 2].DistMin = 3e4;
// Field[ IFI + 2].IField = IFI + 1;
// Field[ IFI + 2].LcMin = 5e4;
// Field[ IFI + 2].LcMax = 2e5;
//
// Background Field = IFI + 2;

Field[ IFI%(fileid)s + 1] = MathEval;
Field[ IFI%(fileid)s + 1].F = "%(elementlength)e";

Field[ IFI%(fileid)s + 2 ] = Attractor;
//Field[ IFI%(fileid)s + 2 ].EdgesList = { 999999, %(boundary_list)s };
Field[ IFI%(fileid)s + 2 ].EdgesList = { %(boundary_list)s };
//Field[ IFI%(fileid)s + 2 ].NNodesByEdge = 5e4;
Field[ IFI%(fileid)s + 2 ].NNodesByEdge = 20000;

// Field[ IFI%(fileid)s + 3] = Threshold;
// Field[ IFI%(fileid)s + 3].DistMax = 2e6;
// Field[ IFI%(fileid)s + 3].DistMin = 3e4;
// Field[ IFI%(fileid)s + 3].IField = IFI%(fileid)s + 2;
// Field[ IFI%(fileid)s + 3].LcMin = 5e4;
// Field[ IFI%(fileid)s + 3].LcMax = 2e5;
// 
// // Filchner-Ronne:
// Field[ IFI%(fileid)s + 4] = Threshold;
// Field[ IFI%(fileid)s + 4].DistMax = 5e5;
// Field[ IFI%(fileid)s + 4].DistMin = 3e4;
// Field[ IFI%(fileid)s + 4].IField = IFI%(fileid)s + 2;
// Field[ IFI%(fileid)s + 4].LcMin = 2e4;
// Field[ IFI%(fileid)s + 4].LcMax = 5e5;
// 
// // Amundsen 
// Field[ IFI%(fileid)s + 5] = Threshold;
// Field[ IFI%(fileid)s + 5].DistMax = 5e5;
// Field[ IFI%(fileid)s + 5].DistMin = 8e4;
// Field[ IFI%(fileid)s + 5].IField = IFI%(fileid)s + 2;
// Field[ IFI%(fileid)s + 5].LcMin = 2e4;
// Field[ IFI%(fileid)s + 5].LcMax = 5e5;

// Global
// Field[ IFI%(fileid)s + 6 ] = Threshold;
// Field[ IFI%(fileid)s + 6 ].DistMax = 1000000;
// Field[ IFI%(fileid)s + 6 ].DistMin = 1000;
// Field[ IFI%(fileid)s + 6 ].IField = IFI%(fileid)s + 2;
// Field[ IFI%(fileid)s + 6 ].LcMin = 80000;
// Field[ IFI%(fileid)s + 6 ].LcMax = 200000;

// Northsea
Field[ IFI%(fileid)s + 7 ] = Threshold;
Field[ IFI%(fileid)s + 7 ].IField = IFI%(fileid)s + 2;
Field[ IFI%(fileid)s + 7 ].DistMax = 100000;
Field[ IFI%(fileid)s + 7 ].DistMin = 1000;
Field[ IFI%(fileid)s + 7 ].LcMin = 5000;
Field[ IFI%(fileid)s + 7 ].LcMax = 20000;
Field[ IFI%(fileid)s + 7 ].Sigmoid = 0;

// Dont extent the elements sizes from the boundary inside the domain
//Mesh.CharacteristicLengthExtendFromBoundary = 0;

Background Field = IFI%(fileid)s + 1;
''' % { 'boundary_list':list_to_comma_separated(index.contour, prefix = 'IL%(fileid)s + %(edgeindex)s' % {'fileid':self.Fileid(), 'edgeindex':edgeindex}), 'elementlength':self.BaseEdgeLength(), 'fileid':self.Fileid() } )

    self.gmsh_section('Physical entities')

    self.AddContent('''
//Set some options for better png output
General.Color.Background = {255,255,255};
General.Color.BackgroundGradient = {255,255,255};
General.Color.Foreground = Black;
Mesh.Color.Lines = {0,0,0};

General.Trackball = 0 ;
General.RotationX = 180;
General.RotationY = 0;
General.RotationZ = 270;
''')




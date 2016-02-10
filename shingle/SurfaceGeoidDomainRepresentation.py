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
from StringOperations import expand_boxes, list_to_comma_separated, list_to_space_separated
from RepresentationTools import draw_parallel_explicit
from Spud import libspud
from ReadOptionTree import ReadMultipleInstance

class SurfaceGeoidDomainRepresentation(object):

  _cacheFiletype = '.shc'

  name = None 
  output = None
  filehandle = None
  brep_component = None
  # For now, use universal definitions:
  # Later to go in shml
  planet_radius = None
  fileid = None
  outputfile = None
  pathall = None
  content = None
  paths = None
  minarea = None
  region = None
  latitude_max = None 
  compound = None
  boundariestoexclude = None
  include_iceshelf_ocean_cavities = None
  contourtype = None
  brepsource = None 
  
  def __init__(self, name='SurfaceGeoidDomainRepresentation', output=None):
    self.name = name
    self.content = ''
    self.report('Initialising surface geoid representation %(name)s', var = {'name':self.name}, include=False)
    self.output = ''
    self.brep_component = {}
    self.compound = False
    self.boundariestoexclude = []
    self.include_iceshelf_ocean_cavities = True
    # For now, use universal definitions:
    # Later to go in shml
    self.planet_radius = universe.planet_radius
    self.fileid = universe.fileid
    #self.outputfile = universe.output
    #self.outputfile = self.name
    self.outputfile = universe.name
    self.minarea = 0.0
    self.region = 'True'

    self.SetSpacing(universe.dx)
    self.SetPathsSelected(universe.boundaries)
    self.SetMinArea(universe.minarea)
    self.SetRegion(universe.region)
    self.SetMaximumLatitude(universe.extendtolatitude)

    self.ReadOptions()

    self.OutputFilenameUpdate()
    self.AppendArguments()
    self.AppendParameters()


  class index:
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

  class boundary:
    contour = 3
    open    = 4
    surface = 9

  def ReadOptions(self):
    self.report('Reading surface geoid representation %(name)s', var = {'name':self.name}, include=False) 
    path = '//surface_geoid_representation::%(name)s/' % {'name':self.name}
    if libspud.have_option(path + 'id'):
      self.boundary.surface = libspud.get_option(path + 'id')
    if libspud.have_option(path + 'id_internal_suffix'):
      self.fileid = libspud.get_option(path + 'id_internal_suffix')
    if libspud.have_option(path + 'output'):
      self.outputfile = libspud.get_option(path + 'output/file_name')

    #if libspud.have_option(path + 'more_bsplines'):
    #  self.?? = libspud.get_option(path + 'more_bsplines')

    if libspud.have_option(path + 'closure'):
      #self.?? = libspud.have_option(path + 'closure/no_open')
      #self.?? = libspud.have_option(path + 'closure/close_with_parallels')

      if libspud.have_option(path + 'closure/open_id'):
        self.boundary.open = libspud.get_option(path + 'closure/open_id')
      #if libspud.have_option(path + 'closure/bounding_latitude')
      #  self.?? = libspud.get_option(path + 'closure/bounding_latitude')
      if libspud.have_option(path + 'closure/extend_to_latitude'):
        self.SetMaximumLatitude(libspud.get_option(path + 'closure/extend_to_latitude'))
  
    self.brep_component = {}
    for number in range(libspud.option_count(path + 'brep_component')):
      if len(self.brep_component) > 0:
        error('More than one boundary representation component in the same initialisaiton currently not supported. Will examine the first for now.', fatal=False)
        break
      d = ReadMultipleInstance(path + 'brep_component', number)
      self.brep_component[d.name] = d

    report('Found %(number)d component boundary representations:' % { 'number':len(self.brep_component) })
    for d in self.brep_component.keys():
      self.brep_component[d].Show()
    
    # For running form the commandline:
    if len(self.brep_component) == 0:
      self.brepsource = 'legacy'
      return

    brep_component_names = self.brep_component.keys()
    b = self.brep_component[brep_component_names[0]]

    self.report('Reading boundary representation %(name)s', var = {'name':b.name}) 
    path = '/surface_geoid_representation::%(name)s/brep_component::%(brep_name)s/' % {'name':self.name, 'brep_name':b.name}

    if libspud.have_option(path + 'id'):
      self.boundary.contour = libspud.get_option(path + 'id')
    if libspud.have_option(path + 'spacing'):
      self.SetSpacing(libspud.get_option(path + 'spacing'))
    representation_type = libspud.get_option(path + 'representation_type[0]/name')
    if representation_type == 'CompoundBSplines':
      self.compound = True

    form = libspud.get_option(path + 'form[0]/name')

    if form == 'Raster':
      path = '/surface_geoid_representation::%(name)s/brep_component::%(brep_name)s/form::%(form)s/' % {'name':self.name, 'brep_name':b.name, 'form':form}

      self.brepsource = libspud.get_option(path + 'source[0]/name')
      
      if libspud.have_option(path + 'region'):
        self.SetRegion(libspud.get_option(path + 'region'))

      if libspud.have_option(path + 'box'):
        self.SetRegion( expand_boxes(self.region, libspud.get_option(path + 'box').split() ) )

      if libspud.have_option(path + 'minimum_area'):
        self.SetMinArea(libspud.get_option(path + 'minimum_area')) 

      if libspud.have_option(path + 'contourtype'):
        self.contourtype = libspud.get_option(path + 'contourtype')
      
      self.include_iceshelf_ocean_cavities = libspud.have_option(path + 'exclude_iceshelf_ocean_cavities')

      if libspud.have_option(path + 'boundary'):
        self.SetPathsSelected(libspud.get_option(path + 'boundary').split())

      if libspud.have_option(path + 'boundary_to_exclude'):
        self.boundariestoexclude = libspud.get_option(path + 'boundary_to_exclude').split()

    elif form == 'Polyline':
      raise NotImplementedError
    else:
      raise NotImplementedError


  def AddPath(self, source):
    self.AddContent(source.log)
    self.pathall = source.path

  def SetPathsSelected(self, paths):
    self.paths = paths

  def SetMinArea(self, area):
    self.minarea = area

  def SetRegion(self, region):
    self.region = region

  def SetSpacing(self, dx):
    self.dx = dx

  def SetMaximumLatitude(self, latitude):
    self.latitude_max = latitude

  def OutputFilenameUpdate(self):
    # Update output file name used to write representation
    from Support import FilenameAddExtension
    self.outputfile = FilenameAddExtension(self.outputfile, 'geo')

  def filehandleOpen(self):
    from Support import PathFull
    self.OutputFilenameUpdate()
    fullpath = PathFull(self.outputfile)
    report('%(blue)sWriting surface geoid representation to file:%(end)s %(yellow)s%(filename)s%(end)s %(grey)s(%(fullpath)s)%(end)s', var={'filename':self.outputfile, 'fullpath':fullpath})
    self.filehandle = file(fullpath,'w')

  def filehandleClose(self):
    self.filehandle.close()

  def WriteContent(self):
    self.filehandleOpen()
    self.filehandle.write(self.content)
    self.filehandleClose()

  def AddContent(self, string=''):
    from os import linesep
    #self.filehandle.write( string + linesep)
    self.content = self.content + string + linesep

  def report(self, text, include = True, debug = False, var = {}):
    if debug and not universe.debug:
      return
    if (universe.verbose):
      report(text, var=var, debug=debug)
    if include:
      self.gmsh_comment(text % var)

  def reportSkipped(self):
    from os import linesep
    if len(self.index.skipped) > 0:
      self.report('Skipped (because no point on the boundary appeared in the required region, or area enclosed by the boundary was too small):'+linesep+' '.join(rep.index.skipped))

  def AppendArguments(self):
    self.gmsh_comment('Arguments: ' + universe.call)

  def AppendParameters(self):
    self.report('Output to ' + self.outputfile)
    self.report('Projection type ' + universe.projection)
    if len(universe.boundaries) > 0:
      self.report('Boundaries restricted to ' + str(universe.boundaries))
    if universe.region is not 'True':
      self.report('Region defined by ' + str(universe.region))
    if self.dx != universe.dx_default:
      self.report('Open contours closed with a line formed by points spaced %(dx)g degrees apart' % {'dx':self.dx} )
    if universe.extendtolatitude is not None:
      self.report('Extending region to meet parallel on latitude ' + str(universe.extendtolatitude))

    self.gmsh_comment('')


  def gmsh_comment(self, comment, newline=False):
    if newline:
      self.AddContent()
    if (len(comment) > 0):
      self.AddContent( '// ' + comment )

  def gmsh_out(self, comment):
    self.AddContent( comment )

  def gmsh_section(self, title):
    line = '='
    self.gmsh_comment('%s %s %s' % ( line * 2, title, line * (60 - len(title))), True)


  def gmsh_header(self):
    self.gmsh_section('Header')
    if universe.compound:
      edgeindex = ' + 1000000'
    else:
      edgeindex = ''
    if not universe.compound:
      header = '''\
IP%(fileid)s = newp;
IL%(fileid)s = newl;
ILL%(fileid)s = newll;
IS%(fileid)s = news;
IFI%(fileid)s = newf;
''' % { 'fileid':self.fileid, 'edgeindex':edgeindex }
    else:
      header = '''\
IP%(fileid)s = 0;
IL%(fileid)s = 0%(edgeindex)s;
ILL%(fileid)s = 0;
IS%(fileid)s = news;
IFI%(fileid)s = newf;
''' % { 'fileid':self.fileid, 'edgeindex':edgeindex }
    header_polar = '''
Point ( IP%(fileid)s + 0 ) = { 0, 0, 0 };
Point ( IP%(fileid)s + 1 ) = { 0, 0, %(planet_radius)g };
PolarSphere ( IS%(fileid)s + 0 ) = { IP%(fileid)s, IP%(fileid)s + 1 };
''' % { 'planet_radius': self.planet_radius, 'fileid': self.fileid }
    
    if (universe.projection not in ['longlat','proj_cartesian'] ):
      header = header + header_polar
    self.AddContent(header)
    self.gmsh_remove_projection_points()


  def gmsh_footer(self, loopstart, loopend):
    # Note used?
    self.AddContent()
    self.AddContent( '''Field [ IFI%(fileid)s + 0 ]  = Attractor;
Field [ IFI%(fileid)s + 0 ].NodesList  = { IP + %(loopstart)i : IP + %(loopend)i };''' % { 'loopstart':loopstart, 'loopend':loopend, 'fileid':self.fileid } )

  def gmsh_remove_projection_points(self):
    if universe.projection == 'longlat':
      return
    self.AddContent( '''Delete { Point{ IP%(fileid)s + 0}; }
Delete { Point{ IP%(fileid)s + 1}; }''' % { 'fileid':self.fileid } )


  def gmsh_format_point(self, index, loc, z):
    accuracy = '.8'
    format = 'Point ( IP%(fileid)s + %%i ) = { %%%(dp)sf, %%%(dp)sf, %%%(dp)sf };' % { 'dp': accuracy, 'fileid':self.fileid }
    self.AddContent(format % (index, loc[0], loc[1], z))
    #return "Point ( IP + %i ) = { %f, %f, %f }\n" % (index, x, y, z)

  def gmsh_loop(self, index, loopstartpoint, last, open,  cachephysical):
    if (index.point <= index.start):
      return index
    #pointstart = indexstart
    #pointend   = index.point
    #loopnumber = index.loop
    if (last):
      closure = ', IP%(fileid)s + %(pointstart)i' % { 'pointstart':loopstartpoint, 'fileid':self.fileid }
    else:
      closure = ''
    if (open):
      index.open.append(index.path)
      type = 'open'
      boundaryid = self.boundary.open
      index.physicalopen.append(index.path)
    else:
      index.contour.append(index.path)
      type = 'contour'
      boundaryid = self.boundary.contour
      index.physicalcontour.append(index.path)

    index.pathsinloop.append(index.path)

  #//Line Loop( ILL + %(loopnumber)i ) = { IL + %(loopnumber)i };
  #// Identified as a %(type)s path
    self.AddContent( '''LoopStart%(loopnumber)i = IP + %(pointstart)i;
LoopEnd%(loopnumber)i = IP + %(pointend)i;''' % { 'pointstart':index.start, 'pointend':index.point, 'loopnumber':index.path, 'loopstartpoint':closure, 'type':type, 'boundaryid':boundaryid } )
    
    if not universe.compound:
      self.AddContent( '''BSpline ( IL%(fileid)s + %(loopnumber)i ) = { IP%(fileid)s + %(pointstart)i : IP%(fileid)s + %(pointend)i%(loopstartpoint)s };''' % { 'pointstart':index.start, 'pointend':index.point, 'loopnumber':index.path, 'loopstartpoint':closure, 'type':type, 'boundaryid':boundaryid, 'fileid':self.fileid } )

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
      if universe.compound:
        for i in range(index.start, index.point+1):
          if i == index.point:
            end = index.start
          else:
            end = i + 1
          self.AddContent( '''Line ( ILL%(fileid)s + %(loopnumber)i + 100000 ) = { IP%(fileid)s + %(pointstart)i, IP%(fileid)s + %(pointend)i };
''' % { 'pointstart':i, 'pointend':end, 'loopnumber':i, 'fileid':self.fileid } )
        self.AddContent( '''Compound Line ( IL%(fileid)s + %(loopnumber)i ) = { ILL%(fileid)s + %(pointstart)i + 100000 : ILL%(fileid)s + %(pointend)i + 100000 };
''' % { 'pointstart':index.start, 'pointend':index.point, 'loopnumber':index.loop, 'fileid':self.fileid } )
        self.AddContent( '''Line Loop( ILL%(fileid)s + %(loop)i ) = { IL%(fileid)s + %(loopnumber)i};''' % { 'loop':index.loop, 'fileid':self.fileid, 'loopnumber': index.loop } )

      else:
        self.AddContent()
        self.AddContent( '''Line Loop( ILL%(fileid)s + %(loop)i ) = { %(loopnumbers)s };''' % { 'loop':index.loop, 'fileid':self.fileid, 'loopnumbers':list_to_comma_separated(index.pathsinloop, prefix = 'IL%(fileid)s + ' % { 'fileid':self.fileid }) } )
      index.loops.append(index.loop)
      index.loop += 1
      index.pathsinloop = []
    
    self.AddContent()

    index.path +=1
    index.start = index.point
    return index

    self.report('Closed boundaries (id %i): %s' % (self.boundary.contour, list_to_space_separated(self.index.contour, add=1)))
    self.report('Open boundaries   (id %i): %s' % (self.boundary.open, list_to_space_separated(self.index.open, add=1)))

  def GenerateContour(self):
    self.report('Generating contours', include = False)
    self.pathall = read_paths(self, self.contourtype)

  def output_boundaries(self):
    import pickle
    import os
    from numpy import zeros
    from Mathematical import area_enclosed
    from RepresentationTools import array_to_gmsh_points
    from StringOperations import strplusone

    paths = self.paths
    minarea = self.minarea
    region = self.region
    dx = self.dx
    latitude_max = self.latitude_max

    self.gmsh_header()
    splinenumber = 0
    indexbase = 1
    self.index.point = indexbase

    ends = zeros([len(self.pathall),4])
    for num in range(len(self.pathall)):
      ends[num,:] = [ self.pathall[num].vertices[0][0], self.pathall[num].vertices[0][1], self.pathall[num].vertices[-1][0], self.pathall[num].vertices[-1][1]] 
    
    dateline=[]
    for num in range(len(self.pathall)):
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
        #print self.pathall[num].vertices
        #print self.pathall[num].vertices
        #print self.pathall[match].vertices
        #print self.pathall[match].vertices[::-1]
        if orientation:
          self.pathall[num].vertices = concatenate((self.pathall[num].vertices[:-2,:], self.pathall[match].vertices[::-1]), axis=0) 
        else:
          self.pathall[num].vertices = concatenate((self.pathall[num].vertices[:-2,:], self.pathall[match].vertices), axis=0) 
        self.pathall[match] = None
        matched.append(match)
        appended.append(num)

    self.report('Merged paths that cross the date line: ' + ' '.join(map(strplusone,appended)))

    if ((paths is not None) and (len(paths) > 0)):
      pathids=paths
    else:
      pathids=range(len(self.pathall)+1)[1:]

    def maxlat(points):
      maxlat = max(points[:,1])
      maxlat = points[0][1]
      for point in points:
        maxlat = max(maxlat, point[1])

    pathvalid = []
    for num in pathids: 
      if (self.pathall[num-1] == None):
        continue
      area = area_enclosed(self.pathall[num-1].vertices)
      if (area < minarea):
        continue
      #if (max(self.pathall[num-1].vertices[:,1]) > -55):
      #  continue
      if num in self.boundariestoexclude:
        continue
      pathvalid.append(num)  
    self.report('Paths found valid: ' + str(len(pathvalid)) + ', including ' + ' '.join(map(str, pathvalid)))
    #print ends
    if (len(pathvalid) == 0):
      self.report('No valid paths found.')
      sys.exit(1)

    if universe.smooth_data:
      for num in pathvalid:
        if (self.pathall[num-1] == None):
          continue
        xy=self.pathall[num-1].vertices
        origlen=len(xy)
        x = smoothGaussian(xy[:,0], degree=universe.smooth_degree)
        y = smoothGaussian(xy[:,1], degree=universe.smooth_degree)
        xy = zeros([len(x),2])
        xy[:,0] = x
        xy[:,1] = y
        self.pathall[num-1].vertices = xy
        self.report('Smoothed path %d, nodes %d from %d' % (num, len(xy), origlen))


    if (universe.plotcontour):
      import matplotlib.pyplot as plt
      import matplotlib.patches as patches
      import matplotlib.collections as collections
      import matplotlib.font_manager as font_manager
      fig = plt.figure()
      #plt.plot(lon,lat, 'g-')
      #plt.show
      #plt.imshow(lon,lat,field)

      p = [self.pathall[0].vertices, self.pathall[0].vertices] 

      #bol=patches.PathPatch(self.pathall[0])
      ax = plt.subplot(111)
      #ax.add_patch(bol, facecolor='none')
      pathcol = []
      for num in pathvalid: 
        pathcol.append(self.pathall[num-1].vertices)
      col = collections.LineCollection(pathcol)
      ax.add_collection(col, autolim=True)

      font = font_manager.FontProperties(family='sans-serif', weight='normal', size=8)
      for num in pathvalid: 
        #ax.annotate(str(num), (self.pathall[num-1].vertices[0][0], self.pathall[num-1].vertices[0][1]),
        #              horizontalalignment='center', verticalalignment='center')
        ax.annotate(str(num), (self.pathall[num-1].vertices[0][0], self.pathall[num-1].vertices[0][1]),
          xytext=(-20,20), textcoords='offset points', ha='center', va='bottom',
          bbox=dict(boxstyle='round,pad=0.2', fc='yellow', alpha=0.8),
          arrowprops=dict(arrowstyle='->', connectionstyle='arc3,rad=0.5', 
          color='red'), fontproperties=font)

      ax.autoscale()
      plt.show()
      sys.exit(0)

    for num in pathvalid:
      if (self.pathall[num-1] == None):
        continue
      xy=self.pathall[num-1].vertices
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





  def close_path(self, start, end, index, dx, latitude_max, proj='longlat'):
    #print start, end
    #print p2(start), p2(end)
    if (universe.closewithparallels):
      return draw_parallel_explicit(start, end, index, latitude_max, dx)
    current = start.copy()
    tolerance = dx * 0.6
    diffinit = point_diff(end, current)

    dxs = int(ceil(norm([ diffinit[0], diffinit[1] ]) / dx))
    #print dxs
    
    if (compare_points(current, end, dx, proj=proj)):
      self.gmsh_comment('Points already close enough after all' + proj + ' dx ' + str(dx))
      return index
    else:
      self.gmsh_comment('Closing path, from (%.8f, %.8f) to (%.8f, %.8f), with vector (%.8f, %.8f)' % ( start[0], start[1], end[0], end[1], diffinit[0], diffinit[1] ) )
   
    loopstartpoint = 0
    loopstartpoint = index.point
    loopstart = index

    if (proj is 'longlat'):
      while (not compare_points(current, end, dx, proj=proj)):

        diff = point_diff(end, current)
          
        normdiff = norm(diff)
        #print current,end,diff,dx,normdiff
        if (abs(normdiff) < dx * 1.5):
          self.gmsh_comment('Finished closing, projection ' + proj + ' normdiff ' + str(normdiff) + ' dx ' + str(dx))
          current = end
        else:
          current[0] = current[0] + diff[0] * (dx /  normdiff)
          current[1] = current[1] + diff[1] * (dx /  normdiff)

          index.point += 1
          report('Drawing connection to end index %s at %f.2, %f.2 (to match %f.2)' % (index.point, current[0], current[1], end[1]), debug=False)
          loc = project(current)
          self.gmsh_format_point(index.point, loc, 0.0)

    elif (proj is 'horizontal'):
      diff = array(point_diff_cartesian(end, current)) / dxs

      pstart = project(start, type='proj_cartesian')
      pend   = project(end, type='proj_cartesian')

      pcurrent = current.copy()
      ncurrent = current.copy()
      for i in range(dxs):
        pcurrent[0] = pstart[0] + diff[0] * (i)
        pcurrent[1] = pstart[1] + diff[1] * (i)
        ncurrent = project(pcurrent, type='proj_cartesian_inverse')
        if (ncurrent[0] < 0.0):
          ncurrent[0] = ncurrent[0] + 360
        #print start, end, ncurrent, diff
        index.point += 1
        report('Drawing connection to end index %s at %f.2, %f.2 (to match %f.2)' % (index.point, ncurrent[0], ncurrent[1], end[1]), debug=False)
        nloc = project(ncurrent)
        self.gmsh_format_point(index.point, nloc, 0.0)
        

    #print index.point, loopstartpoint

    #if (index.point - loopstartpoint > 10):
      #print 'Excessive ', start, end, diff, diffinit
      
    if (index.point > loopstart.point):
      index = self.gmsh_loop(index, loopstart, True, True, False)
    
    self.gmsh_comment( 'Closed path as crow flys, from (%.8f, %.8f) to  (%.8f, %.8f)' % ( start[0], start[1], end[0], end[1] ) )

    #print index
    return index


  def output_open_boundaries(self):
    if not universe.open:
      return

    index = self.index
    boundary = self.boundary

    dx = self.dx
    parallel = universe.bounding_lat
    index.start = index.point + 1
    loopstartpoint = index.start
    index = draw_parallel_explicit(self, [   -1.0, parallel], [ 179.0, parallel], index, None, dx)
    index = draw_parallel_explicit(self, [-179.0,  parallel], [   1.0, parallel], index, None, dx)
    
    index = self.gmsh_loop(index, loopstartpoint, True, True, False)


  def output_surfaces(self):
    index = self.index
    boundary = self.boundary

    self.gmsh_section('Physical entities')


    if universe.physical_lines_separate:
      for l in index.physicalcontour:
        self.AddContent( '''Physical Line( %(boundaryid)i ) = { %(loopnumbers)s };''' % { 'boundaryid':self.boundary.contour, 'loopnumbers':list_to_comma_separated([l], prefix = 'IL%(fileid)s + ' % { 'fileid':self.fileid } ) } )
    else: 
      self.AddContent( '''Physical Line( %(boundaryid)i ) = { %(loopnumbers)s };''' % { 'boundaryid':self.boundary.contour, 'loopnumbers':list_to_comma_separated(index.physicalcontour, prefix = 'IL%(fileid)s + ' % { 'fileid':self.fileid } ) } )

    self.AddContent( '''Physical Line( %(boundaryid)i ) = { %(loopnumbers)s };''' % { 'boundaryid':self.boundary.open, 'loopnumbers':list_to_comma_separated(index.physicalopen, prefix = 'IL%(fileid)s + ' % { 'fileid':self.fileid } ) } )


    self.report('Open boundaries   (id %i): %s' % (self.boundary.open, list_to_space_separated(index.open, add=1)))
    self.report('Closed boundaries (id %i): %s' % (self.boundary.contour, list_to_space_separated(index.contour, add=1)))
    boundary_list = list_to_comma_separated(index.contour + index.open)
  #//Line Loop( ILL + %(loopnumber)i ) = { %(boundary_list)s };
  #//Plane Surface( %(surface)i ) = { ILL + %(loopnumber)i };
    if (len(index.loops) > 0):
      self.AddContent('''Plane Surface( %(surface)i ) = { %(boundary_list)s };
Physical Surface( %(surface)i ) = { %(surface)i };''' % { 'loopnumber':index.path, 'surface':self.boundary.surface + 1, 'boundary_list':list_to_comma_separated(index.loops, prefix = 'ILL%(fileid)s + ' % { 'fileid':self.fileid } ) } )
    else:
      self.report('Warning: Unable to define surface - may need to define Line Loops?')



  def output_fields(self):
    index = self.index
    boundary = self.boundary

    self.gmsh_section('Field definitions')
    if universe.compound:
      edgeindex = ''
    else:
      edgeindex = ''
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
Field[ IFI%(fileid)s + 1].F = "%(elementlength)s";

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
''' % { 'boundary_list':list_to_comma_separated(index.contour, prefix = 'IL%(fileid)s + %(edgeindex)s' % {'fileid':self.fileid, 'edgeindex':edgeindex}), 'elementlength':universe.elementlength, 'fileid':self.fileid } )

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



  def Generate(self):
#   from specific.Pig import pig_sponge

    if self.brepsource not in universe.dataset.keys():
      error('Dataset %(dataset)s required for surface geoid representation %(rep)s' % {'dataset':self.brepsource, 'rep':self.name}, fatal=True)

    r = universe.dataset[self.brepsource]
    r.Generate()
    self.AddPath(r)
    

    self.output_boundaries()
    self.output_open_boundaries()
    self.output_surfaces()

    #from specific.AntarcticCircumpolarCurrent import draw_acc
    #index = draw_acc(index, boundary, self.dx)

    self.gmsh_section('End of contour definitions')

    self.output_fields()

    self.reportSkipped()
    self.WriteContent()
    




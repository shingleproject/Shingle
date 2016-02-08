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
from Import import read_paths
from StringOperations import list_to_comma_separated, list_to_space_separated
from RepresentationTools import draw_parallel_explicit

class SurfaceGeoidDomainRepresentation(object):

  def __init__(self, name='surfaceGeoidDomainRepresentation'):
    self.output = ''
    self.filehandle = None
    # For now, use universal definitions:
    # Later to go in shml
    self.earth_radius = universe.earth_radius
    self.fileid = universe.fileid

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

  def filehandleOpen(self, filename):
    self.filehandle = file(filename,'w')

  def filehandleClose(self):
    self.filehandle.close()

  def report(self, text, include = True, debug = False):
    print debug, universe.debug
    if debug and not universe.debug:
      return
    if (universe.verbose):
      print text
    if include:
      self.gmsh_comment(text)

  def gmsh_comment(self, comment, newline=False):
    if newline:
      self.filehandle.write('\n')
    if (len(comment) > 0):
      self.filehandle.write( '// ' + comment + '\n')

  def gmsh_out(self, comment):
    self.filehandle.write( comment + '\n')

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
Point ( IP%(fileid)s + 1 ) = { 0, 0, %(earth_radius)g };
PolarSphere ( IS%(fileid)s + 0 ) = { IP%(fileid)s, IP%(fileid)s + 1 };
''' % { 'earth_radius': self.earth_radius, 'fileid': self.fileid }
    
    if (universe.projection not in ['longlat','proj_cartesian'] ):
      header = header + header_polar
    self.filehandle.write(header)
    self.gmsh_remove_projection_points()


  def gmsh_footer(self, loopstart, loopend):
    # Note used?
    self.filehandle.write( '''
Field [ IFI%(fileid)s + 0 ]  = Attractor;
Field [ IFI%(fileid)s + 0 ].NodesList  = { IP + %(loopstart)i : IP + %(loopend)i };
''' % { 'loopstart':loopstart, 'loopend':loopend, 'fileid':self.fileid } )

  def gmsh_remove_projection_points(self):
    if universe.projection == 'longlat':
      return
    self.filehandle.write( '''Delete { Point{ IP%(fileid)s + 0}; }
Delete { Point{ IP%(fileid)s + 1}; }
''' % { 'fileid':self.fileid } )


  def gmsh_format_point(self, index, loc, z):
    accuracy = '.8'
    format = 'Point ( IP%(fileid)s + %%i ) = { %%%(dp)sf, %%%(dp)sf, %%%(dp)sf };\n' % { 'dp': accuracy, 'fileid':self.fileid }
    self.filehandle.write(format % (index, loc[0], loc[1], z))
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
    self.filehandle.write( '''LoopStart%(loopnumber)i = IP + %(pointstart)i;
LoopEnd%(loopnumber)i = IP + %(pointend)i;
''' % { 'pointstart':index.start, 'pointend':index.point, 'loopnumber':index.path, 'loopstartpoint':closure, 'type':type, 'boundaryid':boundaryid } )
    
    if not universe.compound:
      self.filehandle.write( '''BSpline ( IL%(fileid)s + %(loopnumber)i ) = { IP%(fileid)s + %(pointstart)i : IP%(fileid)s + %(pointend)i%(loopstartpoint)s };''' % { 'pointstart':index.start, 'pointend':index.point, 'loopnumber':index.path, 'loopstartpoint':closure, 'type':type, 'boundaryid':boundaryid, 'fileid':self.fileid } )

    index.physicalgroup.append(index.path)
  #  self.filehandle.write( '''
  #Physical Line( %(boundaryid)i ) = { %(loopnumbers)s };
  #''' % { 'boundaryid':boundaryid , 'loopnumbers':list_to_comma_separated(index.pathsinloop, prefix = 'IL + ') } )
  #  self.filehandle.write( '''
  #Physical Line( ILL + %(loop)i ) = { %(loopnumbers)s };
  #''' % { 'loop':index.loop , 'loopnumbers':list_to_comma_separated(index.pathsinloop, prefix = 'IL + ') } )


    if (not(cachephysical)):
      #self.filehandle.write( '''
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
          self.filehandle.write( '''Line ( ILL%(fileid)s + %(loopnumber)i + 100000 ) = { IP%(fileid)s + %(pointstart)i, IP%(fileid)s + %(pointend)i };
''' % { 'pointstart':i, 'pointend':end, 'loopnumber':i, 'fileid':self.fileid } )
        self.filehandle.write( '''Compound Line ( IL%(fileid)s + %(loopnumber)i ) = { ILL%(fileid)s + %(pointstart)i + 100000 : ILL%(fileid)s + %(pointend)i + 100000 };
''' % { 'pointstart':index.start, 'pointend':index.point, 'loopnumber':index.loop, 'fileid':self.fileid } )
        self.filehandle.write( '''
Line Loop( ILL%(fileid)s + %(loop)i ) = { IL%(fileid)s + %(loopnumber)i};''' % { 'loop':index.loop, 'fileid':self.fileid, 'loopnumber': index.loop } )

      else:
        self.filehandle.write( '''
Line Loop( ILL%(fileid)s + %(loop)i ) = { %(loopnumbers)s };''' % { 'loop':index.loop, 'fileid':self.fileid, 'loopnumbers':list_to_comma_separated(index.pathsinloop, prefix = 'IL%(fileid)s + ' % { 'fileid':self.fileid }) } )
      index.loops.append(index.loop)
      index.loop += 1
      index.pathsinloop = []
    
    self.filehandle.write( '''
''' )

    index.path +=1
    index.start = index.point
    return index

    self.report('Closed boundaries (id %i): %s' % (self.boundary.contour, list_to_space_separated(self.index.contour, add=1)))
    self.report('Open boundaries   (id %i): %s' % (self.boundary.open, list_to_space_separated(self.index.open, add=1)))



  def output_boundaries(self, filename, paths=None, minarea=0, region='True', dx=universe.dx_default, latitude_max=None):
    import pickle
    import os
    from numpy import zeros
    from Mathematical import area_enclosed
    from RepresentationTools import array_to_gmsh_points
    #try:
    #  picklefile = open(universe.picklefile, 'rb')
    #  self.report('Path pickle file found: ' + universe.picklefile)
    #  pathall = pickle.load(picklefile)
    #  picklefile.close()
    #except:
    #  self.report('No path pickle file present, generating contours and saving ' + universe.picklefile + 'for the future!')
    #  pathall = read_rtopo(filename)
    #  picklefile = open(universe.picklefile, 'wb')
    #  pickle.dump(pathall, picklefile)
    #  picklefile.close()


    if universe.cache and os.path.exists(universe.picklefile):
      picklefile = open(universe.picklefile, 'rb')
      self.report('Cache file found: ' + universe.picklefile)
      pathall = pickle.load(picklefile)
      picklefile.close()
    else:
      self.report('Generating contours', include = False)
      pathall = read_paths(self, filename)
      if universe.cache:
        self.report('Saving contours to: ' + universe.picklefile + ' for the future!')
        picklefile = open(universe.picklefile, 'wb')
        pickle.dump(pathall, picklefile)
        picklefile.close()

    self.report('Paths found: ' + str(len(pathall)))
    self.gmsh_header()
    splinenumber = 0
    indexbase = 1
    self.index.point = indexbase

    ends = zeros([len(pathall),4])
    for num in range(len(pathall)):
      ends[num,:] = [ pathall[num].vertices[0][0], pathall[num].vertices[0][1], pathall[num].vertices[-1][0], pathall[num].vertices[-1][1]] 
    
    dateline=[]
    for num in range(len(pathall)):
      if (abs(ends[num,0]) == 180) and (abs(ends[num,2]) == 180):
        if (ends[num,1] != ends[num,3]):
          dateline.append(num)

    def strplusone(number):
      return str(number + 1)
    self.report('Paths that cross the date line: ' + ' '.join(map(strplusone,dateline)))

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
        self.report('More than one match found for path %d' % num)
        print matches
        sys.exit(1)
      elif (len(matches) == 0):
        self.report('No match found for path %d' % num)
        #sys.exit(1)

      printvv('Path %d crosses date line' % (num + 1))
      if (len(matches) > 0):
        match = matches[0][0]
        orientation = matches[0][1]
        printvv('  match %d - %d (%s)' % (num + 1, match + 1, str(orientation)))
        #print pathall[num].vertices
        #print pathall[num].vertices
        #print pathall[match].vertices
        #print pathall[match].vertices[::-1]
        if orientation:
          pathall[num].vertices = concatenate((pathall[num].vertices[:-2,:], pathall[match].vertices[::-1]), axis=0) 
        else:
          pathall[num].vertices = concatenate((pathall[num].vertices[:-2,:], pathall[match].vertices), axis=0) 
        pathall[match] = None
        matched.append(match)
        appended.append(num)

    self.report('Merged paths that cross the date line: ' + ' '.join(map(strplusone,appended)))

    if ((paths is not None) and (len(paths) > 0)):
      pathids=paths
    else:
      pathids=range(len(pathall)+1)[1:]

    def maxlat(points):
      maxlat = max(points[:,1])
      maxlat = points[0][1]
      for point in points:
        maxlat = max(maxlat, point[1])

    pathvalid = []
    for num in pathids: 
      if (pathall[num-1] == None):
        continue
      area = area_enclosed(pathall[num-1].vertices)
      if (area < minarea):
        continue
      #if (max(pathall[num-1].vertices[:,1]) > -55):
      #  continue
      if num in universe.boundariestoexclude:
        continue
      pathvalid.append(num)  
    self.report('Paths found valid: ' + str(len(pathvalid)) + ', including ' + ' '.join(map(str, pathvalid)))
    #print ends
    if (len(pathvalid) == 0):
      self.report('No valid paths found.')
      sys.exit(1)

    if universe.smooth_data:
      for num in pathvalid:
        if (pathall[num-1] == None):
          continue
        xy=pathall[num-1].vertices
        origlen=len(xy)
        x = smoothGaussian(xy[:,0], degree=universe.smooth_degree)
        y = smoothGaussian(xy[:,1], degree=universe.smooth_degree)
        xy = zeros([len(x),2])
        xy[:,0] = x
        xy[:,1] = y
        pathall[num-1].vertices = xy
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

      p = [pathall[0].vertices, pathall[0].vertices] 

      #bol=patches.PathPatch(pathall[0])
      ax = plt.subplot(111)
      #ax.add_patch(bol, facecolor='none')
      pathcol = []
      for num in pathvalid: 
        pathcol.append(pathall[num-1].vertices)
      col = collections.LineCollection(pathcol)
      ax.add_collection(col, autolim=True)

      font = font_manager.FontProperties(family='sans-serif', weight='normal', size=8)
      for num in pathvalid: 
        #ax.annotate(str(num), (pathall[num-1].vertices[0][0], pathall[num-1].vertices[0][1]),
        #              horizontalalignment='center', verticalalignment='center')
        ax.annotate(str(num), (pathall[num-1].vertices[0][0], pathall[num-1].vertices[0][1]),
          xytext=(-20,20), textcoords='offset points', ha='center', va='bottom',
          bbox=dict(boxstyle='round,pad=0.2', fc='yellow', alpha=0.8),
          arrowprops=dict(arrowstyle='->', connectionstyle='arc3,rad=0.5', 
          color='red'), fontproperties=font)

      ax.autoscale()
      plt.show()
      sys.exit(0)

    for num in pathvalid:
      if (pathall[num-1] == None):
        continue
      xy=pathall[num-1].vertices
      self.index = array_to_gmsh_points(self, num, self.index, xy, minarea, region, dx, latitude_max)


    #for i in range(-85, 0, 5):
    #  indexend += 1
    #  self.filehandle.write( self.gmsh_format_point(indexend, project(0, i), 0) )
    #for i in range(-85, 0, 5):
    #  indexend += 1
    #  self.filehandle.write( self.gmsh_format_point(indexend, project(45, i), 0) )
    #self.gmsh_remove_projection_points()
    #return index

  def define_point(self, name, location):
    # location [long, lat]
    self.filehandle.write('''
//Point %(name)s is located at, %(longitude).2f deg, %(latitude).2f deg.
Point_%(name)s_longitude_rad = (%(longitude)f + (00/60))*(Pi/180);
Point_%(name)s_latitude_rad  = (%(latitude)f + (00/60))*(Pi/180);
Point_%(name)s_stereographic_y = Cos(Point_%(name)s_longitude_rad)*Cos(Point_%(name)s_latitude_rad)  / ( 1 + Sin(Point_%(name)s_latitude_rad) );
Point_%(name)s_stereographic_x = Cos(Point_%(name)s_latitude_rad) *Sin(Point_%(name)s_longitude_rad) / ( 1 + Sin(Point_%(name)s_latitude_rad) );
''' % { 'name':name, 'longitude':location[0], 'latitude':location[1] } )

  def draw_parallel(self, startn, endn, start, end, points=200):
    startp = project(start)
    endp = project(end)
    
    self.filehandle.write('''
pointsOnParallel = %(points)i;
parallelSectionStartingX = %(start_x)g;
parallelSectionStartingY = %(start_y)g;
firstPointOnParallel = IP + %(start_n)i;
parallelSectionEndingX = %(end_x)g;
parallelSectionEndingY = %(end_y)g;
lastPointOnParallel = IP + %(end_n)i;
newParallelID = IL + 10100;
Call DrawParallel;
''' % { 'start_x':startp[0], 'start_y':startp[1], 'end_x':endp[0], 'end_y':endp[1], 'start_n':startn, 'end_n':endn, 'points':points })





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
          printvv('Drawing connection to end index %s at %f.2, %f.2 (to match %f.2)' % (index.point, current[0], current[1], end[1]))
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
        printvv('Drawing connection to end index %s at %f.2, %f.2 (to match %f.2)' % (index.point, ncurrent[0], ncurrent[1], end[1]))
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
    index = self.index
    boundary = self.boundary

    dx = universe.dx
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
        self.filehandle.write( '''Physical Line( %(boundaryid)i ) = { %(loopnumbers)s };''' % { 'boundaryid':self.boundary.contour, 'loopnumbers':list_to_comma_separated([l], prefix = 'IL%(fileid)s + ' % { 'fileid':self.fileid } ) } )
        self.filehandle.write( '''\n''' )
    else: 
      self.filehandle.write( '''Physical Line( %(boundaryid)i ) = { %(loopnumbers)s };''' % { 'boundaryid':self.boundary.contour, 'loopnumbers':list_to_comma_separated(index.physicalcontour, prefix = 'IL%(fileid)s + ' % { 'fileid':self.fileid } ) } )
      self.filehandle.write( '''\n''' )

    self.filehandle.write( '''Physical Line( %(boundaryid)i ) = { %(loopnumbers)s };''' % { 'boundaryid':self.boundary.open, 'loopnumbers':list_to_comma_separated(index.physicalopen, prefix = 'IL%(fileid)s + ' % { 'fileid':self.fileid } ) } )
    self.filehandle.write( '''\n''' )


    self.report('Open boundaries   (id %i): %s' % (self.boundary.open, list_to_space_separated(index.open, add=1)))
    self.report('Closed boundaries (id %i): %s' % (self.boundary.contour, list_to_space_separated(index.contour, add=1)))
    boundary_list = list_to_comma_separated(index.contour + index.open)
  #//Line Loop( ILL + %(loopnumber)i ) = { %(boundary_list)s };
  #//Plane Surface( %(surface)i ) = { ILL + %(loopnumber)i };
    if (len(index.loops) > 0):
      self.filehandle.write('''Plane Surface( %(surface)i ) = { %(boundary_list)s };
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
      self.filehandle.write('''
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

    self.filehandle.write('''
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




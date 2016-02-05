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

import libspud

from Scientific.IO import NetCDF
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

# TODO
# Add repo version number/release in geo header
#
# Calculate area in right projection
# Add region selection function
# Ensure all islands selected
# Identify Open boundaries differently
# Export command line to geo file
# If nearby, down't clode with parallel

#### IMPORT START
earth_radius = 6.37101e+06
dx_default = 0.1
#fileid = 'G'
fileid = ''
compound = False
#compound = True
more_bsplines = False
# Interestingly, if the following is true, gmsh generates a nice mesh, but complains (rightly so) on multiple definitions of a physical line id.  If false, the mesh contains extra 1d elements, which need parsing out!
physical_lines_separate = False
#### IMPORT END


def printv(text, include = True):
  if (arguments.verbose):
    print text
  if include:
    gmsh_comment(text)

def printvv(text):
  if (arguments.debug):
    print text

def gmsh_comment(comment, newline=False):
  if newline:
    output.write('\n')
  if (len(comment) > 0):
    output.write( '// ' + comment + '\n')

def gmsh_out(comment):
  output.write( comment + '\n')

def gmsh_section(title):
  line = '='
  gmsh_comment('%s %s %s' % ( line * 2, title, line * (60 - len(title))), True)

def norm(r):
  return math.sqrt(r[0]**2 + r[1]**2)

def normalise(r):
  return r/norm(r)

def expand_boxes(region, boxes):
  def error():
    print 'Error in argument for -b.'
    sys.exit(1)

  def build_function(function, requireand, axis, comparison, number):
    if (len(number) > 0):
      function = '%s%s(%s %s %s)' % (function, requireand, axis, comparison, number)
      requireand = ' and '
    return [function, requireand]

  #re.sub(pattern, repl, string,
  #((latitude >= -89.0) and (latitude <=-65.0) and (longitude >= -64.0) and (longitude <= -20.0))'
  if (len(boxes) > 0):
    function = ''
    requireor = ''
    for box in boxes:
      longlat = box.split(',')
      if (len(longlat) != 2): error()

      long = longlat[0].split(':')
      lat = longlat[1].split(':')
      if ((len(long) != 2) and (len(lat) != 2)): error()
      
      function_box = ''
      requireand = ''
      if (len(long) == 2):
        [function_box, requireand] = build_function(function_box, requireand, 'longitude', '>=', long[0])
        [function_box, requireand] = build_function(function_box, requireand, 'longitude', '<=', long[1])
      if (len(lat) == 2):
        [function_box, requireand] = build_function(function_box, requireand, 'latitude',  '>=', lat[0])
        [function_box, requireand] = build_function(function_box, requireand, 'latitude',  '<=', lat[1])

      if (len(function_box) > 0):
        function = '%s%s(%s)' % (function, requireor, function_box)
        requireor = ' or '
  
    if (len(function) > 0):
      if (region is not 'True'):
        region = '((%s) and (%s))' % (region, function)
      else:
        region = function

  return region

def pig_sponge(index, indexa, indexb, a, b):

  print indexa, indexb
  if indexa != 722:
    return index

  #a = array([ 256.07473195, -75.13382975 ])
  #b = array([ 258.63485727, -74.21467892 ])

  #print project([-70.2052,42.0822], type='proj_cartesian')
  if (True):
    pa = project(a, type='proj_cartesian')
    pb = project(b, type='proj_cartesian')
    pv = normalise(pb - pa)

    ppv = pv.copy()
    ppv[1] =  -pv[0]
    ppv[0] =  pv[1]


    distice = 15000
    pai = pa + distice * ppv
    pbi = pb + distice * ppv
    ai = project(pai, type='proj_cartesian_inverse')
    bi = project(pbi, type='proj_cartesian_inverse')


    dist = 30000
    pad = pai + dist * ppv
    pbd = pbi + dist * ppv

    ad = project(pad, type='proj_cartesian_inverse')
    bd = project(pbd, type='proj_cartesian_inverse')

  else:
    dist = - 0.4
    v = normalise(b - a)
    proj = v.copy()
    proj[1] = v[0]
    proj[0] = v[1]
    ad = a + dist * proj
    bd = b + dist * proj

  #index = 722

  #def gmsh_loop(index, loopstartpoint, last, open,  cachephysical):

  indexstore = index

  ldx = arguments.dx / 10.0
  #ldx = 5000

  index = close_path(b, bi, index, ldx, None, proj='horizontal')
  index.point += 1
  gmsh_format_point(index.point, project(bi), 0.0)
  index = gmsh_loop(index, indexb, False, True, False)
  indexbi = index.point

  index = close_path(bi, ai, index, ldx, None, proj='horizontal')
  index.point += 1
  gmsh_format_point(index.point, project(ai), 0.0)
  index = gmsh_loop(index, indexbi, False, True, False)
  indexai = index.point

  index = close_path(ai, a, index, ldx, None, proj='horizontal')
  index = gmsh_loop(index, indexa, True, True, False)


  index = close_path(ai, ad, index, ldx, None, proj='horizontal')
  index.point += 1
  gmsh_format_point(index.point, project(ad), 0.0)
  gmsh_out("// Change here!  'IPG + 7420 :' -> 'IPG + 722, IPG + 7421 :'")
  index = gmsh_loop(index, indexai, False, True, False)
  indexad = index.point

  index = close_path(ad, bd, index, ldx, None, proj='horizontal')
  index.point += 1
  gmsh_format_point(index.point, project(bd), 0.0)
  index = gmsh_loop(index, indexad, False, True, False)

  index = close_path(bd, bi, index, ldx, None, proj='horizontal')
  index = gmsh_loop(index, indexai, False, True, False)





  gmsh_out("// To the above add ', IPG + 7366 };")
  gmsh_out('Line Loop ( ILLG + 11 ) = { IPG + 8, IPG + 9, IPG + 10, IPG + 7 };')
  gmsh_out('Plane Surface( 11 ) = { ILLG + 11 };')
  gmsh_out('Physical Surface( 11 ) = { 11 };')
  gmsh_out('// Remember to remove internal boundary!')







  return index


  #start = 7366
  #count = start
  #for i in range(100):
  #  di = (i+1) * 0.01
  #  print di
  #  a = project(a + di * dist * proj)
  #  count = count + 1
  #  gmsh_out('Point ( IPG + ' + str(count) + ' ) = { ' + str(a[0]) + ', ' + str(a[1]) + ', 0.0 };')
  #gmsh_out('Line Loop ( 1001 ) = { IPG + start : IPG + count };')
  #aend = count
  #
  #start = 7366
  #count = start
  #for i in range(100):
  #  di = (i+1) * 0.01
  #  print di
  #  a = project(a + di * dist * proj)
  #  count = count + 1
  #  gmsh_out('Point ( IPG + ' + str(count) + ' ) = { ' + str(a[0]) + ', ' + str(a[1]) + ', 0.0 };')
  #gmsh_out('Line Loop ( 1001 ) = { IPG + start : IPG + count };')
  #aend = count

  #start = count
  #for i in range(100):
  #  di = (i+1) * 0.01
  #  print di
  #  a = project(a + di * dist * proj)
  #  count = count + 1
  #  gmsh_out('Point ( IPG + ' + str(count) + ' ) = { ' + str(a[0]) + ', ' + str(a[1]) + ', 0.0 };')
  #gmsh_out('Line ( 1001 ) = { IPG + start : IPG + count };')

  #gmsh_out('Point ( IPG + 7368 ) = { ' + str(b[0]) + ', ' + str(b[1]) + ', 0.0 };')
  #gmsh_out('Line Loop ( ILLG + 6 ) = { ILG + 6, 1000 };')

  #  b = project(b + dist * proj)

  #gmsh_out('Line ( 1000 ) = { IPG + 7366, IPG + 722 };')
  #gmsh_out('Line ( 1002 ) = { IPG + 7367, IPG + 7368 };')
  #gmsh_out('Line ( 1003 ) = { IPG + 7368, IPG + 722 };')
  #gmsh_out('Line Loop ( ILLG + 7 ) = { -1000, 1001, 1002, 1003 };')


def usage(unknown = None):
  if unknown:
    print 'Unknown option ' + unknown
  print '''Usage for %(cmdname)s
 %(cmdname)s [options]
- Options ---------------------\ 
   -n filename                 | Input netCDF file
   -f filename                 | Output Gmsh file
   -p path1 (path2)..          | Specify paths to include
   -pn path1 (path2)..         | Specify paths to exclude
   -r function                 | Function specifying region of interest
   -b box1 (box2)..            | Boxes with regions of interest
   -a minarea                  | Minimum area of islands
   -dx dist                    | Distance of steps when drawing parallels and meridians (currently in degrees - need to project)
   -m projection               | Projection type (default 'cartesian', 'longlat')
   -bounding_latitude latitude | Latitude of boundary to close the domain
   -bl latitude                | Short form of -bounding_latitude
   -t type                     | Contour type (default: iceshelfcavity) icesheet gsds
   -c                          | Force cache refresh
   -exclude_iceshelves         | Excludes iceshelf ocean cavities from mesh (default behaviour includes region)
   -smooth_data degree         | Smoothes boundaries
   -no                         | Do not include open boundaries
   -mesh                       | Mesh geometry
   -lat latitude               | Latitude to extend open domain to
   -s scenario                 | Select scenario (in development)
   -plot                       | Plot contour before geo generation 
   -el                         | Element length (default 1.0E5)
   -metric                     | Generate background metric based on bathymetry
                               |______________________________________________
   -v                          | Verbose
   -vv                         | Very verbose (debugging)
   -q                          | Quiet
   -h                          | Help
                               \_____________________________________________
Example usage:
Include only the main Antarctic mass (path 1), and only parts which lie below 60S
  rtopo_mask_to_stereographic.py -r 'latitude <= -60.0' -p 1
Filchner-Ronne extended out to the 65S parallel
  rtopo_mask_to_stereographic.py -no -b -85.0:-20.0,-89.0:-75.0 -64.0:-30.0,-89.0:-70.0 -30.0:-20.0,-89.0:-75.0 -lat '-65.0'
Antarctica, everything below the 60S parallel, coarse approximation to open boundary
  rtopo_mask_to_stereographic.py -dx 2 -r 'latitude <= -60'
Small region close to the Filcher-Ronne ice shelf
  rtopo_mask_to_stereographic.py -no -b -85.0:-20.0,-89.0:-75.0 -64.0:-30.0,-89.0:-70.0 -30.0:-20.0,-89.0:-75.0 -p 1 -r 'latitude <= -83'
Amundsen Sea
  rtopo_mask_to_stereographic.py -no -b -130.0:-85.0,-85.0:-60.0 -lat -64.0

Small islands, single out, or group with -p
  312, 314
  79 - an island on 90W 68S''' % { 'cmdname': os.path.       basename(sys.argv[0]) }
  sys.exit(1)

def gmsh_header():
  gmsh_section('Header')
  if compound:
    edgeindex = ' + 1000000'
  else:
    edgeindex = ''
  if not compound:
    header = '''\
IP%(fileid)s = newp;
IL%(fileid)s = newl;
ILL%(fileid)s = newll;
IS%(fileid)s = news;
IFI%(fileid)s = newf;
''' % { 'fileid':fileid, 'edgeindex':edgeindex }
  else:
    header = '''\
IP%(fileid)s = 0;
IL%(fileid)s = 0%(edgeindex)s;
ILL%(fileid)s = 0;
IS%(fileid)s = news;
IFI%(fileid)s = newf;
''' % { 'fileid':fileid, 'edgeindex':edgeindex }
  header_polar = '''
Point ( IP%(fileid)s + 0 ) = { 0, 0, 0 };
Point ( IP%(fileid)s + 1 ) = { 0, 0, %(earth_radius)g };
PolarSphere ( IS%(fileid)s + 0 ) = { IP%(fileid)s, IP%(fileid)s + 1 };
''' % { 'earth_radius': earth_radius, 'fileid': fileid }
  
  if (arguments.projection not in ['longlat','proj_cartesian'] ):
    header = header + header_polar
  output.write(header)
  gmsh_remove_projection_points()

def smoothGaussian(list,degree,strippedXs=False):
  list = list.tolist()
  window=degree*2-1
  weight=array([1.0]*window)
  weightGauss=[]
  for i in range(window):
    i=i-degree+1
    frac=i/float(window)
    gauss=1/(exp((4*(frac))**2))
    weightGauss.append(gauss)
  weight=array(weightGauss)*weight
  smoothed=[0.0]*(len(list)-window)
  for i in range(len(smoothed)):
    smoothed[i]=sum(array(list[i:i+window])*weight)/sum(weight)
  return array(smoothed)

def gmsh_footer(loopstart, loopend):
  output.write( '''
Field [ IFI%(fileid)s + 0 ]  = Attractor;
Field [ IFI%(fileid)s + 0 ].NodesList  = { IP + %(loopstart)i : IP + %(loopend)i };
''' % { 'loopstart':loopstart, 'loopend':loopend, 'fileid':fileid } )

def gmsh_remove_projection_points():
  if arguments.projection == 'longlat':
    return
  output.write( '''Delete { Point{ IP%(fileid)s + 0}; }
Delete { Point{ IP%(fileid)s + 1}; }
''' % { 'fileid':fileid } )


def gmsh_format_point(index, loc, z):
  accuracy = '.8'
  format = 'Point ( IP%(fileid)s + %%i ) = { %%%(dp)sf, %%%(dp)sf, %%%(dp)sf };\n' % { 'dp': accuracy, 'fileid':fileid }
  output.write(format % (index, loc[0], loc[1], z))
  #return "Point ( IP + %i ) = { %f, %f, %f }\n" % (index, x, y, z)


def project(location, type=None):
  from pyproj import Proj
  #params={'proj':'utm','zone':19}
  # Antartica - pig?:
  #params={'proj':'utm','lon_0':'-101','lat_0':'-74.5'}
  # UK:
  params={'proj':'utm','lon_0':'0','lat_0':'50'}
  proj = Proj(params)
  if (type is None):
    type = arguments.projection
  if (type == 'cartesian' ):
    longitude = location[0]
    latitude  = location[1]
    cos = math.cos
    sin = math.sin
    #pi  = math.pi
    #longitude_rad2 = longitude * ( pi / 180 )
    #latitude_rad2  = latitude  * ( pi / 180 )
    longitude_rad = math.radians(- longitude - 90)
    latitude_rad  = math.radians(latitude)
    # Changed sign in x formulae - need to check
    if 1 + sin(latitude_rad) == 0:
      x = None
      y = None
    else:
      x = sin( longitude_rad ) * cos( latitude_rad ) / ( 1 + sin( latitude_rad ) );
      y = cos( longitude_rad ) * cos( latitude_rad  ) / ( 1 + sin( latitude_rad ) );
    return array([ x, y ])

  elif (type == 'proj_cartesian' ):
    longitude = location[0]
    latitude  = location[1]
    return array(proj(longitude, latitude))

  elif (type == 'proj_cartesian_inverse' ):
    longitude = location[0]
    latitude  = location[1]
    return array(proj(longitude, latitude, inverse=True))

  elif (type == 'hammer' ):
    longitude = location[0]
    latitude  = location[1]
    cos = math.cos
    sin = math.sin
    #pi  = math.pi
    #longitude_rad2 = longitude * ( pi / 180 )
    #latitude_rad2  = latitude  * ( pi / 180 )
    longitude_rad = math.radians(- longitude - 90)
    latitude_rad  = math.radians(latitude)
    # Changed sign in x formulae - need to check
    m = math.sqrt(1 + cos(latitude_rad) * cos(longitude_rad / 2.0))
    x = earth_radius * ( 2 * math.sqrt(2) * cos(latitude_rad) * sin(longitude_rad / 2.0) ) / m
    y = earth_radius * (     math.sqrt(2) * sin(latitude_rad) ) / m
    return array([ x, y ])
  elif (type == 'longlat' ):
    return location
  else:
    print 'Invalid projection type:', arguments.projection
    sys.exit(1)

def read_rtopo(filename):
  file = NetCDF.NetCDFFile(filename, 'r')
  #variableNames = fileN.variables.keys() 
  try:
    lon = file.variables['lon'][:] 
    lat = file.variables['lat'][:] 
  except:
    printv('Warning: Problem reading variables lon and lat.')
  if (arguments.contourtype=='iceshelfcavity'):
    #             % 2
    # 0 ocean    1
    # 1 ice      0
    # 2 shelf    1
    # 3 rock     0
    try:
      field = file.variables['amask'][:, :] 
    except:
      field = file.variables['z'][:, :] 
    if arguments.include_iceshelf_ocean_cavities == True:
      printv('Including iceshelf ocean cavities')
      field = field % 2
    else:
      printv('Excluding iceshelf ocean cavities')
      field[field>0.5]=1 
  elif (arguments.contourtype=='icesheet'):
    lon = file.variables['lon'][:] 
    lat = file.variables['lat'][:] 
    field = file.variables['height'][:, :] 
    field[field>0.001]=1 
  elif (arguments.contourtype=='z'):
    lon = file.variables['lon'][:] 
    lat = file.variables['lat'][:] 
    field = file.variables['z'][:, :] 
    field[field<10.0]=0
    field[field>=10.0]=1
  elif (arguments.contourtype=='ocean10m'):
    lon = file.variables['lon'][:] 
    lat = file.variables['lat'][:] 
    field = file.variables['z'][:, :] 
    field[field<=-10.0]=-10.0
    field[field>-10.0]=0
    field[field<=-10.0]=1
  elif (arguments.contourtype=='zmask'):
    lon = file.variables['lon'][:] 
    lat = file.variables['lat'][:] 
    field = file.variables['z'][:, :] 
  elif (arguments.contourtype=='xyz'):
    lon = file.variables['x'][:] 
    lat = file.variables['y'][:] 
    field = file.variables['z'][:, :] 
    field[field>=-10.0]=1
    field[field<-10.0]=0
  elif (arguments.contourtype=='noshelf'):
    lon = file.variables['lon'][:] 
    lat = file.variables['lat'][:] 
    field = file.variables['noshelf'][:, :] 
  # Greenland Standard Data Set
  elif (arguments.contourtype=='gsds'):
    lon = file.variables['x1'][:] 
    lat = file.variables['y1'][:] 
    field = file.variables['usrf'][0,:, :] 
    field[field>0.001]=1 
  elif (arguments.contourtype=='mask'):
    lon = file.variables['longrid'][:,:] 
    lat = file.variables['latgrid'][:,:] 
    field = file.variables['grounding'][:, :] 
  # Greenland Standard Data Set, to zero ice thickness
  elif (arguments.contourtype=='gsdsz'):
    lon = file.variables['x1'][:] 
    lat = file.variables['y1'][:] 
    field  = file.variables['thk'][0,:, :] 
    #height  = file.variables['usrf'][0,:, :] 
    #bedrock = file.variables['topg'][0,:, :] 
    #field = abs(height - bedrock)

    field[field<10.0]=0
    field[field>=10.0]=1
    #field[field>0.001]=1 
  elif (arguments.contourtype=='gebco'):
    # Currently non-functional - needs 2d z array
    lon = file.variables['x_range'][:] 
    lat = file.variables['y_range'][:] 
    field = file.variables['z_range'][:] 
    field[field<10.0]=0
    field[field>=10.0]=1
  elif (arguments.contourtype=='gsdszc'):
    lon = file.variables['x1'][:] 
    lat = file.variables['y1'][:] 
    height  = file.variables['usrf'][0,:, :] 
    bedrock = file.variables['topg'][0,:, :] 
    field = height - bedrock

    field[field<10.0]=0
    field[field>=10.0]=1
    #field[field<0.001]=0 
    #field[field>=0.001]=1 
  else:
    print "Contour type not recognised, '" + arguments.contourtype + "'"
    sys.exit(1)

  return lon, lat, field

def read_raster(filename):
  from PIL import Image
  im = Image.open(filename, 'r').convert('L')
  p = im.load()
  #p = im.getdata()
  #a = array(p)
  #a = array(im)
  a = asarray(im)
  #print a

  #sys.exit(0)
  # Change from 0-255 -> 0-1

  # Note flipped
  lon = arange(a.shape[1])
  lat = arange(a.shape[0])
  field = a
  print "Found raster, sizes", len(lon), len(lat), a.shape

  return lon, lat, field

def read_shape(filename):
  from osgeo import ogr
  from shapely.wkb import loads

  # See http://yaboolog.blogspot.co.uk/2012/08/geometry-and-python-tips-how-to-load.html
  def get_d_fid2pol(path_to_shp):
    """
    :param path_to_shp: path to *.shp
    :type path_to_shp: string
 
    :returns: {fid: MultiPolygon(), ...}
    :rtype: dictionary
    """
    data = ogr.Open(path_to_shp)
    elements = data.GetLayer()
    return dict([get_fid_and_poly(element) for element in elements])

  def get_fid_and_poly(element):
    """
    :param element: element of shapefile
    :type element: object
 
    :returns: {fid: MultiPolygon()}
    :rtype: element of dictionary
    """
    fid = element.GetField(0)
    poly = loads(element.GetGeometryRef().ExportToWkb())
    return (fid, poly)
  
  paths = []
  shapes = get_d_fid2pol(filename)
  shape = shapes[shapes.keys()[0]]
  #shape = shapes[0]

  from matplotlib.path import Path
  #class PPath(object):
  #  def __init__(self, vertices):
  #    self.vertices = vertices

  try:
    p = Path(vertices=shape.exterior.coords[:])
    #print p.vertices
    paths.append(p)
  except:
    pass
  for interior in shape.interiors:
    p = Path(vertices=interior.coords[:])
    #print p.vertices
    paths.append(p)

  return paths

def read_paths(filename):
  contour_required = False
  base, ext = os.path.splitext(filename)
  ext = ext.lstrip('.')
  if ext in ['png', 'tif', 'tiff']:
    lon, lat, field = read_raster(filename)
    contour_required = True
  elif ext in ['shp']:
    paths = read_shape(filename) 
  else: # NetCDF .nc files
    lon, lat, field = read_rtopo(filename)
    contour_required = True

  if (False):
    import matplotlib.pyplot as plt
    fig = plt.figure()
    #plt.plot(lon,lat, 'g-')
    #plt.show
    #plt.imshow(lon,lat,field)
    paths = plt.contour(lon,lat,field,levels=[0.5]).collections[0].get_paths()

    plt.show()
    #sys.exit(0)

  else:
    if contour_required:
      import matplotlib
      matplotlib.use('Agg')
      from pylab import contour
      print "Found raster, sizes", len(lon), len(lat), field.shape
      paths = contour(lon,lat,field,levels=[0.5]).collections[0].get_paths()

  return paths


#def haversine(origin, point):
#  
#  dLat = (lat2-lat1).toRad();
#var dLon = (lon2-lon1).toRad();
#var lat1 = lat1.toRad();
#var lat2 = lat2.toRad();
#
#var a = math.sin(dLat/2) * Math.sin(dLat/2) +
#        math.sin(dLon/2) * Math.sin(dLon/2) * Math.cos(lat1) * Math.cos(lat2); 
#var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a)); 
#var d = R * c;


def area_enclosed(p):
  #origin = [min(p[:,0]), min(p[:,1])]
  #print origin
  if (False):
    pp = zeros([size(p), 2], float)
    for i in range(size(p,0)):
      pp[i] = project(p[i], 'hammer')
      print i, p[i], pp[i]
  else:
    pp = p
  return 0.5 * abs(sum(x0*y1 - x1*y0 for ((x0, y0), (x1, y1)) in segments(pp)))

def segments(p):
  return zip(p, p[1:] + [p[0]])

def check_point_required(region, location):
  # make all definitions of the math module available to the function
  globals=math.__dict__
  globals['longitude'] = location[0]
  globals['latitude']  = location[1]
  return eval(region, globals)

def array_to_gmsh_points(num, index, location, minarea, region, dx, latitude_max):
  indexstore = index
  gmsh_section('Ice-Land mass number %s' % (num))
  count = 0 
  pointnumber = len(location[:,0])
  valid = [False]*pointnumber
  validnumber = 0

  loopstart = None
  loopend = None
  flag = 0
  #location[:, 0] = - location[:, 0] - 90.0
  dlatitude = 0
  dlongitude = 0
  for point in range(pointnumber):
    longitude = location[point, 0]
    latitude  = location[point, 1]
    if ( check_point_required(region, location[point, :]) ):
      if (validnumber > 0):
         dlatitude = max(abs(latitude - latitude_old), dlatitude)
         dlongitude = max(abs(longitude - longitude_old), dlongitude)
      latitude_old = latitude
      longitude_old = longitude
      valid[point] = True
      validnumber += 1
      if (flag == 0):
        loopstart = point
        flag = 1
      elif (flag == 1):
        loopend = point
    #print latitude, valid[point]
    
  if (loopend is None):
    printvv('Path %i skipped (no points found in region)' % ( num ))
    gmsh_comment('  Skipped (no points found in region)\n')
    return index

  #print num, abs(location[loopstart, 0] - location[loopend, 0]), abs(location[loopstart, 1] - location[loopend, 1]), 2 * dlongitude, 2 * dlatitude
  #print num, (abs(location[loopstart, 0] - location[loopend, 0]) < 2 * dlongitude), (abs(location[loopstart, 1] - location[loopend, 1]) > 2 * dlatitude)
  
  if ( (abs(location[loopstart, 0] - location[loopend, 0]) < 2 * dlongitude) and (abs(location[loopstart, 1] - location[loopend, 1]) > 2 * dlatitude) ):
    printvv('Path %i skipped (island crossing meridian - code needs modification to include)' % ( num ))
    gmsh_comment('  Skipped (island crossing meridian - code needs modification to include)\n')
    return index

  closelast=False
  if (compare_points(location[loopstart,:], location[loopend,:], dx)):
    # Remove duplicate line at end
    # Note loopend no longer valid
    valid[loopend] = False
    validnumber -= 1
    closelast=True

  validlocation = zeros( (validnumber, 2) )
  close = [False]*validnumber
  count = 0
  closingrequired = False
  closingrequirednumber = 0
  for point in range(pointnumber):
    if (valid[point]):
      validlocation[count,:] = location[point,:]
      if ((closingrequired) and (count > 0)):
        if (compare_points(validlocation[count-1,:], validlocation[count,:], dx)):
          closingrequired = False
      close[count] = closingrequired
      count += 1
      closingrequired = False
    else:
      if (not closingrequired):
        closingrequired = True
        closingrequirednumber += 1

  if (closelast):
    close[-1] = True
    closingrequirednumber += 1
    

  if (closingrequirednumber == 0): 
    closingtext = ''
  elif (closingrequirednumber == 1): 
    closingtext = ' (required closing in %i part of the path)' % (closingrequirednumber)
  else:
    closingtext = ' (required closing in %i parts of the path)' % (closingrequirednumber)
      
  area = area_enclosed(validlocation)
  if (area < minarea):
    printvv('Path %i skipped (area too small)' % ( num ))
    gmsh_comment('  Skipped (area too small)\n')
    return index

  printv('Path %i points %i/%i area %g%s' % ( num, validnumber, pointnumber, area_enclosed(validlocation), closingtext ))
 
  # if (closingrequired and closewithparallel):
  #   latitude_max = None
  #   index_start = index + 1
  #   for point in range(validnumber - 1):
  #     longitude = validlocation[point,0]
  #     latitude  = validlocation[point,1]
  #     index += 1
  #     loc = project(longitude, latitude)
  #     output.write( gmsh_format_point(index, loc, 0) )
  #     if (latitude_max is None):
  #       latitude_max = latitude
  #     else:
  #       latitude_max = max(latitude_max, latitude)
  #   draw_parallel(index, index_start, [ validlocation[point,0], max(latitude_max, validlocation[point,1]) ], [ validlocation[0,0], max(latitude_max, validlocation[0,1]) ], points=200)
  #   index += 200
  #   
  #   index += 1
  #   output.write( gmsh_format_point(index, project(validlocation[0,0], validlocation[0,1]), 0) )
  #   
  # else:
  if (close[0]):
    close[-1] = close[0]
  
  index.start = index.point + 1
  loopstartpoint = index.start
   
  # 0=old, 1=new
  behaviour=0
  print dx

  if behaviour == 1:
    for point in range(validnumber):
      #longitude = validlocation[point,0]
      #latitude  = validlocation[point,1]

      #gmsh_comment('HERE ' + str(close[0]) + ' ' + str(close[point]) + ' ' + str(point == validnumber - 1) + '' + str(not (compare_points(validlocation[point], validlocation[0], dx))))
      if ((close[point]) and (point == validnumber - 1) and (not (compare_points(validlocation[point], validlocation[0], dx)))):
        #gmsh_comment('**** END ' + str(point) + '/' + str(validnumber-1) + str(close[point]))
       # index = gmsh_loop(index, loopstartpoint, False, False, False)
        #index = draw_parallel_explicit(validlocation[point], validlocation[0], index, latitude_max, dx)
        index = close_path(validlocation[point], validlocation[0], index, dx, latitude_max)
        #index = gmsh_loop(index, loopstartpoint, True, True, False)
        index = gmsh_loop(index, loopstartpoint, True, False, False)
        #gmsh_comment('**** END end of loop ' + str(closelast) + str(point) + '/' + str(validnumber-1) + str(close[point]))
        gmsh_comment('')
      elif ((close[point]) and (point > 0) and (not (compare_points(validlocation[point], validlocation[0], dx)))):
        #gmsh_comment('**** NOT END ' + str(point) + '/' + str(validnumber-1) + str(close[point]))
        gmsh_comment(str(validlocation[point,:]) + str(validlocation[point,:]))
        index = gmsh_loop(index, loopstartpoint, False, False, False)
        #index = draw_parallel_explicit(validlocation[point - 1], validlocation[point], index, latitude_max, dx)
        index = close_path(validlocation[point - 1], validlocation[point], index, dx, latitude_max)
        index = gmsh_loop(index, loopstartpoint, False, True, False)
        #gmsh_comment('**** NOT END end of loop ' + str(point) + '/' + str(validnumber-1) + str(close[point]))
        gmsh_comment('')
      else:
        index.point += 1
        gmsh_format_point(index.point, project(validlocation[point,:]), 0)
        index.contournodes.append(index.point)
  
      index = gmsh_loop(index, loopstartpoint, (closelast and (point == validnumber - 1)), False, False)

  else:
    for point in range(validnumber):
      #longitude = validlocation[point,0]
      #latitude  = validlocation[point,1]
      print 'dxx', dx

      if ((close[point]) and (point == validnumber - 1) and (not (compare_points(validlocation[point], validlocation[0], dx)))):
        gmsh_comment('**** END ' + str(point) + '/' + str(validnumber-1) + str(close[point]))
        index = gmsh_loop(index, loopstartpoint, False, False, True)
        index = draw_parallel_explicit(validlocation[point], validlocation[0], index, latitude_max, dx)
        index = gmsh_loop(index, loopstartpoint, True, True, True)
        gmsh_comment('**** END end of loop ' + str(closelast) + str(point) + '/' + str(validnumber-1) + str(close[point]))
      elif ((close[point]) and (point > 0) and (not (compare_points(validlocation[point], validlocation[0], dx)))):
        gmsh_comment('**** NOT END ' + str(point) + '/' + str(validnumber-1) + str(close[point]))
        gmsh_comment(str(validlocation[point,:]) + str(validlocation[point,:]))
        index = gmsh_loop(index, loopstartpoint, False, False, True)
        index = draw_parallel_explicit(validlocation[point - 1], validlocation[point], index, latitude_max, dx)
        index = gmsh_loop(index, loopstartpoint, False, True, True)
        gmsh_comment('**** NOT END end of loop ' + str(point) + '/' + str(validnumber-1) + str(close[point]))
      else:
        index.point += 1
        gmsh_format_point(index.point, project(validlocation[point,:]), 0)
        index.contournodes.append(index.point)

    index = gmsh_loop(index, loopstartpoint, (closelast and (point == validnumber - 1)), False, True)




  # asc
  #index = pig_sponge(index, loopstartpoint, index.point, validlocation[0], validlocation[-1])

  return index

#LoopStart1 = IP + 20;
#LoopEnd1 = IP + 3157;
#BSpline ( IL + 1 ) = { IP + 20 : IP + 3157 };
#Line Loop( ILL + 10 ) = { IL + 1 };
#
#LoopStart1 = IP + 3157;
#LoopEnd1 = IP + 3231;
#BSpline ( IL + 2 ) = { IP + 3157 : IP + 3231, IP + 20 };
#Line Loop( ILL + 20 ) = { IL + 2 };


def gmsh_loop(index, loopstartpoint, last, open,  cachephysical):
  if (index.point <= index.start):
    return index
  #pointstart = indexstart
  #pointend   = index.point
  #loopnumber = index.loop
  if (last):
    closure = ', IP%(fileid)s + %(pointstart)i' % { 'pointstart':loopstartpoint, 'fileid':fileid }
  else:
    closure = ''
  if (open):
    index.open.append(index.path)
    type = 'open'
    boundaryid = boundary.open
    index.physicalopen.append(index.path)
  else:
    index.contour.append(index.path)
    type = 'contour'
    boundaryid = boundary.contour
    index.physicalcontour.append(index.path)

  index.pathsinloop.append(index.path)

#//Line Loop( ILL + %(loopnumber)i ) = { IL + %(loopnumber)i };
#// Identified as a %(type)s path
  output.write( '''LoopStart%(loopnumber)i = IP + %(pointstart)i;
LoopEnd%(loopnumber)i = IP + %(pointend)i;
''' % { 'pointstart':index.start, 'pointend':index.point, 'loopnumber':index.path, 'loopstartpoint':closure, 'type':type, 'boundaryid':boundaryid } )
  
  if not compound:
    output.write( '''BSpline ( IL%(fileid)s + %(loopnumber)i ) = { IP%(fileid)s + %(pointstart)i : IP%(fileid)s + %(pointend)i%(loopstartpoint)s };''' % { 'pointstart':index.start, 'pointend':index.point, 'loopnumber':index.path, 'loopstartpoint':closure, 'type':type, 'boundaryid':boundaryid, 'fileid':fileid } )

  index.physicalgroup.append(index.path)
#  output.write( '''
#Physical Line( %(boundaryid)i ) = { %(loopnumbers)s };
#''' % { 'boundaryid':boundaryid , 'loopnumbers':list_to_comma_separated(index.pathsinloop, prefix = 'IL + ') } )
#  output.write( '''
#Physical Line( ILL + %(loop)i ) = { %(loopnumbers)s };
#''' % { 'loop':index.loop , 'loopnumbers':list_to_comma_separated(index.pathsinloop, prefix = 'IL + ') } )


  if (not(cachephysical)):
    #output.write( '''
#Physical Line( %(boundaryid)i ) = { %(loopnumbers)s };
#''' % { 'boundaryid':boundaryid, 'loopnumbers':list_to_comma_separated(index.physicalgroup, prefix = 'IL + ') } )
    index.physicalgroup = []

  compoundpoints = False
  if (last):
    if compound:
      for i in range(index.start, index.point+1):
        if i == index.point:
          end = index.start
        else:
          end = i + 1
        output.write( '''Line ( ILL%(fileid)s + %(loopnumber)i + 100000 ) = { IP%(fileid)s + %(pointstart)i, IP%(fileid)s + %(pointend)i };
''' % { 'pointstart':i, 'pointend':end, 'loopnumber':i, 'fileid':fileid } )
      output.write( '''Compound Line ( IL%(fileid)s + %(loopnumber)i ) = { ILL%(fileid)s + %(pointstart)i + 100000 : ILL%(fileid)s + %(pointend)i + 100000 };
  ''' % { 'pointstart':index.start, 'pointend':index.point, 'loopnumber':index.loop, 'fileid':fileid } )
      output.write( '''
Line Loop( ILL%(fileid)s + %(loop)i ) = { IL%(fileid)s + %(loopnumber)i};''' % { 'loop':index.loop, 'fileid':fileid, 'loopnumber': index.loop } )

    else:
      output.write( '''
Line Loop( ILL%(fileid)s + %(loop)i ) = { %(loopnumbers)s };''' % { 'loop':index.loop, 'fileid':fileid, 'loopnumbers':list_to_comma_separated(index.pathsinloop, prefix = 'IL%(fileid)s + ' % { 'fileid':fileid }) } )
    index.loops.append(index.loop)
    index.loop += 1
    index.pathsinloop = []
  
  output.write( '''
''' )

  index.path +=1
  index.start = index.point
  return index

  printv('Closed boundaries (id %i): %s' % (boundary.contour, list_to_space_separated(index.contour, add=1)))
  printv('Open boundaries   (id %i): %s' % (boundary.open, list_to_space_separated(index.open, add=1)))



def output_boundaries(index, filename, paths=None, minarea=0, region='True', dx=dx_default, latitude_max=None):
  import pickle
  #try:
  #  picklefile = open(arguments.picklefile, 'rb')
  #  printv('Path pickle file found: ' + arguments.picklefile)
  #  pathall = pickle.load(picklefile)
  #  picklefile.close()
  #except:
  #  printv('No path pickle file present, generating contours and saving ' + arguments.picklefile + 'for the future!')
  #  pathall = read_rtopo(filename)
  #  picklefile = open(arguments.picklefile, 'wb')
  #  pickle.dump(pathall, picklefile)
  #  picklefile.close()


  if arguments.cache and os.path.exists(arguments.picklefile):
    picklefile = open(arguments.picklefile, 'rb')
    printv('Cache file found: ' + arguments.picklefile)
    pathall = pickle.load(picklefile)
    picklefile.close()
  else:
    printv('Generating contours', include = False)
    pathall = read_paths(filename)
    if arguments.cache:
      printv('Saving contours to: ' + arguments.picklefile + ' for the future!')
      picklefile = open(arguments.picklefile, 'wb')
      pickle.dump(pathall, picklefile)
      picklefile.close()

  printv('Paths found: ' + str(len(pathall)))
  gmsh_header()
  splinenumber = 0
  indexbase = 1
  index.point = indexbase

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
  printv('Paths that cross the date line: ' + ' '.join(map(strplusone,dateline)))

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
      printv('More than one match found for path %d' % num)
      print matches
      sys.exit(1)
    elif (len(matches) == 0):
      printv('No match found for path %d' % num)
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

  printv('Merged paths that cross the date line: ' + ' '.join(map(strplusone,appended)))

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
    if num in arguments.boundariestoexclude:
      continue
    pathvalid.append(num)  
  printv('Paths found valid: ' + str(len(pathvalid)) + ', including ' + ' '.join(map(str, pathvalid)))
  #print ends
  if (len(pathvalid) == 0):
    printv('No valid paths found.')
    sys.exit(1)

  if arguments.smooth_data:
    for num in pathvalid:
      if (pathall[num-1] == None):
        continue
      xy=pathall[num-1].vertices
      origlen=len(xy)
      x = smoothGaussian(xy[:,0], degree=arguments.smooth_degree)
      y = smoothGaussian(xy[:,1], degree=arguments.smooth_degree)
      xy = zeros([len(x),2])
      xy[:,0] = x
      xy[:,1] = y
      pathall[num-1].vertices = xy
      printv('Smoothed path %d, nodes %d from %d' % (num, len(xy), origlen))


  if (arguments.plotcontour):
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
    index = array_to_gmsh_points(num, index, xy, minarea, region, dx, latitude_max)


  #for i in range(-85, 0, 5):
  #  indexend += 1
  #  output.write( gmsh_format_point(indexend, project(0, i), 0) )
  #for i in range(-85, 0, 5):
  #  indexend += 1
  #  output.write( gmsh_format_point(indexend, project(45, i), 0) )
  #gmsh_remove_projection_points()
  return index

def define_point(name, location):
  # location [long, lat]
  output.write('''
//Point %(name)s is located at, %(longitude).2f deg, %(latitude).2f deg.
Point_%(name)s_longitude_rad = (%(longitude)f + (00/60))*(Pi/180);
Point_%(name)s_latitude_rad  = (%(latitude)f + (00/60))*(Pi/180);
Point_%(name)s_stereographic_y = Cos(Point_%(name)s_longitude_rad)*Cos(Point_%(name)s_latitude_rad)  / ( 1 + Sin(Point_%(name)s_latitude_rad) );
Point_%(name)s_stereographic_x = Cos(Point_%(name)s_latitude_rad) *Sin(Point_%(name)s_longitude_rad) / ( 1 + Sin(Point_%(name)s_latitude_rad) );
''' % { 'name':name, 'longitude':location[0], 'latitude':location[1] } )

def draw_parallel(startn, endn, start, end, points=200):
  startp = project(start)
  endp = project(end)
  
  output.write('''
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

def longitude_diff(a,b):
  diff = a - b
  if (diff > 180):
    diff = diff - 360
  if (diff < -180):
    diff = diff + 360
  return diff
   #  -179  -   179 = -358  2
   #  179   -  -179 =  358  -2

def point_diff(a,b):
  diff = [longitude_diff(a[0],b[0]), (a[1] - b[1]) % 360]
  if (diff[1] > 180):
    diff[1] = diff[1] - 360
  return diff 


def point_diff_cartesian(a,b):
  pa = project(a, type='proj_cartesian')
  pb = project(b, type='proj_cartesian')
  diff = [ a[0] - b[0], a[1] - b[1] ]
  return diff

def point_diff_cartesian(a,b):
  pa = project(a, type='proj_cartesian')
  pb = project(b, type='proj_cartesian')
  diff = [ pa[0] - pb[0], pa[1] - pb[1] ]
  return diff

def compare_points(a, b, dx, proj='longlat'):
  tolerance = dx * 0.6
  if (proj == 'horizontal'):
    pa = project(a, type='proj_cartesian')
    pb = project(b, type='proj_cartesian')
    #print tolerance, pa, pb
    if ( not (abs(pa[1] - pb[1]) < tolerance) ):
      return False
    elif (abs(pa[0] - pb[0]) < tolerance):
      return True
    else:
      return False
  else: 
    if ( not (abs(a[1] - b[1]) < tolerance) ):
      #gmsh_comment('lat differ')
      return False
    elif (abs(a[0] - b[0]) < tolerance):
      #gmsh_comment('long same')
      return True
    elif ((abs(abs(a[0]) - 180) < tolerance) and (abs(abs(b[0]) - 180) < tolerance)):
      #gmsh_comment('long +/-180')
      return True
    else:
      #gmsh_comment('not same %g %g' % (abs(abs(a[0]) - 180), abs(abs(b[0]) - 180) ) )
      return False

def p2(location):
  p = project(project(location, type='proj_cartesian'), type='proj_cartesian_inverse')
  if (p[0] < 0.0):
    p[0] = p[0] + 360
  return p

def norm(a):
  return math.sqrt( (a[0]**2 + a[1]**2) )

def close_path(start, end, index, dx, latitude_max, proj='longlat'):
  #print start, end
  #print p2(start), p2(end)
  if (arguments.closewithparallels):
    return draw_parallel_explicit(start, end, index, latitude_max, dx)
  current = start.copy()
  tolerance = dx * 0.6
  diffinit = point_diff(end, current)

  dxs = int(ceil(norm([ diffinit[0], diffinit[1] ]) / dx))
  #print dxs
  
  if (compare_points(current, end, dx, proj=proj)):
    gmsh_comment('Points already close enough after all' + proj + ' dx ' + str(dx))
    return index
  else:
    gmsh_comment('Closing path, from (%.8f, %.8f) to (%.8f, %.8f), with vector (%.8f, %.8f)' % ( start[0], start[1], end[0], end[1], diffinit[0], diffinit[1] ) )
 
  loopstartpoint = 0
  loopstartpoint = index.point
  loopstart = index

  if (proj is 'longlat'):
    while (not compare_points(current, end, dx, proj=proj)):

      diff = point_diff(end, current)
        
      normdiff = norm(diff)
      #print current,end,diff,dx,normdiff
      if (abs(normdiff) < dx * 1.5):
        gmsh_comment('Finished closing, projection ' + proj + ' normdiff ' + str(normdiff) + ' dx ' + str(dx))
        current = end
      else:
        current[0] = current[0] + diff[0] * (dx /  normdiff)
        current[1] = current[1] + diff[1] * (dx /  normdiff)

        index.point += 1
        printvv('Drawing connection to end index %s at %f.2, %f.2 (to match %f.2)' % (index.point, current[0], current[1], end[1]))
        loc = project(current)
        gmsh_format_point(index.point, loc, 0.0)

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
      gmsh_format_point(index.point, nloc, 0.0)
      

  #print index.point, loopstartpoint

  #if (index.point - loopstartpoint > 10):
    #print 'Excessive ', start, end, diff, diffinit
    
  if (index.point > loopstart.point):
    index = gmsh_loop(index, loopstart, True, True, False)
  
  gmsh_comment( 'Closed path as crow flys, from (%.8f, %.8f) to  (%.8f, %.8f)' % ( start[0], start[1], end[0], end[1] ) )

  #print index
  return index

def draw_parallel_explicit(start, end, index, latitude_max, dx):

  #print start, end, index.point
  # Note start is actual start - 1
  if (latitude_max is None):
    latitude_max = max(start[1], end[1])
  else:
    latitude_max = max(latitude_max, start[1], end[1])
  current = start 
  tolerance = dx * 0.6
   
  if (compare_points(current, end, dx)):
    gmsh_comment('Points already close enough, no need to draw parallels and meridians after all')
    return index
  else:
    gmsh_comment('Closing path with parallels and merdians, from (%.8f, %.8f) to  (%.8f, %.8f)' % ( start[0], start[1], end[0], end[1] ) )
  
  loopstart = index
  if (current[1] != latitude_max):
    gmsh_comment('Drawing meridian to max latitude index %s at %f.2, %f.2 (to match %f.2)' % (index.point, current[0], current[1], latitude_max))
  while (current[1] != latitude_max):
    if (current[1] < latitude_max):
      current[1] = current[1] + dx
    else:
      current[1] = current[1] - dx
    if (abs(current[1] - latitude_max) < tolerance): current[1] = latitude_max
    if (compare_points(current, end, dx)): return index
    index.point += 1
    printvv('Drawing meridian to max latitude index %s at %f.2, %f.2 (to match %f.2)' % (index.point, current[0], current[1], latitude_max))
    loc = project(current)
    gmsh_format_point(index.point, loc, 0.0)
  if more_bsplines:
    index = gmsh_loop(index, loopstart, False, True, True)

    loopstart = index
  if (current[0] != end[0]):
    gmsh_comment('Drawing parallel index %s at %f.2 (to match %f.2), %f.2' % (index.point, current[0], end[0], current[1]))
  while (current[0] != end[0]):
    if (longitude_diff(current[0], end[0]) < 0):
      current[0] = current[0] + dx
    else:
      current[0] = current[0] - dx
    #if (abs(current[0] - end[0]) < tolerance): current[0] = end[0]
    if (abs(longitude_diff(current[0], end[0])) < tolerance): current[0] = end[0]

    if (compare_points(current, end, dx)): return index
    index.point += 1
    printvv('Drawing parallel index %s at %f.2 (to match %f.2), %f.2' % (index.point, current[0], end[0], current[1]))
    loc = project(current)
    gmsh_format_point(index.point, loc, 0.0)
  if more_bsplines:
    index = gmsh_loop(index, loopstart, False, True, True)

    loopstart = index
  if (current[1] != end[1]):
    gmsh_comment('Drawing meridian to end index %s at %f.2, %f.2 (to match %f.2)' % (index.point, current[0], current[1], end[1]))
  while (current[1] != end[1]):
    if (current[1] < end[1]):
      current[1] = current[1] + dx
    else:
      current[1] = current[1] - dx
    if (abs(current[1] - end[1]) < tolerance): current[1] = end[1]
    if (compare_points(current, end, dx)): return index
    index.point += 1
    printvv('Drawing meridian to end index %s at %f.2, %f.2 (to match %f.2)' % (index.point, current[0], current[1], end[1]))
    loc = project(current)
    gmsh_format_point(index.point, loc, 0.0)
  index = gmsh_loop(index, loopstart, True, True, False)
  
  gmsh_comment( 'Closed path with parallels and merdians, from (%.8f, %.8f) to  (%.8f, %.8f)' % ( start[0], start[1], end[0], end[1] ) )

  return index

def list_to_comma_separated(numbers, prefix='', add=0):
  requirecomma = False
  string = ''
  for number in numbers:
    if (requirecomma):
      string += ', '
    else:
      requirecomma = True
    string += prefix
    string += str(number + add)
  return string

def list_to_space_separated(numbers, prefix='', add=0):
  requirespace = False
  string = ''
  for number in numbers:
    if (requirespace):
      string += ' '
    else:
      requirespace = True
    string += prefix
    string += str(number + add)
  return string

def output_open_boundaries(index, boundary, dx):
  parallel = arguments.bounding_lat
  index.start = index.point + 1
  loopstartpoint = index.start
  index = draw_parallel_explicit([   -1.0, parallel], [ 179.0, parallel], index, None, dx)
  index = draw_parallel_explicit([-179.0,  parallel], [   1.0, parallel], index, None, dx)
  
  index = gmsh_loop(index, loopstartpoint, True, True, False)

  return index

def output_surfaces(index, boundary):

  gmsh_section('Physical entities')


  if physical_lines_separate:
    for l in index.physicalcontour:
      output.write( '''Physical Line( %(boundaryid)i ) = { %(loopnumbers)s };''' % { 'boundaryid':boundary.contour, 'loopnumbers':list_to_comma_separated([l], prefix = 'IL%(fileid)s + ' % { 'fileid':fileid } ) } )
      output.write( '''\n''' )
  else: 
    output.write( '''Physical Line( %(boundaryid)i ) = { %(loopnumbers)s };''' % { 'boundaryid':boundary.contour, 'loopnumbers':list_to_comma_separated(index.physicalcontour, prefix = 'IL%(fileid)s + ' % { 'fileid':fileid } ) } )
    output.write( '''\n''' )

  output.write( '''Physical Line( %(boundaryid)i ) = { %(loopnumbers)s };''' % { 'boundaryid':boundary.open, 'loopnumbers':list_to_comma_separated(index.physicalopen, prefix = 'IL%(fileid)s + ' % { 'fileid':fileid } ) } )
  output.write( '''\n''' )


  printv('Open boundaries   (id %i): %s' % (boundary.open, list_to_space_separated(index.open, add=1)))
  printv('Closed boundaries (id %i): %s' % (boundary.contour, list_to_space_separated(index.contour, add=1)))
  boundary_list = list_to_comma_separated(index.contour + index.open)
#//Line Loop( ILL + %(loopnumber)i ) = { %(boundary_list)s };
#//Plane Surface( %(surface)i ) = { ILL + %(loopnumber)i };
  if (len(index.loops) > 0):
    output.write('''Plane Surface( %(surface)i ) = { %(boundary_list)s };
Physical Surface( %(surface)i ) = { %(surface)i };''' % { 'loopnumber':index.path, 'surface':boundary.surface + 1, 'boundary_list':list_to_comma_separated(index.loops, prefix = 'ILL%(fileid)s + ' % { 'fileid':fileid } ) } )
  else:
    printv('Warning: Unable to define surface - may need to define Line Loops?')

def acc_array():
  acc = array([[   1.0, -53.0 ],
[  10.0, -53.0 ],
[  20.0, -52.0 ],
[  30.0, -56.0 ],
[  40.0, -60.0 ],
[  50.0, -63.0 ],
[  60.0, -64.0 ],
[  70.0, -65.0 ],
[  80.0, -67.0 ],
[  90.0, -60.0 ],
[ 100.0, -58.0 ],
[ 110.0, -62.0 ],
[ 120.0, -63.0 ],
[ 130.0, -65.0 ],
[ 140.0, -65.0 ],
[ 150.0, -64.0 ],
[ 160.0, -61.0 ],
[ 170.0, -64.0 ],
[ 179.0, -65.0 ],
[-179.0, -65.0 ],
[-170.0, -64.0 ],
[-160.0, -62.0 ],
[-150.0, -66.0 ],
[-140.0, -58.0 ],
[-130.0, -60.0 ],
[-120.0, -65.0 ],
[-110.0, -66.0 ],
[-100.0, -70.0 ],
[ -90.0, -70.0 ],
[ -80.0, -77.0 ],
[ -70.0, -72.0 ],
[ -60.0, -60.0 ],
[ -50.0, -57.0 ],
[ -40.0, -51.0 ],
[ -30.0, -50.0 ],
[ -20.0, -60.0 ],
[ -10.0, -56.0 ],
[ -1.0, -53.0 ]])
  return acc


def draw_acc_old(index, boundary, dx):
  acc = acc_array()
  gmsh_comment('ACC')
  index.start = index.point + 1
  loopstartpoint = index.start
  for i in range(len(acc[:,0])):
    index.point += 1
    location = project(acc[i,:])
    gmsh_format_point(index.point, location, 0.0)

  for i in range(len(acc[:,0])):
    a = index.start + i
    b = a + 1
    if (a == index.point):
      b = index.start
    output.write('Line(%i) = {%i,%i};\n' % (i + 100000, a, b  ))
  output.write('Line Loop(999999) = { %i : %i};\n' % ( index.start, index.point ))
  return index


def draw_acc(index, boundary, dx):
  acc = acc_array()
  acc1 = acc[0:18,:]
  acc2 = acc[19:,:]
  print acc1
  print acc2
  gmsh_comment('ACC')

  index.start = index.point + 1
  loopstartpoint = index.start
  for i in range(len(acc1[:,0])):
    index.point += 1
    location = project(acc1[i,:])
    gmsh_format_point(index.point, location, 0.0)
  index = gmsh_loop(index, loopstartpoint, False, True, False)

  #index.start = index.point + 1
  #loopstartpoint = index.start
  for i in range(len(acc2[:,0])):
    index.point += 1
    location = project(acc2[i,:])
    gmsh_format_point(index.point, location, 0.0)
  index = gmsh_loop(index, loopstartpoint, True, True, False)

  return index


def output_fields(index,boundary):
  gmsh_section('Field definitions')
  if compound:
    edgeindex = ''
  else:
    edgeindex = ''
  if (index.contour is not None):
    output.write('''
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
''' % { 'boundary_list':list_to_comma_separated(index.contour, prefix = 'IL%(fileid)s + %(edgeindex)s' % {'fileid':fileid, 'edgeindex':edgeindex}), 'elementlength':arguments.elementlength, 'fileid':fileid } )

  gmsh_section('Physical entities')

  output.write('''
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

def generate_mesh(infile):
  if (not arguments.generatemesh):
    return
  import subprocess, re
  command = 'gmsh'
  commandfull = command + ' -2 ' + infile
  print('Mesh generation, using ' + commandfull)
  p = subprocess.Popen(commandfull , shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
  #f = open(tempfile, 'w')
  #f.write(str(p.pid))
  #f.close()
  for line in p.stdout.readlines():
    print line,
  retval = p.wait()

  outfile = re.sub(r"\.geo$", ".msh", infile)
  print('Mesh generation complete, try: ' + command + ' ' + outfile)
  print('  note, might require parsing')

def generate_mesh2(infile):
  if (not arguments.generatemesh):
    return
  import subprocess, re
  command = 'gmsh'
  commandfull = command + ' -v 1 -2 ' + infile
  print('Mesh generation, using ' + commandfull)
  process = subprocess.Popen(
    commandfull, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE
  )
  while True:
    out = process.stdout.read(1)
    if out == '' and process.poll() != None:
      break
    if out != '':
      sys.stdout.write(out)
      sys.stdout.flush()
  outfile = re.sub(r"\.geo$", ".msh", infile)
  print('Mesh generation complete, try: ' + command + ' ' + outfile)
  print('  note, might require parsing')

def generatemetric(sourcefile, outputfilename = 'metric.pos', fieldname = 'z', minimumdepth = 10.0, type='struct'):

  globallonglat = False

  globe=True
  globe=False

  fieldname = 'z'
  fieldname = 'Band1'

  def write(string, newline=True):
    metric.write(string + '\n')

  file = NetCDF.NetCDFFile(sourcefile, 'r')
  print file.variables.keys()
  if 'lon' in file.variables.keys():
    lon = file.variables['lon'][:] 
    lat = file.variables['lat'][:]
    globallonglat = True
  else:
    lon = file.variables['x'][:] 
    lat = file.variables['y'][:]
  field = file.variables[fieldname][:, :] 

  metric = open(outputfilename,'w')
 

  if (globe):
    field[field > - minimumdepth] = - minimumdepth
    field = - field

  if (type == 'pos'):
    write('View "background_edgelength" {')
    for i in range(len(lon)):
      for j in range(len(lat)):            
        p = project([lon[i],lat[j]], type=None)
        if (p[0] == None or p[1] == None):
          continue
        write('SP(' + str(p[0]) + ', ' + str(p[0]) + ', 0.0 ){' + str(field[j][i]) + '};')
    write('};')
  elif(type == 'struct'):
    if (not globe):
      #x = [ -16.0, 5 ]
      #y = [ 44.0, 66.0 ]
      x = [ 256.164, 261.587 ]
      y = [ -75.519, -74.216 ]
      
      x = [ lon[0], lon[-1] ]
      y = [ lat[-1], lat[0] ]

      write( str(x[0]) + ' ' + str(y[0]) + ' ' +  '0' )
      write( str(float(x[-1] - x[0])/len(lon)) + " " + str(float(y[-1] - y[0])/len(lat)) + ' 1')
    else: 
      if globallonglat:
        write( str( lon[0] + 180 ) + ' ' + str( lat[0] + 90 ) + ' 0' )
      else:
        write( str( lon[0] ) + ' ' + str( lat[0] ) + ' 0' )

      write( str(float(abs(lon[0])+abs(lon[-1]))/len(lon))+" "+ str(float(abs(lat[0])+abs(lat[-1]))/len(lat)) + ' 1')
    write( str(len(lon))+" "+str(len(lat))+" 1")
    for i in range(len(lon)):
      for j in range(len(lat))[::-1]:         
        write(str(field[j][i]))
        #write(str(lon[i]))

  metric.close()

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



#def scenario(name):
#  filcher_ronne = argument

argv = sys.argv[1:]
class arguments:
  input  = '/d/dataset/rtopo/RTopo105b_50S.nc'
  #picklefile = '/d/dataset/rtopo/rtopo.pkl'
  picklefile = ''
  #output = './stereographic_projection.geo'
  output = './shorelines.geo'
  boundaries = []
  boundariestoexclude = []
  region = 'True'
  box = []
  minarea = 0
  dx = dx_default
  extendtolatitude = None
  open = True
  verbose = True
  debug = False
  bounding_lat = -50.0
  smooth_data = False
  smooth_degree = 100
  include_iceshelf_ocean_cavities = True
  projection = 'cartesian'
  contourtype = 'iceshelfcavity'
  plotcontour = False
  #call = ' '.join(argv)
  call = ''
  cache = False
  closewithparallels = False
  elementlength = '1.0E5'
  generatemesh = False
  generatemetric = False
  for arg in argv:
    if ' ' in arg:
      call = call + ' \'' + arg + '\''
    else:
      call = call + ' ' + arg


def main():
  while (len(argv) > 0):
    argument = argv.pop(0).rstrip()
    if   (argument == '-h'): usage()
    elif (argument == '-s'): arguments.scenario = str(argv.pop(0).rstrip()); arguments=scenario(arguments.scenario)
    elif (argument == '-n'): arguments.input  = argv.pop(0).rstrip()
    elif (argument == '-f'): arguments.output = argv.pop(0).rstrip()
    elif (argument == '-t'): arguments.contourtype = argv.pop(0).rstrip()
    elif (argument == '-r'): arguments.region = argv.pop(0).rstrip()
    elif (argument == '-m'): arguments.projection = argv.pop(0).rstrip()
    elif (argument == '-dx'): arguments.dx = float(argv.pop(0).rstrip())
    elif (argument == '-lat'): arguments.extendtolatitude = float(argv.pop(0).rstrip()); arguments.closewithparallels = True
    elif (argument == '-a'): arguments.minarea = float(argv.pop(0).rstrip())
    elif (argument == '-bounding_latitude'): arguments.bounding_lat =float(argv.pop(0).rstrip())
    elif (argument == '-bl'): arguments.bounding_lat = float(argv.pop(0).rstrip())
    elif (argument == '-smooth_data'):
      arguments.smooth_degree = int(argv.pop(0).rstrip())
      arguments.smooth_data = True
    elif (argument == '-no'): arguments.open = False
    elif (argument == '-exclude_ice_shelves'): arguments.include_iceshelf_ocean_cavities = False
    elif (argument == '-c'): arguments.cache = True
    elif (argument == '-plot'): arguments.plotcontour = True
    elif (argument == '-mesh'): arguments.generatemesh = True
    elif (argument == '-m'): arguments.projection = argv.pop(0).rstrip()
    elif (argument == '-el'): arguments.elementlength = argv.pop(0).rstrip()
    elif (argument == '-metric'): arguments.generatemetric = True
    elif (argument == '-v'): arguments.verbose = True
    elif (argument == '-vv'): arguments.verbose = True; arguments.debug = True; 
    elif (argument == '-q'): arguments.verbose = False
    elif (argument == '-p'):
      while ((len(argv) > 0) and (argv[0][0] != '-')):
        arguments.boundaries.append(int(argv.pop(0).rstrip()))
    elif (argument == '-pn'):
      while ((len(argv) > 0) and (argv[0][0] != '-')):
        arguments.boundariestoexclude.append(int(argv.pop(0).rstrip()))
    elif (argument == '-b'):
      while ((len(argv) > 0) and ((argv[0][0] != '-') or ( (argv[0][0] == '-') and (argv[0][1].isdigit()) ))):
        arguments.box.append(argv.pop(0).rstrip())

  arguments.region = expand_boxes(arguments.region, arguments.box)



  if (arguments.generatemetric):
    print('Generating metric...')
    generatemetric(arguments.input)
    sys.exit(0)


  #source = file(arguments.input,'r')
  output = file(arguments.output,'w')

  gmsh_comment('Arguments: ' + arguments.call)
  if (not(os.path.isfile(arguments.input))):
    print('Source netCDF ' + arguments.input + ' not found!')
    sys.exit(1)
  printv('Source netCDF located at ' + arguments.input)
  arguments.picklefile = arguments.input + '.' + arguments.contourtype + '.pkl'
  if (not(os.path.isfile(arguments.picklefile))):
    print('Contour cache ' + arguments.picklefile + ' not found, forcing generation.')
    arguments.cache = True
  printv('Output to ' + arguments.output)
  printv('Projection type ' + arguments.projection)
  if (len(arguments.boundaries) > 0):
    printv('Boundaries restricted to ' + str(arguments.boundaries))
  if (arguments.region is not 'True'):
    printv('Region defined by ' + str(arguments.region))
  if (arguments.dx != dx_default):
    printv('Open contours closed with a line formed by points spaced %g degrees apart' % (arguments.dx))
  if (arguments.extendtolatitude is not None):
    printv('Extending region to meet parallel on latitude ' + str(arguments.extendtolatitude))

  gmsh_comment('')




  index = output_boundaries(index, filename=arguments.input, paths=arguments.boundaries, minarea=arguments.minarea, region=arguments.region, dx=arguments.dx, latitude_max=arguments.extendtolatitude)

  if (arguments.open): index = output_open_boundaries(index, boundary, arguments.dx)
  output_surfaces(index, boundary)

  #index = draw_acc(index, boundary, arguments.dx)

  gmsh_section('End of contour definitions')

  output_fields(index,boundary)


  if (len(index.skipped) > 0):
    printv('Skipped (because no point on the boundary appeared in the required region, or area enclosed by the boundary was too small):\n'+' '.join(index.skipped))
  output.close()

  generate_mesh2(arguments.output)


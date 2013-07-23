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

from Scientific.IO import NetCDF
import matplotlib
matplotlib.use('Agg')
from pylab import contour
#import matplotlib
#matplotlib._cntr.Cntr
#from matplotlib import contour
#matplotlib.use('Agg')
from numpy import zeros, array, append, exp

#contour = matplotlib.pyplot.contour

# TODO
# Calculate area in right projection
# Add region selection function
# Ensure all islands selected
# Identify Open boundaries differently
# Export command line to geo file
# If nearby, down't clode with parallel

def printv(text):
  if (arguments.verbose):
    print text
  gmsh_comment(text)

def printvv(text):
  if (arguments.debug):
    print text

def gmsh_comment(comment):
  output.write( '// ' + comment + '\n')

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

def usage():
  print '''
 -n filename                 | Input netCDF file
 -f filename                 | Output Gmsh file
 -p path1 (path2)..          | Specify paths to include
 -r function                 | Function specifying region of interest
 -b box1 (box2)..            | Boxes with regions of interest
 -a minarea                  | Minimum area of islands
 -dx dist                    | Distance of steps when drawing parallels and meridians (currently in degrees - need to project)
 -bounding_latitude latitude | Latitude of boundary to close the domain
 -bl latitude                | Short form of -bounding_latitude
 -exclude_iceshelves         | Excludes iceshelf ocean cavities from mesh (default behaviour includes region)
 -no                         | Do not include open boundaries
 -lat latitude               | Latitude to extent open domain to
 -s scenario                 | Select scenario (in development)
 -v                          | Verbose
 -vv                         | Very verbose (debugging)
 -q                          | Quiet
 -h                          | Help
------------------------------------------------------------
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
  79 - an island on 90W 68S
'''
  sys.exit(0)

#def scenario(name):
#  filcher_ronne = argument

argv = sys.argv[1:]
dx_default = 0.1
class arguments:
  input  = '/d/dataset/rtopo/RTopo105b_50S.nc'
  #output = './stereographic_projection.geo'
  output = './shorelines.geo'
  boundaries = []
  region = 'True'
  box = []
  minarea = 0
  dx = dx_default
  extendtolatitude = None
  open = True
  verbose = True
  debug = False
  bounding_lat = -50.0
  include_iceshelf_ocean_cavities = True
  #call = ' '.join(argv)
  call = ''
  for arg in argv:
    if ' ' in arg:
      call = call + ' \'' + arg + '\''
    else:
      call = call + ' ' + arg

while (len(argv) > 0):
  argument = argv.pop(0).rstrip()
  if   (argument == '-h'): usage()
  elif (argument == '-s'): arguments.scenario = str(argv.pop(0).rstrip()); arguments=scenario(arguments.scenario)
  elif (argument == '-n'): arguments.input  = argv.pop(0).rstrip()
  elif (argument == '-f'): arguments.output = argv.pop(0).rstrip()
  elif (argument == '-r'): arguments.region = argv.pop(0).rstrip()
  elif (argument == '-dx'): arguments.dx = float(argv.pop(0).rstrip())
  elif (argument == '-lat'): arguments.extendtolatitude = float(argv.pop(0).rstrip())
  elif (argument == '-a'): arguments.minarea = float(argv.pop(0).rstrip())
  elif (argument == '-bounding_latitude'): arguments.bounding_lat =float(argv.pop(0).rstrip())
  elif (argument == '-bl'): arguments.bounding_lat = float(argv.pop(0).rstrip())
  elif (argument == '-no'): arguments.open = False
  elif (argument == '-exclude_ice_shelves'): arguments.include_iceshelf_ocean_cavities = False
  elif (argument == '-v'): arguments.verbose = True
  elif (argument == '-vv'): arguments.verbose = True; arguments.debug = True; 
  elif (argument == '-q'): arguments.verbose = False
  elif (argument == '-p'):
    while ((len(argv) > 0) and (argv[0][0] != '-')):
      arguments.boundaries.append(int(argv.pop(0).rstrip()))
  elif (argument == '-b'):
    while ((len(argv) > 0) and ((argv[0][0] != '-') or ( (argv[0][0] == '-') and (argv[0][1].isdigit()) ))):
      arguments.box.append(argv.pop(0).rstrip())

arguments.region = expand_boxes(arguments.region, arguments.box)
 

#source = file(arguments.input,'r')
output = file(arguments.output,'w')

gmsh_comment('Arguments: ' + arguments.call)
printv('Source netCDF located at ' + arguments.input)
printv('Output to ' + arguments.output)
if (len(arguments.boundaries) > 0):
  printv('Boundaries restricted to ' + str(arguments.boundaries))
if (arguments.region is not 'True'):
  printv('Region defined by ' + str(arguments.region))
if (arguments.dx != dx_default):
  printv('Open contours closed with a line formed by points spaced %g degrees apart' % (arguments.dx))
if (arguments.extendtolatitude is not None):
  printv('Extending region to meet parallel on latitude ' + str(arguments.extendtolatitude))

gmsh_comment('')

def gmsh_header():
  earth_radius = 6.37101e+06
  return '''
IP = newp;
IL = newl;
ILL = newll;
IS = news;
IFI = newf;
Point ( IP + 0 ) = { 0, 0, 0 };
Point ( IP + 1 ) = { 0, 0, %(earth_radius)g };
PolarSphere ( IS + 0 ) = { IP, IP + 1 };

''' % { 'earth_radius': earth_radius }

def gmsh_footer(loopstart, loopend):
  output.write( '''
Field [ IFI + 0 ]  = Attractor;
Field [ IFI + 0 ].NodesList  = { IP + %(loopstart)i : IP + %(loopend)i };
''' % { 'loopstart':loopstart, 'loopend':loopend } )

def gmsh_remove_projection_points():
  output.write( '''
Delete { Point{1}; }
Delete { Point{2}; }
''' )


def gmsh_format_point(index, loc, z):
  accuracy = '.8'
  format = 'Point ( IP + %%i ) = { %%%(dp)sf, %%%(dp)sf, %%%(dp)sf };\n' % { 'dp': accuracy }
  output.write(format % (index, loc[0], loc[1], z))
  #return "Point ( IP + %i ) = { %f, %f, %f }\n" % (index, x, y, z)

def project(location):
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
  x = sin( longitude_rad ) * cos( latitude_rad ) / ( 1 + sin( latitude_rad ) );
  y = cos( longitude_rad ) * cos( latitude_rad  ) / ( 1 + sin( latitude_rad ) );
  return [ x, y ]

def read_rtopo(filename):
  file = NetCDF.NetCDFFile(filename, 'r')
  #variableNames = fileN.variables.keys() 
  lon = file.variables['lon'][:] 
  lat = file.variables['lat'][:] 
  field = file.variables['amask'][:, :] 
  #             % 2
  # 0 ocean    1
  # 1 ice      0
  # 2 shelf    1
  # 3 rock     0
  if arguments.include_iceshelf_ocean_cavities == True:
    printv('Including iceshelf ocean cavities')
    field = field % 2
  else:
    printv('Excluding iceshelf ocean cavities')
    field[field>0.5]=1 
  paths = contour(lon,lat,field,levels=[0.5]).collections[0].get_paths()
  return paths

def area_enclosed(p):
  return 0.5 * abs(sum(x0*y1 - x1*y0 for ((x0, y0), (x1, y1)) in segments(p)))

def segments(p):
  return zip(p, p[1:] + [p[0]])

def check_point_required(region, location):
  # make all definitions of the math module available to the function
  globals=math.__dict__
  globals['longitude'] = location[0]
  globals['latitude']  = location[1]
  return eval(region, globals)

def array_to_gmsh_points(num, index, location, minarea, region, dx, latitude_max):
  gmsh_comment('Ice-Land mass number %s' % (num))
  count = 0 
  pointnumber = len(location[:,0])
  valid = [False]*pointnumber
  validnumber = 0

  loopstart = None
  loopend = None
  flag = 0
  #location[:, 0] = - location[:, 0] - 90.0
  for point in range(pointnumber):
    longitude = location[point, 0]
    latitude  = location[point, 1]
    if ( check_point_required(region, location[point, :]) ):
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
  for point in range(validnumber):
    #longitude = validlocation[point,0]
    #latitude  = validlocation[point,1]
    
    if ((close[point]) and (point == validnumber - 1) and (not (compare_points(validlocation[point], validlocation[0], dx)))):
      gmsh_comment('**** END ' + str(point) + '/' + str(validnumber-1) + str(close[point]))
      index = gmsh_loop(index, loopstartpoint, False, False)
      index = draw_parallel_explicit(validlocation[point], validlocation[0], index, latitude_max, dx)
      index = gmsh_loop(index, loopstartpoint, True, True)
      gmsh_comment('**** END end of loop ' + str(closelast) + str(point) + '/' + str(validnumber-1) + str(close[point]))
    elif ((close[point]) and (point > 0) and (not (compare_points(validlocation[point], validlocation[0], dx)))):
      gmsh_comment('**** NOT END ' + str(point) + '/' + str(validnumber-1) + str(close[point]))
      gmsh_comment(str(validlocation[point,:]) + str(validlocation[point,:]))
      index = gmsh_loop(index, loopstartpoint, False, False)
      index = draw_parallel_explicit(validlocation[point - 1], validlocation[point], index, latitude_max, dx)
      index = gmsh_loop(index, loopstartpoint, False, True)
      gmsh_comment('**** NOT END end of loop ' + str(point) + '/' + str(validnumber-1) + str(close[point]))
    else:
      index.point += 1
      gmsh_format_point(index.point, project(validlocation[point,:]), 0)
      index.contournodes.append(index.point)

  index = gmsh_loop(index, loopstartpoint, (closelast and (point == validnumber - 1)), False)

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


def gmsh_loop(index, loopstartpoint, last, open):
  if (index.point <= index.start):
    return index
  #pointstart = indexstart
  #pointend   = index.point
  #loopnumber = index.loop
  if (last):
    closure = ', IP + %(pointstart)i' % { 'pointstart':loopstartpoint }
  else:
    closure = ''
  if (open):
    index.open.append(index.path)
    type = 'open'
    boundaryid = boundary.open
  else:
    index.contour.append(index.path)
    type = 'contour'
    boundaryid = boundary.contour

  index.pathsinloop.append(index.path)

#//Line Loop( ILL + %(loopnumber)i ) = { IL + %(loopnumber)i };
#// Identified as a %(type)s path

  output.write( '''LoopStart%(loopnumber)i = IP + %(pointstart)i;
LoopEnd%(loopnumber)i = IP + %(pointend)i;
BSpline ( IL + %(loopnumber)i ) = { IP + %(pointstart)i : IP + %(pointend)i%(loopstartpoint)s };
Physical Line( %(boundaryid)i ) = { IL + %(loopnumber)i };

''' % { 'pointstart':index.start, 'pointend':index.point, 'loopnumber':index.path, 'loopstartpoint':closure, 'type':type, 'boundaryid':boundaryid } )

  if (last):
    output.write( '''Line Loop( ILL + %(loop)i ) = { %(loopnumbers)s };
''' % { 'loop':index.loop , 'loopnumbers':list_to_comma_separated(index.pathsinloop, prefix = 'IL + ') } )
    index.loops.append(index.loop)
    index.loop += 1
    index.pathsinloop = []

  index.path +=1
  index.start = index.point
  return index

  printv('Closed boundaries (id %i): %s' % (boundary.contour, list_to_space_separated(index.contour, add=1)))
  printv('Open boundaries   (id %i): %s' % (boundary.open, list_to_space_separated(index.open, add=1)))



def output_boundaries(index, filename, paths=None, minarea=0, region='True', dx=dx_default, latitude_max=None):
  pathall = read_rtopo(filename)
  printv('Paths found: ' + str(len(pathall)))
  output.write( gmsh_header() )
  splinenumber = 0
  indexbase = 1
  index.point = indexbase

  if ((paths is not None) and (len(paths) > 0)):
    pathids=paths
  else:
    pathids=range(len(pathall)+1)[1:]

  for num in pathids:
    xy=pathall[num-1].vertices
    index = array_to_gmsh_points(num, index, xy, minarea, region, dx, latitude_max)
  #for i in range(-85, 0, 5):
  #  indexend += 1
  #  output.write( gmsh_format_point(indexend, project(0, i), 0) )
  #for i in range(-85, 0, 5):
  #  indexend += 1
  #  output.write( gmsh_format_point(indexend, project(45, i), 0) )
  gmsh_remove_projection_points()
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

def compare_points(a, b, dx):
  tolerance = dx * 0.6
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

def draw_parallel_explicit(start, end, index, latitude_max, dx):

  #print start, end, index.point
  # Note start is actual start - 1
  if (latitude_max is None):
    latitude_max = max(start[1], end[1])
  else:
    latitude_max = max(latitude_max, start[1], end[1])
  current = start 
  tolerance = dx * 0.6
  
  gmsh_comment( 'Closing path with parallels and merdians, from (%.8f, %.8f) to  (%.8f, %.8f)' % ( start[0], start[1], end[0], end[1] ) )
  
  if (compare_points(current, end, dx)):
    gmsh_comment('Points already close enough, no need to draw parallels and meridians after all')
    return index
  
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

  gmsh_comment('Drawing parallel index %s at %f.2 (to match %f.2), %f.2' % (index.point, current[0], end[0], current[1]))
  while (current[0] != end[0]):
    if (current[0] < end[0]):
      current[0] = current[0] + dx
    else:
      current[0] = current[0] - dx
    if (abs(current[0] - end[0]) < tolerance): current[0] = end[0]
    if (compare_points(current, end, dx)): return index
    index.point += 1
    printvv('Drawing parallel index %s at %f.2 (to match %f.2), %f.2' % (index.point, current[0], end[0], current[1]))
    loc = project(current)
    gmsh_format_point(index.point, loc, 0.0)

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
  
  index = gmsh_loop(index, loopstartpoint, True, True)

  return index

def output_surfaces(index, boundary):
  printv('Open boundaries   (id %i): %s' % (boundary.open, list_to_space_separated(index.open, add=1)))
  printv('Closed boundaries (id %i): %s' % (boundary.contour, list_to_space_separated(index.contour, add=1)))
  boundary_list = list_to_comma_separated(index.contour + index.open)
#//Line Loop( ILL + %(loopnumber)i ) = { %(boundary_list)s };
#//Plane Surface( %(surface)i ) = { ILL + %(loopnumber)i };
  output.write('''
Plane Surface( %(surface)i ) = { %(boundary_list)s };
Physical Surface( %(surface)i ) = { %(surface)i };
''' % { 'loopnumber':index.path, 'surface':boundary.surface + 1, 'boundary_list':list_to_comma_separated(index.loops, prefix = 'ILL + ') } )

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
  index = gmsh_loop(index, loopstartpoint, False, True)

  #index.start = index.point + 1
  #loopstartpoint = index.start
  for i in range(len(acc2[:,0])):
    index.point += 1
    location = project(acc2[i,:])
    gmsh_format_point(index.point, location, 0.0)
  index = gmsh_loop(index, loopstartpoint, True, True)

  return index


def output_fields(index,boundary):
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
// Dont extent the elements sizes from the boundary inside the domain
//Mesh.CharacteristicLengthExtendFromBoundary = 0;

Field[ IFI + 1] = MathEval;
Field[ IFI + 1].F = "1.0E5";
Background Field = IFI + 1;

//Set some options for better png output
General.Color.Background = {255,255,255};
General.Color.BackgroundGradient = {255,255,255};
General.Color.Foreground = Black;
Mesh.Color.Lines = {0,0,0};

General.Trackball = 0 ;
General.RotationX = 180;
General.RotationY = 0;
General.RotationZ = 270;
''' % { 'boundary_list':list_to_comma_separated(index.contour, prefix = 'IL + ') } )

class index:
  point = 0
  path = 0
  contour = []
  contournodes= []
  open = []
  skipped = []
  start = 0
  pathsinloop = []
  loop = 0
  loops = []

class boundary:
  contour = 3
  open    = 4
  surface = 9


index = output_boundaries(index, filename=arguments.input, paths=arguments.boundaries, minarea=arguments.minarea, region=arguments.region, dx=arguments.dx, latitude_max=arguments.extendtolatitude)


if (arguments.open): index = output_open_boundaries(index, boundary, arguments.dx)
output_surfaces(index, boundary)

#index = draw_acc(index, boundary, arguments.dx)


output_fields(index,boundary)


if (len(index.skipped) > 0):
  printv('Skipped (because no point on the boundary appeared in the required region, or area enclosed by the boundary was too small):\n'+' '.join(index.skipped))
output.close()

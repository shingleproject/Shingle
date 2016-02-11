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

from Universe import universe
from Projection import compare_points, project
from Mathematical import area_enclosed

def draw_parallel_explicit(rep, start, end, index, latitude_max, dx):
  from Projection import longitude_diff

  #print start, end, index.point
  # Note start is actual start - 1
  if (latitude_max is None):
    latitude_max = max(start[1], end[1])
  else:
    latitude_max = max(latitude_max, start[1], end[1])
  current = start 
  tolerance = dx * 0.6
   
  if (compare_points(current, end, dx)):
    rep.gmsh_comment('Points already close enough, no need to draw parallels and meridians after all')
    return index
  else:
    rep.gmsh_comment('Closing path with parallels and merdians, from (%.8f, %.8f) to  (%.8f, %.8f)' % ( start[0], start[1], end[0], end[1] ) )
  
  loopstart = index
  if (current[1] != latitude_max):
    rep.gmsh_comment('Drawing meridian to max latitude index %s at %f.2, %f.2 (to match %f.2)' % (index.point, current[0], current[1], latitude_max))
  while (current[1] != latitude_max):
    if (current[1] < latitude_max):
      current[1] = current[1] + dx
    else:
      current[1] = current[1] - dx
    if (abs(current[1] - latitude_max) < tolerance): current[1] = latitude_max
    if (compare_points(current, end, dx)): return index
    index.point += 1
    # vv
    rep.report('Drawing meridian to max latitude index %s at %f.2, %f.2 (to match %f.2)' % (index.point, current[0], current[1], latitude_max), debug=True)
    loc = project(current)
    rep.gmsh_format_point(index.point, loc, 0.0)
  if rep.MoreBSplines():
    index = rep.gmsh_loop(index, loopstart, False, True, True)

    loopstart = index
  if (current[0] != end[0]):
    rep.gmsh_comment('Drawing parallel index %s at %f.2 (to match %f.2), %f.2' % (index.point, current[0], end[0], current[1]))
  while (current[0] != end[0]):
    if (longitude_diff(current[0], end[0]) < 0):
      current[0] = current[0] + dx
    else:
      current[0] = current[0] - dx
    #if (abs(current[0] - end[0]) < tolerance): current[0] = end[0]
    if (abs(longitude_diff(current[0], end[0])) < tolerance): current[0] = end[0]

    if (compare_points(current, end, dx)): return index
    index.point += 1
    # vv
    rep.report('Drawing parallel index %s at %f.2 (to match %f.2), %f.2' % (index.point, current[0], end[0], current[1]), debug=True)
    loc = project(current)
    rep.gmsh_format_point(index.point, loc, 0.0)
  if rep.MoreBSplines():
    index = rep.gmsh_loop(index, loopstart, False, True, True)

    loopstart = index
  if (current[1] != end[1]):
    rep.gmsh_comment('Drawing meridian to end index %s at %f.2, %f.2 (to match %f.2)' % (index.point, current[0], current[1], end[1]))
  while (current[1] != end[1]):
    if (current[1] < end[1]):
      current[1] = current[1] + dx
    else:
      current[1] = current[1] - dx
    if (abs(current[1] - end[1]) < tolerance): current[1] = end[1]
    if (compare_points(current, end, dx)): return index
    index.point += 1
    # vv
    rep.report('Drawing meridian to end index %s at %f.2, %f.2 (to match %f.2)' % (index.point, current[0], current[1], end[1]), debug=True)
    loc = project(current)
    rep.gmsh_format_point(index.point, loc, 0.0)
  index = rep.gmsh_loop(index, loopstart, True, True, False)
  
  rep.gmsh_comment( 'Closed path with parallels and merdians, from (%.8f, %.8f) to  (%.8f, %.8f)' % ( start[0], start[1], end[0], end[1] ) )

  return index

def array_to_gmsh_points(rep, num, index, location, minarea, region, dx, latitude_max):
  from numpy import zeros
  
  def check_point_required(region, location):
    import math
    # make all definitions of the math module available to the function
    globals=math.__dict__
    globals['longitude'] = location[0]
    globals['latitude']  = location[1]
    return eval(region, globals)

  indexstore = index
  rep.gmsh_section('Ice-Land mass number %s' % (num))
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
    # vv
    rep.report('Path %i skipped (no points found in region)' % ( num ), debug=True)
    rep.gmsh_comment('  Skipped (no points found in region)\n')
    return index

  #print num, abs(location[loopstart, 0] - location[loopend, 0]), abs(location[loopstart, 1] - location[loopend, 1]), 2 * dlongitude, 2 * dlatitude
  #print num, (abs(location[loopstart, 0] - location[loopend, 0]) < 2 * dlongitude), (abs(location[loopstart, 1] - location[loopend, 1]) > 2 * dlatitude)
  
  if ( (abs(location[loopstart, 0] - location[loopend, 0]) < 2 * dlongitude) and (abs(location[loopstart, 1] - location[loopend, 1]) > 2 * dlatitude) ):
    # vv
    rep.report('Path %i skipped (island crossing meridian - code needs modification to include)' % ( num ), debug=True)
    rep.gmsh_comment('  Skipped (island crossing meridian - code needs modification to include)\n')
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
    # vv
    rep.report('Path %i skipped (area too small)' % ( num ), debug=True)
    rep.gmsh_comment('  Skipped (area too small)\n')
    return index

  rep.report('Path %i points %i/%i area %g%s' % ( num, validnumber, pointnumber, area_enclosed(validlocation), closingtext ))
 
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
  #   output.write( rep.gmsh_format_point(index, project(validlocation[0,0], validlocation[0,1]), 0) )
  #   
  # else:
  if (close[0]):
    close[-1] = close[0]
  
  index.start = index.point + 1
  loopstartpoint = index.start
   
  # 0=old, 1=new
  behaviour=0

  if behaviour == 1:
    for point in range(validnumber):
      #longitude = validlocation[point,0]
      #latitude  = validlocation[point,1]

      #rep.gmsh_comment('HERE ' + str(close[0]) + ' ' + str(close[point]) + ' ' + str(point == validnumber - 1) + '' + str(not (compare_points(validlocation[point], validlocation[0], dx))))
      if ((close[point]) and (point == validnumber - 1) and (not (compare_points(validlocation[point], validlocation[0], dx)))):
        #rep.gmsh_comment('**** END ' + str(point) + '/' + str(validnumber-1) + str(close[point]))
       # index = rep.gmsh_loop(index, loopstartpoint, False, False, False)
        #index = draw_parallel_explicit(validlocation[point], validlocation[0], index, latitude_max, dx)
        index = close_path(validlocation[point], validlocation[0], index, dx, latitude_max)
        #index = rep.gmsh_loop(index, loopstartpoint, True, True, False)
        index = rep.gmsh_loop(index, loopstartpoint, True, False, False)
        #rep.gmsh_comment('**** END end of loop ' + str(closelast) + str(point) + '/' + str(validnumber-1) + str(close[point]))
        rep.gmsh_comment('')
      elif ((close[point]) and (point > 0) and (not (compare_points(validlocation[point], validlocation[0], dx)))):
        #rep.gmsh_comment('**** NOT END ' + str(point) + '/' + str(validnumber-1) + str(close[point]))
        rep.gmsh_comment(str(validlocation[point,:]) + str(validlocation[point,:]))
        index = rep.gmsh_loop(index, loopstartpoint, False, False, False)
        #index = draw_parallel_explicit(validlocation[point - 1], validlocation[point], index, latitude_max, dx)
        index = close_path(validlocation[point - 1], validlocation[point], index, dx, latitude_max)
        index = rep.gmsh_loop(index, loopstartpoint, False, True, False)
        #rep.gmsh_comment('**** NOT END end of loop ' + str(point) + '/' + str(validnumber-1) + str(close[point]))
        rep.gmsh_comment('')
      else:
        index.point += 1
        rep.gmsh_format_point(index.point, project(validlocation[point,:]), 0)
        index.contournodes.append(index.point)
  
      index = rep.gmsh_loop(index, loopstartpoint, (closelast and (point == validnumber - 1)), False, False)

  else:
    for point in range(validnumber):
      #longitude = validlocation[point,0]
      #latitude  = validlocation[point,1]

      if ((close[point]) and (point == validnumber - 1) and (not (compare_points(validlocation[point], validlocation[0], dx)))):
        rep.gmsh_comment('**** END ' + str(point) + '/' + str(validnumber-1) + str(close[point]))
        index = rep.gmsh_loop(index, loopstartpoint, False, False, True)
        index = draw_parallel_explicit(rep, validlocation[point], validlocation[0], index, latitude_max, dx)
        index = rep.gmsh_loop(index, loopstartpoint, True, True, True)
        rep.gmsh_comment('**** END end of loop ' + str(closelast) + str(point) + '/' + str(validnumber-1) + str(close[point]))
      elif ((close[point]) and (point > 0) and (not (compare_points(validlocation[point], validlocation[0], dx)))):
        rep.gmsh_comment('**** NOT END ' + str(point) + '/' + str(validnumber-1) + str(close[point]))
        rep.gmsh_comment(str(validlocation[point,:]) + str(validlocation[point,:]))
        index = rep.gmsh_loop(index, loopstartpoint, False, False, True)
        index = draw_parallel_explicit(rep, validlocation[point - 1], validlocation[point], index, latitude_max, dx)
        index = rep.gmsh_loop(index, loopstartpoint, False, True, True)
        rep.gmsh_comment('**** NOT END end of loop ' + str(point) + '/' + str(validnumber-1) + str(close[point]))
      else:
        index.point += 1
        rep.gmsh_format_point(index.point, project(validlocation[point,:]), 0)
        index.contournodes.append(index.point)

    index = rep.gmsh_loop(index, loopstartpoint, (closelast and (point == validnumber - 1)), False, True)




  # asc
  #index = pig_sponge(index, loopstartpoint, index.point, validlocation[0], validlocation[-1], dx)

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

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
import math
from numpy import array

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


def project(location, type=None):
  from pyproj import Proj
  #params={'proj':'utm','zone':19}
  # Antartica - pig?:
  #params={'proj':'utm','lon_0':'-101','lat_0':'-74.5'}
  # UK:
  params={'proj':'utm','lon_0':'0','lat_0':'50'}
  proj = Proj(params)
  if (type is None):
    type = universe.projection
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
    print 'Invalid projection type:', universe.projection
    sys.exit(1)



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

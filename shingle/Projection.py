#!/usr/bin/env python
# -*- coding: utf-8 -*-

##############################################################################
#
#  Copyright (C) 2011-2018 Dr Adam S. Candy and others.
#  
#  Shingle:  An approach and software library for the generation of
#            boundary representation from arbitrary geophysical fields
#            and initialisation for anisotropic, unstructured meshing.
#  
#            Web: http://www.shingleproject.org
#  
#            Contact: Dr Adam S. Candy, contact@shingleproject.org
#  
#  This file is part of the Shingle project.
#  
#  Please see the AUTHORS file in the main source directory for a full list
#  of contributors.
#  
#  Shingle is free software: you can redistribute it and/or modify
#  it under the terms of the GNU Lesser General Public License as published by
#  the Free Software Foundation, either version 3 of the License, or
#  (at your option) any later version.
#  
#  Shingle is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU Lesser General Public License for more details.
#  
#  You should have received a copy of the GNU Lesser General Public License
#  along with Shingle. If not, see <http://www.gnu.org/licenses/>.
#
##############################################################################

from Universe import universe
from Reporting import report, error
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


# FIXME: Check projection usage consistent throughout

def point_diff_cartesian(a,b):
    pa = project(a, projection_type='proj_cartesian')
    pb = project(b, projection_type='proj_cartesian')
    diff = [ a[0] - b[0], a[1] - b[1] ]
    return diff

def point_diff_cartesian(a,b):
    pa = project(a, projection_type='proj_cartesian')
    pb = project(b, projection_type='proj_cartesian')
    diff = [ pa[0] - pb[0], pa[1] - pb[1] ]
    return diff

def compare_latitude(a, b, dx):
    tolerance = dx * 2.0
    #print abs(a - b), tolerance, abs(a - b) < tolerance
    return abs(a - b) < tolerance

def c1ompare_points_old(a, b, dx, proj='LongLat'):
    if isinstance(dx, float):
        dx = [dx, dx]
    tolerance = [0.6 * x for x in dx]
    if (proj == 'horizontal'):
        pa = project(a, projection_type='proj_cartesian')
        pb = project(b, projection_type='proj_cartesian')
        #print tolerance, pa, pb
        if ( not (abs(pa[1] - pb[1]) < tolerance[1]) ):
            return False
        elif (abs(pa[0] - pb[0]) < tolerance[0]):
            return True
        else:
            return False
    else:
        from pyproj import Geod
        wgs84_geod = Geod(ellps='WGS84')
        az12,az21,dist = wgs84_geod.inv(a[0],a[1],a[0],a[1])
        return dist < tolerance[0] * 1e5

        if ( not (abs(a[1] - b[1]) < tolerance[1]) ):
            #AddComment('lat differ')
            return False
        elif (abs(a[0] - b[0]) < tolerance[0]):
            #AddComment('long same')
            return True
        elif ((abs(abs(a[0]) - 180) < tolerance[0]) and (abs(abs(b[0]) - 180) < tolerance[0])):
            #AddComment('long +/-180')
            return True
        else:
            #AddComment('not same %g %g' % (abs(abs(a[0]) - 180), abs(abs(b[0]) - 180) ) )
            return False

def p2(location):
    p = project(project(location, projection_type='proj_cartesian'), projection_type='proj_cartesian_inverse')
    if (p[0] < 0.0):
        p[0] = p[0] + 360
    return p

def get_pyproj_projection(string):
    import pyproj
    _translation = {
        'LongLat': 'epsg:4326',
        'Automatic': 'LongLat',
    }

    while string in _translation.keys():
        string = _translation[string]
    try:
        if string.startswith('+proj='):
            p = pyproj.Proj(string)
        else:
            p = pyproj.Proj(init=string)
    except:
        #error('Unable to define py.Proj with init string: ' + string, fatal=True)
        p = None

    return p

def projection_function_cartesian(x, y, z=None):
    from math import cos, sin, radians
    longitude = x
    latitude  = y
    longitude_rad = radians(- longitude - 90)
    latitude_rad  = radians(latitude)
    # Changed sign in x formulae - need to check
    if 1 + sin(latitude_rad) == 0:
        x = None
        y = None
    else:
        x = sin( longitude_rad ) * cos( latitude_rad ) / ( 1 + sin( latitude_rad ) );
        y = cos( longitude_rad ) * cos( latitude_rad  ) / ( 1 + sin( latitude_rad ) );
    if z:
      return x, y, z
    else:
      return x, y

def projection_function_xy_reverse(x, y, z=None):
    if z:
      return x, -y, z
    else:
      return x, -y

def project_shape(shape, source, destination):
    if not shape:
        return None
    import pyproj
    from functools import partial
    from shapely.ops import transform

    #print source, destination
    # Pass thorugh
    if destination == 'Automatic':
        return shape
        #projection = projection_function_xy_reverse
    elif destination == 'Cartesian':
        projection = projection_function_cartesian
    else:
        # Source coordinate system
        s = get_pyproj_projection(source)
        # Destination coordinate system
        d = get_pyproj_projection(destination)

        if not s or not d:
            for i, vertex in enumerate(shape.coords[:]):
                shape.coord[i] = project(vertex, projection_type=destination)
            return shape

        elif s.srs == d.srs:
            return shape

        else:
            projection = partial(
                pyproj.transform,
                s,
                d
            )

    # Appy the projection to the shapefile
    return transform(projection, shape)


def project(location, projection_type=None):
    from pyproj import Proj
    #params={'proj':'utm','zone':19}
    # Antartica - pig?:
    #params={'proj':'utm','lon_0':'-101','lat_0':'-74.5'}
    # UK:
    params={'proj':'utm','lon_0':'0','lat_0':'50'}
    proj = Proj(params)
    if (projection_type is None):
        projection_type = universe.default.projection
        # FIXME - needs to pick this up from somewhere without breaking everything.  loglat is needed here for Shingle_text case - could highlight issues with other cases
        projection_type = 'LongLat'
        #print projection_type, universe.default.projection
        # FIXME: Projection is not defined for some operations
        #error('Projection type not defined')
    if (projection_type == 'Cartesian' ):
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

    elif (projection_type == 'proj_cartesian' ):
        longitude = location[0]
        latitude  = location[1]
        return array(proj(longitude, latitude))

    elif (projection_type == 'proj_cartesian_inverse' ):
        longitude = location[0]
        latitude  = location[1]
        return array(proj(longitude, latitude, inverse=True))

    elif (projection_type == 'Hammer' ):
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
        x = planet_radius * ( 2 * math.sqrt(2) * cos(latitude_rad) * sin(longitude_rad / 2.0) ) / m
        y = planet_radius * (     math.sqrt(2) * sin(latitude_rad) ) / m
        return array([ x, y ])
    elif (projection_type == 'LongLat' ):
        return location
    else:
        error('Invalid projection type: ' + projection_type, fatal=True)



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


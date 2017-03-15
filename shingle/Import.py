#!/usr/bin/env python
# -*- coding: utf-8 -*-

##########################################################################
#  
#  Copyright (C) 2011-2016 Dr Adam S. Candy
# 
#  Shingle:  An approach and software library for the generation of
#            boundary representation from arbitrary geophysical fields
#            and initialisation for anisotropic, unstructured meshing.
# 
#            Web: https://www.shingleproject.org
#
#            Contact: Dr Adam S. Candy, contact@shingleproject.org
#
#  This file is part of the Shingle project.
#  
#  Shingle is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 3 of the License, or
#  (at your option) any later version.
#  
#  Shingle is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#  
#  You should have received a copy of the GNU General Public License
#  along with Shingle.  If not, see <http://www.gnu.org/licenses/>.
#
##########################################################################

import os
from Universe import universe
from Reporting import error, report
from Scientific.IO import NetCDF


def read_rtopo(brep, rep, filename):
    file = NetCDF.NetCDFFile(filename, 'r')
    try:
        lon = file.variables['lon'][:] 
        lat = file.variables['lat'][:] 
    except:
        error('Warning: Problem reading variables lon and lat.')
    contourtype = brep.ContourType()
    if (contourtype=='iceshelfcavity'):
        #             % 2
        # 0 ocean    1
        # 1 ice      0
        # 2 shelf    1
        # 3 rock     0
        try:
            field = file.variables['amask'][:, :] 
        except:
            field = file.variables['z'][:, :] 
        if brep.ExcludeIceshelfCavities():
            rep.report('Excluding iceshelf ocean cavities', indent = 2)
            field[field>0.5]=1 
        else:
            rep.report('Including iceshelf ocean cavities', indent = 2)
            field = field % 2
    elif (contourtype=='icesheet'):
        lon = file.variables['lon'][:] 
        lat = file.variables['lat'][:] 
        field = file.variables['height'][:, :] 
        field[field>0.001]=1 
    elif (contourtype=='z'):
        lon = file.variables['lon'][:] 
        lat = file.variables['lat'][:] 
        field = file.variables['z'][:, :] 
        field[field<10.0]=0
        field[field>=10.0]=1
    elif (contourtype=='ocean10m'):
        lon = file.variables['lon'][:] 
        lat = file.variables['lat'][:] 
        field = file.variables['z'][:, :] 
        field[field<=-10.0]=-10.0
        field[field>-10.0]=0
        field[field<=-10.0]=1
    elif (contourtype=='gebco10m'):
        lon = file.variables['lon'][:] 
        lat = file.variables['lat'][:] 
        field = file.variables['z'][:, :] 
        field[field<=-10.0]=-10.0
        field[field>-10.0]=0
        field[field<=-10.0]=1
    elif (contourtype=='gebco1m'):
        lon = file.variables['lon'][:] 
        lat = file.variables['lat'][:] 
        field = file.variables['z'][:, :] 
        field[field<=-1.0]=-1.0
        field[field>-1.0]=0
        field[field<=-1.0]=1
    elif (contourtype=='gebco0.1m'):
        lon = file.variables['lon'][:] 
        lat = file.variables['lat'][:] 
        field = file.variables['z'][:, :] 
        field[field<=-0.1]=-0.1
        field[field>-0.1]=0
        field[field<=-0.1]=1
    elif (contourtype=='gebco-10m'):
        lon = file.variables['lon'][:] 
        lat = file.variables['lat'][:] 
        field = file.variables['z'][:, :] 
        field[field<=10.0]=0
        field[field>10.0]=1
    elif (contourtype=='zmask'):
        lon = file.variables['lon'][:] 
        lat = file.variables['lat'][:] 
        field = file.variables['z'][:, :] 
    elif (contourtype=='xyz'):
        lon = file.variables['x'][:] 
        lat = file.variables['y'][:] 
        field = file.variables['z'][:, :] 
        field[field>=-10.0]=1
        field[field<-10.0]=0
    elif (contourtype=='noshelf'):
        lon = file.variables['lon'][:] 
        lat = file.variables['lat'][:] 
        field = file.variables['noshelf'][:, :] 
    # Greenland Standard Data Set
    elif (contourtype=='gsds'):
        lon = file.variables['x1'][:] 
        lat = file.variables['y1'][:] 
        field = file.variables['usrf'][0,:, :] 
        field[field>0.001]=1 
    elif (contourtype=='mask'):
        lon = file.variables['longrid'][:,:] 
        lat = file.variables['latgrid'][:,:] 
        field = file.variables['grounding'][:, :] 
    # Greenland Standard Data Set, to zero ice thickness
    elif (contourtype=='gsdsz'):
        lon = file.variables['x1'][:] 
        lat = file.variables['y1'][:] 
        field  = file.variables['thk'][0,:, :] 
        #height  = file.variables['usrf'][0,:, :] 
        #bedrock = file.variables['topg'][0,:, :] 
        #field = abs(height - bedrock)

        field[field<10.0]=0
        field[field>=10.0]=1
        #field[field>0.001]=1 
    elif (contourtype=='gebco'):
        # Currently non-functional - needs 2d z array
        lon = file.variables['x_range'][:] 
        lat = file.variables['y_range'][:] 
        field = file.variables['z_range'][:] 
        field[field<10.0]=0
        field[field>=10.0]=1
    elif (contourtype=='gsdszc'):
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
        error("Contour type not recognised, '" + contourtype + "'", fatal=True)
        sys.exit(1)

    return lon, lat, field

def read_raster(filename):
    from PIL import Image
    from numpy import asarray, arange
    im = Image.open(filename, 'r').convert('L')
    p = im.load()
    a = asarray(im)

    # Note flipped
    lon = arange(a.shape[1])
    lat = - arange(a.shape[0])
    field = a
    report("Found raster, sizes: lat %(lat)d, lon %(lon)d, shape %(shape)s", var = {'lon':len(lon), 'lat':len(lat), 'shape':str(a.shape)}, indent = 2 )

    return lon, lat, field

def read_shape(filename):
    from osgeo import ogr
    from shapely.wkb import loads

    def ReadShapefile(path_to_shp):
        """Reads shapefile file and generates a dictionary of shapefile elements
        """
        data = ogr.Open(path_to_shp)
        elements = data.GetLayer()
        return dict([GetFieldPolygon(element) for element in elements])

    def GetFieldPolygon(element):
        """Processes shapefile elements and returns a shapefile MultiPolygon
        """
        feild = element.GetField(0)
        polygon = loads(element.GetGeometryRef().ExportToWkb())
        return (field, polygon)

    paths = []
    shapes = ReadShapefile(filename)
    shape = shapes[shapes.keys()[0]]

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

def read_paths(brep, rep, filename):
    contour_required = False
    base, ext = os.path.splitext(filename)
    ext = ext.lstrip('.')
    if ext in ['png', 'tif', 'tiff']:
        lon, lat, field = read_raster(filename)
        contour_required = True
    elif ext in ['shp']:
        paths = read_shape(filename) 
    else: # NetCDF .nc files
        lon, lat, field = read_rtopo(brep, rep, filename)
        contour_required = True

    if (False):
        import matplotlib.pyplot as plt
        fig = plt.figure()
        #plt.plot(lon,lat, 'g-')
        #plt.show
        #plt.imshow(lon,lat,field)
        paths = plt.contour(lon,lat,field,levels=[0.5]).collections[0].get_paths()

        plt.show()

    else:
        if contour_required:
            import matplotlib
            universe.plot_backend = matplotlib.get_backend()
            matplotlib.use('Agg')
            from pylab import contour
            report("Found raster, sizes: lat %(lat)d, lon %(lon)d, shape %(shape)s", var = {'lon':len(lon), 'lat':len(lat), 'shape':str(field.shape)}, indent = 2 )
            paths = contour(lon,lat,field,levels=[0.5]).collections[0].get_paths()



    return paths

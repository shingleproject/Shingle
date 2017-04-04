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
from Scientific.IO import NetCDF
from pydap.client import open_url

from Universe import universe
from Reporting import error, report
from StringOperations import list_to_comma_separated

class ReadDataNetCDF():
    """Read source data from NetCDF.
    """
    _brep = None
    _rep = None
    _filename = None

    _fileobject = None

    _x_names = ['lon', 'longrid', 'x', 'x_range', 'x1']
    _y_names  = ['lat', 'latgrid', 'y', 'y_range', 'y1']
    _field_names = ['z', 'elevation', 'topo', 'height', 'z_range']

    _x_name = None
    _y_name = None
    _field_name = None

    _subregion = None
    _x_irange = None
    _y_irange = None

    def __init__(self, brep, rep, subregion = None):
        self._brep = brep
        self._rep = rep
        self._filename = rep.LocationFull()
        if subregion is not None:
            self._subregion = subregion
        else:
            bounds = self._brep.Region().GetMaxBounds()
            if len(bounds) == 4:
                self._subregion = bounds
        self.Load()
        
    def _file(self):
        if self._fileobject is None:
            if self._rep.isLocal() or self._rep.isLocal():
                self._fileobject = NetCDF.NetCDFFile(self._filename, 'r')
            elif self._rep.isOpendap():
                self._fileobject = open_url(self._filename)
            else:
                self._fileobject = NetCDF.NetCDFFile(self._filename, 'r')
        return self._fileobject

    def Variables(self):
        if self._rep.isOpendap():
            return self._file()
        else:
            return self._file().variables

    def VariablesAvailable(self):
        return self.Variables().keys()

    def _determine_variable_names(self):
        
        # Determine x name
        names = []
        for name in self._x_names:
            if name in self.VariablesAvailable():
                names.append(name)
        if len(names) == 0:
            error('Source dataset contains the fields: ' + list_to_comma_separated(self.VariablesAvailable()))
            error('Cannot identify x coordinate field in source dataset: ' + self._filename, fatal=True)
        elif len(names) > 1:
            error('Identified multiple x coordinate fields in source dataset: ' + self._filename, fatal=True)
        else:
          self._x_name = names[0]

        # Determine y name
        names = []
        for name in self._y_names: 
            if name in self.VariablesAvailable():
                names.append(name)
        if len(names) == 0:
            error('Cannot identify y coordinate field in source dataset: ' + self._filename, fatal=True)
        elif len(names) > 1:
            error('Identified multiple y coordinate fields in source dataset: ' + self._filename, fatal=True)
        else:
          self._y_name = names[0]

        # Determine field name
        names = []
        for name in self._field_names: 
            if name in self.VariablesAvailable():
                names.append(name)
        if len(names) == 0:
            error('Cannot identify height field in source dataset: ' + self._filename, fatal=True)
        elif len(names) > 1:
            error('Identified multiple height fields in source dataset: ' + self._filename, fatal=True)
        else:
          self._field_name = names[0]

    def Crop(self):
        # Begin with widest bounds
        self._x_irange = [0, len(self.lon)]
        self._y_irange = [0, len(self.lat)]

        subregion = self._subregion

        # Determine bounding box
        if subregion is not None: 
            x_range, y_range = (subregion[0], subregion[2]), (subregion[1], subregion[3]) 

            if x_range[0] is not None:
                for i, x in enumerate(self.lon):
                    self._x_irange[0] = i
                    if x > x_range[0]:
                        break
            if x_range[1] is not None:
                for i, x in reversed(list(enumerate(self.lon))):
                    self._x_irange[1] = i
                    if x < x_range[1]:
                        break

            if y_range[0] is not None:
                for i, y in enumerate(self.lat):
                    self._y_irange[0] = i
                    if y > y_range[0]:
                        break
            if y_range[1] is not None:
                for i, y in reversed(list(enumerate(self.lat))):
                    self._y_irange[1] = i
                    if y < y_range[1]:
                        break

        # Indexes saved in: self._x_irange, self._y_irange

        # Update spatial coordinate fields
        self.lon = self.Variables()[self._x_name][self._x_irange[0]:self._x_irange[1]] 
        self.lat = self.Variables()[self._y_name][self._y_irange[0]:self._y_irange[1]] 

    def LoadField(self, name = None):
        if name is None:
            name = self._field_name
        if self._rep.isOpendap():
            field = self.Variables()[name].array
        else:
            field = self.Variables()[name]
        return field[self._y_irange[0]:self._y_irange[1], self._x_irange[0]:self._x_irange[1]] 
        
    def Load(self):
        # Take a look at the available variables within the NetCDF file
        self._determine_variable_names()
        
        # Attempt to load spatial coordinate variables from source NetCDF
        try:
            self.lon = self.Variables()[self._x_name][:] 
            self.lat = self.Variables()[self._y_name][:] 
        except:
            error('Warning: Problem reading spatial coordinate variables from source NetCDF: ' + self._filename)

        self.Crop()
        self.Process()

    def Process(self):
        contourtype = self._brep.ContourType()
        if (contourtype=='iceshelfcavity'):
            #             % 2
            # 0 ocean    1
            # 1 ice      0
            # 2 shelf    1
            # 3 rock     0
            try:
                self.field = self.LoadField('amask')
            except:
                self.field = self.LoadField(self._field_name)
            if self._brep.ExcludeIceshelfCavities():
                self._rep.report('Excluding iceshelf ocean cavities', indent = 2)
                self.field[self.field>0.5]=1 
            else:
                self._rep.report('Including iceshelf ocean cavities', indent = 2)
                self.field = self.field % 2

        elif (contourtype=='icesheet'):
            self.field = self.LoadField('height')
            self.field[self.field>0.001]=1 

        elif (contourtype=='z'):
            self.field = self.LoadField(self._field_name)
            self.field[self.field<10.0]=0
            self.field[self.field>=10.0]=1

        elif (contourtype=='ocean10m'):
            self.field = self.LoadField(self._field_name)
            self.field[self.field<=-10.0]=-10.0
            self.field[self.field>-10.0]=0
            self.field[self.field<=-10.0]=1

        elif (contourtype=='gebco10m'):
            self.field = self.LoadField(self._field_name)
            self.field[self.field<=-10.0]=-10.0
            self.field[self.field>-10.0]=0
            self.field[self.field<=-10.0]=1
            
        elif (contourtype=='gebco1m'):
            self.field = self.LoadField(self._field_name)
            self.field[self.field<=-1.0]=-1.0
            self.field[self.field>-1.0]=0
            self.field[self.field<=-1.0]=1

        elif (contourtype=='gebco0.1m'):
            self.field = self.LoadField(self._field_name)
            self.field[self.field<=-0.1]=-0.1
            self.field[self.field>-0.1]=0
            self.field[self.field<=-0.1]=1

        elif (contourtype=='gebco-10m'):
            self.field = self.LoadField(self._field_name)
            self.field[self.field<=10.0]=0
            self.field[self.field>10.0]=1

        elif (contourtype=='zmask'):
            self.field = self.LoadField(self._field_name)

        elif (contourtype=='xyz'):
            self.field = self.LoadField(self._field_name)
            self.field[self.field>=-10.0]=1
            self.field[self.field<-10.0]=0

        elif (contourtype=='noshelf'):
            self.field = self.LoadField('noshelf')

        # Greenland Standard Data Set
        elif (contourtype=='gsds'):
            self.field = self.LoadField('usrf')
            self.field[self.field>0.001]=1 

        elif (contourtype=='mask'):
            self.field = self.LoadField('grounding')

        # Greenland Standard Data Set, to zero ice thickness
        elif (contourtype=='gsdsz'):
            self.field = self.LoadField('thk')
            #height  = self.Variables()['usrf'][0,:, :] 
            #bedrock = self.Variables()['topg'][0,:, :] 
            #self.field = abs(height - bedrock)

            self.field[self.field<10.0]=0
            self.field[self.field>=10.0]=1
            #self.field[self.field>0.001]=1 

        elif (contourtype=='gebco'):
            # Currently non-functional - needs 2d z array
            self.field = self.LoadField('z_range')
            self.field[self.field<10.0]=0
            self.field[self.field>=10.0]=1

        elif (contourtype=='gsdszc'):
            height = self.LoadField('usrf')
            bedrock = self.LoadField('topg')
            self.field = height - bedrock

            self.field[self.field<10.0]=0
            self.field[self.field>=10.0]=1
            #self.field[self.field<0.001]=0 
            #self.field[self.field>=0.001]=1 

        else:
            error("Contour type not recognised, '" + contourtype + "'", fatal=True)

class ReadDataRaster():

    def __init__(self, filename):
        self._filename = filename

    def Load(self):
        from PIL import Image
        from numpy import asarray, arange
        im = Image.open(self._filename, 'r').convert('L')
        p = im.load()
        a = asarray(im)

        # Note flipped
        self.lon = arange(a.shape[1])
        self.lat = - arange(a.shape[0])
        self.field = a
        report("Found raster, sizes: lat %(lat)d, lon %(lon)d, shape %(shape)s", var = {'lon':len(self.lon), 'lat':len(self.lat), 'shape':str(self.field.shape)}, indent = 2 )

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

def ReadPaths(brep, rep):
    filename = rep.LocationFull()
    contour_required = False
    base, ext = os.path.splitext(filename)
    ext = ext.lstrip('.')
    if ext in ['png', 'tif', 'tiff']:
        r = ReadDataRaster(filename)
        contour_required = True
    elif ext in ['shp']:
        paths = read_shape(filename) 
    else: # NetCDF .nc files
        r = ReadDataNetCDF(brep, rep)
        contour_required = True

    if (False):
        import matplotlib.pyplot as plt
        fig = plt.figure()
        #plt.plot(lon,lat, 'g-')
        #plt.show
        #plt.imshow(lon,lat,field)
        paths = plt.contour(r.lon,r.lat,r.field,levels=[0.5]).collections[0].get_paths()
        plt.show()

    else:
        if contour_required:
            import matplotlib
            universe.plot_backend = matplotlib.get_backend()
            matplotlib.use('Agg')
            from pylab import contour
            report("Found raster, sizes: lat %(lat)d, lon %(lon)d, shape %(shape)s", var = {'lon':len(r.lon), 'lat':len(r.lat), 'shape':str(r.field.shape)}, indent = 2 )
            paths = contour(r.lon,r.lat,r.field,levels=[0.5]).collections[0].get_paths()



    return paths

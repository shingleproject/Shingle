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

import os
from copy import deepcopy
from Scientific.IO import NetCDF
from pydap.client import open_url

from Universe import universe
from Spud import specification
from Reporting import error, report
from StringOperations import list_to_comma_separated

class ReadDataNetCDF():
    """Read source data from NetCDF.
    """

    _NAMES_X = ['lon', 'longrid', 'x', 'x_range', 'x1']
    _NAMES_Y  = ['lat', 'latgrid', 'y', 'y_range', 'y1']
    _NAMES_FIELD = ['z', 'elevation', 'topo', 'height', 'z_range']

    def __init__(self, dataset, subregion=None, name_field=None, name_x=None, name_y=None):

        # Store
        self.dataset = dataset
        self.subregion = subregion
        self.name_field = name_field
        self.name_x = name_x
        self.name_y = name_y

        # Variable containing the fileoject or distributed reosurce URL
        self._fileobject = None

        # Variables containing the index range of a requested subregion
        self._x_irange = None
        self._y_irange = None

        ## Automatically load the whole or subregion of a dataset on initialisation
        #self.Load()

    def __eq__(self, other):
        return ((self.dataset == other.dataset) and
            (self.subregion == other.subregion) and
            (self.name_field == other.name_field) and
            (self.name_x == other.name_x) and
            (self.name_y == other.name_y))

    def _file(self):
        if self._fileobject is None:
            if self.dataset.isLocal() or self.dataset.isHttp():
                self._fileobject = NetCDF.NetCDFFile(self.dataset.LocationFull(), 'r')
            elif self.dataset.isOpendap():
                self._fileobject = open_url(self.dataset.LocationFull())
            else:
                self._fileobject = NetCDF.NetCDFFile(self.dataset.LocationFull(), 'r')
        return self._fileobject

    def _determine_variable_names(self):

        # Determine x name
        if self.name_x is None:
            names = []
            for name in self._NAMES_X:
                if name in self.VariablesAvailable():
                    names.append(name)
            if len(names) == 0:
                error('Source dataset contains the fields: ' + list_to_comma_separated(self.VariablesAvailable()))
                error('Cannot identify x coordinate field in source dataset: ' + self.dataset.LocationFull(), fatal=True)
            elif len(names) > 1:
                error('Identified multiple x coordinate fields in source dataset: ' + self.dataset.LocationFull(), fatal=True)
            else:
              self.name_x = names[0]

        # Determine y name
        if self.name_y is None:
              names = []
              for name in self._NAMES_Y:
                  if name in self.VariablesAvailable():
                      names.append(name)
              if len(names) == 0:
                  error('Cannot identify y coordinate field in source dataset: ' + self.dataset.LocationFull(), fatal=True)
              elif len(names) > 1:
                  error('Identified multiple y coordinate fields in source dataset: ' + self.dataset.LocationFull(), fatal=True)
              else:
                self.name_y = names[0]

        # Determine field name
        if self.name_field == 'Automatic':
            self.name_field = None
        if self.name_field is None:
            names = []
            for name in self._NAMES_FIELD:
                if name in self.VariablesAvailable():
                    names.append(name)
            if len(names) == 0:
                error('Cannot identify height field in source dataset: ' + self.dataset.LocationFull(), fatal=True)
            elif len(names) > 1:
                error('Identified multiple height fields in source dataset: ' + self.dataset.LocationFull(), fatal=True)
            else:
              self.name_field = names[0]

    def Variables(self):
        if self.dataset.isOpendap():
            return self._file()
        else:
            return self._file().variables

    def VariablesAvailable(self):
        return self.Variables().keys()


    def Crop(self):
        # Begin with widest bounds
        self._x_irange = [0, len(self.lon)]
        self._y_irange = [0, len(self.lat)]

        subregion = self.subregion

        # Determine bounding box
        if subregion is not None:
            if len(subregion) > 0:
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
        self.lon = self.Variables()[self.name_x][self._x_irange[0]:self._x_irange[1]]
        self.lat = self.Variables()[self.name_y][self._y_irange[0]:self._y_irange[1]]

    def LoadField(self, name = None):
        if name is None:
            name = self.name_field
        if self.dataset.isOpendap():
            field = self.Variables()[name].array
        else:
            field = self.Variables()[name]
        self.data = deepcopy(field[self._y_irange[0]:self._y_irange[1], self._x_irange[0]:self._x_irange[1]])
        return self.data

    def Load(self):
        # Take a look at the available variables within the NetCDF file
        self._determine_variable_names()

        # Attempt to load spatial coordinate variables from source NetCDF
        try:
            self.lon = self.Variables()[self.name_x][:]
            self.lat = self.Variables()[self.name_y][:]
        except:
            error('Warning: Problem reading spatial coordinate variables from source NetCDF: ' + self.dataset.LocationFull())

        self.Crop()
        return self.LoadField(self.name_field)
        #self.Process()

    def Data(self):
        return self.data

def Filter(dataset, brep, subregion):
    from numpy import array

    if specification.have_option(brep.FormPath() + 'contourtype[0]'):
        contour_type = specification.get_option(brep.FormPath() + 'contourtype[0]/name')
    else:
        contour_type = universe.default.contourtype
    name_field = None
    level = None

    path = '%(form)scontourtype::%(contour)s/field_name' % {'form':brep.FormPath(), 'contour': contour_type}
    if specification.have_option(path):
        name_field = specification.get_option(path)

    path = '%(form)scontourtype::%(contour)s/field_level' % {'form':brep.FormPath(), 'contour': contour_type}
    if specification.have_option(path):
        level = specification.get_option(path)


    if name_field == 'usrf-topg':
        height = dataset.Load(subregion, name_field='usrf').Data()
        bedrock = dataset.Load(subregion, name_field='topg').Data()
        field = height.Data() - bedrock.Data()
        region = height
    else:
        region = dataset.Load(subregion, name_field=name_field)
        field = deepcopy(region.Data())

    if (contour_type=='iceshelfcavity'):
        #            % 2
        # 0 ocean    1
        # 1 ice      0
        # 2 shelf    1
        # 3 rock     0

        path = '%(form)scontourtype::%(contour)s/exclude_iceshelf_ocean_cavities' % {'form':brep.FormPath(), 'contour': contour_type}
        if specification.have_option(path):
            exclude_ice_cavities = specification.have_option(path)
        else:
            exclude_ice_cavities = universe.default.exclude_iceshelf_ocean_cavities

        if exclude_ice_cavities:
            #self.dataset.report('Excluding iceshelf ocean cavities', indent = 2)
            field[field>0.5]=1
        else:
            #self.dataset.report('Including iceshelf ocean cavities', indent = 2)
            field = field % 2

    elif (contour_type=='icesheet'):
        field[field>0.001]=1

    elif (contour_type=='z'):
        field[field<10.0]=0
        field[field>=10.0]=1

    elif (contour_type=='ocean10m'):
        field[field<=-10.0]=-10.0
        field[field>-10.0]=0
        field[field<=-10.0]=1

    elif (contour_type=='gebco10m'):
        field[field<=-10.0]=-10.0
        field[field>-10.0]=0
        field[field<=-10.0]=1

    elif (contour_type=='gebco1m'):
        field[field<=-1.0]=-1.0
        field[field>-1.0]=0
        field[field<=-1.0]=1

    elif (contour_type=='gebco0.1m'):
        field[field<=-0.1]=-0.1
        field[field>-0.1]=0
        field[field<=-0.1]=1

    elif (contour_type=='gebco-10m'):
        field[field<=10.0]=0
        field[field>10.0]=1


    elif (contour_type=='xyz'):
        field[field>=-10.0]=1
        field[field<-10.0]=0

    # Greenland Standard Data Set
    elif (contour_type=='gsds'):
        field[field>0.001]=1

    # Greenland Standard Data Set, to zero ice thickness
    elif (contour_type=='gsdsz'):
        #height  = self.Variables()['usrf'][0,:, :]
        #bedrock = self.Variables()['topg'][0,:, :]
        #field = abs(height - bedrock)

        field[field<10.0]=0
        field[field>=10.0]=1
        #field[field>0.001]=1

    elif (contour_type=='gebco'):
        # Currently non-functional - needs 2d z array
        field[field<10.0]=0
        field[field>=10.0]=1

    elif (contour_type=='gsdszc'):

        field[field<10.0]=0
        field[field>=10.0]=1
        #field[field<0.001]=0
        #field[field>=0.001]=1

    elif (contour_type=='zmask'):
        field = field
    elif (contour_type=='noshelf'):
        field = field
    elif (contour_type=='mask'):
        field = field

    else:
        error("Contour type not recognised, '" + contour_type + "'", fatal=True)
    return region, field



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

    def ReadShapefile(filename):
        """Reads shapefile file and generates a dictionary of shapefile elements
        """
        data = ogr.Open(filename)
        # Obtain the ESRI Shapefile driver
        driver = ogr.GetDriverByName('ESRI Shapefile')

        # Open the source shapefile
        #data = driver.Open('data/OpenOcean.shp', 0)
        if data is None:
            error('Unable to open shapefile: ' + filename, fatal=True)

        layer = data.GetLayer()

        #features = [GetFieldPolygon(element) for element in layer]

        features = []
        for feature in layer:
            p = GetFieldPolygon(feature)
            #print p
            if p is not None:
                features.append(p)


        #feature = layer.GetNextFeature()
        #while feature:
        #    p = GetFieldPolygon(feature)
        #    if p is not None:
        #        features.append(p)

        #return dict(features)
        return features

    def GetFieldPolygon(element):
        """Processes shapefile elements and returns a shapefile MultiPolygon
        """
        geometry_reference = element.GetGeometryRef()
        if geometry_reference is not None:
            field = element.GetField(0)
            polygon = loads(geometry_reference.ExportToWkb())
            #return (field, polygon)
            #print field
            return polygon
        return None

    paths = []
    shapes = ReadShapefile(filename)

    #from matplotlib.path import Path
    from shapely.geometry.polygon import LineString
    #class PPath(object):
    #  def __init__(self, vertices):
    #    self.vertices = vertices

    #import code
    #code.interact(local=locals())

    #shape = shapes[shapes.keys()[0]]
    for shape in shapes:
        #print shape.type

        if shape.type == 'Polygon':
            try:
                p = LineString(shape.exterior.coords[:])
                #print p.vertices
                paths.append(p)
            except:
                pass
            for interior in shape.interiors:
                p = LineString(interior.coords[:])
                #print p.vertices
                paths.append(p)
        elif shape.type == 'LineString':
                p = LineString(shape.coords[:])
                #print p.vertices
                paths.append(p)
        else:
            error("Unable to process a %(type)s feature contained in shapefile: %(filename)s" % {'type': shape.type, 'filename': filename}, fatal=True)

    return paths

def ReadShape(brep, dataset):
    filename = dataset.LocationFull()
    return read_shape(filename)

def ReadPaths(brep, dataset):
    filename = dataset.LocationFull()
    contour_required = False
    base, ext = os.path.splitext(filename)
    ext = ext.lstrip('.')

    subregion = brep.Region().GetMaxBounds()

    if ext in ['png', 'tif', 'tiff']:
        r = ReadDataRaster(filename)
        r.Load()
        #region, field = Filter(dataset, brep, subregion)
        region = r
        field = r.field
        contour_required = True
    elif ext in ['shp']:
        paths = read_shape(filename)
        raise NotImplemented
    else: # NetCDF .nc files

        region, field = Filter(dataset, brep, subregion)

        #r = ReadDataNetCDF(dataset, subregion = subregion)
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
            try:
                shape = ", shape %(shape)s" % {'shape':str(region.Data().shape)}
            except:
                shape = ""
                pass
            report("Found raster, sizes: lat %(lat)d, lon %(lon)d%(shape)s", var = {'lon':len(region.lon), 'lat':len(region.lat), 'shape':shape}, indent = 2 )
            paths = contour(region.lon,region.lat,field,levels=[0.5]).collections[0].get_paths()

    return paths


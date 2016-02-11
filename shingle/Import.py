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

import os
from Universe import universe
from Reporting import error, report
from Scientific.IO import NetCDF


def read_rtopo(brep, ref, filename):
  file = NetCDF.NetCDFFile(filename, 'r')
  #variableNames = fileN.variables.keys() 
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
      ref.report('Including iceshelf ocean cavities')
      field = field % 2
    else:
      ref.report('Excluding iceshelf ocean cavities')
      field[field>0.5]=1 
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
  report("Found raster, sizes: lat %(lat)d, lon %(lon)d, shape %(shape)s", var = {'lon':len(lon), 'lat':len(lat), 'shape':str(a.shape)} )

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
    #sys.exit(0)

  else:
    if contour_required:
      import matplotlib
      matplotlib.use('Agg')
      from pylab import contour
      report("Found raster, sizes: lat %(lat)d, lon %(lon)d, shape %(shape)s", var = {'lon':len(lon), 'lat':len(lat), 'shape':str(field.shape)} )
      paths = contour(lon,lat,field,levels=[0.5]).collections[0].get_paths()

  return paths

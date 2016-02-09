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
from Reporting import error

class Raster(object):

  _cacheFiletype = '.shc'

  def __init__(self, name='Raster', source=None, cache=False):
    # Input parameters
    self.contoursource = source
    self.cache = cache
    # Internal variables
    self.cachefile = None 
    self.pathall = None
    self.path = None
    # Log of object events
    self.log = ''

  def SetContourSource(self, filename):
    self.contoursource = filename

  def CheckSource(self):
    from os.path import isfile
    if not isfile(self.contoursource):
      error('Source netCDF ' + self.contoursource + ' not found!', fatal=True)

  def GetCacheLocation(self):
    if self.cachefile is None:
      from os.path import splitext
      base, extension = splitext(self.contoursource)
      self.cachefile = base + '_' + extension.lstrip('.') + '_' + universe.contourtype + self._cacheFiletype

  def CheckCache(self):
    self.GetCacheLocation()
    if not self.isCachePresent():
      self.report('Contour cache ' + self.cachefile + ' not found, forcing generation.')
      self.cache = True

  def isCachePresent(self):
    from os.path import isfile
    return isfile(self.cachefile)

  def report(self, text, include = True, debug = False):
    from os import linesep
    if debug and not universe.debug:
      return
    if (universe.verbose):
      print text
    if include:
      self.log = self.log + '// ' + text + linesep

  def AppendParameters(self):
    self.report('Source netCDF located at ' + self.contoursource)

  def CacheLoad(self):
    import pickle
    import os
    if not self.cache:
      return False
    if not os.path.exists(self.cachefile):
      error('Cannot locate cache file: ', fatal=True)
    cachefile = open(self.cachefile, 'rb')
    self.report('Cache file found: ' + self.cachefile)
    self.pathall = pickle.load(cachefile)
    cachefile.close()

  def CacheSave(self):
    import pickle
    import os
    if not self.cache:
      return False
    try:
      self.report('Saving contours to: ' + self.cachefile + ' for the future!')
      cachefile = open(self.cachefile, 'wb')
      pickle.dump(self.pathall, cachefile)
      cachefile.close()
      return True
    except:
      error('Cannot save cache to file: ', fatal=False)
      pass
    return False

  def GenerateContour(self):
    from Import import read_paths
    self.report('Generating contours', include = False)
    self.pathall = read_paths(self, self.contoursource)

  def Generate(self):
    import os

    self.AppendParameters()
    self.CheckSource()

    if self.cache and os.path.exists(self.cachefile):
      self.CacheLoad()
    else:
      self.GenerateContour()
      self.CacheSave()

    self.path = self.pathall
    self.report('Paths found: ' + str(len(self.pathall)))


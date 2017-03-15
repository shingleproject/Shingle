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

from Universe import universe
from Reporting import error, report
from Spud import specification

class Dataset(object):

    def __init__(self, spatial_discretisation=None, number=None):
        self._path = None
        self._spatial_discretisation = None
        self.name = None
        self.form = None
        self.source = None
        self.location = None
        self.projection = None
        self._number = number
        if spatial_discretisation is not None:
            self._spatial_discretisation = spatial_discretisation
        self.Read()

    def Read(self):
        if self._number is None:
            return
        self.name = specification.get_option('/dataset[%(number)d]/name' % {'number':self._number} )
        self._path = '/dataset::%(name)s' % {'name':self.name} 
        self.form = specification.get_option(self._path + '/form[0]/name' )
        self.source = specification.get_option(self._path + '/form[0]/source[0]/name' )
        if self.source == 'Local_file':
            self.SetContourSource(specification.get_option(self._path + '/form[0]/source[0]/file_name' )) 
        elif self.source == 'OPeNDAP':
            self.location = specification.get_option(self._path + '/form[0]/source[0]/url' )  
        self.projection = specification.get_option(self._path + '/projection[0]/name' )

    def SetContourSource(self, filename):
        self.location = filename

    def LocationFull(self):
        return self._spatial_discretisation.PathRelative(self.location)

    def Show(self):
        report('  %(blue)s%(number)s.%(end)s %(name)s', var = {'number':self._number + 1, 'name':self.name })
        report('      %(blue)sPath:       %(end)s%(path)s', var = {'path':self._path} )
        report('      %(blue)sForm:       %(end)s%(form)s', var = {'form':self.form} )
        report('      %(blue)sSource:     %(end)s%(source)s', var = {'source':self.source} )
        report('      %(blue)sLocation:   %(end)s%(location)s', var = {'location':self.location} )
        report('      %(blue)sProjection: %(end)s%(projection)s', var = {'projection':self.projection} )

class Raster(Dataset):

    _cacheFiletype = '.shc'

    def __init__(self, name='Raster', location=None, cache=False, number=None, spatial_discretisation=None):
        # Input parameters
        self.contoursource = None
        self.cache = None
        # Internal variables
        self.cachefile = None 
        self.pathall = None
        self.path = None
        # Log of object events
        self.log = ''
        if location is not None:
            self.location = location
        Dataset.__init__(self, spatial_discretisation=spatial_discretisation, number=number)
        self.cache = cache

    def SourceExists(self):
        from os.path import isfile
        if self.location is None:
            return False
        return isfile(self.LocationFull())

    def CheckSource(self):
        from os.path import isfile
        if not self.SourceExists(): 
            error('Source NetCDF ' + self.LocationFull() + ' not found!', fatal=True, indent = 1)

    def GetCacheLocation(self):
        if self.cachefile is None:
            from os.path import splitext
            base, extension = splitext(self.LocationFull())
            self.cachefile = base + '_' + extension.lstrip('.') + '_' + universe.default.contourtype + self._cacheFiletype

    def CheckCache(self):
        self.GetCacheLocation()
        if not self.isCachePresent():
            self.report('Contour cache ' + self.cachefile + ' not found, forcing generation.')
            self.cache = True

    def isCachePresent(self):
        from os.path import isfile
        return isfile(self.cachefile)

    def report(self, *args, **kwargs):
        return self._spatial_discretisation.report(*args, **kwargs)

    def AppendParameters(self):
        self.report('Source NetCDF located at ' + self.location, indent = 1)

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


#  def GenerateContour(self):
#    from Import import read_paths
#    self.report('Generating contours', include = False)
#    self.pathall = read_paths(self, self.LocationFull())
#
#  def Generate(self):
#    import os
#
#    self.AppendParameters()
#    self.CheckSource()
#
#    if self.cache and os.path.exists(self.cachefile):
#      self.CacheLoad()
#    else:
#      self.GenerateContour()
#      self.CacheSave()
#
#    self.path = self.pathall
#    self.report('Paths found: ' + str(len(self.pathall)))


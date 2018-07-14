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
from Spud import specification
from StringOperations import expand_boxes, parse_boxes, bound_by_latitude
from shapely.geometry import box, MultiPolygon

class Bounds():

    _bounds = None
    _polybounds = None
    _path = None

    _expression = None

    def __init__(self, brep = None, path = None):
        self._bounds = None
        self._brep = brep
        if self._brep is not None:
            self._path = self._brep.FormPath()
        else:
            self._path = path
        self._expression = None

    def AddComment(self, *args, **kwargs):
        if self._brep is None:
            return None
        return self._brep.AddComment(*args, **kwargs)

    def BoundingLatitude(self, *args, **kwargs):
        if self._brep is None:
            return None
        return self._brep.BoundingLatitude(*args, **kwargs)

    def __str__(self):
        return self.GetBoundsExpression()

    def GetBounds(self):
        if self._bounds is None:
            self.Read()
        return self._bounds

    def GetMaxBounds(self):
        self.GetBounds()
        union = MultiPolygon(self._polybounds)
        return union.bounds

    def GetBoundsExpression(self):
        if self._expression is None:
          self.ReadExpression()
        return self._expression

    def Add(self, bound):
        # Add a new bound specifying the region of interest
        if self._bounds is None:
            self._bounds = []
        self._bounds.append(bound)

        if self._polybounds is None:
            self._polybounds = []

        self._polybounds.append(box(bound[0][0], bound[1][0], bound[0][1], bound[1][1]))

    def Read(self):
        # Establish bounding box
        if specification.have_option(self._path + 'box'):
            box = specification.get_option(self._path + 'box')
            for bound in parse_boxes(specification.get_option(self._path + 'box')):
                self.Add(bound)

        #if specification.have_option(self._path + 'region'):
        total_regions = specification.option_count(self._path + 'region')
        for number in range(total_regions):
            path = self._path + 'region[%(number)d]' % {'number':number}
            long1 = specification.get_option(path + '/longitude/minimum')
            long2 = specification.get_option(path + '/longitude/maximum')
            lat1  = specification.get_option(path + '/latitude/minimum')
            lat2  = specification.get_option(path + '/latitude/maximum')
            bound = ( [long1, long2], [lat1, lat2] )
            self.Add(bound)

    def ReadExpression(self):
        # Read full bound expression
        region = universe.default.region

        if specification.have_option(self._path + 'region_description'):
            region = specification.get_option(self._path + 'region_description')

        if specification.have_option(self._path + 'box'):
            box = specification.get_option(self._path + 'box').split()
            self.AddComment('Imposing box region: ' + ('\n  ').join([''] + box))
            region = expand_boxes(region, box)

        bounding_latitude = self.BoundingLatitude()
        if bounding_latitude is not None:
            self.AddComment('Bounding by latitude: ' + str(bounding_latitude))
            region = bound_by_latitude(region, bounding_latitude)

        if region != 'True':
            self.AddComment('Region of interest: ' + region)
        self._expression = region


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



class Bounds():

    _bounds = None

    def __init__(self):
        _bounds = []





    def Add(self, bound):
        # Add a new bound specifying the region of interest
        self._bounds.append(bound)

    def Read(self):
      # Bits from region

        if specification.have_option(self.FormPath() + 'region'):
            region = specification.get_option(self.FormPath() + 'region')
        if specification.have_option(self.FormPath() + 'box'):
            box = specification.get_option(self.FormPath() + 'box').split()
            from os import linesep
            self.AddComment('Imposing box region: ' + (linesep + '  ').join([''] + box))
            region = expand_boxes(region, box )
        bounding_latitude = self.BoundingLatitude()
        if bounding_latitude is not None:
            self.AddComment('Bounding by latitude: ' + str(bounding_latitude))
            region = bound_by_latitude(region, bounding_latitude)


    def __str__(self):


    def Region(self):
        if self._region is None:
            region = universe.default.region
            if specification.have_option(self.FormPath() + 'region'):
                region = specification.get_option(self.FormPath() + 'region')
            if specification.have_option(self.FormPath() + 'box'):
                box = specification.get_option(self.FormPath() + 'box').split()
                from os import linesep
                self.AddComment('Imposing box region: ' + (linesep + '  ').join([''] + box))
                region = expand_boxes(region, box )
            bounding_latitude = self.BoundingLatitude()
            if bounding_latitude is not None:
                self.AddComment('Bounding by latitude: ' + str(bounding_latitude))
                region = bound_by_latitude(region, bounding_latitude)
            self.AddComment('Region of interest: ' + region)
            self._region = region
        return self._region

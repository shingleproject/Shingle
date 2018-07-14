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
from Reporting import error, report
from Spud import specification

class Boundary(object):

    def __init__(self, surface=None, number=None):
        self._path = None
        self.name = None
        self.physical_id = None

        self._number = number
        self._surface = surface
        self.path = []
        self.Read()

    def Name(self):
        return self.name

    def Read(self):
        if self._number is None or self._surface is None:
            return
        self.name = specification.get_option('%(root)s/boundary[%(number)d]/name' % {'root':self._surface._path, 'number':self._number} )
        self._path = '%(root)s/boundary::%(name)s' % {'root':self._surface._path, 'name':self.name}
        self.physical_id = specification.get_option(self._path + '/identification_number' )
        #for number in range(specification.option_count(self._path + 'brep_component')):
        #  specification.get_option(self._path + '/brep_component[%(number)s]' % {'number':number} )

    def Add(self, path):
        self.path.append(path)

    def Show(self):
        report('  %(blue)s%(number)s.%(end)s %(name)s', var = {'number':self._number + 1, 'name':self.name })
        report('      %(blue)sPath:        %(end)s%(path)s', var = {'path':self._path} )
        report('      %(blue)sPhysical ID: %(end)s%(id)s', var = {'id':self.physical_id} )


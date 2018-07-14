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
from Universe import universe
from Reporting import error, report
from Spud import specification

class OutputFormat(object):

    def __init__(self, spatial_discretisation=None, representation=None, mesh=None):
        self.spatial_discretisation = spatial_discretisation
        self.representation = representation
        self.mesh = mesh
        self.Process()

    def Process(self):
        path = '/postprocess/format'
        if specification.have_option('%(path)s/h2ocean' % {'path':path}):
            from OutputFormatWriter.H2Ocean import H2Ocean
            H2Ocean(self.spatial_discretisation, self.representation, self.mesh)


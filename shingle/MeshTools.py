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
from Support import ExecuteStage
from Reporting import report, error
from Spud import specification

from numpy import array

def read_line_number(filename, line_number):
    # Add check for header in previous line?
    #f = open(filename, 'r')
    count = 0
    with open(filename, 'r') as fh:
        for line in fh:
            count += 1
            if count == line_number:
                return line.strip()
    return None

class Mesh(object):

    _msh_file_node_number_line = 5
    _msh_file_element_number_displacement = 3
    _loaded = False

    _connectivity = None
    _triangulation = None

    nodes = {}
    elements = {}

    def __init__(self, representation = None, source = None):
        self.filename = self.Source(source, representation)
        self.representation = representation
        self.node_number = None
        self.element_number = None

    def isGenerated(self):
        return self.representation.mesh_generated

    def Source(self, source, representation):
        if source is not None:
            return source
        if representation is not None:
            if representation.mesh_filename is not None:
                return representation.mesh_filename
        error('Mesh object has no source filename')
        return None

    def Show(self):
        report('%(blue)sMesh properties:%(end)s %(yellow)s%(name)s%(end)s', var = {'name':self.filename })
        report('%(blue)sNumber of nodes:%(end)s    %(number)d', var = {'number':self.NodeNumber()}, indent=1 )
        report('%(blue)sNumber of elements:%(end)s %(number)d', var = {'number':self.ElementNumber()}, indent=1 )

    def Load(self, force=False):
        if not self._loaded or force:
          from shingle.OutputFormatWriter.GmshData import GmshData
          d = GmshData()
          d.Read(self.filename)
          self.nodes = d.nodes
          self.elements = d.elements
          self._loaded = True

    def GetConnectivity(self, force=False):
        if (self._connectivity is None) or force:
            self.Load()
            _connectivity = []
            for i in range(len(self.elements)):
                entry = self.elements[i + 1]
                if entry[0] != 2: continue
                _connectivity.append(entry[2])
            self._connectivity = array([e-1 for e in array(_connectivity)])
        return self._connectivity

    def GetTriangulation(self, force=False):
        if (self._triangulation is None) or force:
            self.Load()
            x = array([position[0] for position in self.nodes.itervalues()])
            y = array([position[1] for position in self.nodes.itervalues()])
            triangles = self.GetConnectivity()
            import matplotlib.tri as tri
            self._triangulation = tri.Triangulation(x, y, triangles)
        return self._triangulation

    def NodeNumber(self):
        if not self.isGenerated():
            return 0
        if self.node_number is None:
            self.node_number = int(read_line_number(self.filename, self._msh_file_node_number_line))
        return self.node_number

    def ElementNumber(self):
        if not self.isGenerated():
            return 0
        if self.element_number is None:
            self.element_number = int(read_line_number(self.filename, self._msh_file_node_number_line + self._msh_file_element_number_displacement + self.NodeNumber()))
        return self.element_number


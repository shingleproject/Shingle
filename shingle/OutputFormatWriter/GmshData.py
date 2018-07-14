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
import sys
sys.path.insert(0, os.path.realpath(os.path.join(os.path.realpath(os.path.dirname(os.path.realpath(__file__))), os.path.pardir)))
from Reporting import error, report

class Node:
    identification = None
    location = None

    def __init__(self, identification, location):
        self.identification = identification
        self.location = location

    def __str__(self):
        return format(self.GetIdentification()) + ' ' + ' '.join([format(x) for x in self.GetLocation()]) + '\n'

    def GetIdentification(self):
        return self.identification

    def GetLocation(self):
        return self.location

class Element:
    _polytopes  = {
        1: 'line',
        2: 'triangle',
        3: 'quadrilateral',
        4: 'tetrahedral',
        5: 'hexahedral',
        6: 'triangular_prism',
        7: 'pyramid'
    }
    _polytope_dofs = {
        1: 2, # line
        2: 3, # triangle
        3: 4, # quadrilateral
        4: 4, # tetrahedral
        5: 8, # hexahedral
        6: 6, # triangular prism
        7: 5, # pyramid
    }

    identification = None
    polytope = None
    tags = None
    connectivity = None

    def __init__(self, identification, polytope):
        self.identification = identification
        self.polytope = polytope
        self.tags = []
        self.connectivity = []

    def __str__(self):
        return format(self.GetIdentification()) \
            + ' ' + format(self.GetPolytope()) \
            + ' ' + format(self.GetNumberOfTags()) \
            + ' ' + ' '.join([format(x) for x in self.GetTags()]) \
            + ' ' + ' '.join([format(x) for x in self.GetConnectivity()]) + '\n'

    def GetIdentification(self):
        return self.identification

    def GetPolytope(self):
        return self.polytope

    def GetTags(self):
        return self.tags

    def GetNumberOfTags(self):
        return len(self.tags)

    def GetConnectivity(self):
        return self.connectivity

    def GetVertexNumber(self):
        return self._polytope_dofs[self.polytope]

    def AddTag(self, tag):
      self.tags.append(tag)

    def AddVertex(self, vertex):
      self.connectivity.append(vertex)

    def AddTags(self, tags):
      self.tags = self.tags + tags

    def AddVertices(self, vertices):
      self.connectivity = self.connectivity + vertices

class GmshData:
    """Class for interacting with mesh files generated and read by Gmsh.
    Stores nodes and element information.  Reads and outputs Gmsh .msh mesh syntax.
    """

    _header = '''$MeshFormat
2.0 0 8
$EndMeshFormat
$Nodes
%(node_number)d
'''
    _mid = '''$EndNodes
$Elements
%(element_number)d
'''
    _footer = '''$EndElements
'''
    _namelist = {
        'marker': '$',
        'nodes_start': '$Nodes',
        'nodes_end': '$EndNodes',
        'elements_start': '$Elements',
        'elements_end': '$EndElements',
    }

    def __init__(self, source = None):
        self.source = source
        self.nodes = {}
        self.elements = {}

        self.version_number = None
        self.file_type = None
        self.data_size = None
        self.version_main = None

        if self.source is not None:
          self.Read()

    def isBinary(self, filename = None):
        if self.file_type is None:
            self.ReadFormat(filename)
        return self.file_type == 1

    def VersionMain(self, filename = None):
        if self.version_main is None:
          from math import floor
          if self.version_number is None:
              self.ReadFormat(filename)
          self.version_main = int(floor(self.version_number))
        return self.version_main

    def SetNamelist(self):
        if self.VersionMain() == 1:
            self._namelist['nodes_start'] = '$NOD'
            self._namelist['elements_start'] = '$ELM'

    def AddNode(self, node):
        self.nodes[node.identification] = node

    def AddElement(self, element):
        self.elements[element.identification] = element

    def ReadFormat(self, filename = None):
        """Read mesh file format data"""
        #if (self.version_number is None) or (self.file_type is None) or (self.data_size is None):
        if filename is None:
            filename = self.source
        if filename is None:
            error('Source mesh file not provided')
        else:
            meshfile = open(filename, 'r')
            meshfile.readline()
            line = meshfile.readline().split()
            self.version_number = float(line[0])
            self.file_type = int(line[1])
            self.data_size = int(line[2])

    def ReadBinary(self, filename = None):
        """Read a mesh file containing binary data"""
        import struct
        error_count = 0
        if filename is None:
            filename = self.source
        if filename is None:
            error('Source mesh file not provided')
        meshfile = open(filename, 'r')
        report('%(blue)sReading binary mesh file:%(end)s %(yellow)s%(filename)s%(end)s', var = {'filename': meshfile.name}, indent=1)

        meshfile.readline()
        meshfile.readline()
        meshfile.readline()
        meshfile.readline()
        meshfile.readline()

        # Read nodes
        totalnodes = int(meshfile.readline())
        for i in range(totalnodes):
            number = struct.unpack('i', meshfile.read(4))[0]
            location = struct.unpack('ddd', meshfile.read(24))
            self.AddNode(Node(number, location))

        meshfile.readline()
        meshfile.readline()
        meshfile.readline()

        # Read elements
        totalelements = int(meshfile.readline())
        ele = 0
        while ele <= totalelements:
            polytope = struct.unpack('i', meshfile.read(4))[0]
            number_of_elements = struct.unpack('i', meshfile.read(4))[0]
            number_of_tags = struct.unpack('i', meshfile.read(4))[0]

            for n in range(number_of_elements):
                # Determine element identification number
                identification  = struct.unpack('i', meshfile.read(4))[0]
                # Create element object
                element = Element(identification, polytope)
                # Initialise element tags
                for i in range(number_of_tags):
                    element.AddTag(struct.unpack('i', meshfile.read(4))[0])
                # Initialise element connectivity
                for i in range(element.GetVertexNumber()):
                    element.AddVertex(struct.unpack('i', meshfile.read(4))[0])
                self.AddElement(element)

                ele += 1
                if ele == totalelements:
                    break
            if ele == totalelements:
                break
        meshfile.close()
        return error_count

    def ReadPlain(self, filename = None):
        error_count = 0
        stage = 0
        if filename is None:
            filename = self.source
        if filename is None:
            error('Source mesh file not provided')
        meshfile = open(filename, 'r')
        report('%(blue)sReading plain mesh file:%(end)s %(yellow)s%(filename)s%(end)s', var = {'filename': meshfile.name}, indent=1)
        self.SetNamelist()
        total_nodes = None
        total_elements = None
        for line in meshfile:
            line = line.strip()
            if line.startswith(self._namelist['marker']):
                if line == self._namelist['nodes_start']:
                    stage = 1
                    total_nodes = -1
                elif line == self._namelist['elements_start']:
                    stage = 2
                    total_elements = -1
                elif line == self._namelist['nodes_end']:
                    continue
                else:
                    stage = 0

            elif stage > 0:

                if stage == 1:
                    if total_nodes == -1:
                        total_nodes = int(line)
                        continue
                    data = line.split()
                    if len(data) == 4:
                        try:
                            self.AddNode(Node(int(data[0]), map(float, data[1:])))
                        except ValueError:
                            error('Input node line format error: ' + line)
                            error_count += 1
                            stage = 0

                elif stage > 1:
                    if total_elements == -1:
                        total_elements = int(line)
                        continue

                    data = line.split()
                    if len(data) > 5:
                        try:
                            data = map(int, data)
                        except ValueError:
                            error('Input element line format error: ' + line)
                            error_count += 1
                            stage = 0
                        else:
                            element = Element(data[0], data[1])
                            if self.version_main == 1:
                                element.AddTags(data[2:4])
                                element.AddVertices(data[5:])
                            else:
                                element.AddTags(data[3:3+data[2]])
                                element.AddVertices(data[3+data[2]:])
                            self.AddElement(element)

        meshfile.close()
        report('%(blue)sDiscretisation characteristics:%(end)s %(yellow)s%(nodes)d%(end)s %(blue)snodes,%(end)s %(yellow)s%(yellow)s%(elements)d%(end)s %(blue)selements%(end)s', var = {'nodes': len(self.nodes), 'elements': len(self.elements)}, indent=2)
        return error_count

    def Read(self, filename = None):
        """Read mesh data from a Gmsh .msh file.
        Handles both 1.0 and 2.0 formats.
        """
        if self.isBinary(filename):
            self.ReadBinary(filename)
        else:
            self.ReadPlain(filename)

    def GetNodes(self):
        return self.nodes

    def GetElements(self):
        return self.elements

    def GetNumberOfNodes(self):
        return len(self.GetNodes())

    def GetNumberOfElements(self):
        return len(self.GetElements())

    def __str__(self):
        """Writes mesh information to in-memory stream using Gmsh .msh syntax, version 2.0."""

        import io
        output = io.StringIO()

        output.write(unicode(self._header % {'node_number': self.GetNumberOfNodes()}))

        for i in range(self.GetNumberOfNodes()):
            output.write(unicode(str(self.GetNodes()[i+1])))

        output.write(unicode(self._mid % {'element_number': self.GetNumberOfElements()}))

        for i in range(self.GetNumberOfElements()):
            output.write(unicode(str(self.GetElements()[i+1])))

        output.write(unicode(self._footer))
        return output.getvalue()

    def Write(self, filename):
        """Writes mesh information to file 'filename' using Gmsh .msh syntax, version 2.0."""

        f = open (filename, 'w')
        f.write(self._header % {'node_number': self.GetNumberOfNodes()})

        for i in range(self.GetNumberOfNodes()):
            f.write(str(self.GetNodes()[i+1]))

        f.write(self._mid % {'element_number': self.GetNumberOfElements()})

        for i in range(self.GetNumberOfElements()):
            f.write(str(self.GetElements()[i+1]))

        f.write(self._footer)
        f.close()


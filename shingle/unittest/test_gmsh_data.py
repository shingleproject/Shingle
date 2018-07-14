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

shingle_path = os.path.realpath(os.path.join(os.path.realpath(os.path.dirname(os.path.realpath(__file__))), os.path.pardir, os.path.pardir, 'shingle'))
sys.path.insert(0, shingle_path)

from OutputFormatWriter.GmshData import GmshData

meshfile_plain = os.path.join(shingle_path, 'unittest', 'data', 'Amundsen_Sea.msh')
meshfile_binary = os.path.join(shingle_path, 'unittest', 'data', 'Amundsen_Sea_binary.msh')
meshfile_output = os.path.join(shingle_path, 'unittest', 'output.msh')

class TestClass:
    def test_plain_nodes(self):
        d = GmshData()
        d.Read(meshfile_plain)
        assert d.GetNumberOfNodes() == 3354

    def test_plain_elements(self):
        d = GmshData()
        d.Read(meshfile_plain)
        assert d.GetNumberOfElements() == 6730

    def test_binary_nodes(self):
        d = GmshData()
        d.Read(meshfile_binary)
        assert d.GetNumberOfNodes() == 3354

    def test_binary_elements(self):
        d = GmshData()
        d.Read(meshfile_binary)
        assert d.GetNumberOfElements() == 6730


    def test_read_write_nodes(self):
        d = GmshData()
        d.Read(meshfile_plain)
        d.Write(meshfile_output)
        o = GmshData(meshfile_output)
        assert o.GetNumberOfNodes() == 3354

    def test_read_write_elements(self):
        d = GmshData()
        d.Read(meshfile_plain)
        d.Write(meshfile_output)
        o = GmshData(meshfile_output)
        assert o.GetNumberOfElements() == 6730

if __name__ == '__main__':
    t = TestClass()
    for method in [method for method in dir(t) if callable(getattr(t, method)) if not method.startswith('_')]:
        print method
        getattr(t, method)()


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

from StringOperations import list_to_sentence

class TestClass:
    def test_one_item(self):
        assert list_to_sentence([7]) == '7'

    def test_two_items(self):
        assert list_to_sentence([5,4]) == '5 and 4'

    def test_three_items(self):
        assert list_to_sentence([1,2,3]) == '1, 2 and 3'

if __name__ == '__main__':
    t = TestClass()
    for method in [method for method in dir(t) if callable(getattr(t, method)) if not method.startswith('_')]:
        print method
        getattr(t, method)()


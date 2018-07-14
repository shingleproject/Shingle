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

from Spud import specification

brml = os.path.join(shingle_path, 'unittest', 'data', 'Caribbean.brml')
brml_output = os.path.join(shingle_path, 'unittest', 'output.brml')

class TestClass:
    def test_read_model_name(self):
        specification.clear_options()
        specification.load_options(brml)
        assert specification.get_option('/model_name') == 'Caribbean'

    def test_read_domain_type(self):
        specification.clear_options()
        specification.load_options(brml)
        assert type(specification.get_option('/domain_type')) is str

    def test_read_brep_count(self):
        specification.clear_options()
        specification.load_options(brml)
        assert specification.option_count('/geoid_surface_representation/brep_component') == 2

    def test_set_model_name(self):
        specification.clear_options()
        specification.load_options(brml)
        specification.set_option('/model_name', 'Caribbean_fine')
        assert specification.get_option('/model_name') != 'Caribbean'
        assert specification.get_option('/model_name') == 'Caribbean_fine'

    def test_save_and_read(self):
        specification.clear_options()
        specification.load_options(brml)
        specification.set_option('/model_name', 'Caribbean_new')
        specification.write_options(brml_output)
        specification.clear_options()
        specification.load_options(brml_output)
        assert specification.get_option('/model_name') != 'Caribbean'
        assert specification.get_option('/model_name') == 'Caribbean_new'

if __name__ == '__main__':
    t = TestClass()
    for method in [method for method in dir(t) if callable(getattr(t, method)) if not method.startswith('_')]:
        print method
        getattr(t, method)()


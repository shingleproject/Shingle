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

import os
import sys

shingle_path = os.path.realpath(os.path.join(os.path.realpath(os.path.dirname(os.path.realpath(__file__))), os.path.pardir, 'shingle'))
sys.path.insert(0, shingle_path)

from Spud import specification

class Tag():

    _rootpath = '/validation/tag'

    def __init__(self, filename):
        self.Locate(filename)
        self.tags = []
        self.Load()

    def __str__(self):
        return ', '.join(self.tags)

    def Locate(self, filename):
        locations = []
        if os.path.isdir(filename):
            locations = [ x for x in os.listdir(filename) if x.endswith('.brml') ]
            if len(locations) == 1:
                self.filename = os.path.join(filename, locations[0])
                return
        self.filename = filename

    def Load(self):
        self.tags = []
        specification.clear_options()
        specification.load_options(self.filename)
        for n in range(specification.option_count(self._rootpath)):
            path = self._rootpath + ('[%d]' % n) + '/name'
            tag = specification.get_option(path)
            self.tags.append(tag)
        return self.tags

    def Save(self):
        specification.write_options(self.filename)

    def Exists(self, tag):
        return tag in self.tags

    def Add(self, tag):
        if self.Exists(tag):
            return False
        else:
            n = len(self.tags)
            path = self._rootpath + ('::%s' % tag)
            print path
            try:
                specification.add_option(path)
            except specification.SpudNewKeyWarning, e:
                pass
            self.tags.append(tag)
            

if __name__ == '__main__':
    args = sys.argv[1:]
    tag = args[0]
    filenames = args[1:]
    for filename in filenames:
        t = Tag(filename)
        existing = str(t)
        stat = t.Add(tag)
        if stat:
            print t.filename + ':', existing, '->', t
        else:
            print t.filename + ':', t
        t.Save()



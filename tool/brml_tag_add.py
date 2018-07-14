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

shingle_path = os.path.realpath(os.path.join(os.path.realpath(os.path.dirname(os.path.realpath(__file__))), os.path.pardir, 'shingle'))
sys.path.insert(0, shingle_path)

from Spud import specification

class Tag():

    _rootpath = '/validation/tag'

    def __init__(self, filename):
        self.loaded = False
        self.Locate(filename)
        self.Load()

    def __str__(self):
        return ', '.join(self.tags)

    def Locate(self, filename):
        locations = []
        if os.path.isdir(filename):
            locations = [ x for x in os.listdir(filename) if x.endswith('.brml') ]
            if len(locations) == 1:
                self.filename = os.path.join(filename, locations[0])
            else:
                self.filename = None
        elif os.path.exists(filename):
            self.filename = filename
        else:
            self.filename = None

    def isLoaded(self):
        return self.loaded

    def Load(self):
        self.tags = []
        if self.filename is not None:
            specification.clear_options()
            specification.load_options(self.filename)
            for n in range(specification.option_count(self._rootpath)):
                path = self._rootpath + ('[%d]' % n) + '/name'
                tag = specification.get_option(path)
                self.tags.append(tag)
            self.loaded = True

    def Save(self):
        if self.isLoaded():
            specification.write_options(self.filename)
            restore_linefeed(self.filename)

    def Exists(self, tag):
        return tag in self.tags

    def Add(self, tag):
        if self.isLoaded():
            if self.Exists(tag):
                return False
            else:
                path = self._rootpath + ('::%s' % tag)
                try:
                    specification.add_option(path)
                except specification.SpudNewKeyWarning, e:
                    pass
                self.tags.append(tag)
                return True

    def Remove(self, tag):
        if self.isLoaded():
            if not self.Exists(tag):
                return False
            else:
                path = self._rootpath + ('::%s' % tag)
                specification.delete_option(path)
                self.tags.remove(tag)
                return True

def restore_linefeed(filename):
    from re import sub
    with open(filename, 'r') as f:
        lines = f.readlines()
    with open(filename, 'w') as f:
        for line in lines:
            f.write(sub(r'&#x0A;', '\n', line))

if __name__ == '__main__':
    args = sys.argv[1:]
    remove = False
    if args[0] == '-r':
        remove = True
        args = args[1:]
    tag = args[0]
    filenames = args[1:]
    for filename in filenames:
        print filename
        t = Tag(filename)
        if t.isLoaded():
            existing = str(t)
            if remove:
                stat = t.Remove(tag)
            else:
                stat = t.Add(tag)
            if stat:
                print '  ' + t.filename + ':', existing, '->', t
            else:
                print '  ' + t.filename + ':', t
            t.Save()


#!/usr/bin/env python
# -*- coding: utf-8 -*-

##########################################################################
#  
#  Copyright (C) 2011-2016 Dr Adam S. Candy.
#  Dr Adam S. Candy, contact@shingleproject.org
#
#  Shingle
#
#  Generation of boundary representation from arbitrary geophysical
#  fields and initialisation for anisotropic, unstructured meshing.
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
from Universe import universe
from Reporting import report
from StringOperations import expand_boxes
from Usage import usage

def FilenameAddExtension(path, extension):
  base, extension_existing = os.path.splitext(path)
  path = base + '.' + extension
  return path

def PathFull(path):
  if path.startswith('/'):
    return path
  return os.path.realpath(os.path.join(universe.root, path))

class ReadArguments(object):

  _stages = ['path', 'brep', 'mesh', 'metric']
  _box = []
  
  def __init__(self):
    from sys import argv
    self.arguments = argv[1:]
    self.argument = None
    self.legacy = False
    self.saveCall()
    self.Read()

  def saveCall(self):
    call = ''
    for argument in self.arguments:
      if ' ' in argument:
        call = call + ' \'' + argument + '\''
      else:
        call = call + ' ' + argument
    universe.call = call

  def NextArgument(self, ):
    return self.arguments.pop(0).rstrip()

  def Read(self):
    from Universe import universe
    while (len(self.arguments) > 0):
      self.argument = self.NextArgument()
      if   (self.argument == '-h'): usage()
      elif (self.argument == '-v'): universe.verbose = True
      elif (self.argument == '-vv'): universe.verbose = True; universe.debug = True; 
      elif (self.argument == '-q'): universe.verbose = False
      elif (self.argument == '-x'): universe.optiontreesource = self.NextArgument();
      elif (self.argument == '-t'): universe.testfolder = self.NextArgument()
      elif (self.argument == '-l'):
        universe.log_active = True
        if ((len(self.arguments) > 0) and (self.arguments[0][0] != '-')):
          universe.logfilename = self.NextArgument()

      elif (self.argument == '-c'): universe.cache = True
      elif (self.argument == '-plot'): universe.plotcontour = True
      elif (self.argument == '-stage'): universe.stage = self.NextArgument()

      elif (self.argument == '-legacy'): self.legacy = True; universe.legacy.legacy = True; report('Including legacy command line options')
      else: self.ReadLegacy()

    universe.default.region = expand_boxes(universe.default.region, self._box)
  
    # Argument sanity check
    if universe.stage is not None:
      if universe.stage not in stages:
        error('Stage %(stage)s not recognised' % universe.stage, fatal=True)

  def ReadLegacy(self):
    from Universe import universe
    if not self.legacy: return
    if (self.argument == '-n'): universe.legacy.source  = self.NextArgument();
    elif (self.argument == '-f'): universe.legacy.output = self.NextArgument();
    elif (self.argument == '-t'): universe.default.contourtype = self.NextArgument()
    elif (self.argument == '-r'): universe.default.region = self.NextArgument()
    elif (self.argument == '-m'): universe.default.projection = self.NextArgument()
    elif (self.argument == '-dx'): universe.default.dx = float(self.NextArgument())
    elif (self.argument == '-lat'): universe.default.extendtolatitude = float(self.NextArgument()); universe.default.closewithparallels = True
    elif (self.argument == '-a'): universe.default.minarea = float(self.NextArgument())
    elif (self.argument == '-bounding_latitude'): universe.default.bounding_lat =float(self.NextArgument())
    elif (self.argument == '-bl'): universe.default.bounding_lat = float(self.NextArgument())
    elif (self.argument == '-smooth_data'):
      universe.default.smooth_degree = int(self.NextArgument())
      universe.default.smooth_data = True
    elif (self.argument == '-no'): universe.open = False
    elif (self.argument == '-exclude_ice_shelves'): universe.default.exclude_iceshelf_ocean_cavities = False
    elif (self.argument == '-mesh'): universe.generatemesh = True
    elif (self.argument == '-metric'): universe.generatemetric = True
    elif (self.argument == '-el'): universe.default.elementlength = self.NextArgument()
    elif (self.argument == '-p'):
      while ((len(self.arguments) > 0) and (self.arguments[0][0] != '-')):
        universe.default.boundaries.append(int(self.NextArgument()))
    elif (self.argument == '-pn'):
      while ((len(self.arguments) > 0) and (self.arguments[0][0] != '-')):
        universe.default.boundariestoexclude.append(int(self.NextArgument()))
    elif (self.argument == '-b'):
      while ((len(self.arguments) > 0) and ((self.arguments[0][0] != '-') or ( (self.arguments[0][0] == '-') and (self.arguments[0][1].isdigit()) ))):
        self._box.append(self.NextArgument())







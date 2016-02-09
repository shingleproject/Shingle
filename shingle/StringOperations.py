#!/usr/bin/env python

##########################################################################
#  
#  Generation of boundary representation from arbitrary geophysical
#  fields and initialisation for anisotropic, unstructured meshing.
#  
#  Copyright (C) 2011-2013 Dr Adam S. Candy, adam.candy@imperial.ac.uk
#  
#  This program is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 3 of the License, or
#  (at your option) any later version.
#  
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#  
#  You should have received a copy of the GNU General Public License
#  along with this program.  If not, see <http://www.gnu.org/licenses/>.
#  
##########################################################################

def list_to_comma_separated(numbers, prefix='', add=0):
  requirecomma = False
  string = ''
  for number in numbers:
    if (requirecomma):
      string += ', '
    else:
      requirecomma = True
    string += prefix
    string += str(number + add)
  return string

def list_to_space_separated(numbers, prefix='', add=0):
  requirespace = False
  string = ''
  for number in numbers:
    if (requirespace):
      string += ' '
    else:
      requirespace = True
    string += prefix
    string += str(number + add)
  return string

def strplusone(number):
  return str(number + 1)

def expand_boxes(region, boxes):
  def error():
    print 'Error in argument for -b.'
    sys.exit(1)

  def build_function(function, requireand, axis, comparison, number):
    if (len(number) > 0):
      function = '%s%s(%s %s %s)' % (function, requireand, axis, comparison, number)
      requireand = ' and '
    return [function, requireand]

  #re.sub(pattern, repl, string,
  #((latitude >= -89.0) and (latitude <=-65.0) and (longitude >= -64.0) and (longitude <= -20.0))'
  if (len(boxes) > 0):
    function = ''
    requireor = ''
    for box in boxes:
      longlat = box.split(',')
      if (len(longlat) != 2): error()

      long = longlat[0].split(':')
      lat = longlat[1].split(':')
      if ((len(long) != 2) and (len(lat) != 2)): error()
      
      function_box = ''
      requireand = ''
      if (len(long) == 2):
        [function_box, requireand] = build_function(function_box, requireand, 'longitude', '>=', long[0])
        [function_box, requireand] = build_function(function_box, requireand, 'longitude', '<=', long[1])
      if (len(lat) == 2):
        [function_box, requireand] = build_function(function_box, requireand, 'latitude',  '>=', lat[0])
        [function_box, requireand] = build_function(function_box, requireand, 'latitude',  '<=', lat[1])

      if (len(function_box) > 0):
        function = '%s%s(%s)' % (function, requireor, function_box)
        requireor = ' or '
  
    if (len(function) > 0):
      if (region is not 'True'):
        region = '((%s) and (%s))' % (region, function)
      else:
        region = function

  return region

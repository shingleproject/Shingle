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

def list_to_space_separated_concatenate(numbers, prefix='', add=0):
    if not numbers:
        return ''
    groups = []
    group = []
    group.append(numbers[0])
    for number in numbers[1:]:
        if len(group) == 0:
            group.append(number)
        elif number == group[-1] + 1:
            group.append(number)
        elif group:
            groups.append(group)
            group = []
    if group:
        groups.append(group)
        group = []
    string = []
    for group in groups:
        if len(group) > 1:
            string.append(prefix + str(group[0] + add) + '-' + str(group[-1] + add))
        else:
            string.append(prefix + str(group[0] + add))

    return ' '.join(string)

def list_to_space_separated(numbers, prefix='', add=0, concatenate=False):
    if concatenate:
        return list_to_space_separated_concatenate(numbers, prefix=prefix, add=add)

    print numbers
    requirespace = False
    string = ''
    for number in numbers:
        if (requirespace):
            string += ' '
        else:
            requirespace = True
        string += prefix
        string += str(number + add)
    print string
    return string

def list_to_sentence(strings):
    if len(strings) == 0:
        return ''
    elif len(strings) == 1:
        return str(strings[0])
    elif len(strings) == 2:
        return ' and '.join((str(x) for x in strings))
    else:
        return ', '.join([str(x) for x in strings[:-2]] + ['']) + ' and '.join([str(x) for x in strings[-2:]])

def strplusone(number):
    return str(number + 1)

def parse_boxes(string):
    from Reporting import error

    bounds = []
    strings = string.split()
    if (len(strings) > 0):
        for s in strings:
            longlat = s.split(',')
            if (len(longlat) != 2):
                print 'longlat:', longlat
                error('Error in splitting around comma in the definition of box: ' + str(s), fatal=True)

            bound = ( [float(x) for x in longlat[0].split(':')], [float(x) for x in longlat[1].split(':')] )
            if ((len(bound[0]) != 2) and (len(bound[1]) != 2)):
                error('Error in splitting around a colon in the definition of box: ' + str(s), fatal=True)

            bounds.append(bound)

    return bounds

def expand_boxes(region, boxes):
    from Reporting import error
    def build_function(function, requireand, axis, comparison, number):
        if (len(number) > 0):
            function = '%s%s(%s %s %s)' % (function, requireand, axis, comparison, number)
            requireand = ' and '
        return [function, requireand]

    if (len(boxes) > 0):
        function = ''
        requireor = ''
        for box in boxes:
            longlat = box.split(',')
            if (len(longlat) != 2):
                print 'longlat:', longlat
                error('Error in splitting around comma in the definition of box: ' + str(box), fatal=True)

            long = longlat[0].split(':')
            lat = longlat[1].split(':')
            if ((len(long) != 2) and (len(lat) != 2)):
                print 'long:', long
                print 'lat:', lat
                error('Error in splitting around a colon in the definition of box: ' + str(box), fatal=True)

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

def bound_by_latitude(region, latitude):
    if latitude is None:
        return region
    function = 'latitude <= %s' % latitude
    if (region is not 'True'):
        region = '((%s) and (%s))' % (region, function)
    else:
        region = function
    return region


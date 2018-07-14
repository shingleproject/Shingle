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

def acc_array():
    acc = array([[   1.0, -53.0 ],
  [  10.0, -53.0 ],
  [  20.0, -52.0 ],
  [  30.0, -56.0 ],
  [  40.0, -60.0 ],
  [  50.0, -63.0 ],
  [  60.0, -64.0 ],
  [  70.0, -65.0 ],
  [  80.0, -67.0 ],
  [  90.0, -60.0 ],
  [ 100.0, -58.0 ],
  [ 110.0, -62.0 ],
  [ 120.0, -63.0 ],
  [ 130.0, -65.0 ],
  [ 140.0, -65.0 ],
  [ 150.0, -64.0 ],
  [ 160.0, -61.0 ],
  [ 170.0, -64.0 ],
  [ 179.0, -65.0 ],
  [-179.0, -65.0 ],
  [-170.0, -64.0 ],
  [-160.0, -62.0 ],
  [-150.0, -66.0 ],
  [-140.0, -58.0 ],
  [-130.0, -60.0 ],
  [-120.0, -65.0 ],
  [-110.0, -66.0 ],
  [-100.0, -70.0 ],
  [ -90.0, -70.0 ],
  [ -80.0, -77.0 ],
  [ -70.0, -72.0 ],
  [ -60.0, -60.0 ],
  [ -50.0, -57.0 ],
  [ -40.0, -51.0 ],
  [ -30.0, -50.0 ],
  [ -20.0, -60.0 ],
  [ -10.0, -56.0 ],
  [ -1.0, -53.0 ]])
    return acc


def draw_acc_old(index, boundary, dx):
    acc = acc_array()
    gmsh_comment('ACC')
    index.start = index.point + 1
    loopstartpoint = index.start
    for i in range(len(acc[:,0])):
        index.point += 1
        location = project(acc[i,:])
        gmsh_format_point(index.point, location, 0.0)

    for i in range(len(acc[:,0])):
        a = index.start + i
        b = a + 1
        if (a == index.point):
            b = index.start
        output.write('Line(%i) = {%i,%i};\n' % (i + 100000, a, b  ))
    output.write('Line Loop(999999) = { %i : %i};\n' % ( index.start, index.point ))
    return index


def draw_acc(index, boundary, dx):
    acc = acc_array()
    acc1 = acc[0:18,:]
    acc2 = acc[19:,:]
    print acc1
    print acc2
    gmsh_comment('ACC')

    index.start = index.point + 1
    loopstartpoint = index.start
    for i in range(len(acc1[:,0])):
        index.point += 1
        location = project(acc1[i,:])
        gmsh_format_point(index.point, location, 0.0)
    index = AddLoop(index, loopstartpoint, False, True, False)

    #index.start = index.point + 1
    #loopstartpoint = index.start
    for i in range(len(acc2[:,0])):
        index.point += 1
        location = project(acc2[i,:])
        gmsh_format_point(index.point, location, 0.0)
    index = AddLoop(index, loopstartpoint, True, True, False)

    return index


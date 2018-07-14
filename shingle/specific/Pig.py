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

def pig_sponge(index, indexa, indexb, a, b, dx):

    print indexa, indexb
    if indexa != 722:
        return index

    #a = array([ 256.07473195, -75.13382975 ])
    #b = array([ 258.63485727, -74.21467892 ])

    #print project([-70.2052,42.0822], type='proj_cartesian')
    if (True):
        pa = project(a, type='proj_cartesian')
        pb = project(b, type='proj_cartesian')
        pv = normalise(pb - pa)

        ppv = pv.copy()
        ppv[1] =  -pv[0]
        ppv[0] =  pv[1]


        distice = 15000
        pai = pa + distice * ppv
        pbi = pb + distice * ppv
        ai = project(pai, type='proj_cartesian_inverse')
        bi = project(pbi, type='proj_cartesian_inverse')


        dist = 30000
        pad = pai + dist * ppv
        pbd = pbi + dist * ppv

        ad = project(pad, type='proj_cartesian_inverse')
        bd = project(pbd, type='proj_cartesian_inverse')

    else:
        dist = - 0.4
        v = normalise(b - a)
        proj = v.copy()
        proj[1] = v[0]
        proj[0] = v[1]
        ad = a + dist * proj
        bd = b + dist * proj

    #index = 722

    #def AddLoop(index, loopstartpoint, last, open):

    indexstore = index

    ldx = dx / 10.0
    #ldx = 5000

    index = close_path(b, bi, index, ldx, None, proj='horizontal')
    index.point += 1
    gmsh_format_point(index.point, project(bi), 0.0)
    index = AddLoop(index, indexb, False, True, False)
    indexbi = index.point

    index = close_path(bi, ai, index, ldx, None, proj='horizontal')
    index.point += 1
    gmsh_format_point(index.point, project(ai), 0.0)
    index = AddLoop(index, indexbi, False, True, False)
    indexai = index.point

    index = close_path(ai, a, index, ldx, None, proj='horizontal')
    index = AddLoop(index, indexa, True, True, False)


    index = close_path(ai, ad, index, ldx, None, proj='horizontal')
    index.point += 1
    gmsh_format_point(index.point, project(ad), 0.0)
    gmsh_out("// Change here!  'IPG + 7420 :' -> 'IPG + 722, IPG + 7421 :'")
    index = AddLoop(index, indexai, False, True, False)
    indexad = index.point

    index = close_path(ad, bd, index, ldx, None, proj='horizontal')
    index.point += 1
    gmsh_format_point(index.point, project(bd), 0.0)
    index = AddLoop(index, indexad, False, True, False)

    index = close_path(bd, bi, index, ldx, None, proj='horizontal')
    index = AddLoop(index, indexai, False, True, False)





    gmsh_out("// To the above add ', IPG + 7366 };")
    gmsh_out('Line Loop ( ILLG + 11 ) = { IPG + 8, IPG + 9, IPG + 10, IPG + 7 };')
    gmsh_out('Plane Surface( 11 ) = { ILLG + 11 };')
    gmsh_out('Physical Surface( 11 ) = { 11 };')
    gmsh_out('// Remember to remove internal boundary!')







    return index


    #start = 7366
    #count = start
    #for i in range(100):
    #  di = (i+1) * 0.01
    #  print di
    #  a = project(a + di * dist * proj)
    #  count = count + 1
    #  gmsh_out('Point ( IPG + ' + str(count) + ' ) = { ' + str(a[0]) + ', ' + str(a[1]) + ', 0.0 };')
    #gmsh_out('Line Loop ( 1001 ) = { IPG + start : IPG + count };')
    #aend = count
    #
    #start = 7366
    #count = start
    #for i in range(100):
    #  di = (i+1) * 0.01
    #  print di
    #  a = project(a + di * dist * proj)
    #  count = count + 1
    #  gmsh_out('Point ( IPG + ' + str(count) + ' ) = { ' + str(a[0]) + ', ' + str(a[1]) + ', 0.0 };')
    #gmsh_out('Line Loop ( 1001 ) = { IPG + start : IPG + count };')
    #aend = count

    #start = count
    #for i in range(100):
    #  di = (i+1) * 0.01
    #  print di
    #  a = project(a + di * dist * proj)
    #  count = count + 1
    #  gmsh_out('Point ( IPG + ' + str(count) + ' ) = { ' + str(a[0]) + ', ' + str(a[1]) + ', 0.0 };')
    #gmsh_out('Line ( 1001 ) = { IPG + start : IPG + count };')

    #gmsh_out('Point ( IPG + 7368 ) = { ' + str(b[0]) + ', ' + str(b[1]) + ', 0.0 };')
    #gmsh_out('Line Loop ( ILLG + 6 ) = { ILG + 6, 1000 };')

    #  b = project(b + dist * proj)

    #gmsh_out('Line ( 1000 ) = { IPG + 7366, IPG + 722 };')
    #gmsh_out('Line ( 1002 ) = { IPG + 7367, IPG + 7368 };')
    #gmsh_out('Line ( 1003 ) = { IPG + 7368, IPG + 722 };')
    #gmsh_out('Line Loop ( ILLG + 7 ) = { -1000, 1001, 1002, 1003 };')


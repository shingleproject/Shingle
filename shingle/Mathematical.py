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

from math import sqrt

def norm(r):
    return sqrt(r[0]**2 + r[1]**2)

def normalise(r):
    return r/norm(r)

def smoothGaussian(list,degree,strippedXs=False):
    list = list.tolist()
    window=degree*2-1
    weight=array([1.0]*window)
    weightGauss=[]
    for i in range(window):
        i=i-degree+1
        frac=i/float(window)
        gauss=1/(exp((4*(frac))**2))
        weightGauss.append(gauss)
    weight=array(weightGauss)*weight
    smoothed=[0.0]*(len(list)-window)
    for i in range(len(smoothed)):
        smoothed[i]=sum(array(list[i:i+window])*weight)/sum(weight)
    return array(smoothed)

def area_enclosed(p):
    #origin = [min(p[:,0]), min(p[:,1])]
    #print origin
    if (False):
        pp = zeros([size(p), 2], float)
        for i in range(size(p,0)):
            # FIXME
            pp[i] = project(p[i], 'Hammer')
            print i, p[i], pp[i]
    else:
        pp = p
    return 0.5 * abs(sum(x0*y1 - x1*y0 for ((x0, y0), (x1, y1)) in segments(pp)))

def segments(p):
    return zip(p, p[1:] + [p[0]])


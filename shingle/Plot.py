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
from Reporting import report

def PlotContours(pathvalid, boxes=None):
    import sys

    modules = []
    for module in sys.modules:
        if module.startswith('matplotlib'):
            modules.append(module)
    for module in modules:
        sys.modules.pop(module)

    import matplotlib
    matplotlib.use(universe.plot_backend)

    import matplotlib.pyplot as plt
    import matplotlib.patches as patches
    import matplotlib.collections as collections
    import matplotlib.font_manager as font_manager

    report('Generating a plot of identified polylines, labelled with their ID number')

    fig = plt.figure()
    #plt.plot(lon,lat, 'g-')
    #plt.show
    #plt.imshow(lon,lat,field)

    p = [pathvalid[0].vertices, pathvalid[0].vertices]

    #bol=patches.PathPatch(paths[0])
    ax = plt.subplot(111)
    #ax.add_patch(bol, facecolor='none')
    pathcol_selected = []
    pathcol = []
    colors = []
    for p in pathvalid:
        if p._valid:
            pathcol_selected.append(p.vertices)
            colors.append('red')
        else:
            pathcol.append(p.vertices)
    col_selected = collections.LineCollection(pathcol_selected, color='blue')
    col = collections.LineCollection(pathcol, color='grey')
    ax.add_collection(col_selected, autolim=True)
    ax.add_collection(col, autolim=True)

    if boxes is not None:
        for box in boxes:
            print 'Box:', box
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

            ax.add_patch(
                patches.Rectangle((float(long[0]), float(lat[0])), float(long[1])-float(long[0]), float(lat[1])-float(lat[0]), fill=False)
            )

    font = font_manager.FontProperties(family='sans-serif', weight='normal', size=8)

    n = 0
    for p in pathvalid:
        #ax.annotate(str(num), (paths[num-1].vertices[0][0], paths[num-1].vertices[0][1]),
        #              horizontalalignment='center', verticalalignment='center')
        n += 1
        if n > 0: break
        if p._valid:
          continue
          colour_arrow = 'red'
          colour_label = 'yellow'
        else:
          colour_arrow = 'coral'
          colour_label = 'yellow'
        ax.annotate(str(p.reference_number), (p.vertices[0][0], p.vertices[0][1]),
          xytext=(-20,20), textcoords='offset points', ha='center', va='bottom',
            bbox=dict(boxstyle='round,pad=0.2', fc=colour_label, alpha=0.8),
            arrowprops=dict(arrowstyle='->', connectionstyle='arc3,rad=0.5',
          color=colour_arrow), fontproperties=font)


    for p in pathvalid:
        #ax.annotate(str(num), (paths[num-1].vertices[0][0], paths[num-1].vertices[0][1]),
        #              horizontalalignment='center', verticalalignment='center')
        n += 1
        if p._valid:
          colour_arrow = 'red'
          colour_label = 'yellow'
        else:
          continue
          colour_arrow = 'coral'
          colour_label = 'yellow'
        ax.annotate(str(p.reference_number), (p.vertices[0][0], p.vertices[0][1]),
          xytext=(-20,20), textcoords='offset points', ha='center', va='bottom',
            bbox=dict(boxstyle='round,pad=0.2', fc=colour_label, alpha=0.8),
            arrowprops=dict(arrowstyle='->', connectionstyle='arc3,rad=0.5',
          color=colour_arrow), fontproperties=font)

    ax.autoscale()
    plt.show()
    if universe.plotcontouronly:
        import sys
        sys.exit(0)


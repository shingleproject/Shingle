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

from Universe import universe
from Reporting import report



def PlotContours(paths, pathvalid):
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

  p = [paths[0].vertices, paths[0].vertices] 

  #bol=patches.PathPatch(paths[0])
  ax = plt.subplot(111)
  #ax.add_patch(bol, facecolor='none')
  pathcol = []
  for num in pathvalid: 
    pathcol.append(paths[num-1].vertices)
  col = collections.LineCollection(pathcol)
  ax.add_collection(col, autolim=True)

  font = font_manager.FontProperties(family='sans-serif', weight='normal', size=8)
  for num in pathvalid: 
    #ax.annotate(str(num), (paths[num-1].vertices[0][0], paths[num-1].vertices[0][1]),
    #              horizontalalignment='center', verticalalignment='center')
    ax.annotate(str(num), (paths[num-1].vertices[0][0], paths[num-1].vertices[0][1]),
      xytext=(-20,20), textcoords='offset points', ha='center', va='bottom',
      bbox=dict(boxstyle='round,pad=0.2', fc='yellow', alpha=0.8),
      arrowprops=dict(arrowstyle='->', connectionstyle='arc3,rad=0.5', 
      color='red'), fontproperties=font)

  ax.autoscale()
  plt.show()
  import sys
  sys.exit(0)


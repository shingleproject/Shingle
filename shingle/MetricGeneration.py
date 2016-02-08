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

class Metric(object):

  def __init__(self, output = None):
    if output == None:
      self.outputfilename = 'metric.pos'
    self.sourcefile = None
    self.fieldname = 'z'
    self.minimumdepth = 10.0
    self.outputtype='struct'
    self.metric_only=True

  def Generate(self, sourcefile, outputfilename=None, fieldname=None, minimumdepth=None, outputtype=None, metric_only=True):

    if not universe.generatemetric: return

    self.sourcefile = sourcefile
    if outputfilename is not None:
      self.outputfilename = outputfilename
    if fieldname is not None:
      self.fieldname = fieldname
    if minimumdepth is not None:
      self.minimumdepth = minimumdepth
    if outputtype is not None:
      self.outputtype = outputtype

    
    report('Generating metric...')

    globallonglat = False

    globe=True
    globe=False

    fieldname = 'z'
    fieldname = 'Band1'

    def write(string, newline=True):
      metric.write(string + '\n')

    file = NetCDF.NetCDFFile(self.sourcefile, 'r')
    print file.variables.keys()
    if 'lon' in file.variables.keys():
      lon = file.variables['lon'][:]
      lat = file.variables['lat'][:]
      globallonglat = True
    else:
      lon = file.variables['x'][:] 
      lat = file.variables['y'][:]
    field = file.variables[fieldname][:, :] 

    metric = open(outputfilename,'w')
   

    if (globe):
      field[field > - minimumdepth] = - minimumdepth
      field = - field

    if (outputtype == 'pos'):
      write('View "background_edgelength" {')
      for i in range(len(lon)):
        for j in range(len(lat)):            
          p = project([lon[i],lat[j]], type=None)
          if (p[0] == None or p[1] == None):
            continue
          write('SP(' + str(p[0]) + ', ' + str(p[0]) + ', 0.0 ){' + str(field[j][i]) + '};')
      write('};')
    elif(outputtype == 'struct'):
      if (not globe):
        #x = [ -16.0, 5 ]
        #y = [ 44.0, 66.0 ]
        x = [ 256.164, 261.587 ]
        y = [ -75.519, -74.216 ]
        
        x = [ lon[0], lon[-1] ]
        y = [ lat[-1], lat[0] ]

        write( str(x[0]) + ' ' + str(y[0]) + ' ' +  '0' )
        write( str(float(x[-1] - x[0])/len(lon)) + " " + str(float(y[-1] - y[0])/len(lat)) + ' 1')
      else: 
        if globallonglat:
          write( str( lon[0] + 180 ) + ' ' + str( lat[0] + 90 ) + ' 0' )
        else:
          write( str( lon[0] ) + ' ' + str( lat[0] ) + ' 0' )

        write( str(float(abs(lon[0])+abs(lon[-1]))/len(lon))+" "+ str(float(abs(lat[0])+abs(lat[-1]))/len(lat)) + ' 1')
      write( str(len(lon))+" "+str(len(lat))+" 1")
      for i in range(len(lon)):
        for j in range(len(lat))[::-1]:         
          write(str(field[j][i]))
          #write(str(lon[i]))

    metric.close()

    if metric_only:
      sys.exit(0)

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



def generate_mesh(infile):
  if (not universe.generatemesh):
    return
  import subprocess, re
  command = 'gmsh'
  commandfull = command + ' -2 ' + infile
  print('Mesh generation, using ' + commandfull)
  p = subprocess.Popen(commandfull , shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
  #f = open(tempfile, 'w')
  #f.write(str(p.pid))
  #f.close()
  for line in p.stdout.readlines():
    print line,
  retval = p.wait()

  outfile = re.sub(r"\.geo$", ".msh", infile)
  print('Mesh generation complete, try: ' + command + ' ' + outfile)
  print('  note, might require parsing')

def generate_mesh2(infile):
  if (not universe.generatemesh):
    return
  import subprocess, re
  command = 'gmsh'
  commandfull = command + ' -v 1 -2 ' + infile
  print('Mesh generation, using ' + commandfull)
  process = subprocess.Popen(
    commandfull, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE
  )
  while True:
    out = process.stdout.read(1)
    if out == '' and process.poll() != None:
      break
    if out != '':
      sys.stdout.write(out)
      sys.stdout.flush()
  outfile = re.sub(r"\.geo$", ".msh", infile)
  print('Mesh generation complete, try: ' + command + ' ' + outfile)
  print('  note, might require parsing')

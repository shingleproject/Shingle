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

from Universe import universe, colour


#def printv(text, include = True):
#  if (universe.verbose):
#    print text
#  if include:
#    gmsh_comment(text)

def printvv(text):
  if (universe.debug):
    print text

# def report(string, forced=False, noreturn=False, debug=False, routine=False):
#   # routine messages do not get added to consecutive reports, cauing error on multiple reports
#   if debug and not universe.debug: return
#   if (not debug and not routine):
#     # Only change report lines for non-debug messages
#     universe.reportline += 1
#     # Don't include debug messages in repo commits
#     universe.reportcache = universe.reportcache + string + os.linesep
#   if (universe.verbose or forced):
#     if logging():
#       if noreturn:
#         universe.bufferreturned = False
#       else:
#         string = string + os.linesep
#         if not universe.bufferreturned:
#           string = os.linesep + string
#           universe.bufferreturned = True
#       f = open(universe.log, 'ab')
#       # Can cause trouble!
#       f.write(string.encode('utf-8'))
#       f.close()
#     else:
#       if noreturn:
#         universe.bufferreturned = False
#         sys.stdout.write(string.encode('utf-8'))
#         sys.stdout.flush()
#       else: 
#         if not universe.bufferreturned:
#           print ''.encode('utf-8')
#           universe.bufferreturned = True
#         print string.encode('utf-8')
# 

def error(string, fatal=False):
 stringexit = ''
 if fatal:
   stringexit = ' [FATAL ERROR, exiting]'
 report("%(redbright)sERROR:%(end)s %(red)s%(string)s%(end)s%(redbright)s%(stringexit)s%(end)s", var = {'string':string, 'stringexit':stringexit}, forced=True)
 if len(universe.errors) > 0:
   universe.errors = universe.errors + os.linesep
 universe.errors = universe.errors + string + stringexit
 if fatal:
   sys.exit(1)


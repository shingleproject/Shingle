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

import os
from Universe import universe
from Reporting import error, report
from Scenario import Scenario
from Spud import libspud

class VerificationTestEngine(object):
  
  _folder = None
  _extension = None

  locations = []
  total_number = 0

  def __init__(self, folder=None, extension=None):
    if folder is None:
      self._folder = './'
    if extension is None:
      self._extension = '.shml'
    self.EnableLogging()
    self.LocateTestProblems()
    self.total_number = len(self.locations)
    self.Test()

  def LocateTestProblems(self):
    for root, dirs, files in os.walk(self._folder):
      for f in files:
        if os.path.splitext(f)[1] == self._extension:
          fullpath = os.path.join(root, f)
          self.locations.append(fullpath)
  
  def EnableLogging(self):
    universe.log_active = True
    universe.verbose = False

  def List(self):
    spacing = str(len(str(self.total_number)) + 2)

    report('%(blue)sTest problems:%(end)s %(grey)s(%(total)d in total)%(end)s', var={'total':self.total_number}, force=True) 
    for i in range(self.total_number):
      number = i + 1
      numberstr = '[%(number)d]' % {'number':number}
      location = self.locations[i]
      if location.startswith('./'): locationstr = location[2:]
      else: locationstr = location 
      report('%(number)'+spacing+'s %(location)s', var={'number':numberstr, 'location':locationstr}, force=True)

  def Test(self):
    spacing = str(len(str(self.total_number)) + 2)
    self.List()
    report('%(blue)sBeginning tests:%(end)s %(grey)s(%(total)d in total)%(end)s', var={'total':self.total_number}, force=True) 
    for i in range(self.total_number):
      number = i + 1
      numberstr = '[%(number)d]' % {'number':number}
      location = self.locations[i]
      if location.startswith('./'): locationstr = location[2:]
      else: locationstr = location 
      report('%(number)'+spacing+'s %(location)s', var={'number':numberstr, 'location':locationstr}, force=True)
      report('%(blue)sGenerating representation%(end)s%(grey)s...%(end)s', force=True, indent=1) 
      Scenario(case=location)


class VerificationTests(object):

  def __init__(self, representation, mesh=None):
    self.representation = representation
    self.mesh = mesh
    self.PerformValidationTests()

  def TestDiff(self, valid=None):
    import difflib
    from filecmp import cmp as CompareFiles

    fullpath = self.representation.scenario.PathRelative(self.representation.Output())
    if universe.legacy.legacy:
      fullvalid = fullpath.replace('legacy','legacy/valid')
    else:
      fullvalid = self.representation.scenario.PathRelative(valid)

    if not os.path.exists(fullvalid):
      error('Cannot locate valid file: ' + fullvalid)
      return False
    if not os.path.exists(fullpath):
      error('Cannot locate generated file: ' + fullpath)
      return False
  
    if CompareFiles(fullvalid, fullpath):
      return True

    file1 = open(fullvalid, 'r')
    file2 = open(fullpath, 'r')

    # Too slow even on relatively small surface representation outputs (stuck in find_longest_match):
    #diff = difflib.ndiff(file1.readlines(), file2.readlines())
    diff = difflib.Differ().compare(file1.readlines(), file2.readlines())
    #delta = ''.join(x[2:] for x in diff if x.startswith('- '))
    changes = (x for x in diff if (x.startswith('- ') or x.startswith('+ ')) and ('// Arguments:' not in x))

    total = 0
    cached = []
    for change in changes:
      total += 1
      if total > 4000:
        break
      cached.append(change)

    if total > 30:
      toshow = 20
    else:
      toshow = total

    show = True
    number = 0
    if show:
      for change in cached:
        number += 1
        if number > toshow: break
        if change.startswith('+ '):
          report('%(green)s%(change)s%(end)s', var={'change':change.strip()}, indent=2, force=True)
        elif change.startswith('- '):
          report('%(red)s%(change)s%(end)s', var={'change':change.strip()}, indent=2, force=True)
    if toshow < total:
      if total > 4000:
        totalstring = 'more than 4000'
      else:
        totalstring = str(total)
      report('%(blue)s...%(end)s %(grey)s(further differences exist (%(total)s in total), but are not shown here)%(end)s', var={'total':totalstring}, indent=2, force=True)

    file1.close()
    file2.close()
    if total == 0:
      error('File compare picked up a difference, but detailed diff showed none - potentially a difference in arguments comment line?')
    else:
      report('%(grey)svim -d %(valid)s %(new)s%(end)s', var = {'valid':fullvalid, 'new':fullpath}, indent=2, force=True)
    #State 'Over 10' on break
    #report('Total differences: %(total)s' % {'total':total}, indent=2, force=True)
      #return True
    return False


  def PerformValidationTests(self):
    #if not libspud.have_option('/verification'):
    #  return

    total = libspud.option_count('/verification/test')
    report('%(blue)sReading verification tests%(end)s %(grey)s(%(total)d in total)%(end)s', var={'total':total}, force=True, indent=1) 

    passes = 0
    for number in range(total):
      name = libspud.get_option('/verification/test[%(number)d]/name' % {'number':number})
      if name == 'BrepDescription':
        filename = libspud.get_option('/verification/test::%(name)s/file_name' % {'name':name})
        result = self.TestDiff(valid=filename)
      else:
        continue
      if result:
        passes += 1
      report('%(blue)sTest %(number)s:%(end)s %(yellow)s%(name)s%(end)s' + ResultToString(result), var={'name':name, 'number':number + 1}, force=True, indent=2) 
    # Inxclude legacy test cases
    if universe.legacy.legacy:
      passes = self.TestDiff()
      total = 1
      number = 1
    report('%(blue)sResult:%(end)s %(yellow)s%(name)s%(end)s' + ResultToString(passes == total, show_failures=True, failures=total-passes), var={'name':self.representation.scenario.Name(), 'number':number + 1, 'failures':total-passes}, force=True, indent=1) 
      

def ResultToString(result, show_failures=False, failures=None):
  if show_failures:
    if (failures is not None) and failures == 1:
      failreport = '  %(grey)s(%(failures)d failure)%(end)s'
    else:
      failreport = '  %(grey)s(%(failures)d failures)%(end)s'
  else:
    failreport = ''
  if result:
    string = '  %(brightgreen)sPASS%(end)s'
  else:
    string = '  %(brightred)sFAIL%(end)s' + failreport
  return string







#!/usr/bin/env python
# -*- coding: utf-8 -*-

##########################################################################
#  
#  Copyright (C) 2011-2016 Dr Adam S. Candy
# 
#  Shingle:  An approach and software library for the generation of
#            boundary representation from arbitrary geophysical fields
#            and initialisation for anisotropic, unstructured meshing.
# 
#            Web: https://www.shingleproject.org
#
#            Contact: Dr Adam S. Candy, contact@shingleproject.org
#
#  This file is part of the Shingle project.
#  
#  Shingle is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 3 of the License, or
#  (at your option) any later version.
#  
#  Shingle is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#  
#  You should have received a copy of the GNU General Public License
#  along with Shingle.  If not, see <http://www.gnu.org/licenses/>.
#
##########################################################################

import os
from Universe import universe
from Reporting import error, report
from SpatialDiscretisation import SpatialDiscretisation
from Spud import specification
from Support import SourceTestFolder

def isTesting():
    return universe.testfolder is not None

class VerificationTestEngine(object):

    _default_extension = '.brml'

    def __init__(self, extension=None, locate_only=False, test_folder=None):
        self._folder = None
        self._extension = None
        self.locations = []
        self.skipped = []
        self.names = None
        self.numbers = None
        self.total_number = 0
        self.passes = []
        self.failures = []
        if test_folder is not None:
            self._folder = test_folder
        elif universe.testfolder is not None:
            self._folder = universe.testfolder
        else:
            self._folder = SourceTestFolder()
        if self._folder is None:
            self._folder = './'
        if extension is None:
            self._extension = self._default_extension
        self.LocateTestProblems()
        if locate_only:
            return
        self.GetNames()

        report('%(blue)sVerification test engine%(end)s%(grey)s, tests located in directory: %(folder)s%(end)s', var={'folder':self._folder}, test=True) 
        self.EnableLogging()
        self.Test()
        self.Summary()

    def Stat(self):
        return len(self.failures) == 0

    def GetLocations(self):
        return self.locations

    def Summary(self):
        pass_number = len(self.passes) 
        fail_number = len(self.failures) 
        total = pass_number + fail_number
        if fail_number == 0:
            report('%(brightgreen)sPASS%(end)s  %(grey)s(%(total)d in total)%(end)s', var = {'total':total}, test=True)
        else:
            report('%(brightred)sFAIL%(end)s  %(pass)d of %(total)d verification tests passed', var = {'pass':pass_number, 'total':total}, test=True)
            report('Failures', test=True)
            for failure in self.failures:
                report(failure, indent=1, test=True)

    def GetTags(self, filename):
        s = SpatialDiscretisation(case=filename, load_only=True)
        return s.tags

    def LocateTestProblems(self):
        for root, dirs, files in os.walk(self._folder):
            for f in files:
                if os.path.splitext(f)[1] == self._extension:
                    fullpath = os.path.join(root, f)
                    # TODO: Skip if excluded
                    # TODO: Impement tags
                    if os.path.exists(os.path.join(os.path.dirname(fullpath), 'skip')):
                        self.skipped.append(fullpath)
                        continue
                    if 'development' in self.GetTags(fullpath):
                        self.skipped.append(fullpath)
                        continue
                    if len(universe.tags) > 0:
                        include = False
                        for tag in self.GetTags(fullpath):
                            if tag in universe.tags:
                                include = True
                                break
                        if not include:
                            self.skipped.append(fullpath)
                            continue
                    self.locations.append(fullpath)
        self.total_number = len(self.locations)

    def Locate(self, name):
        locations = []
        for location in self.locations:
            full_name = name + self._extension
            if location.endswith(full_name):
                locations.append(location)
        # A less constained search
        if len(locations) == 0:
            import os
            name_base, name_ext = os.path.splitext(name)
            for location in self.locations:
                base, ext = os.path.splitext(location)
                base_end = os.path.split(base)[-1]
                if base_end == name_base:
                    locations.append(location)
        # A further less constained search
        if len(locations) == 0:
            name_base, name_ext = os.path.splitext(name)
            for location in self.locations:
                base, ext = os.path.splitext(location)
                base_dir = os.path.split(base)[-2]
                if base_dir == name_base:
                    locations.append(location)
        # A loose search
        if len(locations) == 0:
            for location in self.locations:
                if name in location:
                    locations.append(location)
        if len(locations) == 1:
            return locations[0]
        elif len(locations) == 0:
            report('Unable to locate case with name: %(name)s' % {'name':name})
        else:
            report("Multiple cases found with name '%(name)s':", var = {'name':name})
            for location in locations:
                report('%(location)s', var = {'location':location}, indent = 1)
            report('Unable to locate a unique case with name: %(name)s' % {'name':name})
        return None

    def EnableLogging(self):
        universe.log_active = True
        universe.verbose = False

    def GetNames(self, number=None):
        if self.names is None:
            names = []
            numbers = []
            for i in range(self.total_number):
                s = SpatialDiscretisation(case=self.locations[i], load_only=True)
                names.append(s.Name())
                numbers.append(s.verification.number)
            self.names = names
            self.numbers = numbers
        if number is None:
            return self.names
        else:
            if number + 1 <= len(self.names):
                return self.names[number]
            else:
                return '[Not found]'

    def List(self):
        spacing = str(len(str(self.total_number)) + 2)

        report('%(blue)sVerification test problems:%(end)s %(grey)s(%(total)d in total)%(end)s', var={'total':self.total_number}, test=True) 
        for i in range(self.total_number):
            number = i + 1
            numberstr = '[%(number)d]' % {'number':number}
            location = self.locations[i]
            if location.startswith('./'):
                locationstr = location[2:]
            else:
                locationstr = location 
            report('%(number)'+spacing+'s %(location)s %(yellow)s%(name)s%(end)s %(grey)s(%(test_number)s)%(end)s', var={'number':numberstr, 'location':locationstr, 'name':self.GetNames()[i], 'test_number':self.numbers[i]}, test=True)
            if self.numbers[i] == 0:
                error('Case has no validation tests defined.', warning=True)
        if len(self.skipped) > 0:
            spacing = str(len(str(len(self.skipped))) + 2)
            report('%(red)sSkipped cases:%(end)s', test=True)
            for i in range(len(self.skipped)):
                number = i + 1
                numberstr = '[%(number)d]' % {'number':number}
                location = self.skipped[i]
                if location.startswith('./'):
                    locationstr = location[2:]
                else:
                    locationstr = location 
                report('%(red)s%(number)'+spacing+'s%(end)s %(location)s', var={'number':numberstr, 'location':locationstr}, test=True, indent=1)

    def CheckForDuplicates(self):
        from StringOperations import list_to_sentence
        not_unique = {}
        for name in self.GetNames():
            indexes = [ i + 1 for i,x in enumerate(self.GetNames()) if x == name ]
            if len(indexes) > 1:
                if name in not_unique.keys():
                    if not_unique[name] != indexes:
                        error('Problem with duplicate names in test files.  Should never reach this point!', fatal=True)
                not_unique[name] = indexes
        if len(not_unique) > 0:
            for name in not_unique.keys():
                report('%(blue)sProject name %(yellow)s%(name)s%(end)s %(blue)sis not unique, appears in:%(end)s %(yellow)s%(indexes)s%(end)s', var = { 'name':name, 'indexes':list_to_sentence(not_unique[name])}, test=True)
            error('Duplicate project names identified in specifications sent to the test engine.', fatal=True)

    def Test(self):
        from copy import deepcopy
        spacing = str(len(str(self.total_number)) + 2)
        self.List()
        self.CheckForDuplicates()
        report('%(blue)sBeginning verification cases:%(end)s %(grey)s(%(total)d cases and %(tests)s tests in total)%(end)s', var={'total':self.total_number, 'tests':sum(self.numbers)}, test=True) 
        for i in range(self.total_number):
            number = i + 1
            numberstr = '[%(number)d]' % {'number':number}
            location = self.locations[i]
            if location.startswith('./'):
                locationstr = location[2:]
            else:
                locationstr = location 
            report('%(number)'+spacing+'s %(location)s', var={'number':numberstr, 'location':locationstr}, test=True)
            if specification.have_option('/geoid_mesh/generate') or universe.generate_mesh:
                report('%(blue)sGenerating surface geoid representation and discretising%(end)s%(grey)s%(end)s', test=True, indent=1) 
            else:
                report('%(blue)sGenerating surface geoid representation%(end)s%(grey)s%(end)s', test=True, indent=1) 

            # If updating, only run test if needed
            #s = SpatialDiscretisation(case=location, load_only=True)
            #if not (universe.verification_update and os.path.exists(s.PathRelative(s.Output()))):
            
            s = SpatialDiscretisation(case=location)

            name = deepcopy(s.Name())
            if s.verification.result:
                self.passes.append(name)
            else:
                self.failures.append(name)


class VerificationTests(object):

    def __init__(self, representation=None, mesh=None, load_only=False):
        self.result = None
        self.mesh = mesh
        self.number = None
        self.GetTestNumber()
        if load_only:
            return
        self.representation = representation
        self.PerformValidationTests()

    def NodeNumber(self):
        name = 'NodeNumber'
        path = '/validation/test::%(name)s' % {'name':name}
        if specification.have_option('%(path)s/value' % {'path':path}):
            value = specification.get_option('%(path)s/value' % {'path':path})
            tolerance = 0
            if specification.have_option('%(path)s/value/tolerance' % {'path':path}):
                tolerance = specification.get_option('%(path)s/value/tolerance' % {'path':path})
            if ( self.mesh.NodeNumber() > value + tolerance ) or ( self.mesh.NodeNumber() < value - tolerance ):
                report('Node number %(number)d out of bounds of %(value)d with tolerance %(tolerance)d' % {'number':self.mesh.NodeNumber(), 'value':value, 'tolerance':tolerance}, indent=3)
                return False
            return True

        elif specification.have_option('%(path)s/range' % {'path':path}):
            if specification.have_option('%(path)s/value/minimum' % {'path':path}):
                minimum = specification.get_option('%(path)s/minimum' % {'path':path})
                if self.mesh.NodeNumber() < minimum:
                    report('Node number %(number)d less than minimum %(minimum)d' % {'number':self.mesh.NodeNumber(), 'minimum':minimum}, indent=3)
                    return False
            if specification.have_option('%(path)s/value/maximum' % {'path':path}):
                minimum = specification.get_option('%(path)s/maximum' % {'path':path})
                if self.mesh.NodeNumber() > maximum:
                    report('Node number %(number)d greater than maximum %(maximum)d' % {'number':self.mesh.NodeNumber(), 'maximum':maximum}, indent=3)
                    return False
            return True
        else:
            error('Verification test %(name)s is not configured correctly.' % {'name':name})
        return False

    def ElementNumber(self):
        name = 'ElementNumber'
        path = '/validation/test::%(name)s' % {'name':name}
        if specification.have_option('%(path)s/value' % {'path':path}):
            value = specification.get_option('%(path)s/value' % {'path':path})
            tolerance = 0
            if specification.have_option('%(path)s/value/tolerance' % {'path':path}):
                tolerance = specification.get_option('%(path)s/value/tolerance' % {'path':path})
            if ( self.mesh.ElementNumber() > value + tolerance ) or ( self.mesh.ElementNumber() < value - tolerance ):
                report('Element number %(number)d out of bounds of %(value)d with tolerance %(tolerance)d' % {'number':self.mesh.ElementNumber(), 'value':value, 'tolerance':tolerance}, indent=3)
                return False
            return True

        elif specification.have_option('%(path)s/range' % {'path':path}):
            if specification.have_option('%(path)s/value/minimum' % {'path':path}):
                minimum = specification.get_option('%(path)s/minimum' % {'path':path})
                if self.mesh.ElementNumber() < minimum:
                    report('Element number %(number)d less than minimum %(minimum)d' % {'number':self.mesh.ElementNumber(), 'minimum':minimum}, indent=3)
                    return False
            if specification.have_option('%(path)s/value/maximum' % {'path':path}):
                minimum = specification.get_option('%(path)s/maximum' % {'path':path})
                if self.mesh.ElementNumber() > maximum:
                    report('Element number %(number)d greater than maximum %(maximum)d' % {'number':self.mesh.ElementNumber(), 'maximum':maximum}, indent=3)
                    return False
            return True
        else:
            error('Verification test %(name)s is not configured correctly.' % {'name':name})
        return False

    def TestDiff(self):
        import difflib
        from filecmp import cmp as CompareFiles

        def include_diff_line(string):
            if not (string.startswith('- ') or string.startswith('+ ')):
                return False
            if '// Arguments: ' in string:
                return False
            if '// Created at: ' in string:
                return False
            if '// Created by: ' in string:
                return False
            if '// Version: ' in string:
                return False
            if 'Mesh tool version: ' in string:
                return False
            if '.FileName = ' in string:
                return False
            return True

        def ReadNextLines(filehandle, number):
            lines = []
            for i in range(number):
                line = filehandle.readline()
                if not line: return lines
                lines.append(line)
            return lines

        def FilterPointFloats(cached):
            import re
            def isSameLocation(a, b, tolerance=1E-5):
                #print [ abs(float(a[0]) - float(b[0])), abs(float(a[1]) - float(b[1])), abs(float(a[2]) - float(b[2])) ]
                return [ abs(float(a[0]) - float(b[0])), abs(float(a[1]) - float(b[1])), abs(float(a[2]) - float(b[2])) ] < [tolerance] * 3
        
            additions = {}
            removals = {}
            # Matches point number, x, y, z
            point_pattern = re.compile('^[-+] Point \( (\d+) \) = { (-*\d+.*\d+), (-*\d+.*\d+), (-*\d+.*\d+) }; *$')
            for i, line in enumerate(cached):
                #print i, line
                if line.startswith('+ Point '):
                    found = point_pattern.match(line)
                    if not found:
                        return cached
                    additions[found.group(1)] = found.group(2,3,4)
                elif line.startswith('- Point '):
                    found = point_pattern.match(line)
                    if not found:
                        return cached
                    removals[found.group(1)] = found.group(2,3,4)
                #else 
                #    return cached
        
            #print 'Removals: ', removals.keys()
            #print 'Additions:', additions.keys()
            same = []
            for identification in removals.keys():
                if identification not in additions.keys():
                    continue
                #    return cached
                if isSameLocation(removals[identification], additions[identification]):
                    same.append(identification)
        
            if len(same) == 0:
                return cached
            
            #print 'Same:', same
            new = []
            for line in cached:
                if line.startswith('+ Point ') or line.startswith('- Point '):
                    found = point_pattern.match(line)
                    if found.group(1) in same:
                        continue
                        new.append(line)
            return new

        def SystemDiff(a, b):
            from Support import Execute
            #cmd = ['diff', '-u', '--suppress-common-lines', fullvalid, fullpath ]
# diff \
#    --old-line-format='-%l
# ' \
#    --new-line-format='+%l
# ' \
#    --unchanged-line-format='' \
# /Users/acandy/src/Shingle/test/Amundsen_Sea/Amundsen_Sea.geo /Users/acandy/src/Shingle/test/Amundsen_Sea/data/Amundsen_Sea_valid.geo 
            cmd = ['diff', '--old-line-format=- %l'+os.linesep, '--new-line-format=+ %l'+os.linesep, '--unchanged-line-format=', fullvalid, fullpath ]

            diff = Execute(cmd, wait=False)
            return diff.stdout

        use_system_diff = True
        compare_floating_values = True

        name = 'BrepDescription'
        path = '/validation/test::%(name)s' % {'name':name}
        valid = specification.get_option('%(path)s/file_name' % {'path':path})
        compressed = specification.have_option('%(path)s/compressed' % {'path':path})

        fullpath = self.representation.spatial_discretisation.PathRelative(self.representation.Output())
        if universe.legacy.legacy:
            fullvalid = fullpath.replace('legacy','legacy/valid')
        else:
            fullvalid = self.representation.spatial_discretisation.PathRelative(valid)

        if not os.path.exists(fullpath):
            error('Cannot locate generated file: ' + fullpath)
            return False

        def update(fullpath, fullvalid, compressed):
            report('%(blue)sUpdating valid boundary representation file:%(end)s%(yellow)s%(valid)s%(end)s', var = {'valid':fullvalid}, test=True, indent=1) 
            f = open(fullpath, 'r')
            content = f.read()
            f.close()
            if compressed:
                import bz2
                content = bz2.compress(content)
            f = open(fullvalid, 'w')
            f.write(content)
            f.close()

        if universe.verification_update:
            update(fullpath, fullvalid, compressed)

        if not os.path.exists(fullvalid):
            error('Cannot locate valid file: ' + fullvalid)
            return False

        # Could decompress in memory - for now decompress whole file
        if compressed:
            fullvalid_compressed = fullvalid
            #fullvalid = fullvalid_compressed.replace('.bz2$', '')
            fullvalid, ext = os.path.splitext(fullvalid_compressed)
            if ext != '.bz2':
                error('Reference file should be compressed with bz2 compression and end with the extension .bz2. No other compression or file format currently supported.')
            if fullvalid == fullvalid_compressed:
                error('Decompressed file name is the same as the compressed file', fatal=True)
            with open(fullvalid_compressed) as f:
                data = f.read()
            import bz2
            f = open(fullvalid, 'w')
            f.write(bz2.decompress(data))
            f.close()

        if not os.path.exists(fullvalid):
            error('Cannot locate valid file: ' + fullvalid)
            return False

        if use_system_diff:
            diff = SystemDiff(fullvalid, fullpath)
        else:
            file1 = open(fullvalid, 'r')
            file2 = open(fullpath, 'r')

        total_toshow = 40
        chunk = 100
        total = 0
        cached = []
        while True:
            if use_system_diff:
                #cached = diff.splitlines()[2:]
                cached = [x for x in diff.splitlines()[2:] if include_diff_line(x)]
                total = len(cached)
                break
            else:
                a = ReadNextLines(file1, chunk)
                b = ReadNextLines(file2, chunk)

                if len(a) == 0 or len(b) == 0: break

                # Too slow even on relatively small surface representation outputs (stuck in find_longest_match):
                #diff = difflib.ndiff(file1.readlines(), file2.readlines())
                diff = difflib.Differ().compare(a, b)
                #delta = ''.join(x[2:] for x in diff if x.startswith('- '))
                #changes = (x for x in diff if (x.startswith('- ') or x.startswith('+ ')) and ('// Arguments:' not in x))
                changes = [x for x in diff if include_diff_line(x)]

                cached = cached + changes
                total = total + len(changes)

                if total > 4000:
                    break

        if compare_floating_values:
            if use_system_diff:
                cached = FilterPointFloats(cached)
                total = len(cached)
            else:
                error('If using custom diff, can not currently ensure all chnanges are compared since the routines are limited to a number of lines dus to time required.')
                raise NotImplementedError

        if total > total_toshow:
            toshow = total_toshow - 10
        else:
            toshow = total

        show = True
        number = 0
        if show:
            for change in cached:
                if number > toshow: break
                if not include_diff_line(change):
                    continue
                if change.startswith('+ '):
                    report('%(green)s%(change)s%(end)s', var={'change':change.strip()}, indent=2, test=True)
                    number += 1
                elif change.startswith('- '):
                    report('%(red)s%(change)s%(end)s', var={'change':change.strip()}, indent=2, test=True)
                    number += 1
        if toshow < total:
            if total > 100:
                totalstring = 'more than 100'
            else:
                totalstring = str(total)
            report('%(red)s... further differences exist%(grey)s, %(total)s in total, not shown here%(end)s', var={'total':totalstring}, indent=2, test=True)

        if not use_system_diff:
            file1.close()
            file2.close()
        if total == 0:
            return True
        #  error('File compare picked up a difference, but detailed diff showed none - potentially a difference in arguments comment line?')
        else:
            report('%(grey)svim -d %(valid)s %(new)s%(end)s', var = {'valid':fullvalid, 'new':fullpath}, indent=2, test=True)
            report('%(grey)sUpdate with: cat %(new)s > %(valid)s%(end)s', var = {'valid':fullvalid, 'new':fullpath}, indent=2, test=True)
        #State 'Over 10' on break
        #report('Total differences: %(total)s' % {'total':total}, indent=2, test=True)
            #return True
        return False

    def GetTestNumber(self):
        if self.number is None:
            self.number = specification.option_count('/validation/test')
        return self.number

    def PerformValidationTests(self):
        #if not specification.have_option('/validation'):
        #  return

        total = self.GetTestNumber()
        if total == 0:
            return True
        report('%(blue)sReading validation tests%(end)s %(grey)s(%(total)d in total)%(end)s', var={'total':total}, test=True, indent=1) 

        passes = 0
        number = 0
        for number in range(total):
            name = specification.get_option('/validation/test[%(number)d]/name' % {'number':number})
            if name == 'BrepDescription':
                result = self.TestDiff()
            elif name == 'NodeNumber':
                result = self.NodeNumber()
            elif name == 'ElementNumber':
                result = self.ElementNumber()
            else:
                continue
            if result:
                passes += 1
            report('%(blue)sTest %(number)s:%(end)s %(yellow)s%(name)s%(end)s' + ResultToString(result), var={'name':name, 'number':number + 1}, test=True, indent=2) 

        # Include legacy test cases
        if universe.legacy.legacy:
            passes = self.TestDiff()
            total = 1
            number = 1
        self.result = passes == total
        report('%(blue)sResult:%(end)s %(yellow)s%(name)s%(end)s' + ResultToString(passes == total, total = total, show_failures=True, failures=total-passes), var={'name':self.representation.spatial_discretisation.Name(), 'number':number + 1, 'passes':passes, 'failures':total-passes}, test=True, indent=1) 


def ResultToString(result, total=None, show_failures=False, failures=None):
    if total is not None and failures is not None:
        passes = total - failures
    if total is not None:
        if total == 0:
            string = '  %(brightred)sNO VERFICATION TESTS DEFINED%(end)s'
            return string
    if show_failures:
        if failures is not None:
            if failures == 0:
                failreport = '  %(grey)s(%(passes)d)%(end)s'
            elif failures == 1:
                failreport = '  %(grey)s(%(failures)d failure)%(end)s'
            else:
                failreport = '  %(grey)s(%(failures)d failures)%(end)s'
    else:
        failreport = ''
    if result:
        string = '  %(brightgreen)sPASS%(end)s' + failreport
    else:
        string = '  %(brightred)sFAIL%(end)s' + failreport
    return string


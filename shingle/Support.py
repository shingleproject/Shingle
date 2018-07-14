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

import os
from Universe import universe
from Reporting import report, error
from StringOperations import expand_boxes
from Usage import usage
from urllib2 import urlopen

from os import devnull
DEVNULL = open(devnull, 'wb')

class Execute(object):

    def __init__(self, command, stat=False, background=False, wait=True, env=None, shell=False, cwd=None, debug=False):
        # Options
        self.command = command
        self.shell = shell
        self.debug = debug or universe.debug
        self.env = env
        self.background = False
        self.wait = wait
        self.cwd = cwd

        # Output
        self.stdout = None
        self.stderr = None
        self.returncode = None

        self._process()

    def _process(self):
        from subprocess import Popen, PIPE
        from Support import DEVNULL
        if self.debug:
            report('Executing: ' + (' '.join(self.command)).replace('%', '%%'))
        s = Popen(self.command, stderr=PIPE, stdout=PIPE, env=self.env, cwd=self.cwd, shell=self.shell)
        if self.wait:
            s.wait()
        if self.background:
            return ''
        self.returncode = s.returncode
        self.stdout, self.stderr = s.communicate()
        if self.debug:
            report('return code: %(num)s', var={'num':self.returncode}, indent=1)
            report('stderr: %(stderr)s', var={'stderr':self.stderr}, indent=1)
            report('stdout: %(stdout)s', var={'stdout':self.stdout}, indent=1)

def RepositoryVersion(full=False, parenthesis=False, not_available_note=True):
    #from Version import version
    import Version
    shingle_path = os.path.realpath(os.path.join(os.path.realpath(os.path.dirname(os.path.realpath(__file__))), os.path.pardir))
    if full:
        suffix = []
    else:
        suffix = ['--abbrev=0']
    describe = Execute(['git', 'describe'] + suffix, cwd=shingle_path)
    version = describe.stdout.strip()
    if describe.returncode != 0 or len(version) == 0:
        if not_available_note:
            version = Version.version
            #version = '[Not available]'
        else:
            version = ''
    if len(version) > 0 and parenthesis:
        version = '(' + version + ')'
    return version

def Filesize(nbytes, decimal_places = 0):
  suffixes = ['B', 'KB', 'MB', 'GB', 'TB', 'PB']
  from math import log10
  if nbytes == 0:
    return 'OB'
  rank = int((log10(nbytes)) / 3)
  rank = min(rank, len(suffixes) - 1)
  human = nbytes / (1024.0 ** rank)
  f = (('%.'+str(decimal_places)+'f') % human)
  if '.' in f:
    f = f.rstrip('0').rstrip('.')
  return '%s%s' % (f, suffixes[rank])

def RetrieveDatafileSize(url, human=False):
    size = int(urlopen(url).info().getheaders("Content-Length")[0])
    if human:
        return Filesize(size)
    else:
        return size

def RetrieveDatafile(url, filename):
    base, ext = os.path.splitext(filename)
    temp = base + '_temp' + ext
    u = urlopen(url)
    size = RetrieveDatafileSize(url)
    f = open(temp, 'wb')
    retrieved = 0
    chunk = 8192
    while True:
        buffer = u.read(chunk)
        if not buffer:
            break
        f.write(buffer)
        retrieved += len(buffer)
    f.close()
    if size == retrieved:
        os.rename(temp, filename)
        return True
    else:
        os.remove(temp)
        return False

def Timestamp():
    from datetime import datetime
    return datetime.now().strftime('%Y/%m/%d %H:%M:%S %Z')

def execute_simple(cmd, stat=False, background=False, env=None, shell=False, debug=False):
    from subprocess import Popen, PIPE
    from Support import DEVNULL
    if debug:
        report('Executing: ' + ' '.join(cmd))
    s = Popen(cmd, stderr=PIPE, stdout=PIPE, env=env, shell=shell)
    s.wait()
    if background:
        return ''
    if stat:
        return s.returncode, s.communicate()
    else:
        return s.communicate()[0]

def ExecuteStage(stage):
    if universe.stages is None:
        return True
    if stage in universe.stages:
        return True
    return False

def FilenameAddExtension(path, extension):
    base, extension_existing = os.path.splitext(path)
    path = base + '.' + extension
    return path

def PathFull(path):
    if path.startswith('/'):
        return path
    if path.startswith('~'):
        return path
    return os.path.realpath(os.path.join(universe.root, path))

def SourceTestFolder():
    return os.path.realpath(os.path.join(os.path.realpath(os.path.dirname(os.path.realpath(__file__))), os.path.pardir, 'test'))

class ReadArguments(object):

    def __init__(self):
        self._stage = None
        self._box = []
        from sys import argv
        self.arguments = argv[1:]
        self.argument = None
        self.legacy = False
        self.saveCall()
        self.Read()

    def saveCall(self):
        call = ''
        for argument in self.arguments:
            if ' ' in argument:
                call = call + ' \'' + argument + '\''
            else:
                call = call + ' ' + argument
        universe.call = call

    def NextArgument(self):
        return self.arguments.pop(0).rstrip()

    def Read(self):
        from Universe import universe
        free_arguments = []
        help_request = False
        while (len(self.arguments) > 0):
            self.argument = self.NextArgument()
            if   (self.argument == '-h'): help_request = True
            elif (self.argument == '-v'): universe.verbose = True
            elif (self.argument == '--debug'): universe.verbose = True; universe.debug = True;
            elif (self.argument == '-q'): universe.verbose = False
            elif (self.argument == '-t'):
                if ((len(self.arguments) > 0) and (self.arguments[0][0] != '-')):
                    universe.testfolder = self.NextArgument()
                else:
                    universe.testfolder = SourceTestFolder()
            elif (self.argument == '-l'):
                universe.log_active = True
                if ((len(self.arguments) > 0) and (self.arguments[0][0] != '-')):
                    universe.logfilename = self.NextArgument()

            elif (self.argument == '--tag'): universe.tags.append(self.NextArgument())
            elif (self.argument == '-c'): universe.cache = True
            elif (self.argument == '--plot'): universe.plotcontour = True; universe.plotcontouronly = True
            elif (self.argument == '--image'): universe.generate_mesh_image = True
            elif (self.argument == '--update'): universe.verification_update = True
            elif (self.argument == '--mesh'): universe.generate_mesh = True
            elif (self.argument == '--pickup'): universe.pickup = True
            elif (self.argument == '--stage'): self._stage = self.NextArgument()

            elif (self.argument == '--legacy'): self.legacy = True; universe.legacy.legacy = True; report('Including legacy command line options')
            elif self.legacy:
                self.ReadLegacy()
            else:
                free_arguments.append(self.argument)

        if help_request:
            usage()

        if len(free_arguments) > 0:
            universe.optiontreesource = free_arguments[0]
        if len(free_arguments) > 1:
           error('More than one source BRML specified, working on only the first.', warning=True)

        universe.default.region = expand_boxes(universe.default.region, self._box)

        # Argument sanity check
        if self._stage is not None:
            if self._stage not in universe._all_stages:
                error('Stage %(stage)s not recognised' % {'stage':self._stage}, fatal=True)
            universe.stages = []
            for stage in universe._all_stages:
                universe.stages.append(stage)
                if self._stage == stage:
                    break


    def ReadLegacy(self):
        from Universe import universe
        if not self.legacy: return
        if (self.argument == '-n'): universe.legacy.source  = self.NextArgument();
        elif (self.argument == '-f'): universe.legacy.output = self.NextArgument();
        elif (self.argument == '-t'): universe.default.contourtype = self.NextArgument()
        elif (self.argument == '-r'): universe.default.region = self.NextArgument()
        elif (self.argument == '-m'): universe.default.projection = self.NextArgument()
        elif (self.argument == '-dx'): universe.default.dx = float(self.NextArgument())
        elif (self.argument == '-lat'): universe.default.extendtolatitude = float(self.NextArgument()); universe.default.closewithparallels = True
        elif (self.argument == '-a'): universe.default.minarea = float(self.NextArgument())
        elif (self.argument == '-bounding_latitude'): universe.default.bounding_lat =float(self.NextArgument())
        elif (self.argument == '-bl'): universe.default.bounding_lat = float(self.NextArgument())
        elif (self.argument == '-smooth_data'):
            universe.default.smooth_degree = int(self.NextArgument())
            universe.default.smooth_data = True
        elif (self.argument == '-no'): universe.default.open = False
        elif (self.argument == '-exclude_ice_shelves'): universe.default.exclude_iceshelf_ocean_cavities = True
        elif (self.argument == '-metric'): universe.generatemetric = True
        elif (self.argument == '-el'): universe.default.elementlength = self.NextArgument()
        elif (self.argument == '-p'):
            while ((len(self.arguments) > 0) and (self.arguments[0][0] != '-')):
                universe.default.boundaries.append(int(self.NextArgument()))
        elif (self.argument == '-pn'):
            while ((len(self.arguments) > 0) and (self.arguments[0][0] != '-')):
                universe.default.boundariestoexclude.append(int(self.NextArgument()))
        elif (self.argument == '-b'):
            while ((len(self.arguments) > 0) and ((self.arguments[0][0] != '-') or ( (self.arguments[0][0] == '-') and (self.arguments[0][1].isdigit()) ))):
                self._box.append(self.NextArgument())


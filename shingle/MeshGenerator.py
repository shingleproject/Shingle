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
from Support import ExecuteStage
from Reporting import report, error
from Spud import specification



from threading import Thread
from Queue import Queue, Empty

class NonBlockingStreamReader:

    def __init__(self, stream):
        '''
        stream: the stream to read from.
                Usually a process' stdout or stderr.
        '''

        self._s = stream
        self._q = Queue()

        def _populateQueue(stream, queue):
            '''
            Collect lines from 'stream' and put them in 'quque'.
            '''

            while True:
                line = stream.readline()
                if line:
                    queue.put(line)
                else:
                    break
                    #pass
                    #raise UnexpectedEndOfStream

        self._t = Thread(target = _populateQueue, args = (self._s, self._q))
        self._t.daemon = True
        self._t.start() #start collecting lines from the stream

    def readline(self, timeout = None):
        try:
            return self._q.get(block = timeout is not None, timeout = timeout)
        except Empty:
            return None

    def isAlive(self):
        return self._t.isAlive()

#class UnexpectedEndOfStream(Exception): pass


def trim_image_file(filename):
    from PIL import Image, ImageChops, ImageOps

    def trim_image(im):
        bg = Image.new(im.mode, im.size, im.getpixel((0,0)))
        diff = ImageChops.difference(im, bg)
        diff = ImageChops.add(diff, diff, 2.0, -100)
        bbox = diff.getbbox()
        if bbox:
            return im.crop(bbox)

    def border_image(im, border=4):
        return ImageOps.expand(im, border=border, fill='white')

    im = Image.open(filename)
    im = trim_image(im)
    im = border_image(im)
    if im is not None:
        im.save(filename)




def ttrim_image(filename):
    from PIL import Image, ImageChops
    im = Image.open(filename)
    bg = Image.new(im.mode, im.size, im.getpixel((0,0)))
    diff = ImageChops.difference(im, bg)
    diff = ImageChops.add(diff, diff, 2.0, -100)
    bbox = diff.getbbox()
    if bbox:
        im.crop(bbox)
        if im is not None:
            im.save(filename+'__.png')
            report('Image saved: %(filename)s', var = {'filename':filename})

class MeshGenerator(object):

    _representation_extension_type = '.geo'
    _mesh_extension_type = '.msh'
    _image_extension_type = '.png'
    _executable = 'gmsh'

    def __init__(self, representation = None, interactive = True):
        self._generated = False
        self.source = None
        self.output = None
        self.image = None
        self._process = None

        self.representation = representation
        self.interactive = interactive
        # Output file name not implemented yet
        # Check if request to output mesh?  and image
        if self.representation is None:
            return
        if not self.representation.isGenerated():
            return
        if specification.have_option('/geoid_mesh/generate') or universe.generate_mesh:
            self.Generate()
        if specification.have_option('/geoid_mesh/generate_image') or universe.generate_mesh_image:
            self.GenerateImage()

    def Version(self):
        from Support import Execute
        s = Execute(['gmsh', '--version'])
        version = s.stderr.splitlines()[-1].strip()
        if s.returncode != 0 or len(version) == 0:
            version = '[Not available]'
        return version

    def Source(self):
        if self.source is None:
            self.source = self.representation.spatial_discretisation.PathRelative(self.representation.Output())
        return self.source

    def OutputBinary(self):
        if specification.have_option('/geoid_mesh/library::Gmsh/binary'):
            return True
        else:
            return universe.default.output_mesh_binary

    def Output(self):
        if self.output is None:
            if specification.have_option('/geoid_mesh/generate/file_name'):
                filename = specification.get_option('/geoid_mesh/generate/file_name')
            else:
                import os
                brep_filename = self.representation.Output()
                filename = os.path.splitext(brep_filename)[0] + self._mesh_extension_type
            self.output = self.representation.spatial_discretisation.PathRelative(filename)
        return self.output

    def OutputImageFilename(self):
        if self.image is None:
            if specification.have_option('/geoid_mesh/generate_image/file_name'):
                filename = specification.get_option('/geoid_mesh/generate_image/file_name')
            else:
                import os
                brep_filename = self.representation.Output()
                filename = os.path.splitext(brep_filename)[0] + self._image_extension_type
            self.image = self.representation.spatial_discretisation.PathRelative(filename)
        return self.image

    def OutputExists(self):
        from os.path import exists
        return exists(self.Output())

    def OutputImageExists(self):
        from os.path import exists
        return exists(self.OutputImageFilename())

    def NodeNumber(self):
        # Count nodes
        return None

    def ElementNumber(self):
        # Count element
        return None

    def SurfaceArea(self):
        # Calculate area
        return None

    # Note gmsh - filename
    # Using '-' runs in shell ('parse and exit')

#General.SmallAxes = 0;
#Mesh.Format=1;
#Mesh 2;
#Save "m.msh";
#Draw;
#Include "m.msh";
#Print Sprintf("%(image)s");
#Exit;''' % {'output':output}

    def IncludeAxesInImage(self):
        if specification.have_option('/geoid_mesh/generate_image/include_axes'):
            return True
        # Default when selected at the command line is to add the axes
        if universe.generate_mesh_image:
            # If a choice is made not to include axes, then follow this
            if specification.have_option('/geoid_mesh/generate_image') and not specification.have_option('/geoid_mesh/generate_image/include_axes'):
                return False
            return True
        return False

    def GenerateImage(self):
        if universe.pickup and self.OutputExists():
            return

        def remove_if_exists(filename):
            if os.path.exists(filename):
                try:
                    os.remove(filename)
                except:
                    pass

        import os
        from time import sleep
        # Not quite functioning yet
        self.Generate()

        base, ext = os.path.splitext(self.OutputImageFilename())
        representation_image = self.representation.spatial_discretisation.PathRelative(base + '_image' + self._representation_extension_type)
        mesh_image = self.representation.spatial_discretisation.PathRelative(base + '_image' + self._mesh_extension_type)
        image = self.representation.spatial_discretisation.PathRelative(base + self._image_extension_type)

        remove_if_exists(representation_image)
        remove_if_exists(mesh_image)
        remove_if_exists(image)

        footer = ''

        if self.IncludeAxesInImage():
            footer = footer + '''
General.Antialiasing = 1;
General.Axes = 3;
'''

        footer = footer + '''
General.SmallAxes = 0;
Geometry.Points = 0;
Geometry.Lines = 1;

Mesh.Format=1;
Mesh 2;
Save "%(mesh)s";
Draw;
Include "%(mesh)s";
Print Sprintf("%(image)s");
Printf("Image output complete");
Exit;''' % {'mesh':mesh_image, 'image':image}


        self.representation.spatial_discretisation.WriteContent(filename=representation_image, footer=footer, force=True)
        if not os.path.exists(representation_image):
            error('Source file not found')
        command_options = [representation_image]
        self.GenerateWithPoll(options = command_options)

        #remove_if_exists(representation_image)
        #remove_if_exists(mesh_image)

        # Not safe, and not needed?
        # count = 0; while (not os.path.exists(image)) and count < 10: sleep(1)
        trim_image_file(image)

        report('%(blue)sImage generation complete, produced:%(end)s %(yellow)s%(output)s%(end)s', var = {'output':image})


    def GeneratePlain(self, options=None):
        import subprocess
        executable = 'gmsh'
        command_options = ' -v 1 -2 %(input)s -o %(output)s' % {'input':self.Source(), 'output':self.Output()}
        if options is not None:
            command_options = options
        command = executable + command_options
        report('%(blue)sMesh generation%(grey)s, using: %(command)s%(end)s', var = {'command':command})
        p = subprocess.Popen(commandfull , shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
        #f = open(tempfile, 'w')
        #f.write(str(p.pid))
        #f.close()
        for line in p.stdout.readlines():
            print line,
        retval = p.wait()

    def GenerateWithPoll(self, options=None, wait=True):
        from  subprocess import Popen, PIPE
        import sys
        from time import sleep
        executable = ['gmsh']
        #command_options = ' -v 1 -2 %(input)s -o %(output)s' % {'input':self.Source(), 'output':self.Output()}
        command_options = ['-2', self.Source(), '-o', self.Output()]
        binary = ''
        if self.OutputBinary():
            binary = ' (binary)'
            command_options = ['-bin'] + command_options
        if options is not None:
            command_options = options
        command = executable + command_options
        report('%(blue)sMesh generation%(binary)s%(grey)s, using: %(command)s%(end)s', var = {'command':' '.join(command), 'binary':binary} )
        process = Popen(
            command, shell=False, stdout=PIPE, stderr=PIPE
        )
        self.process = NonBlockingStreamReader(process.stdout)
        while True:
            out = self.process.readline(0.1)
            if not out:
                break
            report('%(grey)s%(content)s%(end)s', var = {'content':out.strip()}, indent=1)
        #while True:
        #  out = process.stdout.read(1)
        #  if out == '' and process.poll() != None:
        #    break
        #  if out != '':
        #    sys.stdout.write(out)
        #    sys.stdout.flush()
        if wait:
            while True:
                alive = self.process.isAlive()
                if not alive: break
                sleep(0.5)
            #process.wait()

    def isGenerated(self):
        return self._generated

    def Generate(self):
        if universe.pickup and self.OutputExists():
            self._generated = True
        if self.isGenerated():
            return
        if not ExecuteStage('mesh'):
            return
        if self.interactive:
            self.GenerateWithPoll()
        else:
            self.GeneratePlain()
        self._generated = True
        report('%(blue)sMesh generation complete, produced:%(end)s %(yellow)s%(output)s%(end)s', var = {'output':self.Output()})
        #report('%(grey)s  note, might require parsing%(end)s')


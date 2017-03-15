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

import sys
import os
from Universe import universe
from Support import SourceTestFolder
from Reporting import report, error, Log
from Spud import specification
from Raster import Dataset, Raster


class ReadMultipleInstance(object):

    def __init__(self, prefix, number, name=None):
        self._prefix = prefix
        self._number = number
        self._path = None
        if name is None:
            self.name = None
            self.Read()
        else:
            self.name = name
            self.path = prefix

    def Read(self):
        self.name = specification.get_option('%(prefix)s[%(number)d]/name' % {'prefix':self._prefix, 'number':self._number} )
        self._path = '%(prefix)s::filchner_ronne_ice_ocean::%(name)s' % {'prefix':self._prefix, 'name':self.name} 

    def Show(self):
        report('  %(blue)s%(number)s.%(end)s %(name)s', var = {'number':self._number + 1, 'name':self.name })
        report('      %(blue)spath:      %(end)s%(path)s', var = {'path':self._path} )


class SpatialDiscretisation(object):
    """ Read options from the supplied file

      Name()
      PlanetRadius()
      Spacing()
      PhysicalLinesSeparate()
      Dataset()
      SurfaceGeoidRep()

      RawContent()


    """

    def __init__(self, case = None, load_only = False):
        self._loaded = False
        self._dataset_read = False
        self._surface_geoid_rep_read = False
        self._filename = None

        self._dataset = {}
        self._surface_geoid_rep = {}

        self._filehandle = None
        self.content = ''
        self._generated = False

        self.mesh_filename = None
        self.verification = None

        if (case is None) and universe.legacy.legacy:
            case = self.Legacy()
        self.LocateOptionFile(case)
        self.LoadOptions()
        if load_only:
            from Test import VerificationTests
            self.verification = VerificationTests(load_only=True)
            return
        self.Dataset()
        self.SurfaceGeoidRep()
        universe.log = Log(on=universe.log_active, spatial_discretisation=self)
        self.Generate()

    def Name(self):
        if self._loaded and specification.have_option('/model_name'):
            return specification.get_option('/model_name')
        else:
            return universe.default.name

    def Author(self):
        from StringOperations import list_to_sentence
        authors = []
        if self._loaded and specification.have_option('/reference'):
            total = specification.option_count('/reference/author')
            for number in reversed(range(total)):
                path = '/reference/author[%(number)d]' % {'number':number}
                author = specification.get_option(path)
                details = []
                for attribute in 'email_address', 'institution':
                    if specification.have_option(path + '/' + attribute):
                        details.append(specification.get_option(path + '/' + attribute))
                if details:
                    author = author + ' (' + ', '.join(details) + ')'
                authors.append(author)
        if not authors:
            authors.append('None identified')
        return list_to_sentence(authors)

    def GetComment(self):
        from os import linesep
        comments = []
        if self._loaded:
            if specification.have_option('/comment'):
                comments = comments + specification.get_option('/comment').strip().splitlines()
            if specification.have_option('/model_name/comment'):
                new = specification.get_option('/model_name/comment').strip().splitlines()
                if len(comments) > 0 and len(new) > 0:
                    comments = comments + ['----']
                comments = comments + new 
        if len(comments) == 0:
            comments.append('[None provided]')
        return linesep.join(comments)

    def Root(self):
        return os.path.realpath(os.path.dirname(self._filename))

    def PathRelative(self, path):
        if path.startswith('/'):
            return path
        return os.path.realpath(os.path.join(self.Root(), path))

    def report(self, *args, **kwargs):
        report(*args, **kwargs)

    def Output(self):
        from Support import FilenameAddExtension
        if specification.have_option('/output/file_name'):
            output = specification.get_option('/output/file_name')
        elif universe.legacy.legacy:
            # Folder name picked up in spatial_discretisation name and Root()
            from os.path import basename
            output = basename(universe.legacy.output)
        else:
            output = self.Name()
        # Update output file name used to write representation
        return FilenameAddExtension(output, 'geo')

    def Projection(self):
        if specification.have_option('/output/projection'):
            return specification.get_option('/output/projection')
        else:
            return universe.default.projection

    def LocateOptionFile(self, case):
        import os
        if case is None:
            error("Please provide a boundary representation .brml file, or folder containing one.", fatal=True)
        if os.path.exists(case):
            if os.path.isfile(case):
                self._filename = case
                return

        from Test import VerificationTestEngine
        t = VerificationTestEngine(locate_only = True, test_folder = SourceTestFolder())
        location = t.Locate(case)
        if location is not None:
            self._filename = location
            report("%(blue)sLocated:%(end)s %(yellow)s%(location)s%(end)s %(grey)s(from spec '%(case)s')%(end)s", var = {'case':case, 'location':self._filename})
            return

        error("Unable to infer which case is meant by '%(case)s'" % {'case':case}, fatal=True)

    def LoadOptions(self):
        if universe.legacy.legacy:
            return
        specification.clear_options()
        specification.load_options(self._filename)
        self._loaded = True

    def PlanetRadius(self):
        if self._loaded and specification.have_option('/global_parameters/planetary_radius'):
            return specification.get_option('/global_parameters/planetary_radius')
        else:
            return universe.default.planet_radius

    def Spacing(self):
        if self._loaded and specification.have_option('/global_parameters/spacing_default'):
            return specification.get_option('/global_parameters/spacing_default')
        else:
            return universe.default.dx_default

    def PhysicalLinesSeparate(self):
        if self._loaded and specification.have_option('/geoid_mesh/library::Gmsh/physical_lines_separate'):
            return specification.get_option('/geoid_mesh/library::Gmsh/physical_lines_separate')
        else:
            return universe.default.physical_lines_separate

    def Dataset(self):
        # Handle legacy
        if not self._dataset_read:
            self._ReadDataset()
        return self._dataset

    def SurfaceGeoidRep(self):
        # Handle legacy
        if not self._surface_geoid_rep_read:
            self._ReadSurfaceGeoidRep()
        return self._surface_geoid_rep

    def _ReadDataset(self):
        self._dataset = {} 

        for number in range(specification.option_count('/dataset')):
            d = Dataset(spatial_discretisation=self, number=number)
            if d.form == 'Raster':
                d = Raster(spatial_discretisation=self, number=number)
            elif d.form == 'Polyline':
                raise NotImplementedError
            else:
                raise NotImplementedError
            if d.SourceExists():
                self._dataset[d.name] = d
            else:
                error('Dataset %(name)s source not available at: %(location)s' % {'name':d.name, 'location':d.LocationFull()})
        report('%(brightyellow)sDATASETS%(end)s: Found %(number)d datasets:', var = { 'number':len(self._dataset) })
        for d in self._dataset.keys():
            self._dataset[d].Show()
        self._dataset_read = True

    def _ReadSurfaceGeoidRep(self):
        self._surface_geoid_rep = {} 

        for number in range(specification.option_count('/geoid_surface_representation')):
            if len(self._surface_geoid_rep) > 0:
                error('More than one surface geoid representation in the same initialisaiton currently not supported. Will examine the first for now.', fatal=False)
                break
            d = ReadMultipleInstance('/geoid_surface_representation', number)
            self._surface_geoid_rep[d.name] = d

        report('%(brightyellow)sSURFACE GEOID REPRESENTATIONS%(end)s: Found %(number)d surface geoid representations:', var = { 'number':len(self._surface_geoid_rep) })
        for d in self._surface_geoid_rep.keys():
            self._surface_geoid_rep[d].Show()
        self._surface_geoid_rep_read = True

    def _ReadRawContent(self):
        f = open(self._filename, 'r')
        raw_content = f.read()
        f.close()
        return raw_content

    def RawContent(self, comment=False):
        raw_content = self._ReadRawContent()
        if not comment:
            return raw_content
        else:
            prefix = '//  '
            return ''.join([ ( prefix + line ) for line in raw_content.splitlines(True) ])

    def OutputExists(self, filename=None):
        from os.path import exists
        if filename is None:
            filename = self.Output()
        fullpath = self.PathRelative(filename)
        return exists(fullpath)

    def filehandleOpen(self, filename=None):
        if filename is None:
            filename = self.Output()
        fullpath = self.PathRelative(filename)
        report('%(blue)sWriting surface geoid representation to file:%(end)s %(yellow)s%(filename)s%(end)s %(grey)s%(fullpath)s%(end)s', var={'filename':filename, 'fullpath':fullpath})
        self._filehandle = file(fullpath,'w')

    def filehandleClose(self):
        self._filehandle.close()

    def WriteContent(self, filename=None, footer=None, force=False):
        if self.isGenerated() and not force:
            return
        self.filehandleOpen(filename=filename)
        self._filehandle.write(self.content)
        if footer is not None:
            self._filehandle.write(footer)
        self.filehandleClose()
        self._generated = True

    def isGenerated(self):
        return self._generated

    def AddContent(self, string=''):
        from os import linesep
        self.content = self.content + string + linesep

    def AddComment(self, comment, newline=False, indent=0):
        if newline:
            self.AddContent()
        prefix = '// ' + ('  ' * indent)
        for line in comment.splitlines():
            self.AddContent( prefix + line )

    def AddSection(self, title):
        line = '='
        self.AddComment('%s %s %s' % ( line * 2, title, line * (60 - len(title))), True)

    def AppendHeader(self):
        from MeshGenerator import MeshGenerator
        from Support import RepositoryVersion, Timestamp
        m = MeshGenerator()
        header = '''Surface Geoid Boundary Representation, for project: %(name)s

Created by:  Shingle %(version)s

   Shingle:  An approach and software library for the generation of
             boundary representation from arbitrary geophysical fields
             and initialisation for anisotropic, unstructured meshing.

             Web: https://www.shingleproject.org

             Contact: Dr Adam S. Candy, contact@shingleproject.org
    
Version: %(version_full)s
Mesh tool version: %(mesh_tool_version)s
                   (on the system where the boundry representation has been created)

Project name: %(name)s
Boundary Specification authors: %(author)s
Created at: %(timestamp)s
''' % { 'name':self.Name(), 'author':self.Author(), 'version':RepositoryVersion(parenthesis=True, not_available_note=False), 'version_full':RepositoryVersion(full=True), 'mesh_tool_version':m.Version(), 'timestamp':Timestamp() }
        self.AddComment(header)
        self.AddComment('Project description:')
        self.AddComment(self.GetComment(), indent=1)

        self.AddSection('Source Shingle surface geoid boundnary representation')
        self.AddComment(self.RawContent())

    def Legacy(self):
        self._dataset['legacy'] = Raster(location=universe.legacy.source, spatial_discretisation=self)
        self._dataset_read = True
        self._surface_geoid_rep['legacy'] = ReadMultipleInstance('/legacy', 1, name='legacy')

        self._surface_geoid_rep_read = True
        return universe.legacy.output

    def SurfaceGeoidRepFirstName(self):
        if len(self.SurfaceGeoidRep()) == 0:
            return ''
        else:
            names = self.SurfaceGeoidRep().keys()
            return self.SurfaceGeoidRep()[names[0]].name

    def Postprocess(self):
        if not specification.have_option('/geoid_mesh/library::Gmsh/postprocess'):
            return
        text = specification.get_option('/geoid_mesh/library::Gmsh/postprocess')
        self.AddContent('''
    
// Postprocessing instructions:''')
        self.AddContent(text % {'name':self.Name(), 'brepname':self.Output(), 'meshname':'As yet undefined'})
        report('%(blue)sAdded postprocess instructions%(end)s')

    def Generate(self):

        from Universe import universe
        from Test import VerificationTests
        from SurfaceGeoidDomainRepresentation import SurfaceGeoidDomainRepresentation

        from SpatialDiscretisation import SpatialDiscretisation

        from Raster import Raster
        from MeshGenerator import MeshGenerator
        from MeshTools import Mesh
        from MetricGenerator import Metric, Field

        from OutputFormat import OutputFormat

        if universe.pickup and self.OutputExists(): 
            self._generated = True


        self.AppendHeader()

        # For now limit to the first surface geoid representation
        name = self.SurfaceGeoidRepFirstName()

        rep = SurfaceGeoidDomainRepresentation(spatial_discretisation=self, name=name)

        f = Field(surface_representation = rep )
        self.Postprocess()
        self.WriteContent()

        g = MeshGenerator(rep)
        self.mesh_filename = g.Output()
        self.mesh_generated = g.isGenerated()

        mesh = Mesh(self)
        mesh.Show()

        self.verification = VerificationTests(rep, mesh)

        OutputFormat(self, rep, g)


def old():
    assert specification.get_option('/timestepping/timestep') == 0.025

    assert specification.get_number_of_children('/geometry') == 5
    assert specification.get_child_name('geometry', 0) == "dimension"

    assert specification.option_count('/problem_type') == 1
    assert specification.have_option('/problem_type')

    assert specification.get_option_type('/geometry/dimension') is int
    assert specification.get_option_type('/problem_type') is str

    assert specification.get_option_rank('/geometry/dimension') == 0
    assert specification.get_option_rank('/physical_parameters/gravity/vector_field::GravityDirection/prescribed/value/constant') == 1

    assert specification.get_option_shape('/geometry/dimension') == (-1, -1)
    assert specification.get_option_shape('/problem_type')[0] > 1
    assert specification.get_option_shape('/problem_type')[1] == -1

    assert specification.get_option('/problem_type') == "multimaterial"
    assert specification.get_option('/geometry/dimension') == 2
    specification.set_option('/geometry/dimension', 3)


    assert specification.get_option('/geometry/dimension') == 3

    list_path = '/material_phase::Material1/scalar_field::MaterialVolumeFraction/prognostic/boundary_conditions::LetNoOneLeave/surface_ids'
    assert specification.get_option_shape(list_path) == (4, -1)
    assert specification.get_option_rank(list_path) == 1
    assert specification.get_option(list_path) == [7, 8, 9, 10]

    specification.set_option(list_path, [11, 12, 13, 14, 15])
    assert specification.get_option_shape(list_path) == (5, -1)
    assert specification.get_option_rank(list_path) == 1
    assert specification.get_option(list_path)==[11, 12, 13, 14, 15]

    tensor_path = '/material_phase::Material1/tensor_field::DummyTensor/prescribed/value::WholeMesh/anisotropic_asymmetric/constant'
    assert specification.get_option_shape(tensor_path) == (2, 2)
    assert specification.get_option_rank(tensor_path) == 2

    assert specification.get_option(tensor_path)==[[1.0,2.0],[3.0,4.0]]

    specification.set_option(tensor_path, [[5.0,6.0,2.0],[7.0,8.0,1.0]])
    assert specification.get_option_shape(tensor_path) == (2,3)
    assert specification.get_option_rank(tensor_path) == 2

    assert(specification.get_option(tensor_path)==[[5.0, 6.0, 2.0],[7.0, 8.0, 1.0]])

    try:
        specification.add_option('/foo')
        assert False
    except specification.SpudNewKeyWarning, e:
        pass

    assert specification.option_count('/foo') == 1

    specification.set_option('/problem_type', 'helloworld')
    assert specification.get_option('/problem_type') == "helloworld"

    try:
        specification.set_option_attribute('/foo/bar', 'foobar')
        assert False
    except specification.SpudNewKeyWarning, e:
        pass

    assert specification.get_option('/foo/bar') == "foobar"

    specification.delete_option('/foo')
    assert specification.option_count('/foo') == 0

    try:
        specification.get_option('/foo')
        assert False
    except specification.SpudKeyError, e:
        pass

    try:
        specification.get_option('/geometry')
        assert False
    except specification.SpudTypeError, e:
        pass

    specification.write_options('test_out.flml')

    specification.set_option('/test',4)

    assert specification.get_option('/test') == 4

    specification.set_option('/test',[[4.0,2.0,3.0],[2.0,5.0,6.6]]) 

    assert specification.get_option('/test') == [[4.0,2.0,3.0],[2.0,5.0,6.6]]

    specification.set_option('/test',"Hallo")

    assert specification.get_option('/test') == "Hallo"

    specification.set_option('/test',[1,2,3])

    assert specification.get_option('/test') == [1,2,3] 

    specification.set_option('/test',[2.3,3.3])

    assert specification.get_option('/test') == [2.3,3.3]

    try:
        specification.set_option('/test')
        assert False
    except specification.SpudError, e:
        pass


    print "All tests passed!"



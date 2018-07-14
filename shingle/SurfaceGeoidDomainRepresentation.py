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
from Reporting import report, error, addcolour
#from RepresentationTools import draw_parallel_explicit
from Spud import specification
from BRepComponent import BRepComponent
from Boundary import Boundary
from StringOperations import expand_boxes, bound_by_latitude, list_to_comma_separated, list_to_space_separated

class SurfaceBRepIndexes(object):

    def _InitialiseIndexes(self):
        # Current unique point  - could be part of spatial_discretisation
        self.point = 0
        # Current unique path - could be part of spatial_discretisation
        self.path = 0
        # start point in current path - not needed in this surf index!
        self.start = 0
        # required for line loop?
        self.pathsinloop = []
        # loop number - could be part of spatial_discretisation?
        self.loop = 0
        # loops required for surface
        self.loops = []

        self.exterior = []
        self.interior = []

    def __init__(self):
        self._InitialiseIndexes()

class SurfaceGeoidDomainRepresentation(object):

    _cacheFiletype = '.shc'

    def __init__(self, spatial_discretisation=None, name='SurfaceGeoidDomainRepresentation'):
        self._brep_components = None
        self._brep_components_order = None
        self._brep_components_complete = None
        self._boundary = None
        self._boundary_order = []
        self._path = None
        self._pathall = None

        self.name = name
        self.spatial_discretisation = spatial_discretisation
        self._path = '/geoid_surface_representation::%(name)s' % {'name':self.name}
        self.report('Initialising surface geoid representation %(name)s', var = {'name':self.name}, include=False, indent=1)
        self.index = SurfaceBRepIndexes()

        self.AppendParameters()
        self.Boundary()
        #if not self.spatial_discretisation.isGenerated():
        #    self.Generate()

    def Name(self):
        return self.name

    def SurfaceId(self):
        if specification.have_option(self._path + '/id'):
            return specification.get_option(self._path + '/id')
        else:
            return universe.default.boundary.surface

    def CounterPrefix(self, prefix):
        if universe.use_counter_prefix:
            return '%(prefix)s%(fileid)s + ' % { 'prefix':prefix, 'fileid':self.Fileid() }
        else:
            return ''

    def Fileid(self):
        if specification.have_option(self._path + '/id_internal_suffix'):
            return specification.get_option(self._path + '/id_internal_suffix')
        else:
            return universe.default.fileid

    # ------------------------------------------------------------

    def AddContent(self, *args, **kwargs):
        return self.spatial_discretisation.AddContent(*args, **kwargs)

    def AddSection(self, *args, **kwargs):
        return self.spatial_discretisation.AddSection(*args, **kwargs)

    def AddComment(self, *args, **kwargs):
        return self.spatial_discretisation.AddComment(*args, **kwargs)

    def Output(self, *args, **kwargs):
        return self.spatial_discretisation.Output(*args, **kwargs)

    def Projection(self, *args, **kwargs):
        return self.spatial_discretisation.Projection(*args, **kwargs)

    def isGenerated(self, *args, **kwargs):
        return self.spatial_discretisation.isGenerated(*args, **kwargs)

    # ------------------------------------------------------------

    def MoreBSplines(self):
        if specification.have_option(self._path):
            return specification.have_option(self._path + '/more_bsplines')
        else:
            return universe.default.more_bsplines

    def Open(self):
        if specification.have_option(self._path):
            return not specification.have_option(self._path + '/closure/no_open')
        else:
            return universe.default.open

    def CloseWithParallels(self):
        if specification.have_option(self._path):
            return specification.have_option(self._path + '/closure/close_with_parallels')
        else:
            return universe.default.closewithparallels

    def OpenId(self):
        if specification.have_option(self._path + '/closure/open_id'):
            return specification.get_option(self._path + '/closure/open_id')
        else:
            return universe.default.boundary.open

    def BoundingLatitude(self):
        if specification.have_option(self._path + '/closure/bounding_latitude'):
            return specification.get_option(self._path + '/closure/bounding_latitude')
        else:
            return universe.default.bounding_lat

    def ExtendToLatitude(self):
        if specification.have_option(self._path + '/closure/extend_to_latitude'):
            return specification.get_option(self._path + '/closure/extend_to_latitude')
        else:
            return universe.default.extendtolatitude

    def AddPath(self, source):
        self._pathall = source._pathall

    def Boundary(self):
        if self._boundary is None:
            self._boundary = {}

            self._boundary_order = []
            for number in range(specification.option_count(self._path + '/boundary')):
                b = Boundary(self, number)
                self._boundary[b.Name()] = b
                self._boundary_order.append(b)

            report('%(brightyellow)sBOUNDARY IDENTIFICATION%(end)s: Found %(number)d boundary definitions:', var = { 'number':len(self._boundary) })
            for b in self._boundary_order:
                b.Show()
        return self._boundary

    def BRepComponents(self):
        if self._brep_components is None:
            self._brep_components = {}
            self._brep_components_order = []

            if universe.legacy.legacy:
                b = BRepComponent(self, 1)
                self._brep_components[b.Name()] = b

            for number in range(specification.option_count(self._path + '/brep_component')):
                b = BRepComponent(self, number)
                self._brep_components[b.Name()] = b
                self._brep_components_order.append(b)

            if len(self._brep_components) == 0:
                error('No component boundary representations found', fatal=True)
            report('%(brightyellow)sCOMPONENT BOUNDARY REPRESENTATIONS%(end)s: Found %(number)d component boundary representations:', var = { 'number':len(self._brep_components) })
            for b in self._brep_components_order:
                b.Show()
        return self._brep_components

    def BRepComponentsOrder(self):
        self.BRepComponents()
        return self._brep_components_order

    def BRepComponentFirst(self):
        if len(self.BRepComponents()) == 0:
            return ''
        else:
            return self.BRepComponentsOrder()[0]

    def report(self, *args, **kwargs):
        self.spatial_discretisation.report(*args, **kwargs)

        linclude = True
        ldebug = False
        if 'include' in kwargs:
            linclude = kwargs['include']
        if 'debug' in kwargs:
            ldebug = kwargs['debug']
            if ldebug and not universe.debug:
                return
        if linclude:
            lvar = {}
            if 'var' in kwargs:
                lvar = kwargs['var']
            self.AddComment(comment=args[0] % addcolour(lvar, colourful = False))


    def AppendArguments(self):
        self.AddComment('Arguments: ' + universe.call)

    def AppendParameters(self):
        self.AddSection('Boundary Representation Specification Parameters')
        self.report('Output to ' + self.Output(), indent=1)
        self.report('Projection type ' + self.Projection(), indent=1)
        if self.ExtendToLatitude() is not None:
            self.report('Extending region to meet parallel on latitude ' + str(self.ExtendToLatitude()))
        self.AddComment('')

    def GetComponentCompleteBoundaries(self):
        # Regenerate, since using component brep merging
        self.index.exterior = []
        self.index.interior = []
        for i, brep in enumerate(self.getComponentsComplete()):
            if any([x.is_exterior for x in brep.components]):
                self.index.exterior.append(i)
            else:
                self.index.interior.append(i)
        #print 'AA',  self.index.exterior, self.index.interior
        return self.index.exterior + self.index.interior


    def output_surfaces(self):
        index = self.index

        self.AddSection('Physical entities')

        def physical_line_definition(name, boundaryid, paths):
            self.report('Boundary %s (ID %i): %s' % (name, boundaryid, list_to_space_separated(paths, add=1, concatenate=True)), indent = 1)
            prefix = self.CounterPrefix('IL')
            self.AddContent( '''Physical Line( %(boundaryid)d ) = { %(loopnumbers)s };''' % { 'boundaryid':boundaryid, 'loopnumbers':list_to_comma_separated(paths, prefix = prefix ) } )

        for b in self.Boundary().keys():
            boundary = self.Boundary()[b]
            if self.spatial_discretisation.PhysicalLinesSeparate():
                for l in boundary.path:
                    physical_line_definition(boundary.Name(), boundary.physical_id, [l])
            else:
                physical_line_definition(boundary.Name(), boundary.physical_id, boundary.path)

        if (len(self.GetComponentCompleteBoundaries()) > 0):
            prefix = self.CounterPrefix('ILL')
            self.AddContent('''Plane Surface( %(surface)i ) = { %(boundary_list)s };
Physical Surface( %(surface)i ) = { %(surface)i };''' % { 'surface':self.SurfaceId() + 1, 'boundary_list':list_to_comma_separated(self.GetComponentCompleteBoundaries(), prefix = prefix ) } )
        else:
            self.report('Warning: Unable to define surface - may need to define Line Loops?')

        self.AddSection('End of contour definitions')

    def getComponentsComplete(self):
        if not self._brep_components_complete:
            components = []

            self.AddSection('BRep component pre-scan')
            for brep in self.BRepComponentsOrder():

                self.AddSection('BRep component: ' + brep.Name())

                # Generates children BRepComponent objects, one for each distinct physical object
                # e.g. pathline, closed or open  -- to later be merged, interior/exterior determination
                components = brep.Generate(components=components)

                # carry list generated so far, complete and incomplete
                # mark
                #components = components + brep._valid_paths

            # Run through all components and link children
            for j, brep in enumerate(components):
                if len(brep.components) > 1:
                    for i, component in enumerate(brep.components):
                        #print 'breps', j, i, type(brep), type(component)
                        #print ' ', i, (i - 1) % len(brep.components)
                        component.before = brep.components[(i - 1) % len(brep.components)]
                        #print ' ', i, (i + 1) % len(brep.components)
                        component.after = brep.components[(i + 1) % len(brep.components)]
                ##if len(brep.components) > 1:
                #brep.update_component_order()

            self._brep_components_complete = components
        return self._brep_components_complete

    #def getExterior(self):
    #        exterior = any([x.isExterior() for x in brep.components])



    def ShowBRepComponents(self):
        if len(self.getComponentsComplete()) == 0:
            return
        self.AddComment('Component boundary representations identified:', indent=1)
        report('Component boundary representations identified:', indent=1)
        for i, component in enumerate(self.getComponentsComplete()):
            #if any([x.isExterior() for x in component.components]):
            if component.isClosed():
                state = 'closed'
            else:
                state = 'open'
            c= ('%(number)d: %(name)s (components: %(components)s, %(state)s)' %
                {
                    'number': i + 1,
                    'name': component.Name(),
                    'components': len(component.components),
                    'state': state
                })
            self.AddComment(c, indent=2)
            report(c, indent=2)


    def Generate(self):

        #exterior = None
        #interior = []

        # incomplete?

        # make global to class


        self.ShowBRepComponents()

        for i, component in enumerate(self.getComponentsComplete()):

            #component.AddHeader()
            self.AddSection('BRep component: ' + component.Name())
            for comment in component.comment:
                self.AddComment(comment)

            # component.components are enriched lines, need to link
            #  here?  or in BRepComponent.Generate


            for i, p in enumerate(component.components):
                #print component, component.components
                for comment in p.comment:
                    self.AddComment(comment)
                # if multiple, need to connect
                # Better to link child breps and handle in Generate
                first = True
                last = False
                if i > 0:
                    # Need to connect to previous
                    first = False
                if i == (len(component.components) - 1):
                    # Need to connect to first
                    last = True

                self.index = p.Generate(self.index, first=first, last=last)

        #for a in components:
        #    print a
        #    print a.components
        #    print len(a.components)
        #    print len(a.components[0].valid_location)
        #    #print p.valid_location

        self.output_surfaces()


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
from Reporting import report, error
from Import import ReadPaths
from StringOperations import expand_boxes, bound_by_latitude, list_to_comma_separated, list_to_space_separated
#from RepresentationTools import draw_parallel_explicit
from RepresentationTools import EnrichedPolyline
from Projection import project
from Spud import specification
from Plot import PlotContours
from Bounds import Bounds
#from Projection import c1ompare_points

from shapely.geometry.polygon import LinearRing
from shapely.geometry.polygon import LineString
from copy import copy, deepcopy

# class BRepComponentGroup(object):
#     """ Object for organising BRepComponents into complete boundary representations
#         for use in SurfaceGeoidDomainRepresentation objects"""
#
#
#     def __init__(self):
#         # Ordered list of BRepComponent objects that contribute to an exterior boundary
#         exterior = []
#         # List of interior boundaries
#         # The interior boundaries contain ordered lists of BRepComponent objects that contribute to an interior boundary
#         interiors = []
#
#     def isComplete(self):
#
#
#     def Add(self, components):
#         # components is a list of EnrichedPolylines
#         for component in components:
#             if component.isExterior():
#                 # add to exterior
#
#             else:
#
#
#
#     def Merge(self, other):


# Split to form BRepComponentReader(BRepComponent):

class BRepComponent(object):

    _bounds = None

    def __init__(self,
            # Original
            surface_rep=None, number=None, pathall=None,
            # New
            component=None
            ):

        self._name = None
        self._path = None
        self._formpath = None
        self._form_type = None
        self._surface_rep = None
        self._representation_type = None
        self.comment = []

        self._region = None
        self._bounds = None
        self._boundary = None
        self._boundary_to_exclude = None

        self._pathall = None
        self._selected_paths = None
        self._valid_paths = None
        self._pathall_enriched = None

        self._complete = []

        self.index = None

        # Component paths
        self.interior = []
        self.exterior = []
        self.components = []

        self.parent = None
        self.children = []

        self.number = number
        self._surface_rep = surface_rep
        self._path = '/geoid_surface_representation::%(name)s/brep_component::%(brep_name)s' % {'name':self._surface_rep.name, 'brep_name':self.Name()}
        if self._surface_rep is not None:
            self.index = self._surface_rep.index
        self._pathall = pathall

    def __str__(self):
        return self.__class__.__name__ + ': ' + self.Name()

    def Reproduce(self, components=None, total=None):
        # Improve to limit copy of attributes intelligently
        #   use deepcopy if necessary
        child = copy(self)
        self.children.append(child)
        if total:
            output_format = '%(name)s (part %(part)d of %(total)d)'
        else:
            output_format = '%(name)s (part %(part)d)'
        child._name = output_format % {
            'name': self._name,
            'part': len(self.children),
            'total': total,
        }

        child.parent = self
        if components is not None:
            child.components = components
        return child

    # Imports:
    def report(self, *args, **kwargs):
        return self._surface_rep.report(*args, **kwargs)

    def AddComment(self, *args, **kwargs):
        return self._surface_rep.AddComment(*args, **kwargs)

    def AddSection(self, *args, **kwargs):
        return self._surface_rep.AddSection(*args, **kwargs)

    def ExtendToLatitude(self, *args, **kwargs):
        return self._surface_rep.ExtendToLatitude(*args, **kwargs)

    def Fileid(self, *args, **kwargs):
        return self._surface_rep.Fileid(*args, **kwargs)

    def CounterPrefix(self, *args, **kwargs):
        return self._surface_rep.CounterPrefix(*args, **kwargs)

    def Projection(self, *args, **kwargs):
        return self._surface_rep.Projection(*args, **kwargs)

    def AddContent(self, *args, **kwargs):
        return self._surface_rep.AddContent(*args, **kwargs)

    def MoreBSplines(self, *args, **kwargs):
        return self._surface_rep.MoreBSplines(*args, **kwargs)

    def OpenId(self, *args, **kwargs):
        return self._surface_rep.OpenId(*args, **kwargs)

    def Open(self, *args, **kwargs):
        return self._surface_rep.Open(*args, **kwargs)

    def BoundingLatitude(self, *args, **kwargs):
        return self._surface_rep.BoundingLatitude(*args, **kwargs)

    def SurfaceId(self, *args, **kwargs):
        return self._surface_rep.SurfaceId(*args, **kwargs)

    def CloseWithParallels(self, *args, **kwargs):
        return self._surface_rep.CloseWithParallels(*args, **kwargs)

    # ----------------------------------------

    def PreviousBRepComponent(self):
        return self._surface_rep.BRepComponentsOrder()[self.number - 1]

    def isComplete(self):
        return self._complete.count(False) == 0

    def SetComplete(self):
        self._complete.append(True)

    def SetNotComplete(self):
        self._complete.append(False)

    def Show(self):
        self.report('  %(blue)s%(number)s.%(end)s %(name)s', var = {'number':self.number + 1, 'name':self.Name() })
        self.report('      %(blue)sPath:           %(end)s%(path)s', var = {'path':self._path} )
        self.report('      %(blue)sForm:           %(end)s%(form)s', var = {'form':self.FormType()} )
        self.report('      %(blue)sIdentification: %(end)s%(id)s', var = {'id':self.Identification()} )

    def Name(self):
        if self._name is None:
            if specification.have_option('/geoid_surface_representation::%(name)s/brep_component[%(number)d]/name' % {'name':self._surface_rep.name, 'number':self.number}):
                self._name = specification.get_option('/geoid_surface_representation::%(name)s/brep_component[%(number)d]/name' % {'name':self._surface_rep.name, 'number':self.number})
            else:
                self._name = 'legacy'
        return self._name

    def Identification(self):
        if specification.have_option(self._path + '/identification'):
            return specification.get_option(self._path + '/identification/name')
        else:
            error("The boundary of the component BRep '%(brep)s' requires an identification." % {'brep':self.Name()}, fatal = True)
            #return universe.default.boundary.contour

    def Spacing(self):
        if specification.have_option(self._path + '/spacing'):
            return specification.get_option(self._path + '/spacing')
        else:
            return universe.default.dx

    def SourceResolution(self):
        # FIXME
        resolution = [1.0E-4, 1.0E-4]
        return resolution

    def RepresentationType(self):
        if self._representation_type is None:
            if specification.have_option(self._path + '/representation_type[0]/name'):
                self._representation_type = specification.get_option(self._path + '/representation_type[0]/name')
            else:
                return 'Raster'
        return self._representation_type

    def isCompound(self):
        return self.RepresentationType() == 'CompoundBSplines'

    def isBSpline(self):
        return self.RepresentationType() == 'BSpline'

    def isPolyline(self):
        return self.RepresentationType() == 'Polyline'

    def FormType(self):
        if self._form_type is None:
            if specification.have_option(self._path + '/form[0]/name'):
                self._form_type = specification.get_option(self._path + '/form[0]/name')
            else:
                self._form_type = 'Raster'
        # Useful to catch this at the moment:
        if self._form_type not in ['Raster', 'Polyline', 'Parallel', 'ExtendToParallel', 'ExtendToMeridian', 'BoundingBox']:
            raise NotImplementedError
        return self._form_type

    def isRaster(self):
        return self.FormType() == 'Raster'

    def isShapefile(self):
        return self.FormType() == 'Polyline'

    def isParallel(self):
        return self.FormType() == 'Parallel'

    def isBoundingBox(self):
        return self.FormType() == 'BoundingBox'

    def isExtendToParallel(self):
        return self.FormType() == 'ExtendToParallel'

    def isExtendToMeridian(self):
        return self.FormType() == 'ExtendToMeridian'

    def FormPath(self):
        if self._formpath is None:
            self._formpath = '%(path)s/form::%(form)s/' % {'path':self._path, 'form':self.FormType()}
        return self._formpath

    def Source(self):
        if specification.have_option(self.FormPath() + 'source[0]/name'):
            return specification.get_option(self.FormPath() + 'source[0]/name')
        else:
            return 'legacy'

    # Raster options
    #if form == 'Raster':
    def Region(self):
        if self._bounds is None:
            self._bounds = Bounds(brep=self)
        return self._bounds

    def MinimumArea(self):
        if specification.have_option(self.FormPath() + 'minimum_area'):
            return specification.get_option(self.FormPath() + 'minimum_area')
        else:
            return universe.default.minarea

    def ContourType(self):
        if specification.have_option(self.FormPath() + 'contourtype[0]'):
            return specification.get_option(self.FormPath() + 'contourtype[0]/name')
        else:
            return universe.default.contourtype

    def ExcludeIceshelfCavities(self):
        path = '%(form)scontourtype::%(contour)s/exclude_iceshelf_ocean_cavities' % {'form':self.FormPath(), 'contour':self.ContourType()}
        if specification.have_option(path):
            return specification.have_option(path)
        else:
            return universe.default.exclude_iceshelf_ocean_cavities

    def Boundary(self):
        if self._boundary is None:
            if specification.have_option(self.FormPath() + 'boundary'):
                boundaries = specification.get_option(self.FormPath() + 'boundary').split()
                self._boundary = [int(i) for i in boundaries]
            else:
                self._boundary = universe.default.boundaries
        return self._boundary

    def BoundaryToExclude(self):
        if self._boundary_to_exclude is None:
            if specification.have_option(self.FormPath() + 'boundary_to_exclude'):
                boundaries = specification.get_option(self.FormPath() + 'boundary_to_exclude').split()
                self._boundary_to_exclude = [int(i) for i in boundaries]
            else:
                self._boundary_to_exclude = universe.default.boundariestoexclude
        return self._boundary_to_exclude

    def SelectedPaths(self, valid_paths = None):
        if valid_paths is None:
            if self._selected_paths is None:
                # Generate list of valid paths for this part of the boundary representation
                valid = []
                for p in range(len(self._pathall)):
                    path = p + 1
                    # If the path is in the list of boundaries to exclude, then skip
                    if path in self.BoundaryToExclude():
                        continue
                    # If a list of valid boundaries has been provided, and the path is not contained, then skip
                    if self.Boundary():
                        if path not in self.Boundary():
                            continue
                    # Add further tests here, on area, ...?
                    # If the path suceeds through the above tests, add it to the list of valid paths
                    valid.append(path)
                self._selected_paths = valid
        else:
            self._selected_paths = valid_paths
        return self._selected_paths

    def ExteriorBoundary(self, valid_paths = None):
        if specification.have_option(self.FormPath() + 'exterior_boundary'):
            return specification.get_option(self.FormPath() + 'exterior_boundary')
        # If the list of valid paths contains paths, chose the first path in the list
        elif self.SelectedPaths(valid_paths=valid_paths):
            return self.SelectedPaths(valid_paths = valid_paths)[0].reference_number
        # Add further choices?  Based on length of path, nodes in path, area encompased?

    def isExterior(self, number, valid_paths=None):
        return number == self.ExteriorBoundary(valid_paths=valid_paths)

    def AppendParameters(self):
        self._surface_rep.report('Reading boundary representation %(name)s', var = {'name':self.Name()}, indent=1)
        if len(self.Boundary()) > 0:
            self.report('Boundaries restricted to paths: ' + list_to_comma_separated(self.Boundary()), indent=1)
        if str(self.Region()) is not 'True':
            self.report('Region defined by ' + str(self.Region()), indent=1)
        self.report('Open contours closed with a line formed by points spaced %(dx)gm apart' % {'dx':self.Spacing()}, indent=1)
        self.AddComment('')

    def Dataset(self):
        name = self.Source()
        if name not in self._surface_rep.spatial_discretisation.Dataset().keys():
            raise Exception
            error("Component BRep '%(brep)s' requires the dataset '%(dataset)s', but this cannot be sourced." % {'brep':self.Name(), 'dataset':name}, fatal = True)
        return self._surface_rep.spatial_discretisation.Dataset()[name]

    def identifyOpen(self, components):
        open_components = []
        for i, component in enumerate(components):
            #continue
            #print i, len(component.components[0].valid_location), component.components[0].isClosed()
            if not component.components[0].isClosed():
                open_components.append(component)
        return open_components


    def isClosed(self, following=None):

        from itertools import izip
        def pairwise(t):
            it = iter(t)
            return izip(it,it)

        #if following:
        #    print len(self.components), len(following.components)

        if following:
            return self.components[-1].isClosed(following=following.components[0])

        if len(self.components) == 1:
            return self.components[0].isClosed()

        connected = []
        #for pair in pairwise(self.components):
        for pair in zip(self.components, self.components[1:]):
            connected.append(pair[0].isClosed(pair[1]))
        connected.append(self.components[-1].isClosed(self.components[0]))


        return all(connected)


    def Generate(self, components=[]):
        import os
        #self.AddSection('BRep component: ' + self.Name())
        #print 'Name', self.Name()

        components_new = []
        if self.isShapefile():
            self.AppendParameters()
            dataset = self.Dataset()
            dataset.AppendParameters()
            dataset.CheckSource()

            from Import import ReadShape
            self.report('Reading polylines, from shapefile: ' + dataset.LocationFull(), include = False, indent = 1)
            p = ReadShape(self, dataset)
            #print p
            self._pathall = ReadShape(self, dataset)

            self.output_boundaries()

            if (universe.plotcontour):
                self.PlotFoundPaths()

            # Best to interpolate later at time of writing?, also need to process project properly
            #components_new = [self.Reproduce(components=[p.Interpolate(spacing=1000.0)], total=len(self.components)) for p in self.components]
            components_new = [self.Reproduce(components=[p], total=len(self.components)) for p in self.components]

        if self.isRaster():

            self.AppendParameters()
            dataset = self.Dataset()
            dataset.AppendParameters()
            dataset.CheckSource()
            if dataset.cache and os.path.exists(dataset.cachefile):
                dataset.CacheLoad()
            else:
                from Import import ReadPaths
                self.report('Generating contours, from raster: ' + dataset.LocationFull(), include = False, indent = 1)
                self._pathall = ReadPaths(self, dataset)
                dataset.CacheSave()

            self.output_boundaries()

            if (universe.plotcontour):
                self.PlotFoundPaths()

            # Best to interpolate later at time of writing?, also need to process project properly
            #components_new = [self.Reproduce(components=[p.Interpolate(spacing=1000.0)], total=len(self.components)) for p in self.components]
            components_new = [self.Reproduce(components=[p], total=len(self.components)) for p in self.components]

        elif self.isParallel():
            #self.output_open_boundaries()

            index = self.index

            index.start = index.point + 1
            loopstartpoint = index.start

            p = EnrichedPolyline(self, vertices=[ ( 179.99, self.BoundingLatitude()), (-0.01, self.BoundingLatitude())], is_exterior = True, initialise_only=True)

            #print '----'
            # Use p in draw_parallel_explicit, not just as a method
            paths = p.draw_parallel_explicit(None)
            #print 'A', paths
            for path in paths:
                path.projection = 'LongLat'
                self.components.append(path)

            p = EnrichedPolyline(self, vertices=[ ( 0.01, self.BoundingLatitude()), (-179.99, self.BoundingLatitude())], is_exterior = True, initialise_only=True)
            paths = p.draw_parallel_explicit(None)
            #index, paths = p.draw_parallel_explicit(self, [-179.99,  self.BoundingLatitude()], [   0.01, self.BoundingLatitude()], index, self.Spacing()/10.0, None)
            #print 'B', paths
            for path in paths:
                path.projection = 'LongLat'
                self.components.append(path)

            components_new = [self]
            #components_new = [self.Reproduce(components=self.components)]

            #index, paths = d1raw_parallel_explicit(self, a, b, index, self.Spacing(), None)
            #for path in paths: p.components.append(path)

            #index = p.AddLoop(index, loopstartpoint, True)

        elif self.isBoundingBox():
            comment = []
            from itertools import izip
            def pairwise(t):
                it = iter(t)
                return izip(it,it)


            bounds = Bounds(path=self.FormPath())
            bounds = bounds.GetMaxBounds()

            index = self.index

            comment.append('Creating a bounding box to enclose ' + str(bounds))

            index.start = index.point + 1
            loopstartpoint = index.start

            a = [ bounds[0], bounds[1] ]
            b = [ bounds[2], bounds[1] ]
            c = [ bounds[2], bounds[3] ]
            d = [ bounds[0], bounds[3] ]

            bounds = (a, b, c, d)

            for bound in zip(*[bounds[i:]+bounds[:i] for i in range(2)]):
                comment = []
                comment.append('Drawing bounding box line ' + str(bound))
                #print '++++', bound
                #paths.append(EnrichedPolyline(shape=LineString(path), rep=rep, initialise_only=True, comment=comment))
                p = EnrichedPolyline(self, shape=LineString(bound), initialise_only=True, is_exterior=True, comment=comment)
                p.Interpolate()
                #p.Project()

                #print p.shape.coords[:]

                self.components.append(p)

            components_new = [self.Reproduce(components=self.components)]

            # When joining paths, eliminate repeated Point definitions


            #import sys
            #sys.exit()


            #p = EnrichedPolyline(self, reference_number = None, is_exterior = True)


            #index, paths = d1raw_parallel_explicit(self, a, b, index, self.Spacing(), None)
            #for path in paths: p.components.append(path)
            #index, paths = d1raw_parallel_explicit(self, b, c, index, self.Spacing(), None)
            #for path in paths: p.components.append(path)
            #index, paths = d1raw_parallel_explicit(self, c, d, index, self.Spacing(), None)
            #for path in paths: p.components.append(path)
            #index, paths = d1raw_parallel_explicit(self, d, a, index, self.Spacing(), None)
            #for path in paths: p.components.append(path)

            #index = p.AddLoop(index, loopstartpoint, True)


        elif self.isExtendToParallel():
            latitude = specification.get_option(self.FormPath() + 'latitude')

            open_components = self.identifyOpen(components)
            if not open_components:
                error("No open components available to close with an extension to parallel", fatal=True)
            p = open_components[-1]

            #p = self.PreviousBRepComponent()
            self.comment.append('Extending exterior boundary developed in %(previous_brep)s to parallel %(parallel)s' % {'previous_brep':p.Name(), 'parallel':latitude})
            self.report('Extending exterior boundary developed in %(previous_brep)s to parallel %(parallel)s', var = {'previous_brep':p.Name(), 'parallel':latitude}, indent = 1)
            # Check past BRep component is not complete
            #if p.isComplete():
            #    error('Mesh model misconfiguration. Previous boundary representation %(previous_brep)s is complete.  Unable to now extend this boundary to the parallel %(parallel)s' % {'previous_brep':p.Name(), 'parallel':latitude}, fatal = True)

            #print self.Identification()
            # Pick up previous BRep component
            n = EnrichedPolyline(self)
            n.CopyOpenPart(p.components[-1])


            #print project(n.valid_location[0], projection_type=self.Projection())
            #print project(n.valid_location[1], projection_type=self.Projection())

            #print n.valid_location

            p._name = p.Name() + ' AND ' + self.Name()

            #n = p.components[-1].CopyOpenPart()
            #print n.Identification()

            # Close BRep and complete
            paths = n.draw_parallel_explicit(latitude)

            #print p.components
            for path in paths:
                path.projection = 'LongLat'
                p.components.append(path)
            #print p.components

        elif self.isExtendToMeridian():
            longitude = specification.get_option(self.FormPath() + 'longitude')

            #p = self.PreviousBRepComponent()
            open_components = self.identifyOpen(components)
            if not open_components:
                error("No open components available to close with an extension to parallel", fatal=True)
            p = open_components[-1]

            self.comment.append('Extending exterior boundary developed in %(previous_brep)s to meridian %(meridian)s' % {'previous_brep':p.Name(), 'meridian':longitude})
            self.report('Extending exterior boundary developed in %(previous_brep)s to meridian %(meridian)s', var = {'previous_brep':p.Name(), 'meridian':longitude}, include = True, indent = 1)
            # Check past BRep component is not complete
            #if p.isComplete():
            #    error('Mesh model misconfiguration. Previous boundary representation %(previous_brep)s is complete.  Unable to now extend this boundary to the meridian %(meridian)s' % {'previous_brep':p.Name(), 'meridian':longitude}, fatal = True)

            #  # Pick up previous BRep component
            #  #n = EnrichedPolyline(self)
            #  n = p.components[-1].CopyOpenPart()

            #print self.Identification()
            # Pick up previous BRep component
            n = EnrichedPolyline(self)
            n.CopyOpenPart(p.components[-1])

            #print project(n.valid_location[0], projection_type=self.Projection())
            #print project(n.valid_location[1], projection_type=self.Projection())

            #print n.valid_location

            p._name = p.Name() + ' AND ' + self.Name()

            # Close BRep and complete
            paths = n.draw_meridian_explicit(longitude)

            for path in paths:
                path.projection = 'LongLat'
                p.components.append(path)

        #else:
        #    error('BRepComponent ' + self.Name() + ' of type ' + self.FormType() + ' not processed' + str(self.isPolyline()))

        #print self.components
        #print
        #print [self.Reproduce(components=[p]) for p in self.components]

        #print 1+len(self.components)
        #print 1+len([self.Reproduce(components=[p]) for p in self.components])


        #for p in self.components:
        #    a = self.Reproduce(components=[p])
        #    print '**', p
        #    print len(p.valid_location)
        #    print a
        #    print a.components
        #    print len(a.components)
        #    print len(a.components[0].valid_location)
        #    #print p.valid_location

        # Multi-component BReps are split up
        #  note these may become multi-enrichedlines later
        #  e.g. when extended to an orthodrome
        #components_new = [self.Reproduce(components=[p], total=len(self.components)) for p in self.components]

        #print
        #print len(components), components
        #print len(components_new), components_new

        # Run through all components and link children

        #for i, p in enumerate(self.components):
        #    b= p.shape.bounds
        #    if min(b) == -180 or max(b) == 180:
        #        print i+1, b

        components_new = self.Join(components + components_new)

        return components_new

    #def getSingleComponent(self):
    #    if len(self.components) > 1:
    #        error('BRepComponent %(name)s has more than one pathline when only one expected' % {'name':self.Name() }, fatal=True)
    #    return self.components[0]

    def getEnds(self):
        #print self.Name(), len(self.components)
        return self.components[0].ends[0], self.components[-1].ends[1]

    @property
    def ends(self):
        return self.components[0].loopstart, self.components[-1].loopend

    @property
    def components_reversed(self):
        return [x.reversed() for x in reversed(self.components)]

    def update_component_order(self):
        for i, component in enumerate(self.components):
            #print i, component
            #print i
            #print ' ', i, (i - 1) % len(brep.components)
            component.before = self.components[(i - 1) % len(self.components)]
            #print ' ', i, (i + 1) % len(brep.components)
            component.after = self.components[(i + 1) % len(self.components)]

    def Join(self, components):
        import itertools
        open_components = self.identifyOpen(components)

        pair = None

        for first_i in range(len(open_components)):
            first = open_components[first_i]

            for other_i in range(len(open_components)):
                if first_i == other_i:
                    continue
                other = open_components[other_i]
                if not first.components or not other.components:
                    continue

                for i, j in itertools.product(range(2), range(2)):
                    #print i, j, first.ends[i], other.ends[j], c1ompare_points(first.ends[i], other.ends[j], self.Spacing())
                    #print first.Name(), other.Name(), first.ends[i], other.ends[j]
                    if first.components[0].compare_points(first.ends[i], other.ends[j]):
                    #if first.isClosed(other):
                        pair = i, j
                        break
                if pair:
                    #print 'Merge', first, other
                    #print i, j, first.ends[i], other.ends[j]
                    if (i, j) == (1, 0):
                        first._name = first.Name() + ' AND ' + other.Name()
                        first.components = first.components + other.components
                    elif (i, j) == (0, 1):
                        first._name = other.Name() + ' AND ' + first.Name()
                        first.components = other.components + first.components
                    elif (i, j) == (1, 1):
                        #error('Reversal needed, also for first possibly?  Not implemented', fatal=True)
                        error('Reversal needed, also for first possibly?  Not implemented')
                        first._name = other.Name() + ' AND reversed ' + first.Name()
                        first.components = other.components + first.components_reversed
                    elif (i, j) == (0, 0):
                        #error('Reversal needed, also for first possibly?  Not implemented', fatal=True)
                        error('Reversal needed, also for first possibly?  Not implemented 2 ')
                        first._name = first.Name() + ' AND reversed ' + other.Name()
                        first.components = first.components + other.components_reversed
                    # Update_component_order needed?
                    other.components = []


        components = [x for x in components if x.components]

        return components






#    def AddHeader(self):
#        self.AddSection('Boundary Representation description')
#        self.AddSection('Header')
#        if self.isCompound():
#            edgeindex = ' + 1000000'
#        else:
#            edgeindex = ''
#        # TODO: Only include if using CounterPrefix
#        if universe.use_counter_prefix:
#            if not self.isCompound():
#                header = '''\
#  IP%(fileid)s = newp;
#  IL%(fileid)s = newl;
#  ILL%(fileid)s = newll;
#  IS%(fileid)s = news;
#  IFI%(fileid)s = newf;
#  ''' % { 'fileid':self.Fileid(), 'edgeindex':edgeindex }
#            else:
#                header = '''\
#  IP%(fileid)s = 0;
#  IL%(fileid)s = 0%(edgeindex)s;
#  ILL%(fileid)s = 0;
#  IS%(fileid)s = news;
#  IFI%(fileid)s = newf;
#  ''' % { 'fileid':self.Fileid(), 'edgeindex':edgeindex }
#            self.AddContent(header)
#
#        if (self.Projection() not in ['LongLat','proj_cartesian'] ):
#            header_polar = '''Point ( %(prefix)s0 ) = { 0, 0, 0 };
#Point ( %(prefix)s1 ) = { 0, 0, %(planet_radius)g };
#PolarSphere ( %(surface_prefix)s0 ) = { %(prefix)s0, %(prefix)s1 };
#''' % { 'planet_radius': self._surface_rep.spatial_discretisation.PlanetRadius(), 'prefix': self.CounterPrefix('IP'), 'surface_prefix':self.CounterPrefix('IS') }
#            self.AddContent(header_polar)
#
#        self.RemoveProjectionPoints()

#    def RemoveProjectionPoints(self):
#        #FIXME: Apply just in specific case?  - i.e. I need the opposite here
#        if self.Projection() == 'LongLat':
#            return
#        self.AddContent( '''Delete { Point{ %(prefix)s0 }; }
#Delete { Point{ %(prefix)s1 }; }
#''' % { 'prefix':self.CounterPrefix('IP') } )

    def AddFormattedPointQuick(self, index, loc, z=0):
        output_format = 'Point ( %(prefix)s%%i ) = { %%.%(dp)sf, %%.%(dp)sf, %%.%(dp)sf };' % { 'dp': universe.default.output_accuracy, 'prefix':self.CounterPrefix('IP') }
        self.AddContent(output_format % (index, loc[0], loc[1], z))

    def AddFormattedPoint(self, index, loc, z, project_to_output_projection_type=True):
        output_format = 'Point ( %(prefix)s%%i ) = { %%.%(dp)sf, %%.%(dp)sf, %%.%(dp)sf };' % { 'dp': universe.default.output_accuracy, 'prefix':self.CounterPrefix('IP') }
        if project_to_output_projection_type:
            output_location = project(loc, projection_type=self.Projection())
        else:
            output_location = loc
        self.AddContent(output_format % (index, output_location[0], output_location[1], z))
        #return output_location[0], output_location[1]

    def FormatPoint(self, index, loc, z, project_to_output_projection_type=True):
        #output_format = 'Point ( %(prefix)s%%i ) = { %%.%(dp)sf, %%.%(dp)sf, %%.%(dp)sf };' % { 'dp': universe.default.output_accuracy, 'prefix':self.CounterPrefix('IP') }
        if project_to_output_projection_type:
            output_location = project(loc, projection_type=self.Projection())
        else:
            output_location = loc
        #self.AddContent(output_format % (index, output_location[0], output_location[1], z))
        return (output_location[0], output_location[1], z)

    def output_boundaries(self):
        import pickle
        import os
        from numpy import zeros, concatenate
        from Mathematical import area_enclosed
        from StringOperations import strplusone
        #from Projection import compare_latitude

        self.report('Paths found: ' + str(len(self._pathall)), indent=1)

        latitude_max = self.ExtendToLatitude()

        enriched_paths = []
        for num in range(len(self._pathall)+1)[1:]:
            if (self._pathall[num-1] == None):
                continue
                #print 'PPPP'
            if self.isShapefile():
                p = EnrichedPolyline(self, shape=self._pathall[num-1], reference_number = num, initialise_only=True)
                #print p.shape.geom_type
                #print p.isClosed()
            else:
                p = EnrichedPolyline(self, contour=self._pathall[num-1], reference_number = num, initialise_only=True)
            if p.shape is not None:
                enriched_paths.append(p)

        enriched_paths = sorted(enriched_paths, reverse=True)
        for number, p in enumerate(enriched_paths):
          p.reference_number = number + 1


        # Add as a property of BRep, and use below
        dateline=[]
        for i, p in enumerate(enriched_paths):
            if (abs(p.loopstart[0]) == 180) and (abs(p.loopend[0]) == 180):
                if p.loopstart[1] != p.loopend[1]:
                    #print p.loopstart[1], p.loopend[1]
                    dateline.append(i)

        # Instead of merging add make multicomponent - easier to plot then also
        merged = []
        for i in dateline:
            p = enriched_paths[i]
            if not p:
                continue
            #print "*", i, p.ends
            for j in dateline:
                if i == j:
                    continue
                q = enriched_paths[j]
                if not q:
                    continue
                #print i, j, p.loopend, q.loopstart, p.loopstart, q.loopend
                if p.compare_points_source(p.loopend, q.loopstart) and p.compare_points_source(p.loopstart, q.loopend):
                    #asc HERE broken
                    enriched_paths[i] = EnrichedPolyline(self, vertices=p.shape.coords[:] + q.shape.coords[:], reference_number = num, initialise_only=True)
                    enriched_paths[j] = None
                    merged.append((i+1, j+1))
                    break
                elif p.compare_points_source(p.loopend, q.loopend) and p.compare_points_source(p.loopstart, q.loopstart):
                    #asc HERE broken
                    # need to reverse
                    #enriched_paths[i] = EnrichedPolyline(self, vertices=p.shape.coords[:] + reversed(q.shape.coords[:]), reference_number = num, initialise_only=True)
                    enriched_paths[i] = EnrichedPolyline(self, vertices=p.shape.coords[:] + q.shape.coords[::-1], reference_number = num, initialise_only=True)
                    enriched_paths[j] = None
                    merged.append((i+1, -(j+1)))
                    break
           # if merged:
           #     break

        #print 'TO'
        #for i, d in enumerate(dateline):
        #  if d:
        #    print i+1, d.ends

        #self.report('Merged paths that cross the date line: ' + ' '.join(map(strplusone,appended)), indent = 1)
        if merged:
          self.report('Merged %d paths that cross the date line' % len(merged), indent = 1)
          #self.report('  merged: ' + str(merged), indent = 1)

        enriched_paths = [x for x in enriched_paths if x is not None]
        enriched_paths = sorted(enriched_paths, reverse=True)

        for number in range(len(enriched_paths)):
            #enriched_paths[number] = EnrichedPolyline(self, vertices=enriched_paths[number].vertices, reference_number=number+1)
            enriched_paths[number].reference_number = number+1
            #print enriched_paths[number].isClosed()

        paths = self.Boundary()

        pathvalid = []
        if ((paths is not None) and (len(paths) > 0)):
            for p in enriched_paths:
                if p.reference_number in paths:
                    pathvalid.append(p)
                    break
        else:
            for p in enriched_paths:
                if (p.AreaEnclosed() < self.MinimumArea()):
                    p._valid = False
                    continue
                if p.reference_number in self.BoundaryToExclude():
                    p._valid = False
                    continue
                if p.isIncluded():
                    p._valid = True
                    pathvalid.append(p)

        numbers = []
        for p in pathvalid:
          numbers.append(p.reference_number)
        #self.report('Paths found valid (renumbered order): ' + str(len(pathvalid)) + ', including ' + ' '.join(map(str, numbers)), indent = 1)
        self.report('Paths found valid (renumbered order): ' + str(len(pathvalid)) + ', including ' + list_to_space_separated(numbers, concatenate=True), indent = 1)

        if (len(pathvalid) == 0):
            self.report('No valid paths found.', indent = 1)
            error("No valid paths found.")

        #if universe.smooth_data:
        #  for num in pathvalid:
        #    if (self._pathall[num-1] == None):
        #      continue
        #    xy=self._pathall[num-1].vertices
        #    origlen=len(xy)
        #    x = smoothGaussian(xy[:,0], degree=universe.smooth_degree)
        #    y = smoothGaussian(xy[:,1], degree=universe.smooth_degree)
        #    xy = zeros([len(x),2])
        #    xy[:,0] = x
        #    xy[:,1] = y
        #    self._pathall[num-1].vertices = xy
        #    self.report('Smoothed path %d, nodes %d from %d' % (num, len(xy), origlen))
        self._valid_paths = pathvalid
        self._pathall_enriched = enriched_paths

        for p in pathvalid:
            p.is_exterior = self.isExterior(p.reference_number, valid_paths = pathvalid)
            if p.is_exterior:
                self.exterior.append(p)
            else:
                if p.isClosed():
                    self.interior.append(p)
                else:
                    report('Interior path %(number)s skipped, not a complete island', var = {'number':p.reference_number}, indent=2)

        #report('Processing paths:', indent=1)
        # Examine all EnrichedPathlines p
        p = None
        for p in self.interior:
            if p.isClosed():
                area_string = '   area %(area)g' % {'area':p.AreaEnclosed()}
            else:
                area_string = ''
            report('Interior path %(number)s%(area)s', var = {'number':p.reference_number, 'area':area_string}, indent=2)
            #self.index = p.Generate(self.index)
            self.components.append(p)
        for p in self.exterior:
            if p.isClosed():
                area_string = '   area %(area)g' % {'area':p.AreaEnclosed()}
            else:
                area_string = ''
            report('Exterior path %(number)s%(area)s', var = {'number':p.reference_number, 'area':area_string}, indent=2)
            #self.index = p.Generate(self.index)

        self.components = self.interior + self.exterior
        return self._valid_paths



    def PlotFoundPaths(self):
        boxes = []
        if specification.have_option(self.FormPath() + 'box'):
            boxes = specification.get_option(self.FormPath() + 'box').split()

        PlotContours(self._pathall_enriched, boxes=boxes)



    # def output_open_boundaries(self):
    #
    #     index = self.index

    #     index.start = index.point + 1
    #     loopstartpoint = index.start


    #     p = EnrichedPolyline(self, reference_number = None, is_exterior = True)

    #     index = d1raw_parallel_explicit(self, [   -1.0, self.BoundingLatitude()], [ 179.0, self.BoundingLatitude()], index, self.Spacing(), None)
    #     index = d1raw_parallel_explicit(self, [-179.0,  self.BoundingLatitude()], [   1.0, self.BoundingLatitude()], index, self.Spacing(), None)

    #     index = p.AddLoop(index, loopstartpoint, True)


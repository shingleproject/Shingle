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

from Universe import universe
from Reporting import report, error
from Import import read_paths
from StringOperations import expand_boxes, bound_by_latitude, list_to_comma_separated, list_to_space_separated
from RepresentationTools import draw_parallel_explicit
from RepresentationTools import EnrichedPolyline
from Projection import project
from Spud import specification
from Plot import PlotContours


class BRepComponent(object):

    def __init__(self, surface_rep, number, pathall=None):
        self._name = None
        self._path = None
        self._formpath = None
        self._form_type = None
        self._surface_rep = None
        self._representation_type = None

        self._region = None
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

        self.number = number
        self._surface_rep = surface_rep
        self._path = '/geoid_surface_representation::%(name)s/brep_component::%(brep_name)s' % {'name':self._surface_rep.name, 'brep_name':self.Name()}
        self.index = self._surface_rep.index
        self._pathall = pathall

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

    def FormType(self):
        if self._form_type is None:
            if specification.have_option(self._path + '/form[0]/name'):
                self._form_type = specification.get_option(self._path + '/form[0]/name')
            else:
                self._form_type = 'Raster'
        # Useful to catch this at the moment:
        if self._form_type in 'Polyline':
            raise NotImplementedError
        if self._form_type not in ['Raster', 'Parallel', 'ExtendToParallel', 'ExtendToMeridian']:
            raise NotImplementedError
        return self._form_type

    def isRaster(self):
        return self.FormType() == 'Raster'

    def isParallel(self):
        return self.FormType() == 'Parallel'

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
        if self._region is None:
            region = universe.default.region
            if specification.have_option(self.FormPath() + 'region'):
                region = specification.get_option(self.FormPath() + 'region')
            if specification.have_option(self.FormPath() + 'box'):
                box = specification.get_option(self.FormPath() + 'box').split()
                from os import linesep
                self.AddComment('Imposing box region: ' + (linesep + '  ').join([''] + box))
                region = expand_boxes(region, box )
            bounding_latitude = self.BoundingLatitude()
            if bounding_latitude is not None:
                self.AddComment('Bounding by latitude: ' + str(bounding_latitude))
                region = bound_by_latitude(region, bounding_latitude)
            self.AddComment('Region of interest: ' + region)
            self._region = region
        return self._region

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
        if self.Region() is not 'True':
            self.report('Region defined by ' + str(self.Region()), indent=1)
        self.report('Open contours closed with a line formed by points spaced %(dx)g degrees apart' % {'dx':self.Spacing()}, indent=1)
        self.AddComment('')

    def Dataset(self):
        name = self.Source()
        if name not in self._surface_rep.spatial_discretisation.Dataset().keys():
            error("Component BRep '%(brep)s' requires the dataset '%(dataset)s', but this cannot be sourced." % {'brep':self.Name(), 'dataset':name}, fatal = True)
        return self._surface_rep.spatial_discretisation.Dataset()[name]

    def GenerateContour(self):
        from Import import read_paths
        dataset = self.Dataset()
        self.report('Generating contours, from raster: ' + dataset.LocationFull(), include = False, indent = 1)
        self._pathall = read_paths(self, dataset, dataset.LocationFull())

    def Generate(self):
        import os
        self.AddSection('BRep component: ' + self.Name())

        if self.isRaster():
            self.AppendParameters()
            dataset = self.Dataset()
            dataset.AppendParameters()
            dataset.CheckSource()
            if dataset.cache and os.path.exists(dataset.cachefile):
                dataset.CacheLoad()
            else:
                self.GenerateContour()
                dataset.CacheSave()

            self.report('Paths found: ' + str(len(self._pathall)), indent=1)
            self.output_boundaries()
            
            if (universe.plotcontour):
                self.PlotFoundPaths()
            self.PathProcess()

        elif self.isParallel():
            self.output_open_boundaries()

        elif self.isExtendToParallel():
            latitude = specification.get_option(self.FormPath() + 'latitude')
            p = self.PreviousBRepComponent()
            self.report('Extending exterior boundary developed in %(previous_brep)s to parallel %(parallel)s', var = {'previous_brep':p.Name(), 'parallel':latitude}, include = True, indent = 1)
            # Check past BRep component is not complete
            if p.isComplete():
                error('Mesh model misconfiguration. Previous boundary representation %(previous_brep)s is complete.  Unable to now extend this boundary to the parallel %(parallel)s' % {'previous_brep':p.Name(), 'parallel':latitude}, fatal = True)

            # Pick up previous BRep component
            n = EnrichedPolyline(self)
            n.CopyOpenPart(p.components[-1])

            # Close BRep and complete
            self.index = n.ClosePathEndToStart(self.index, extend_to_latitude = latitude)

        elif self.isExtendToMeridian():
            longitude = specification.get_option(self.FormPath() + 'longitude')
            p = self.PreviousBRepComponent()
            self.report('Extending exterior boundary developed in %(previous_brep)s to meridian %(meridian)s', var = {'previous_brep':p.Name(), 'meridian':longitude}, include = True, indent = 1)
            # Check past BRep component is not complete
            if p.isComplete():
                error('Mesh model misconfiguration. Previous boundary representation %(previous_brep)s is complete.  Unable to now extend this boundary to the meridian %(meridian)s' % {'previous_brep':p.Name(), 'meridian':longitude}, fatal = True)

            # Pick up previous BRep component
            n = EnrichedPolyline(self)
            n.CopyOpenPart(p.components[-1])

            # Close BRep and complete
            self.index = n.ClosePathEndToStartLongitude(self.index, extend_to_longitude = longitude)










    def AddHeader(self):
        self.AddSection('Boundary Representation description')
        self.AddSection('Header')
        if self.isCompound():
            edgeindex = ' + 1000000'
        else:
            edgeindex = ''
        # TODO: Only include if using CounterPrefix
        if universe.use_counter_prefix:
            if not self.isCompound():
                header = '''\
  IP%(fileid)s = newp;
  IL%(fileid)s = newl;
  ILL%(fileid)s = newll;
  IS%(fileid)s = news;
  IFI%(fileid)s = newf;
  ''' % { 'fileid':self.Fileid(), 'edgeindex':edgeindex }
            else:
                header = '''\
  IP%(fileid)s = 0;
  IL%(fileid)s = 0%(edgeindex)s;
  ILL%(fileid)s = 0;
  IS%(fileid)s = news;
  IFI%(fileid)s = newf;
  ''' % { 'fileid':self.Fileid(), 'edgeindex':edgeindex }
            self.AddContent(header)

        if (self.Projection() not in ['longlat','proj_cartesian'] ):
            header_polar = '''Point ( %(prefix)s0 ) = { 0, 0, 0 };
Point ( %(prefix)s1 ) = { 0, 0, %(planet_radius)g };
PolarSphere ( %(surface_prefix)s0 ) = { %(prefix)s0, %(prefix)s1 };
''' % { 'planet_radius': self._surface_rep.spatial_discretisation.PlanetRadius(), 'prefix': self.CounterPrefix('IP'), 'surface_prefix':self.CounterPrefix('IS') }
            self.AddContent(header_polar)

        self.RemoveProjectionPoints()

    def RemoveProjectionPoints(self):
        #FIXME: Apply just in specific case?  - i.e. I need the opposite here
        if self.Projection() == 'longlat':
            return
        self.AddContent( '''Delete { Point{ %(prefix)s0 }; }
Delete { Point{ %(prefix)s1 }; }
''' % { 'prefix':self.CounterPrefix('IP') } )


    def AddFormattedPoint(self, index, loc, z, project_to_output_projection_type=True):
        output_format = 'Point ( %(prefix)s%%i ) = { %%.%(dp)sf, %%.%(dp)sf, %%.%(dp)sf };' % { 'dp': universe.default.output_accuracy, 'prefix':self.CounterPrefix('IP') }
        if project_to_output_projection_type:
            output_location = project(loc, projection_type=self.Projection())
        else:
            output_location = loc
        self.AddContent(output_format % (index, output_location[0], output_location[1], z))

    def output_boundaries(self):
        import pickle
        import os
        from numpy import zeros, concatenate
        from Mathematical import area_enclosed
        from StringOperations import strplusone
        from Projection import compare_latitude

        latitude_max = self.ExtendToLatitude()

        self.AddHeader()
        splinenumber = 0
        indexbase = 1
        self.index.point = indexbase

        enriched_paths = []
        for num in range(len(self._pathall)+1)[1:]:
            if (self._pathall[num-1] == None):
                continue
            p = EnrichedPolyline(self, contour=self._pathall[num-1], reference_number = num, initialise_only=True)
            if p.shape is not None:
                enriched_paths.append(p)

        enriched_paths = sorted(enriched_paths, reverse=True)
        for number, p in enumerate(enriched_paths):
          p.reference_number = number + 1

        ends = zeros([len(enriched_paths),4])
        for num in range(len(enriched_paths)):
            ends[num,:] = [
                enriched_paths[num].vertices[0][0], 
                enriched_paths[num].vertices[0][1],
                enriched_paths[num].vertices[-1][0],
                enriched_paths[num].vertices[-1][1]] 

        dateline=[]
        for num in range(len(enriched_paths)):
            if (abs(ends[num,0]) == 180) and (abs(ends[num,2]) == 180):
                if (ends[num,1] != ends[num,3]):
                    dateline.append(num)

        matched = []
        appended = []
        for num in dateline:
            if num in matched:
                continue
            matches = []
            for i in dateline:
                if (i == num):
                    continue
                if compare_latitude(ends[num,1], ends[i,1], self.SourceResolution()[1]) and compare_latitude(ends[num,3], ends[i,3], self.SourceResolution()[1]):
                    # match found, opposite orientation
                    matches.append((i, True))
                if compare_latitude(ends[num,1], ends[i,3], self.SourceResolution()[1]) and compare_latitude(ends[num,3], ends[i,1], self.SourceResolution()[1]):
                    # match found, same orientation
                    matches.append((i, False))

            report('Path %d crosses date line' % (num + 1), indent=1, debug=False)

            if (len(matches) > 1):
                error('Matches:')
                print matches
                error('More than one match found for path %d' % (num + 1), indent=2, fatal=True)
                sys.exit(1)
            elif (len(matches) == 0):
                self.report('No match found for path %d' % (num + 1), indent=2)

            if (len(matches) > 0):
                match = matches[0][0]
                orientation = matches[0][1]
                report('  match %d - %d (%s)' % (num + 1, match + 1, str(orientation)), debug=True)
                if orientation:
                    enriched_paths[num].vertices = concatenate((
                        enriched_paths[num].vertices[:-2,:],
                        enriched_paths[match].vertices[::-1]), axis=0) 
                else:
                    enriched_paths[num].vertices = concatenate((
                        enriched_paths[num].vertices[:-2,:],
                        enriched_paths[match].vertices), axis=0) 
                enriched_paths[num] = EnrichedPolyline(self, vertices=enriched_paths[num].vertices, reference_number=enriched_paths[num].reference_number, initialise_only=True)
                enriched_paths[match] = None
                matched.append(match)
                appended.append(num)

        self.report('Merged paths that cross the date line: ' + ' '.join(map(strplusone,appended)), indent = 1)
         
        enriched_paths = [x for x in enriched_paths if x is not None]
        enriched_paths = sorted(enriched_paths, reverse=True)

        for number in range(len(enriched_paths)):
            enriched_paths[number] = EnrichedPolyline(self, vertices=enriched_paths[number].vertices, reference_number=number+1)

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
        self.report('Paths found valid (renumbered order): ' + str(len(pathvalid)) + ', including ' + ' '.join(map(str, numbers)), indent = 1)
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



    def PlotFoundPaths(self):
        boxes = []
        if specification.have_option(self.FormPath() + 'box'):
            boxes = specification.get_option(self.FormPath() + 'box').split()

        PlotContours(self._pathall_enriched, boxes=boxes)
    
    def PathProcess(self):
        for p in self._valid_paths:
            p.SetExterior(self.isExterior(p.reference_number, valid_paths = self._valid_paths))
            if p.isValid():
                if p.isExterior():
                    self.exterior.append(p)
                else:
                    if p.shape.type == 'Polygon':
                        self.interior.append(p)
                    else:
                        report('Interior path %(number)s skipped, not a complete island', var = {'number':p.reference_number}, indent=2)
                        

        report('Processing paths:', indent=1)
        p = None
        for p in self.interior:
            if p.isClosed():
                area_string = '   area %(area)g' % {'area':p.AreaEnclosed()}
            else:
                area_string = ''
            report('Interior path %(number)s%(area)s', var = {'number':p.reference_number, 'area':area_string}, indent=2)
            self.index = p.Generate(self.index)
        for p in self.exterior:
            if p.isClosed():
                area_string = '   area %(area)g' % {'area':p.AreaEnclosed()}
            else:
                area_string = ''
            report('Exterior path %(number)s%(area)s', var = {'number':p.reference_number, 'area':area_string}, indent=2)
            self.index = p.Generate(self.index)
        if p:
          self.components.append(p)

    def output_open_boundaries(self):
        
        index = self.index

        index.start = index.point + 1
        loopstartpoint = index.start


        p = EnrichedPolyline(self, reference_number = None, is_exterior = True)

        index = draw_parallel_explicit(self, [   -1.0, self.BoundingLatitude()], [ 179.0, self.BoundingLatitude()], index, self.Spacing(), None)
        index = draw_parallel_explicit(self, [-179.0,  self.BoundingLatitude()], [   1.0, self.BoundingLatitude()], index, self.Spacing(), None)

        index = p.AddLoop(index, loopstartpoint, True)








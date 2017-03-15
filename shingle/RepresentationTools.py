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
from Projection import compare_points, project
from Mathematical import area_enclosed
from Reporting import error
from StringOperations import list_to_comma_separated

from shapely.geometry import LineString
from shapely.geometry import Polygon
from shapely.geometry.polygon import LinearRing

def check_point_required(region, location):
    import math
    # make all definitions of the math module available to the function
    globals=math.__dict__
    globals['longitude'] = location[0]
    globals['latitude']  = location[1]
    return eval(region, globals)

def complete_with_bspline(index, loopstart):
    index = rep.AddLoop(index, loopstart)
    loopstart = index
    return index, loopstart


def draw_parallel_explicit(rep, start, end, index, dx, to_parallel=None):
    from Projection import longitude_diff
    #print start, end, index.point
    # Note start is actually start - 1

    # Replace below by shapely bounding box
    if (to_parallel is None):
        to_parallel = max(start[1], end[1])
    else:
        # Generalise:
        # to_parallel = max(to_parallel, start[1], end[1])
        if (to_parallel >= start[1]) and (to_parallel >= end[1]):
            up_to_parallel = True
            to_parallel = max(to_parallel, start[1], end[1])
        elif (to_parallel <= start[1]) and (to_parallel <= end[1]):
            up_to_parallel = False
            to_parallel = min(to_parallel, start[1], end[1])
        else:
            error('Extension of domain to parallel %(parallel)s failed: Parallel appears to be contained within the domain (start: %(start).2f, end: %(end).2f).' % {'parallel':to_parallel, 'start':start[1], 'end':end[1]}, fatal=True)

    current = start 
    tolerance = dx * 0.6

    if (compare_points(current, end, dx)):
        rep.AddComment('Points already close enough, no need to draw parallels and meridians after all')
        return index
    else:
        rep.AddComment('Closing path with parallels and meridians, from (%.8f, %.8f) to  (%.8f, %.8f)' % ( start[0], start[1], end[0], end[1] ) )

    loopstart = index

    # Extend to latitude
    if (current[1] != to_parallel):
        rep.AddComment('Drawing meridian to latitude index %s at %.2f, %.2f (to match %.2f)' % (index.point, current[0], current[1], to_parallel))
    while (current[1] != to_parallel):
        if (current[1] < to_parallel):
            current[1] = current[1] + dx
        else:
            current[1] = current[1] - dx
        if (abs(current[1] - to_parallel) < tolerance): current[1] = to_parallel
        if (compare_points(current, end, dx)): return index
        index.point += 1
        rep.report('Drawing meridian to latitude index %s at %.2f, %.2f (to match %.2f)' % (index.point, current[0], current[1], to_parallel), debug=True)
        rep.AddFormattedPoint(index.point, current, 0.0, project_to_output_projection_type=True)


    if rep.MoreBSplines():
        index, loopstart = complete_as_bspline(index, loopstart)

    if (current[0] != end[0]):
        rep.AddComment('Drawing parallel index %s at %.2f (to match %.2f), %.2f' % (index.point, current[0], end[0], current[1]))
    while (current[0] != end[0]):
        if (longitude_diff(current[0], end[0]) < 0):
            current[0] = current[0] + dx
        else:
            current[0] = current[0] - dx
        #if (abs(current[0] - end[0]) < tolerance): current[0] = end[0]
        if (abs(longitude_diff(current[0], end[0])) < tolerance): current[0] = end[0]
        if (compare_points(current, end, dx)): return index
        index.point += 1
        rep.report('Drawing parallel index %s at %.2f (to match %.2f), %.2f' % (index.point, current[0], end[0], current[1]), debug=True)
        rep.AddFormattedPoint(index.point, current, 0.0, project_to_output_projection_type=True)

    if rep.MoreBSplines():
        index, loopstart = complete_as_bspline(index, loopstart)

    if (current[1] != end[1]):
        rep.AddComment('Drawing meridian to end index %s at %.2f, %.2f (to match %.2f)' % (index.point, current[0], current[1], end[1]))
    while (current[1] != end[1]):
        if (current[1] < end[1]):
            current[1] = current[1] + dx
        else:
            current[1] = current[1] - dx
        if (abs(current[1] - end[1]) < tolerance): current[1] = end[1]
        if (compare_points(current, end, dx)): return index
        index.point += 1
        rep.report('Drawing meridian to end index %s at %.2f, %.2f (to match %.2f)' % (index.point, current[0], current[1], end[1]), debug=True)
        rep.AddFormattedPoint(index.point, current, 0.0, project_to_output_projection_type=True)

    index = rep.AddLoop(index, loopstart, last=True)
    rep.AddComment( 'Closed path with parallels and meridians, from (%.8f, %.8f) to  (%.8f, %.8f)' % ( start[0], start[1], end[0], end[1] ) )

    return index



def draw_meridian_explicit(rep, start, end, index, dx, to_meridian=None):
    from Projection import longitude_diff
    # Replace below by shapely bounding box
    if (to_meridian is None):
        to_meridian = max(start[0], end[0])
    else:
        # Generalise:
        # to_meridian = max(to_meridian, start[1], end[1])
        if (to_meridian >= start[0]) and (to_meridian >= end[0]):
            up_to_meridian = True
            to_meridian = max(to_meridian, start[0], end[0])
        elif (to_meridian <= start[0]) and (to_meridian <= end[0]):
            up_to_meridian = False
            to_meridian = min(to_meridian, start[0], end[0])
        else:
            error('Extension of domain to meridian %(meridian)s failed: Merdian appears to be contained within the domain (start: %(start).2f, end: %(end).2f).' % {'meridian':to_meridian, 'start':start[0], 'end':end[0]}, fatal=True)

    current = start 
    tolerance = dx * 0.6

    if (compare_points(current, end, dx)):
        rep.AddComment('Points already close enough, no need to draw parallels and meridians after all')
        return index
    else:
        rep.AddComment('Closing path with parallels and meridians, from (%.8f, %.8f) to  (%.8f, %.8f)' % ( start[0], start[1], end[0], end[1] ) )

    loopstart = index

    # Extend to longitude
    if (current[0] != to_meridian):
        rep.AddComment('Drawing parallel to longitude index %s at %.2f, %.2f (to match %.2f)' % (index.point, current[0], current[1], to_meridian))
    while (current[0] != to_meridian):
        if (longitude_diff(current[0], to_meridian) < 0):
            current[0] = current[0] + dx
        else:
            current[0] = current[0] - dx
        if (abs(current[0] - to_meridian) < tolerance): current[0] = to_meridian
        if (compare_points(current, end, dx)): return index
        index.point += 1
        rep.report('Drawing parallel to longitude index %s at %.2f, %.2f (to match %.2f)' % (index.point, current[0], current[1], to_meridian), debug=True)
        rep.AddFormattedPoint(index.point, current, 0.0, project_to_output_projection_type=True)


    if rep.MoreBSplines():
        index, loopstart = complete_as_bspline(index, loopstart)

    # Draw meridian
    if (current[1] != end[1]):
        rep.AddComment('Drawing meridian index %s at %.2f (to match %.2f), %.2f' % (index.point, current[1], end[1], current[0]))
    while (current[1] != end[1]):
        if (current[1] < end[1]):
            current[1] = current[1] + dx
        else:
            current[1] = current[1] - dx
        #if (abs(current[0] - end[0]) < tolerance): current[0] = end[0]
        if (abs(current[1] - end[1]) < tolerance): current[1] = end[1]
        if (compare_points(current, end, dx)): return index
        index.point += 1
        rep.report('Drawing meridian index %s at %.2f (to match %.2f), %.2f' % (index.point, current[0], end[0], current[1]), debug=True)
        rep.AddFormattedPoint(index.point, current, 0.0, project_to_output_projection_type=True)

    if rep.MoreBSplines():
        index, loopstart = complete_as_bspline(index, loopstart)

    # Extend back to domain bounds
    if (current[0] != end[0]):
        rep.AddComment('Drawing parallel to end index %s at %.2f, %.2f (to match %.2f)' % (index.point, current[0], current[1], end[0]))
    while (current[0] != end[0]):
        if (longitude_diff(current[0], end[0]) < 0):
            current[0] = current[0] + dx
        else:
            current[0] = current[0] - dx
        if (abs(current[0] - end[0]) < tolerance): current[0] = end[0]
        if (compare_points(current, end, dx)): return index
        index.point += 1
        rep.report('Drawing parallel to end index %s at %.2f, %.2f (to match %.2f)' % (index.point, current[0], current[1], end[0]), debug=True)
        rep.AddFormattedPoint(index.point, current, 0.0, project_to_output_projection_type=True)

    index = rep.AddLoop(index, loopstart, last=True)
    rep.AddComment( 'Closed path with parallels and meridians, from (%.8f, %.8f) to  (%.8f, %.8f)' % ( start[0], start[1], end[0], end[1] ) )

    return index





class EnrichedPolyline(object):

    def __init__(self, rep, contour=None, vertices=None, shape=None, reference_number=None, is_exterior=False, initialise_only = False):
        self.vertices = []
        self.shape = None
        self._valid = False

        self._valid_vertices = []
        self.loopstart = None
        self.loopend = None
        self.loopstartpoint = None

        self._valid_vertices_number = 0

        self.close_last = False
        self.valid_location = None
        self.close = None
        self.point = None
        self.closingrequirednumber = 0

        # Parent boundary representation component
        self._parent_brep_component = None

        # Data spacing
        self._source_spacing = [ 0.0, 0.0 ]

        self.reference_number = None

        self._parent_brep_component = rep
        self._is_exterior = is_exterior
        if reference_number:
            self.reference_number = reference_number
        if shape is not None:
            self.shape = shape
            #self.vertices = 
        elif vertices is not None:
            self.vertices = vertices
        elif contour:
            # To reverse order:
            #self.vertices = contour.vertices[::-1]
            self.vertices = contour.vertices
            #self.shape = LineString(self.vertices)
        else:
            return


        self._valid_vertices = [False]*self.PointNumber()

        self.ConstrainPoints()

        if (self.loopend is not None):
            self.CheckPathEndToBeClosed()
            self.GetValidLocations()

        if shape is None:
            if self.close_last:
                #print self.reference_number, 'linear ring'
                self.shape = Polygon(self.vertices)
            else:
                #print self.reference_number, 'line string'
                self.shape = LineString(self.vertices)

        if initialise_only:
            return

        self.AddSection('Ice-Land mass number %s' % (self.reference_number))
        if (self.loopend is not None):
            self.isIslandCrossingMeridian()

        if not self.isIncluded():
            self.report('Path %i skipped (no points found in region)' % ( self.reference_number ), debug=True)
            self.AddComment('  Skipped (no points found in region)\n')
            return

        if (self.AreaEnclosed() < self.MinimumArea()):
            self.report('Path %i skipped (area too small)' % ( self.reference_number ), debug=True)
            self.AddComment('  Skipped (area too small)\n')
            return

        self.ReportClosingRequired()
        self._valid = True

    def __str__(self):
        return str(self.reference_number)

    def __lt__(self, other):
        if self.shape.length == other.shape.length:
            return self.shape.bounds[0] < other.shape.bounds[0]
        else:
            return self.shape.length < other.shape.length

    def CopyOpenPart(self, source):
        self._is_exterior = source._is_exterior
        self.reference_number = source.reference_number
        self.loopstartpoint = source.loopstartpoint
        self.valid_location = [ source.valid_location[0], source.valid_location[-1] ]

    def Within(self, other):
        return other.shape.within(self.shape)

    def isExterior(self):
        return self._is_exterior

    def SetExterior(self, boolean=True):
        self._is_exterior = boolean

    # Imports:
    def report(self, *args, **kwargs):
        return self._parent_brep_component.report(*args, **kwargs)

    def AddComment(self, *args, **kwargs):
        return self._parent_brep_component.AddComment(*args, **kwargs)

    def AddFormattedPoint(self, *args, **kwargs):
        return self._parent_brep_component.AddFormattedPoint(*args, **kwargs)

    def AddSection(self, *args, **kwargs):
        return self._parent_brep_component.AddSection(*args, **kwargs)

    def ExtendToLatitude(self, *args, **kwargs):
        return self._parent_brep_component.ExtendToLatitude(*args, **kwargs)

    def Spacing(self, *args, **kwargs):
        return self._parent_brep_component.Spacing(*args, **kwargs)

    def MinimumArea(self, *args, **kwargs):
        return self._parent_brep_component.MinimumArea(*args, **kwargs)


    def Projection(self, *args, **kwargs):
        return self._parent_brep_component.Projection(*args, **kwargs)

    def AddContent(self, *args, **kwargs):
        return self._parent_brep_component.AddContent(*args, **kwargs)

    def MoreBSplines(self, *args, **kwargs):
        return self._parent_brep_component.MoreBSplines(*args, **kwargs)

    def Region(self, *args, **kwargs):
        return self._parent_brep_component.Region(*args, **kwargs)

    def CloseWithParallels(self, *args, **kwargs):
        return self._parent_brep_component.CloseWithParallels(*args, **kwargs)

    def Identification(self, *args, **kwargs):
        return self._parent_brep_component.Identification(*args, **kwargs)
    def Name(self, *args, **kwargs):
        return self._parent_brep_component.Name(*args, **kwargs)
    def Fileid(self, *args, **kwargs):
        return self._parent_brep_component.Fileid(*args, **kwargs)

    def CounterPrefix(self, *args, **kwargs):
        return self._parent_brep_component.CounterPrefix(*args, **kwargs)

    def AddContent(self, *args, **kwargs):
        return self._parent_brep_component.AddContent(*args, **kwargs)

    def isCompound(self, *args, **kwargs):
        return self._parent_brep_component.isCompound(*args, **kwargs)

    def SetComplete(self, *args, **kwargs):
        return self._parent_brep_component.SetComplete(*args, **kwargs)

    def SetNotComplete(self, *args, **kwargs):
        return self._parent_brep_component.SetNotComplete(*args, **kwargs)

    # ---------------------------------------- 


    def AddLoop(self, index, loopstartpoint, last=False):
        if (index.point <= index.start):
            return index

        add_start_end_note = False
        compound_edgeindex = 100000

        if self.Identification() not in self._parent_brep_component._surface_rep.Boundary():
            error("The boundary of the component BRep '%(brep)s' is identified to '%(identification)s', but this has not been defined as a boundary." % {'brep':self.Name(), 'identification':self.Identification()}, fatal = True)

        self._parent_brep_component._surface_rep.Boundary()[self.Identification()].Add(index.path)

        index.pathsinloop.append(index.path)

        if (last):
            closure = ', %(prefix)s%(pointstart)i' % { 'pointstart':loopstartpoint, 'prefix':self.CounterPrefix('IP') }
        else:
            closure = ''

        if add_start_end_note:
            self.AddContent( '''LoopStart%(loopnumber)d = %(prefix)s%(pointstart)d;
LoopEnd%(loopnumber)d = %(prefix)s%(pointend)d;''' % { 'pointstart':index.start, 'pointend':index.point, 'loopnumber':index.path, 'loopstartpoint':closure, 'type':type, 'prefix':self.CounterPrefix('IP') } )

        if not self.isCompound():
            self.AddContent( '''BSpline ( %(prefix_line)s%(loopnumber)i ) = { %(prefix)s%(pointstart)i : %(prefix)s%(pointend)i%(loopstartpoint)s };''' % { 'pointstart':index.start, 'pointend':index.point, 'loopnumber':index.path, 'loopstartpoint':closure, 'type':type, 'prefix':self.CounterPrefix('IP'), 'prefix_line':self.CounterPrefix('IL') } )

        compoundpoints = False
        if (last):
            if self.isCompound():
                for i in range(index.start, index.point+1):
                    if i == index.point:
                        end = index.start
                    else:
                        end = i + 1
                    self.AddContent( '''Line ( %(prefix_lineloop)s%(loopnumber)i + 100000 ) = { %(prefix)s%(pointstart)i, %(prefix)s%(pointend)i };
''' % { 'pointstart':i, 'pointend':end, 'loopnumber':i, 'prefix':self.CounterPrefix('IP'), 'prefix_lineloop':self.CounterPrefix('ILL') } )

                self.AddContent( '''Compound Line ( %(prefix_line)s%(loopnumber)i ) = { %(prefix_lineloop)s%(pointstart)i : %(prefix_lineloop)s%(pointend)i };
''' % { 'pointstart':index.start, 'pointend':index.point, 'loopnumber':index.loop, 'prefix_line':self.CounterPrefix('IL'), 'prefix_lineloop':self.CounterPrefix('100000 + ILL') } )

                self.AddContent( '''Line Loop( %(prefix_lineloop)s%(loop)i ) = { %(prefix_line)s%(loopnumber)i};''' % { 'loop':index.loop, 'prefix_line':self.CounterPrefix('IL'), 'prefix_lineloop':self.CounterPrefix('ILL') } )

            else:
                self.AddContent( '''Line Loop( %(prefix_lineloop)s%(loop)i ) = { %(loopnumbers)s };''' % { 'loop':index.loop, 'prefix_lineloop':self.CounterPrefix('ILL'), 'loopnumbers':list_to_comma_separated(index.pathsinloop, prefix = self.CounterPrefix('IL')) } )

            if self.isExterior():
                index.exterior.append(index.loop)
            else:
                index.interior.append(index.loop)
            index.loops.append(index.loop)
            index.loop += 1
            index.pathsinloop = []

        self.AddContent()

        index.path +=1
        index.start = index.point

        if last:
            self.SetComplete()
        else:
            self.SetNotComplete()
        return index


    def PointNumber(self):
        return len(self.vertices[:,0])

    def SetPointInvalid(self, point):
        if self._valid_vertices[point] is True:
            self._valid_vertices[point] = False
            self._valid_vertices_number -= 1

    def SetPointValid(self, point):
        if not self._valid_vertices[point]:
            self._valid_vertices[point] = True
            self._valid_vertices_number += 1

    def ValidPointNumber(self, refresh=False):
        if refresh:
            self._valid_vertices_number = sum(self._valid_vertices)
        return self._valid_vertices_number

    def ConstrainPoints(self):
        flag = 0
        for point in range(self.PointNumber()):
            position = self.vertices[point, :]
            if ( check_point_required(self.Region(), self.vertices[point, :]) ):
                if (self.ValidPointNumber() > 0):
                    self._source_spacing[0] = max(abs(position[0] - position_previous[0]), self._source_spacing[0])
                    self._source_spacing[1] = max(abs(position[1] - position_previous[1]), self._source_spacing[1])
                position_previous = position
                self.SetPointValid(point)
                if (flag == 0):
                    self.loopstart = point
                    flag = 1
                elif (flag == 1):
                    self.loopend = point

    def isIncluded(self):
        return (self.loopend is not None)

    def isIslandCrossingMeridian(self):
        if ( (abs(self.vertices[self.loopstart, 0] - self.vertices[self.loopend, 0]) < 2 * self._source_spacing[0]) and (abs(self.vertices[self.loopstart, 1] - self.vertices[self.loopend, 1]) > 2 * self._source_spacing[1]) ):
            self.report('Path %i skipped (island crossing meridian - code needs modification to include)' % ( self.reference_number ), debug=True)
            self.AddComment('  Skipped (island crossing meridian - code needs modification to include)\n')
            error('Skipped path. Found an island crossing a bounding meridian. Investigate if further treatment required.', warning=True)

    def CheckPathEndToBeClosed(self):
        if (compare_points(self.vertices[self.loopstart,:], self.vertices[self.loopend,:], self.Spacing())):
            # Remove duplicate line at end
            #self._valid_vertices[loopend] = False
            self.SetPointInvalid(self.loopend)
            self.close_last = True

    def isClosed(self):
        return self.close_last

    def AreaEnclosed(self):
        # Use shapely
        if self.shape:
            if self.shape.type == 'Polygon':
                return self.shape.area
        if self.valid_location is not None:
            return area_enclosed(self.valid_location)
        return 0.0

    def isValid(self):
        return self._valid

    def GetValidLocations(self):
        from numpy import zeros
        self.valid_location = zeros( (self.ValidPointNumber(), 2) )
        self.close = [False]*self.ValidPointNumber()
        count = 0
        closingrequired = False
        for point in range(self.PointNumber()):
            if (self._valid_vertices[point]):
                self.valid_location[count,:] = self.vertices[point,:]
                if ((closingrequired) and (count > 0)):
                    if (compare_points(self.valid_location[count-1,:], self.valid_location[count,:], self.Spacing())):
                        closingrequired = False
                self.close[count] = closingrequired
                count += 1
                closingrequired = False
            else:
                if (not closingrequired):
                    closingrequired = True
                    self.closingrequirednumber += 1

        if (self.close_last):
            self.close[-1] = True
            self.closingrequirednumber += 1

        if (self.close[0]):
            self.close[-1] = self.close[0]


    def ReportClosingRequired(self):
        if (self.closingrequirednumber == 0): 
            closingtext = ''
        elif (self.closingrequirednumber == 1): 
            closingtext = ' (required closing in %i part of the path)' % (self.closingrequirednumber)
        else:
            closingtext = ' (required closing in %i parts of the path)' % (self.closingrequirednumber)
        self.report('Path %i: points %i (of %i) area %g%s' % ( self.reference_number, self.ValidPointNumber(), self.PointNumber(), area_enclosed(self.valid_location), closingtext ), indent = 2)


    def atEndOfValidPath(self, point):
        return ((self.close[point]) and (point == self.ValidPointNumber() - 1) and (not (compare_points(self.valid_location[point], self.valid_location[0], self.Spacing()))))


    def atPathPartToBeClosed(self, point):
        return ((self.close[point]) and (point > 0) and (not (compare_points(self.valid_location[point], self.valid_location[0], self.Spacing()))))


    def ClosePathEndToStartLongitude(self, index, extend_to_longitude = None):
        longitude = extend_to_longitude

        point = -1

        loopstartpoint = self.loopstartpoint
        start_point = self.valid_location[point]
        end_point = self.valid_location[0]

        index = self.AddLoop(index, self.loopstartpoint)
        index = draw_meridian_explicit(self._parent_brep_component, start_point, end_point, index, self.Spacing(), longitude)
        index = self.AddLoop(index, self.loopstartpoint, last=True)

        return index


    def ClosePathEndToStart(self, index, extend_to_latitude = None):
        if extend_to_latitude is None:
            latitude = self.ExtendToLatitude()
        else:
            latitude = extend_to_latitude

        point = - 1

        index = self.AddLoop(index, self.loopstartpoint)
        index = draw_parallel_explicit(self._parent_brep_component, self.valid_location[point], self.valid_location[0], index, self.Spacing(), latitude)
        index = self.AddLoop(index, self.loopstartpoint, last=True)

        return index


    def ClosePathPart(self, point, index):
        self.AddComment('Close path part (not at the end of current path, but out of bounds): Start ' + str(point) + '/' + str(self.ValidPointNumber()-1) + str(self.close[point]))
        self.AddComment(str(self.valid_location[point,:]) + str(self.valid_location[point,:]))
        index = self.AddLoop(index, self.loopstartpoint)
        index = draw_parallel_explicit(self._parent_brep_component, self.valid_location[point - 1], self.valid_location[point], index, self.Spacing(), self.ExtendToLatitude())
        index = self.AddLoop(index, self.loopstartpoint)
        self.AddComment('Close path part (not at the end of current path, but out of bounds): End of loop section ' + str(point) + '/' + str(self.ValidPointNumber()-1) + str(self.close[point]))
        return index


    def Generate(self, index):
        if not self._valid:
            return index
        self.AddSection('Ice-Land mass number %s' % (self.reference_number))

        index.start = index.point + 1
        self.loopstartpoint = index.start

        for point in range(self.ValidPointNumber()):
            self.point = point

            if self.atEndOfValidPath(point):
                self.AddComment('Keeping path %(number)d open to be closed by a later component' % {'number':self.reference_number})

            elif self.atPathPartToBeClosed(point):
                index = self.ClosePathPart(point, index)

            else:
                index.point += 1
                self.AddFormattedPoint(index.point, self.valid_location[point,:], 0, project_to_output_projection_type=True)

        index = self.AddLoop(index, self.loopstartpoint, (self.close_last and (point == self.ValidPointNumber() - 1)))

        return index




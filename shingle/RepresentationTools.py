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
#from Projection import c1ompare_points, project, project_shape
from Projection import project, project_shape
from Mathematical import area_enclosed
from Reporting import error
from StringOperations import list_to_comma_separated

from copy import copy, deepcopy
from numpy import asarray

from shapely.geometry import LineString
from shapely.geometry import Polygon
from shapely.geometry import Point
from shapely.geometry.polygon import LinearRing

from shapely.affinity import translate


def check_point_required(region, location):
    import math
    # make all definitions of the math module available to the function
    globals=math.__dict__
    globals['longitude'] = location[0]
    globals['latitude']  = location[1]
    return eval(region, globals)

def distance_on_geoid(a, b):
    from pyproj import Geod
    wgs84_geod = Geod(ellps='WGS84')
    az12, az21, dist = wgs84_geod.inv(a[0], a[1], b[0], b[1])
    return dist


#def complete_with_bspline(index, loopstart):
#    index = rep.AddLoop(index, loopstart)
#    loopstart = index
#    return index, loopstart







class EnrichedPolyline(object):

    _TYPE_UNDFINED = 0
    _TYPE_EXTERIOR = 1
    _TYPE_INTERIOR = 2

    _FORM_LINE = 'LineString'
    _FORM_RING = 'LinearRing'
    _FORM_POLYGON = 'Polygon'

    def __init__(self, rep=None, contour=None, vertices=None, shape=None, reference_number=-1, is_exterior=False, initialise_only = False, comment=[], projection=None):
        self.vertices = []
        self.type = self._TYPE_UNDFINED
        self.shape = None
        self._valid = False
        self.comment = comment

        self._valid_vertices = []
        self.loopstartpoint = None

        self._valid_vertices_number = 0

        #self.c1lose_last = False
        self.valid_location = None
        self.close = None
        self.point = None
        self.closingrequirednumber = 0

        self.before = self
        self.after = self

        self.point_index = []

        # Parent boundary representation component
        self._parent_brep_component = None

        # Data spacing
        self.spacing_source = None
        #[ 0.0, 0.0 ]
        self.__projected = None
        self.__projection = None
        self.projection = projection

        self._parent_brep_component = rep
        self.is_exterior = is_exterior
        if reference_number:
            self.reference_number = reference_number

        if shape is not None:
            self.shape = shape
            #print self.shape.geom_type
            #print 'XX', self.loopstart, self.loopend, self.compare_points(self.loopstart, self.loopend)
            if self.compare_points(self.loopstart, self.loopend):
                #print 'Changing'
                self.shape = LinearRing(self.vertices)
            #self.vertices = shape.coords[:]
            #print self.shape.geom_type
        elif vertices is not None:
            self.vertices = vertices
        elif contour:
            # To reverse order:
            #self.vertices = contour.vertices[::-1]
            self.vertices = contour.vertices
            #self.shape = LineString(self.vertices)
        else:
            #error('oh dear', fatal=True)
            return

        if shape is None:
            self.set_shape()

        #self.set_spacing_source()
        #self._valid_vertices = [False]*self.PointNumber()
        self.ConstrainPoints()

        #if (self.loopend is not None):
        #    self.CheckPathEndToBeClosed()
        #    #self.GetValidLocations()

        #if shape is None:
        #    self.set_shape()

        #self.projected


        if initialise_only:
            return

        #self.AddSection('Ice-Land mass number %s' % (self.reference_number))
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

        if universe.debug:
            self.ReportClosingRequired()
        self._valid = True

    def set_shape(self):
        self.shape = None
        self.spacing_source = None
        if self.vertices is not None:
            #print 'YY', self.loopstart, self.loopend, self.compare_points_source(self.loopstart, self.loopend)
            if self.compare_points_source(self.loopstart, self.loopend):
                #print self.reference_number, 'linear ring'
                #self.shape = Polygon(self.vertices)
                self.shape = LinearRing(self.vertices)
            else:
                #print self.reference_number, 'line string'
                self.shape = LineString(self.vertices)

    @property
    def vertices(self):
        if self.shape:
            #return self.shape.coords[:]
            return self.shape.coords
        else:
            return self.__vertices

    @vertices.setter
    def vertices(self, vertices):
        self.__vertices = vertices

    @property
    def loopstart(self):
        if self.vertices is not None:
            return self.vertices[0]
        else:
            return None

    @property
    def loopend(self):
        if self.vertices is not None:
            return self.vertices[-1]
        else:
            return None

    @property
    def ends(self):
        return self.loopstart, self.loopend

    @property
    def closed(self):
        return self.isClosed()


    def set_spacing_source(self):
        #self.__spacing_source = [ 0.0, 0.0 ]
        self.spacing_source = max([abs(x[0] - y[0]), abs(x[1] - y[1])] for (x, y) in zip(self.vertices[1:], self.vertices[:-1]))
        if not self.spacing_source:
            self.spacing_source = [ 0.0, 0.0 ]

    @property
    def spacing_source(self):
        if not self.__spacing_source:
            self.set_spacing_source()
        return self.__spacing_source

    @spacing_source.setter
    def spacing_source(self, spacing_source):
        self.__spacing_source = spacing_source

    @property
    def spacing_tolerance(self):
        #print self.spacing_source, self.spacing()
        return max(self.spacing_source[0], self.spacing()), max(self.spacing_source[1], self.spacing())
        #return max(self.spacing_source[0], self.spacing()), max(self.spacing_source[1], self.spacing())

    @property
    def projection(self):
        if not self.__projection:
            try:
                return self._parent_brep_component.Dataset().projection
            except:
                return 'LongLat'
        return self.__projection
    @projection.setter
    def projection(self, projection):
        self.__projection = projection

    def compare_latitude(self, a, b):
        return self.compare_points_source(a, b, latitude_only=True)

    def compare_points_source(self, a, b, latitude_only=False):
        tolerance = [0.6 * x for x in self.spacing_source]
        if self.projection in ['Automatic','LongLat']:
            # Check latitude:
            if ( not (abs(a[1] - b[1]) <= tolerance[1]) ):
                return False
            if latitude_only:
                return True
            # Assume longitude in -180, 180 (Grenwich-centred)
            # i.e. that longitude values are >=-180
            return abs(( (a[0] + 360.0) % 360.0 ) - ( (b[0] + 360.0) % 360.0 ) ) <= tolerance[0]
        elif 'utm' in self.projection or 'tmerc' in self.projection:
            return Point(a).distance(Point(b))
        else:
            error('Not implemented for projection type: ' + self.projection, fatal=True)

    def compare_points(self, a, b):
        tolerance = 0.6 * self.spacing()
        if self.projection in ['LongLat', 'Automatic']:
            return distance_on_geoid(a, b) < tolerance
        # This to be the end catch all
        elif 'utm' in self.projection or 'tmerc' in self.projection:
            return Point(a).distance(Point(b)) < tolerance

        # Below needs further checking following updates
        elif (proj == 'horizontal'):
            pa = project(a, projection_type='proj_cartesian')
            pb = project(b, projection_type='proj_cartesian')
            #print tolerance, pa, pb
            if ( not (abs(pa[1] - pb[1]) < tolerance) ):
                return False
            elif (abs(pa[0] - pb[0]) < tolerance):
                return True
            else:
                return False
        else:

            if ( not (abs(a[1] - b[1]) < tolerance) ):
                #AddComment('lat differ')
                return False
            elif (abs(a[0] - b[0]) < tolerance):
                #AddComment('long same')
                return True
            elif ((abs(abs(a[0]) - 180) < tolerance) and (abs(abs(b[0]) - 180) < tolerance)):
                #AddComment('long +/-180')
                return True
            else:
                #AddComment('not same %g %g' % (abs(abs(a[0]) - 180), abs(abs(b[0]) - 180) ) )
                return False

    def reversed(self):
        #if self.isRing():
        self.shape.coords = list(self.shape.coords)[::-1]
        return self

    def __str__(self):
        return str(self.reference_number)

    def __lt__(self, other):
        if self.shape.length == other.shape.length:
            return self.shape.bounds[0] < other.shape.bounds[0]
        else:
            return self.shape.length < other.shape.length

    def isLine(self):
        return self.shape.geom_type == self._FORM_LINE

    def isRing(self):
        return self.shape.geom_type == self._FORM_RING

    def isPolygon(self):
        return self.shape.geom_type == self._FORM_POLYGON

    def isClosed(self, following=None):
        if following:
            # Enable use of dataset spacing
            #print self.loopend, following.loopstart, self.compare_points(self.loopend, following.loopstart)
            return self.compare_points(self.loopend, following.loopstart)
        else:
            #print self.shape.geom_type
            #print self.isRing() or self.isPolygon(), self.isRing(), self.isPolygon()
            return self.isRing() or self.isPolygon()
            #return self.c1lose_last



    def CopyOpenPart(self, source):
        self.is_exterior = source.is_exterior
        self.projection = source.projection
        self.reference_number = source.reference_number
        self.loopstartpoint = source.loopstartpoint
        #self.valid_location = [ copy(source.valid_location[0]), copy(source.valid_location[-1]) ]
        self.shape = LineString(copy(source.ends))

    def CopyOpenPart__(self):
        child = copy(self)
        child.is_exterior = self.is_exterior
        child.reference_number = self.reference_number
        child.loopstartpoint = self.loopstartpoint
        child.valid_location = [ self.valid_location[0], self.valid_location[-1] ]
        return child

    def Within(self, other):
        return other.shape.within(self.shape)

    @property
    def is_exterior(self):
        return self.__is_exterior

    @is_exterior.setter
    def is_exterior(self, state):
        self.__is_exterior = state


    #def SetExterior(self, boolean=True):
    #    self._is_exterior = boolean

    # Imports:
    def report(self, *args, **kwargs):
        return self._parent_brep_component.report(*args, **kwargs)

    def AddComment(self, *args, **kwargs):
        return self._parent_brep_component.AddComment(*args, **kwargs)

    def FormatPoint(self, *args, **kwargs):
        return self._parent_brep_component.FormatPoint(*args, **kwargs)

    def AddFormattedPoint(self, *args, **kwargs):
        return self._parent_brep_component.AddFormattedPoint(*args, **kwargs)

    def AddFormattedPointQuick(self, *args, **kwargs):
        return self._parent_brep_component.AddFormattedPointQuick(*args, **kwargs)

    def AddSection(self, *args, **kwargs):
        return self._parent_brep_component.AddSection(*args, **kwargs)

    def ExtendToLatitude(self, *args, **kwargs):
        return self._parent_brep_component.ExtendToLatitude(*args, **kwargs)

    def spacing(self, *args, **kwargs):
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

    def isPolyline(self, *args, **kwargs):
        return self._parent_brep_component.isPolyline(*args, **kwargs)

    def isBSpline(self, *args, **kwargs):
        return self._parent_brep_component.isBSpline(*args, **kwargs)

    def isCompound(self, *args, **kwargs):
        return self._parent_brep_component.isCompound(*args, **kwargs)

    def SetComplete(self, *args, **kwargs):
        return self._parent_brep_component.SetComplete(*args, **kwargs)

    def SetNotComplete(self, *args, **kwargs):
        return self._parent_brep_component.SetNotComplete(*args, **kwargs)

    # ----------------------------------------


    #def AddLoop(self, index, loopstartpoint, last=False, first=True, last=True):
    def AddLoop(self, index, loopstartpoint=-1, last=True, first=True):
        if (index.point <= index.start):
            return index

        # To edit
        if not first:
            prefix = self.before.point_index[-1]
        else:
            prefix = None

        if last:
            suffix = self.after.point_index[0]
        else:
            suffix = None
        # To edit


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
            pointstart = index.start
            pointend = index.point
            if prefix:
                if prefix == (index.start - 1):
                    pointstart = '%i' % (index.start - 1)
                else:
                    pointstart = '%i, %i' % (prefix, index.start)
            else:
                pointstart = '%i' % (index.start)
            if suffix:
                if suffix == (index.point + 1):
                    pointend = '%i' % (index.point + 1)
                else:
                    pointend = '%i, %i' % (index.point, suffix)
            else:
                pointend = '%i' % (index.point)

            #print '****', first, last, prefix, suffix, pointstart, pointend

            if self.isPolyline():
                #print self.point_index
                self.AddContent( '''Line ( %(prefix_line)s%(loopnumber)i ) = { %(prefix)s%(pointstart)s : %(prefix)s%(pointend)s };''' %
                    {
                        'pointstart': self.point_index[0],
                        'pointend': self.point_index[-1],
                        'loopnumber': index.path,
                        'prefix': self.CounterPrefix('IP'),
                        'prefix_line': self.CounterPrefix('IL')
                    } )

            elif self.isBSpline():
            #self.AddContent( '''BSpline ( %(prefix_line)s%(loopnumber)i ) = { %(prefix)s%(pointstart)s : %(prefix)s%(pointend)s%(loopstartpoint)s };''' %
                self.AddContent( '''BSpline ( %(prefix_line)s%(loopnumber)i ) = { %(prefix)s%(pointstart)s : %(prefix)s%(pointend)s };''' %
                    {
                        'pointstart': pointstart,
                        'pointend': pointend,
                        'loopnumber': index.path,
                        'loopstartpoint': closure,
                        'loopstartpoint': closure,
                        'type': type,
                        'prefix': self.CounterPrefix('IP'),
                        'prefix_line': self.CounterPrefix('IL')
                    } )

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

            if self.is_exterior:
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

    def Vertex(self, number):
        return self.vertices[number][:2]
        #try:
        #    return asarray(self.shape.coords[number][:2])
        #except:
        #    return self.vertices[number,:]


    def PointNumber(self):
        return len(self.vertices)
        # Clean up
        #try:
        #    return len(self.shape.coords)
        #except:
        #    return len(self.vertices[:,0])

    #def SetPointInvalid(self, point):
    #    if self._valid_vertices[point] is True:
    #        self._valid_vertices[point] = False
    #        self._valid_vertices_number -= 1

    def SetPointValid(self, point):
        if not self._valid_vertices[point]:
            self._valid_vertices[point] = True
            self._valid_vertices_number += 1

    def ValidPointNumber(self, refresh=False):
        if refresh:
            self._valid_vertices_number = sum(self._valid_vertices)
        return self._valid_vertices_number

    #def EnsureMinimumSpacing(self):
    #    for point in range(self.PointNumber()):
    #        position = self.vertices[point, :]

    def Interpolate(self, spacing=None):
        from math import ceil
        if not spacing:
            spacing = self.spacing()
        coords = []
        #print self.shape.coords[:]
        for i, coord in enumerate(self.shape.coords[:]):
            #print i, coord
            coords.append(coord)
            if i >= len(self.shape.coords[:]) - 1:
                break
            heading = self.shape.coords[i+1]

            points_to_add = int(ceil(distance_on_geoid(coord, heading) / spacing) - 1.0)
            #dx =  LineString((heading[0] - coord[0], heading[1] - coord[0] ))
            s = (heading[0] - coord[0]) / (points_to_add + 1), (heading[1] - coord[1]) / (points_to_add + 1)

            #s =  LineString((coord, heading ))
            #dx = s / points_to_add

            #shapely.affinity.affine_transform
            #n = translate(d, xoff=s[0], yoff=s[1])

            #print coord, '->', heading, 'distance', d, 'points', points_to_add, 'vec', s

            for j in range(points_to_add):
                coord = (coord[0] + s[0], coord[1] + s[1])
                coords.append(coord)


        #for i, coord in enumerate(coords):
        #    print i, coord

        if self.isLine():
            self.shape = LineString(coords)
        if self.isRing():
            self.shape = LinearRing(coords)
        if self.isPolygon():
            self.shape = Polygon(coords)

        self._valid_vertices = [False]*self.PointNumber()
        self.ConstrainPoints()
        #self.CheckPathEndToBeClosed()
        #self.GetValidLocations()

    #@property
    #def projection(self):
    #    if not self.
    #    self.Dataset().projection


    def get_projection(self):
        #coords = [ project(loc, projection_type=self.Projection()) for loc in vertices]
        projected = copy(self)

        #source=None
        #source = self._parent_brep_component.Dataset().projection
        source = self.projection
        destination = self.Projection()

        projected.shape = project_shape(self.shape, source, destination)

        #print source, destination, 'HERE'
        #print destination
        #import sys; sys.exit()

        # Make the following automatic?  No need to call here or elsewhere
        projected.spacing_source = None

        return projected

    @property
    def projected(self):
        if not self.__projected:
            self.__projected = self.get_projection()
        return self.__projected

        #if self.isLine():
        #    self.shape = LineString(coords)
        #if self.isRing():
        #    self.shape = LinearRing(coords)
        #if self.isPolygon():
        #    self.shape = Polygon(coords)

        #self._valid_vertices = [False]*self.PointNumber()
        #self.ConstrainPoints()

        #self.CheckPathEndToBeClosed()
        #self.GetValidLocations()
        #return coords

    #def getVertices(self):
    #    if self.shape:
    #        return self.shape.coords[:]
    #    elif self.vertices:

    #def vertices(self):
    #    if shape:
    #        return self.shape.coords[:]
    #    else:
    #        return self.vertices





    def ConstrainPoints(self):
        vertices = [vertex for vertex in self.vertices if check_point_required(str(self.Region()), vertex)]
        if len(self.vertices) != len(vertices):
            #print len(self.vertices), '->', len(vertices)
            if len(vertices) > 0:
                self.vertices = vertices
            else:
                self.vertices = None
            self.shape = None
            self.set_shape()


        #vertices = []
        #for vertex in self.vertices:
        #    #print i, vertex, check_point_required(str(self.Region()), vertex)
        #    if check_point_required(str(self.Region()), vertex):
        #        vertices.append(vertex)
        #if len(self.vertices) != len(vertices):
        #    print 'asc TODO', len(self.vertices), len(vertices), ' '*8, len(vertices) - len(self.vertices)
#       #     print self.vertices



#            position = self.Vertex(point)
#            if ( check_point_required(str(self.Region()), self.Vertex(point)) ):
#                if (self.ValidPointNumber() > 0):
#                    self.spacing_source[0] = max(abs(position[0] - position_previous[0]), self.spacing_source[0])
#                    self.spacing_source[1] = max(abs(position[1] - position_previous[1]), self.spacing_source[1])
#                position_previous = position
#                self.SetPointValid(point)
#                if (flag == 0):
#                    self.loopstart = point
#                    flag = 1
#                elif (flag == 1):
#                    self.loopend = point

    def isIncluded(self):
        return (self.loopend is not None)

    def isIslandCrossingMeridian(self):
        if ( (abs(self.loopstart[0] - self.loopend[0]) < 2 * self.spacing_source[0]) and (abs(self.loopstart[1] - self.loopend[1]) > 2 * self.spacing_source[1]) ):
            self.report('Path %i skipped (island crossing meridian - code needs modification to include)' % ( self.reference_number ), debug=True)
            self.AddComment('  Skipped (island crossing meridian - code needs modification to include)\n')
            # Temporary quiet
            #error('Skipped path. Found an island crossing a bounding meridian. Investigate if further treatment required.', warning=True)

    #def CheckPathEndToBeClosed(self):
    #    return
        #if (c1ompare_points(self.Vertex(self.loopstart), self.Vertex(self.loopend), self.spacing())):
        #    # Remove duplicate line at end
        #    #self._valid_vertices[loopend] = False
        #    self.SetPointInvalid(self.loopend)
        #    self.c1lose_last = True

    def AreaEnclosed(self):
        # Use shapely
        if self.shape:
            #projected = self.get_ea_projection()

            #projected = copy(self)


            source = self.projection
            # Increase accuracy by centering on polygon centre (using shapely approximate centre)
            destination =  "+proj=aea"
            projected = project_shape(self.shape, source, destination)
            projected_polygon = Polygon(projected.coords[:])
            area = projected_polygon.area


            #  #bounds = self.shape.bounds
            #  #centroid = self.shape.centroid
            #  #Its x-y bounding box is a (minx, miny, maxx, maxy)
            #  #string = "+proj=aea +lat_1=%0.1f +lat_2=%0.1f +lat_0=%0.1f +lon_0=%0.1f" % bounds
            #  #destination = "+proj=aea +lon_1=%0.1f +lat_1=%0.1f +lon_2=%0.1f +lat_2=%0.1f" % self.shape.bounds
            #  destination = "+proj=aea +lon_0=%0.1f +lat_0=%0.1f" % self.shape.centroid.coords[:][0]
            #  #print string
            #  projected = project_shape(self.shape, source, destination)
            #  projected_polygon = Polygon(projected.coords[:])
            #  area2 = projected_polygon.area

            #  print area_enclosed(self.vertices), area/1e6, area2/1e6
            #  #import sys; sys.exit()
            return area
            #import sys; sys.exit()

            #if self.shape.type == 'Polygon':
            #    return self.shape.area
            #elif self.

        if self.vertices is not None:
            return area_enclosed(self.vertices)
        return 0.0

    def isValid(self):
        return self._valid

    #def GetValidLocations(self):
    #    from numpy import zeros
    #    self.valid_location = zeros( (self.ValidPointNumber(), 2) )
    #    self.close = [False]*self.ValidPointNumber()
    #    count = 0
    #    closingrequired = False
    #    for point in range(self.PointNumber()):
    #        if (self._valid_vertices[point]):
    #            self.valid_location[count,:] = self.Vertex(point)
    #            if ((closingrequired) and (count > 0)):
    #                if (c1ompare_points(self.valid_location[count-1,:], self.valid_location[count,:], self.spacing_tolerance)):
    #                    closingrequired = False
    #            self.close[count] = closingrequired
    #            count += 1
    #            closingrequired = False
    #        else:
    #            if (not closingrequired):
    #                closingrequired = True
    #                self.closingrequirednumber += 1

    #    if (self.c1lose_last):
    #        self.close[-1] = True
    #        self.closingrequirednumber += 1

    #    if (self.close[0]):
    #        self.close[-1] = self.close[0]


    def ReportClosingRequired(self):
        if (self.closingrequirednumber == 0):
            closingtext = ''
        elif (self.closingrequirednumber == 1):
            closingtext = ' (required closing in %i part of the path)' % (self.closingrequirednumber)
        else:
            closingtext = ' (required closing in %i parts of the path)' % (self.closingrequirednumber)
        self.report('Path %i: points %i (of %i) area %g%s' % ( self.reference_number, self.ValidPointNumber(), self.PointNumber(), area_enclosed(self.vertices), closingtext ), indent = 2)


    #def atEndOfValidPath(self, point):
    #    return ((self.close[point]) and (point == self.ValidPointNumber() - 1) and (not (c1ompare_points(self.vertices[point], self.loopstart, self.spacing_tolerance))))


    #def atPathPartToBeClosed(self, point):
    #    return (self.close[point]) and (point > 0) and (not (self.c1ompare_points(self.vertices[point], self.loopstart)))


    # def ClosePathEndToStartLongitude(self, index, extend_to_longitude = None):
    #     longitude = extend_to_longitude

    #     point = -1
    #     self.loopstartpoint = 0

    #     #loopstartpoint = self.loopstartpoint
    #     #start_point = self.valid_location[point]
    #     #end_point = self.valid_location[0]

    #     #index = self.AddLoop(index, self.loopstartpoint)
    #     index, paths = self.draw_meridian_explicit(self._parent_brep_component, self.vertices[point], self.loopstart, index, self.spacing(), longitude)
    #     #index = self.AddLoop(index, self.loopstartpoint, last=True)

    #     return index, paths

    # def ClosePathPart(self, point, index):
    #     self.AddComment('Close path part (not at the end of current path, but out of bounds): Start ' + str(point) + '/' + str(self.ValidPointNumber()-1) + str(self.close[point]))
    #     self.AddComment(str(self.vertices[point] + str(self.vertices[point])))
    #     index = self.AddLoop(index, self.loopstartpoint)
    #     paths = self.draw_parallel_explicit(self.ExtendToLatitude())
    #     index = self.AddLoop(index, self.loopstartpoint)
    #     self.AddComment('Close path part (not at the end of current path, but out of bounds): End of loop section ' + str(point) + '/' + str(self.ValidPointNumber()-1) + str(self.close[point]))
    #     return index

    def develop_orthodrome(self, current, destination):
        from math import ceil
        path = []
        if not self.compare_points(current, destination):
            points_to_add = int(ceil(distance_on_geoid(current, destination) / self.spacing()))
            diff = ( (destination[0] - current[0]) / points_to_add, (destination[1] - current[1]) / points_to_add)
            for i in range(points_to_add + 1):
                point = self.FormatPoint(0, (current[0] + i * diff[0], current[1] + i * diff[1]), 0.0, project_to_output_projection_type=False)
                path.append(point)
        return path

    def draw_parallel_explicit(self, to_parallel=None):
        start = self.loopend
        end = self.loopstart
        dx = self.spacing()
        rep = self._parent_brep_component

        if to_parallel is None:
            to_parallel = self.ExtendToLatitude()

        if (to_parallel is None):
            # Potential to use shapely bounding box here - need to determine direction
            to_parallel = max(start[1], end[1])

        paths = []
        comments = []

        if (self.compare_points(start, end)):
            comments.append('Points already close enough, no need to draw parallels and meridians after all')
            return paths
        else:
            comments.append('Closing path with parallels and meridians, from (%.8f, %.8f) to  (%.8f, %.8f)' % ( start[0], start[1], end[0], end[1] ) )

        # Extend to latitude
        path = self.develop_orthodrome(start, (start[0], to_parallel))
        if path:
            comment = 'Drawing meridian to latitude at %.2f, %.2f (to match %.2f)' % (start[0], start[1], to_parallel)
            comments.append(comment)
            rep.report(comment, debug=True)
            paths.append(EnrichedPolyline(shape=LineString(path), rep=rep, initialise_only=True, comment=comments, projection = 'LongLat'))
            comments = []

        # Extend along parallel
        path = self.develop_orthodrome((start[0], to_parallel), (end[0], to_parallel))
        if path:
            comment = 'Drawing parallel at %.2f (to match %.2f), %.2f' % (start[0], end[0], to_parallel)
            comments.append(comment)
            rep.report(comment, debug=True)
            paths.append(EnrichedPolyline(shape=LineString(path), rep=rep, initialise_only=True, comment=comments, projection = 'LongLat'))
            comments = []

        # Extend back from parallel along a meridian
        destination = end
        path = self.develop_orthodrome((end[0], to_parallel), end)
        if path:
            comment = 'Drawing meridian to end at %.2f, %.2f (to match %.2f)' % (end[0], to_parallel, end[1])
            comments.append(comment)
            rep.report(comment, debug=True)
            paths.append(EnrichedPolyline(shape=LineString(path), rep=rep, initialise_only=True, comment=comments, projection = 'LongLat'))
            comments = []

        return paths



    def draw_meridian_explicit(self, to_meridian=None):
        start = self.loopend
        end = self.loopstart
        dx = self.spacing()
        rep = self._parent_brep_component

        if (to_meridian is None):
            # Potential to use shapely bounding box here - need to determine direction
            to_meridian = max(start[0], end[0])

        paths = []
        comments = []

        if (self.compare_points(start, end)):
            comments.append('Points already close enough, no need to draw parallels and meridians after all')
            return paths
        else:
            comments.append('Closing path with parallels and meridians, from (%.8f, %.8f) to  (%.8f, %.8f)' % ( start[0], start[1], end[0], end[1] ) )

        # Extend to latitude
        path = self.develop_orthodrome(start, (to_meridian, start[1]))
        if path:
            comment = 'Drawing parallel to longitude at %.2f, %.2f (to match %.2f)' % (start[0], start[1], to_meridian)
            comments.append(comment)
            rep.report(comment, debug=True)
            paths.append(EnrichedPolyline(shape=LineString(path), rep=rep, initialise_only=True, comment=comments, projection = 'LongLat'))
            comments = []

        # Extend along meridian
        path = self.develop_orthodrome((to_meridian, start[1]), (to_meridian, end[1]))
        if path:
            comment = 'Drawing along meridian at %.2f (to match %.2f), %.2f' % (start[1], end[1], to_meridian)
            comments.append(comment)
            rep.report(comment, debug=True)
            paths.append(EnrichedPolyline(shape=LineString(path), rep=rep, initialise_only=True, comment=comments, projection = 'LongLat'))
            comments = []

        # Extend back from meridian along a parallel
        destination = end
        path = self.develop_orthodrome((to_meridian, end[1]), end)
        if path:
            comment = 'Drawing parallel back to end at %.2f, %.2f (to match %.2f)' % (to_meridian, end[1], end[0])
            comments.append(comment)
            rep.report(comment, debug=True)
            paths.append(EnrichedPolyline(shape=LineString(path), rep=rep, initialise_only=True, comment=comments, projection = 'LongLat'))
            comments = []

        return paths


        if (current[0] != to_meridian):
            comment.append('Drawing parallel to longitude index %s at %.2f, %.2f (to match %.2f)' % (index.point, current[0], current[1], to_meridian))
        while (current[0] != to_meridian):
            if (longitude_diff(current[0], to_meridian) < 0):
                current[0] = current[0] + dx
            else:
                current[0] = current[0] - dx
            if (abs(current[0] - to_meridian) < tolerance): current[0] = to_meridian
            if (self.compare_points(current, end)):
                break
            #index.point += 1
            rep.report('Drawing parallel to longitude index %s at %.2f, %.2f (to match %.2f)' % (index.point, current[0], current[1], to_meridian), debug=True)
            #rep.FormatPoint(index.point, current, 0.0, project_to_output_projection_type=True)
            point = rep.FormatPoint(index.point, current, 0.0, project_to_output_projection_type=False)
            path.append(point)

        paths.append(EnrichedPolyline(shape=LineString(path), rep=rep, initialise_only=True, comment=comment, projection = 'LongLat'))
        path = []
        comment = []

        if rep.MoreBSplines():
            index, loopstart = complete_as_bspline(index, loopstart)

        # Draw meridian
        if (current[1] != end[1]):
            comment.append('Drawing meridian index %s at %.2f (to match %.2f), %.2f' % (index.point, current[1], end[1], current[0]))
        while (current[1] != end[1]):
            if (current[1] < end[1]):
                current[1] = current[1] + dx
            else:
                current[1] = current[1] - dx
            #if (abs(current[0] - end[0]) < tolerance): current[0] = end[0]
            if (abs(current[1] - end[1]) < tolerance): current[1] = end[1]
            if (self.compare_points(current, end)):
                break
            #index.point += 1
            rep.report('Drawing meridian index %s at %.2f (to match %.2f), %.2f' % (index.point, current[0], end[0], current[1]), debug=True)
            #rep.FormatPoint(index.point, current, 0.0, project_to_output_projection_type=True)
            point = rep.FormatPoint(index.point, current, 0.0, project_to_output_projection_type=False)
            path.append(point)

        paths.append(EnrichedPolyline(shape=LineString(path), rep=rep, initialise_only=True, comment=comment, projection = 'LongLat'))
        path = []
        comment = []

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
            if (self.compare_points(current, end)):
                break
            #index.point += 1
            rep.report('Drawing parallel to end index %s at %.2f, %.2f (to match %.2f)' % (index.point, current[0], current[1], end[0]), debug=True)
            #rep.FormatPoint(index.point, current, 0.0, project_to_output_projection_type=True)
            point = rep.FormatPoint(index.point, current, 0.0, project_to_output_projection_type=False)
            path.append(point)

        comment.append('Closed path with parallels and meridians, from (%.8f, %.8f) to  (%.8f, %.8f)' % ( start[0], start[1], end[0], end[1] ) )
        paths.append(EnrichedPolyline(shape=LineString(path), rep=rep, initialise_only=True, comment=comment, projection = 'LongLat'))
        path = []
        comment = []

        #index = rep.AddLoop(index, loopstart, last=True)

        return index, paths






    def Generate(self, index, first=True, last=True):
        #if not self._valid:
        #    return index

        # asc: Treat first, last


        #self.AddSection('Ice-Land mass number %s' % (self.reference_number))

        index.start = index.point + 1
        self.loopstartpoint = index.start

        a = []
        for i, vertex in enumerate(self.vertices):
            #print point, first

            if not first and i == 0:
                if self.compare_points(self.loopstart, self.before.loopend):
                    #print 'skipped', point, self.valid_location[point,:]
                    continue

            self.point = i

            #if self.atEndOfValidPath(point):
            #    self.AddComment('Keeping path %(number)d open to be closed by a later component' % {'number':self.reference_number})
#
            #elif self.atPathPartToBeClosed(point):
            #    index = self.ClosePathPart(point, index)

            #self.projected

            #else:
            index.point += 1
            self.point_index.append(index.point)
            self.AddFormattedPointQuick(index.point, self.projected.vertices[i], 0)
            #self.AddFormattedPoint(index.point, self.vertices[i], 0)
            #self.AddFormattedPoint(index.point, self.shape.coords[i], 0)
            #print i

            #print a, b

        index = self.AddLoop(index, self.loopstartpoint, last, first)

        return index


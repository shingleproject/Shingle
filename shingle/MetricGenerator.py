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
from Reporting import error
from StringOperations import list_to_comma_separated
from Bounds import Bounds
from Spud import specification
from copy import deepcopy
import numpy
import os.path

def merge_two_dicts(x, y):
    """Given two dicts, merge them into a new dict as a shallow copy."""
    z = x.copy()
    z.update(y)
    return z


class Field(object):

    def __init__(self, surface_representation = None):
        self._surface_rep = surface_representation
        self.index = self._surface_rep.index
        self._form = None
        self.Header()
        if not self._surface_rep.isGenerated():
            self.Read()
            self.OutputOptions()

    def AddSection(self, *args, **kwargs):
        return self._surface_rep.AddSection(*args, **kwargs)

    def AddComment(self, *args, **kwargs):
        return self._surface_rep.AddComment(*args, **kwargs)

    def AddContent(self, *args, **kwargs):
        return self._surface_rep.AddContent(*args, **kwargs)

    def CounterPrefix(self, *args, **kwargs):
        return self._surface_rep.CounterPrefix(*args, **kwargs)

    # To be moved to MetricGeneration
    # To remove
    def BaseEdgeLength(self):
        if specification.have_option('/geoid_metric/element_length'):
            return specification.get_option('/geoid_metric/element_length')
        else:
            return universe.default.elementlength

    def Form(self):
        if self._form is None:
            if specification.have_option('/geoid_metric/form[0]'):
                self._form = specification.get_option('/geoid_metric/form[0]/name')
            else:
                self._form = 'Homogeneous'
        return self._form

    def ExtendFromBoundary(self):
        return specification.have_option('/geoid_mesh/library::Gmsh/extend_metric_from_boundary')

    def Header(self):
        if self.ExtendFromBoundary():
            number = 1
        else:
            number = 0
        self.AddComment('Do not extent the elements sizes from the boundary inside the domain')
        # Commented out for now
        self.AddContent('Mesh.CharacteristicLengthExtendFromBoundary = %(number)d;' % {'number':number})

    def Read(self):
        if self.Form() == 'Homogeneous':
            self.Homogeneous()
        elif self.Form() == 'Proximity':
            self.Proximity()
        elif self.Form() == 'GravityWave':
            self.GravityWave()
        elif self.Form() == 'FromRaster':
            self.FromRaster()
        else:
            raise NotImplementedError

    def Homogeneous(self):
        if specification.have_option('/geoid_metric/form::Homogeneous/edge_length'):
            edge_length = specification.get_option('/geoid_metric/form::Homogeneous/edge_length')
        else:
            edge_length = 1.0E5

        self.AddSection('Field definitions')
        self.AddContent('''
Field[ %(prefix)s1 ] = MathEval;
Field[ %(prefix)s1 ].F = "%(edge_length)e";

Background Field = %(prefix)s1;
''' % { 'edge_length':edge_length, 'prefix':self.CounterPrefix('IFI') } )

    def Proximity(self):
        edge_length_minimum = specification.get_option('/geoid_metric/form::Proximity/edge_length_minimum')
        edge_length_maximum = specification.get_option('/geoid_metric/form::Proximity/edge_length_maximum')
        proximity_minimum = specification.get_option('/geoid_metric/form::Proximity/proximity_minimum')
        proximity_maximum = specification.get_option('/geoid_metric/form::Proximity/proximity_maximum')
        boundary = []
        for number in range(specification.option_count('/geoid_metric/form::Proximity/boundary')):
            b = specification.get_option('/geoid_metric/form::Proximity/boundary[%(number)d]/name' % {'number':number})
            boundary.append(b)
        if specification.have_option('/geoid_metric/form::Proximity/equidistant_node_number'):
            equidistant_node_number = specification.get_option('/geoid_metric/form::Proximity/equidistant_node_number')
        else:
            equidistant_node_number = 2.0E4

        edgeindex = ''

        b = []
        for name in boundary:
            if name not in self._surface_rep.Boundary().keys():
                error("The boundary '%(name)s' required for a proximity metric is not defined." % {'name':name}, fatal = True)
            p = self._surface_rep.Boundary()[name].path
            b = b + p

        self.AddSection('Field definitions')
        if len(b) == 0:
            error('No boundaries found for proximity metric')

        self.AddContent('''
Field[ %(prefix)s2 ] = Attractor;
Field[ %(prefix)s2 ].EdgesList = { %(boundary_list)s };
Field[ %(prefix)s2 ].NNodesByEdge = %(equidistant_node_number)d;

Field[ %(prefix)s3 ] = Threshold;
Field[ %(prefix)s3 ].IField = %(prefix)s2;
Field[ %(prefix)s3 ].LcMin = %(edge_length_minimum)e;
Field[ %(prefix)s3 ].LcMax = %(edge_length_maximum)e;
Field[ %(prefix)s3 ].DistMin = %(proximity_minimum)e;
Field[ %(prefix)s3 ].DistMax = %(proximity_maximum)e;

Background Field = %(prefix)s3;
''' % { 'boundary_list':list_to_comma_separated(b, prefix = self.CounterPrefix(edgeindex + 'IL')), 'prefix':self.CounterPrefix('IFI'), 'equidistant_node_number':equidistant_node_number, 'edge_length_minimum':edge_length_minimum, 'edge_length_maximum':edge_length_maximum, 'proximity_minimum':proximity_minimum, 'proximity_maximum':proximity_maximum } )


    def FromRasterUK(self):
        self.AddContent('''
// input bathymetry
Field[1] = Structured;
Field[1].FileName = "metric.pos";
Field[1].TextFormat = 1;
// constant edge length to use as initial mesh in testing
Field[2] = MathEval;
Field[2].F = "2.0E5";


// convert bathymetry to cartesian space (default field to use is 1)
Field[3] = LonLat;
Field[4] = MathEval;
Field[4].F = "Abs(F3)";
// Set a minimum bathymetry
Field[5] = MathEval;
Field[5].F = "10";
Field[6] = Max;
Field[6].FieldsList = {5, 4};
Field[7] = MathEval;
Field[7].F = "F6 / 10.0";
// So F4 is the unaltered bathymetry, F6 has a minimum depth applied, and F7 is the edited bathymetry divided by a minimum depth scaling factor

// Set up the Max eigenvalue of the hessian of bathymetry field
Field[8] = MaxEigenHessian;
Field[8].Delta = 800000;
Field[8].IField = 7;
Field[9] = MathEval;
// Note the scaling factor of 20 here
Field[9].F = "20 / Sqrt(F8)";

// Now alter edge length based on bathymetry values
Field[10] = MathEval;
Field[10].F = "100000.0/3.0*Sqrt(F7)";

// Now alter based on distance from coastline
Field[ 11 ] = Attractor;
Field[ 11 ].EdgesList = { IL + 0, IL + 1, IL + 2, IL + 3, IL + 4, IL + 5, IL + 6, IL + 7, IL + 8, IL + 9, IL + 10, IL + 11, IL + 12, IL + 13, IL + 14, IL + 15, IL + 16, IL + 17, IL + 18, IL + 19, IL + 20, IL + 21, IL + 22, IL + 23, IL + 24, IL + 25, IL + 26, IL + 27, IL + 28, IL + 29, IL + 30, IL + 31, IL + 32, IL + 33, IL + 34, IL + 35, IL + 36, IL + 37, IL + 38, IL + 39, IL + 40, IL + 41, IL + 42, IL + 43, IL + 44, IL + 45, IL + 46, IL + 47, IL + 48, IL + 49, IL + 50, IL + 51, IL + 52, IL + 53, IL + 54, IL + 55, IL + 56, IL + 57, IL + 58, IL + 59, IL + 60, IL + 61, IL + 62, IL + 63, IL + 64, IL + 65, IL + 66, IL + 67, IL + 68, IL + 69, IL + 70, IL + 71, IL + 72, IL + 73, IL + 74, IL + 75, IL + 76, IL + 77, IL + 78, IL + 79, IL + 80, IL + 81, IL + 82, IL + 83, IL + 84, IL + 85, IL + 86, IL + 87, IL + 88, IL + 89, IL + 90, IL + 91, IL + 92, IL + 93, IL + 94, IL + 95, IL + 96, IL + 97, IL + 98, IL + 99, IL + 100, IL + 101, IL + 102, IL + 103, IL + 104, IL + 105, IL + 106, IL + 107, IL + 108, IL + 109, IL + 110, IL + 111, IL + 112, IL + 113, IL + 114, IL + 115, IL + 116, IL + 117, IL + 118, IL + 119, IL + 120, IL + 121, IL + 122, IL + 123, IL + 124, IL + 125, IL + 126, IL + 127, IL + 128, IL + 129, IL + 130, IL + 131, IL + 132, IL + 133, IL + 134, IL + 135, IL + 136, IL + 137, IL + 138, IL + 139, IL + 140, IL + 141, IL + 142, IL + 143, IL + 144, IL + 145, IL + 146, IL + 147, IL + 148, IL + 149, IL + 150, IL + 151, IL + 152 };
Field [11].NNodesByEdge = 1e3;
Field[12] = Threshold;
Field[12].DistMax = 2e6;
Field[12].DistMin = 3e4;
Field[12].IField = 11;
Field[12].LcMin = 1e4;
Field[12].LcMax = 5e5;

// Now take the minimum of the three sizing fields, F12, F10 and F9
Field[13] = Min;
Field[13].FieldsList = {9, 10, 12};

//Dont extent the elements sizes from the boundary inside the domain
Mesh.CharacteristicLengthExtendFromBoundary = 0;

// Set background field to constant - change to 13 if required
//Background Field = 2;

Background Field = 13;
''')

    def Output(self):
        index = self.index
        edgeindex = ''

        self.AddSection('Field definitions')
        if (index.contour is not None):
            self.AddContent('''
Printf("Assigning characteristic mesh sizes...");

// Field[ IFI + 1] = Attractor;
// Field[ IFI + 1].EdgesList = { 999999, %(boundary_list)s };
// Field [ IFI + 1 ].NNodesByEdge = 5e4;
//
// Field[ IFI + 2] = Threshold;
// Field[ IFI + 2].DistMax = 2e6;
// Field[ IFI + 2].DistMin = 3e4;
// Field[ IFI + 2].IField = IFI + 1;
// Field[ IFI + 2].LcMin = 5e4;
// Field[ IFI + 2].LcMax = 2e5;
//
// Background Field = IFI + 2;

Field[ %(prefix)s1] = MathEval;
Field[ %(prefix)s1].F = "%(edge_length)e";

Field[ %(prefix)s2 ] = Attractor;
//Field[ %(prefix)s2 ].EdgesList = { 999999, %(boundary_list)s };
Field[ %(prefix)s2 ].EdgesList = { %(boundary_list)s };
//Field[ %(prefix)s2 ].NNodesByEdge = 5e4;
Field[ %(prefix)s2 ].NNodesByEdge = 20000;

// Field[ %(prefix)s3] = Threshold;
// Field[ %(prefix)s3].DistMax = 2e6;
// Field[ %(prefix)s3].DistMin = 3e4;
// Field[ %(prefix)s3].IField = %(prefix)s2;
// Field[ %(prefix)s3].LcMin = 5e4;
// Field[ %(prefix)s3].LcMax = 2e5;
//
// // Filchner-Ronne:
// Field[ %(prefix)s4] = Threshold;
// Field[ %(prefix)s4].DistMax = 5e5;
// Field[ %(prefix)s4].DistMin = 3e4;
// Field[ %(prefix)s4].IField = %(prefix)s2;
// Field[ %(prefix)s4].LcMin = 2e4;
// Field[ %(prefix)s4].LcMax = 5e5;
//
// // Amundsen
// Field[ %(prefix)s5] = Threshold;
// Field[ %(prefix)s5].DistMax = 5e5;
// Field[ %(prefix)s5].DistMin = 8e4;
// Field[ %(prefix)s5].IField = %(prefix)s2;
// Field[ %(prefix)s5].LcMin = 2e4;
// Field[ %(prefix)s5].LcMax = 5e5;

// Global
// Field[ %(prefix)s6 ] = Threshold;
// Field[ %(prefix)s6 ].DistMax = 1000000;
// Field[ %(prefix)s6 ].DistMin = 1000;
// Field[ %(prefix)s6 ].IField = %(prefix)s2;
// Field[ %(prefix)s6 ].LcMin = 80000;
// Field[ %(prefix)s6 ].LcMax = 200000;

// Northsea
Field[ %(prefix)s7 ] = Threshold;
Field[ %(prefix)s7 ].IField = %(prefix)s2;
Field[ %(prefix)s7 ].DistMax = 100000;
Field[ %(prefix)s7 ].DistMin = 1000;
Field[ %(prefix)s7 ].LcMin = 5000;
Field[ %(prefix)s7 ].LcMax = 20000;
Field[ %(prefix)s7 ].Sigmoid = 0;

// Dont extent the elements sizes from the boundary inside the domain
//Mesh.CharacteristicLengthExtendFromBoundary = 0;

Background Field = %(prefix)s1;
''' % { 'boundary_list':list_to_comma_separated(index.contour, prefix = self.CounterPrefix(edgeindex + 'IL')), 'prefix':self.CounterPrefix('IFI') } )

        self.AddSection('Physical entities')

    def OutputOptions(self, view=[0.0, 0.0, 0.0]):
        # Check if just a flat projection output, then no need to rotate
        if specification.have_option('/output/orientation'):
            if specification.have_option('/output/orientation/name'):
                view_name = specification.get_option('/output/orientation/name')
            else:
                view_name = 'UserDefined'
            if view_name == 'SouthWest':
                view = [0.0, 0.0, 180.0]
            elif view_name == 'LongLat':
                view = [0.0, 0.0, 0.0]
            elif view_name == 'Caribbean':
                view = [0.0, 0.0, 151.0]
            # Rename, because must be for part of Antarctica?
            elif view_name == 'SouthPole':
                view = [180.0, 0.0, 270.0]
            else:
                view = specification.get_option('/output/orientation')
                #print view
                #print specification.get_option_shape('/output/orientation')
                if specification.get_option_shape('/output/orientation')[0] != 3:
                    error('View not defined with three distinct angles of rotation.', fatal=True)
        self.AddContent('''
// Set general options for default view and improved PNG output
General.Color.Background = {255,255,255};
General.Color.BackgroundGradient = {255,255,255};
General.Color.Foreground = Black;
Mesh.Color.Lines = {0,0,0};
Geometry.Color.Lines = {0,0,0};
//Mesh.Color.Triangles = {0,0,0};
Mesh.Color.Ten = {0,0,0};
Mesh.ColorCarousel = 2;
Mesh.Light = 0;
General.Antialiasing = 1;

General.Trackball = 0;
General.RotationX = %(x).0f;
General.RotationY = %(y).0f;
General.RotationZ = %(z).0f;
''' % {'x':view[0],'y':view[1],'z':view[2], })

# General.RotationX = 180;
# General.RotationY = 0;
# General.RotationZ = 270;


    def FromRaster(self):


        dataset_name = specification.get_option('/geoid_metric/form::FromRaster/source/name')
        field_name = None
        if specification.have_option('/geoid_metric/form::FromRaster/field_name'):
            field_name = specification.get_option('/geoid_metric/form::FromRaster/field_name')

        dataset = self._surface_rep.spatial_discretisation.Dataset()[dataset_name]

        bounds = Bounds(path='/geoid_metric/form::FromRaster/')
        subregion = bounds.GetMaxBounds()

        field_region = dataset.Load(subregion, name_field=field_name)
        #field = deepcopy(region.Data())

        if specification.have_option('/geoid_metric/form::FromRaster/function'):
            function = specification.get_option('/geoid_metric/form::FromRaster/function')
        else:
            function = None

        m = Metric(surface_rep=self._surface_rep)
        m.Generate(field_region, function=function)

        self.AddContent(m.Import())


class Metric(object):

    # Needs a verification test

    _OUTPUT_FORMAT_TYPE_POS = 1
    _OUTPUT_FORMAT_TYPE_STRUCT = 2

    _OUTPUT_FILENAME_DEFAULT = 'metric.pos'

    _function_python_header = '''
global field
'''

    def __init__(self, surface_rep=None, output_filename = None):
        self.output_filename = output_filename
        self.output_format = self._OUTPUT_FORMAT_TYPE_STRUCT
        self._surface_rep = surface_rep

        self.minimumdepth = 10.0

        self.globe = False
        self.globallonglat = False

        self._fileobject = None

    def _file(self):
        if self._fileobject is None:
            self._fileobject = open(self.Filepath(full=True),'w')
        return self._fileobject

    def Filepath(self, full=False):
        if self.output_filename is None:
            filename = self._surface_rep.Name() + '_' + self._OUTPUT_FILENAME_DEFAULT
            dirname = '.'
        else:
            filename = os.path.basename(self.output_filename)
            dirname  = os.path.dirname(self.output_filename)
        if full:
            #if dirname in ['', '.']:
            #    name = filename
            name = os.path.join(dirname, filename)
            return self._surface_rep.spatial_discretisation.PathRelative(name)
        else:
            return filename

    def Finalise(self):
        self._fileobject.close()
        self._fileobject = None

    def WriteLine(self, string, newline=True):
        self._file().write(string + '\n')

    def Import(self):
        from re import sub
        string = '''
// External metric field definition
Field[1] = Structured;
Field[1].FileName = "%(filename)s";
Field[1].TextFormat = 1;

// constant edge length to use as initial mesh in testing
Field[2] = MathEval;
Field[2].F = "0.1";

// Set background field
Background Field = 1;

''' % {
        'filename': self.Filepath(full=True),
        #'filename': sub('^' + os.path.expanduser('~/'), '~/', self.Filepath(full=True)),
    }
        return string

    def Generate(self, source, function=None):
        #if not universe.generatemetric: return
        #field = source.Data()
        #field = deepcopy(source.Data())

        # Expose math and numpy definitions to the user in the transformation function
        import math
        import numpy
        user_space = merge_two_dicts(math.__dict__, numpy.__dict__)

        user_space['field'] = source.Data().astype(numpy.float32, copy=True)
        user_space['lon'] = source.lon.astype(numpy.float32, copy=True)
        user_space['lat'] = source.lat.astype(numpy.float32, copy=True)

        #print user_space['field'].min(), user_space['field'].max()

        if function is not None:
            try:
                exec(self._function_python_header + function, user_space)
            except SyntaxError:
                error('Error in the syntax of the Python code for metric option')
                print function
                raise
            except:
                raise

        lon = user_space['lon']
        lat = user_space['lat']
        field = user_space['field']

        #print user_space['field'].min(), user_space['field'].max()

        if self.globe:
            # needs deepcopy
            field[field > - self.minimumdepth] = - self.minimumdepth
            field = - field

        if (self.output_format == self._OUTPUT_FORMAT_TYPE_POS):
            self.WriteLine('View "background_edgelength" {')
            for i in range(len(lon)):
                for j in range(len(lat)):
                    # FIXME: The needs to be sured up
                    p = project([lon[i],lat[j]], type=None)
                    if (p[0] == None or p[1] == None):
                        continue
                    self.WriteLine('SP(' + str(p[0]) + ', ' + str(p[0]) + ', 0.0 ){' + str(field[j][i]) + '};')
            self.WriteLine('};')

        elif(self.output_format == self._OUTPUT_FORMAT_TYPE_STRUCT):
            if not self.globe:

                x = [ lon[0], lon[-1] ]
                y = [ lat[-1], lat[0] ]

                self.WriteLine( str(x[0]) + ' ' + str(y[0]) + ' ' +  '0' )
                self.WriteLine( str(float(x[-1] - x[0])/len(lon)) + " " + str(float(y[-1] - y[0])/len(lat)) + ' 1')
            else:
                if self.globallonglat:
                    self.WriteLine( str( lon[0] + 180 ) + ' ' + str( lat[0] + 90 ) + ' 0' )
                else:
                    self.WriteLine( str( lon[0] ) + ' ' + str( lat[0] ) + ' 0' )

                self.WriteLine( str(float(abs(lon[0])+abs(lon[-1]))/len(lon))+" "+ str(float(abs(lat[0])+abs(lat[-1]))/len(lat)) + ' 1')

            self.WriteLine( str(len(lon))+" "+str(len(lat))+" 1")

            for i in range(len(lon)):
                for j in range(len(lat))[::-1]:
                    self.WriteLine(str(field[j][i]))
                    #self.WriteLine(str(lon[i]))

        self.Finalise()


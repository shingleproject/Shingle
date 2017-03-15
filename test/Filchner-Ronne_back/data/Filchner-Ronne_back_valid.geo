// Surface Geoid Boundary Representation, for project: Filchner-Ronne_back
// 
// Created by:  Shingle (v1.2)
// 
//    Shingle:  An approach and software library for the generation of
//              boundary representation from arbitrary geophysical fields
//              and initialisation for anisotropic, unstructured meshing.
// 
//              Web: https://www.shingleproject.org
// 
//              Contact: Dr Adam S. Candy, contact@shingleproject.org
//     
// Version: v1.2-446-g14c97ac
// Mesh tool version: 2.11.0
//                    (on the system where the boundry representation has been created)
// 
// Project name: Filchner-Ronne_back
// Boundary Specification authors: Adam S. Candy (A.S.Candy@tudelft.nl, Technische Universiteit Delft)
// Created at: 2017/03/15 12:28:48 
// Project description:
//   Use the RTopo dataset, 50S version (RTopo105b 50S.nc),
//   selecting the very back of the Filchner-Ronne ice sheet ocean cavity bounded by part of the grounding line,
//   extended up to the 83S parallel.
//   Ice shelf ocean cavities are included.

// == Source Shingle surface geoid boundnary representation =======
// <?xml version='1.0' encoding='utf-8'?>
// <boundary_representation>
//   <model_name>
//     <string_value lines="1">Filchner-Ronne_back</string_value>
//     <comment>Use the RTopo dataset, 50S version (RTopo105b 50S.nc),
// selecting the very back of the Filchner-Ronne ice sheet ocean cavity bounded by part of the grounding line,
// extended up to the 83S parallel.
// Ice shelf ocean cavities are included.</comment>
//   </model_name>
//   <reference>
//     <author name="ASCandy">
//       <string_value lines="1">Adam S. Candy</string_value>
//       <email_address>
//         <string_value lines="1">A.S.Candy@tudelft.nl</string_value>
//       </email_address>
//       <institution>
//         <string_value lines="1">Technische Universiteit Delft</string_value>
//       </institution>
//     </author>
//   </reference>
//   <domain_type>
//     <string_value lines="1">ocean_ice_shelf</string_value>
//   </domain_type>
//   <global_parameters/>
//   <output>
//     <orientation name="SouthPole"/>
//   </output>
//   <dataset name="RTopo">
//     <form name="Raster">
//       <source file_name="../../dataset/RTopo105b_50S.nc" name="Local_file"/>
//     </form>
//     <projection name="Automatic"/>
//   </dataset>
//   <geoid_surface_representation name="filchner_ronne_back">
//     <id>
//       <integer_value rank="0">9</integer_value>
//     </id>
//     <brep_component name="filchner_ronne_back_brep">
//       <form name="Raster">
//         <source name="RTopo"/>
//         <box>-85.0:-20.0,-89.0:-75.0 -64.0:-30.0,-89.0:-70.0 -30.0:-20.0,-89.0:-75.0</box>
//         <contourtype name="iceshelfcavity"/>
//         <boundary>1</boundary>
//       </form>
//       <identification name="Coast"/>
//       <id>
//         <integer_value rank="0">3</integer_value>
//       </id>
//       <representation_type name="BSplines"/>
//     </brep_component>
//     <brep_component name="ExtendToParallel83S">
//       <form name="ExtendToParallel">
//         <latitude>
//           <real_value rank="0">-83.0</real_value>
//         </latitude>
//       </form>
//       <identification name="OpenOcean"/>
//       <representation_type name="BSplines"/>
//     </brep_component>
//     <closure>
//       <no_open/>
//       <open_id>
//         <integer_value rank="0">4</integer_value>
//       </open_id>
//       <bounding_latitude>
//         <real_value rank="0">-83.0</real_value>
//       </bounding_latitude>
//     </closure>
//     <boundary name="Coast">
//       <identification_number>
//         <integer_value rank="0">3</integer_value>
//       </identification_number>
//     </boundary>
//     <boundary name="OpenOcean">
//       <identification_number>
//         <integer_value rank="0">4</integer_value>
//       </identification_number>
//     </boundary>
//   </geoid_surface_representation>
//   <geoid_metric>
//     <form name="Homogeneous">
//       <edge_length>
//         <real_value rank="0">5.0E2</real_value>
//       </edge_length>
//     </form>
//   </geoid_metric>
//   <geoid_mesh>
//     <library name="Gmsh"/>
//     <generate/>
//   </geoid_mesh>
//   <validation>
//     <test name="NodeNumber">
//       <value>
//         <integer_value rank="0">8102</integer_value>
//         <tolerance>
//           <integer_value rank="0">2</integer_value>
//         </tolerance>
//       </value>
//     </test>
//     <test name="ElementNumber">
//       <value>
//         <integer_value rank="0">16202</integer_value>
//         <tolerance>
//           <integer_value rank="0">4</integer_value>
//         </tolerance>
//       </value>
//     </test>
//     <test file_name="data/Filchner-Ronne_back_valid.geo" name="BrepDescription"/>
//   </validation>
// </boundary_representation>

// == Boundary Representation Specification Parameters ============
// Output to Filchner-Ronne_back.geo
// Projection type cartesian
//   1. filchner_ronne_back_brep
//       Path:           /geoid_surface_representation::filchner_ronne_back/brep_component::filchner_ronne_back_brep
//       Form:           Raster
//       Identification: Coast
//   2. ExtendToParallel83S
//       Path:           /geoid_surface_representation::filchner_ronne_back/brep_component::ExtendToParallel83S
//       Form:           ExtendToParallel
//       Identification: OpenOcean

// == BRep component: filchner_ronne_back_brep ====================
// Reading boundary representation filchner_ronne_back_brep
// Boundaries restricted to paths: 1
// Imposing box region: 
//   -85.0:-20.0,-89.0:-75.0
//   -64.0:-30.0,-89.0:-70.0
//   -30.0:-20.0,-89.0:-75.0
// Bounding by latitude: -83.0
// Region of interest: ((((longitude >= -85.0) and (longitude <= -20.0) and (latitude >= -89.0) and (latitude <= -75.0)) or ((longitude >= -64.0) and (longitude <= -30.0) and (latitude >= -89.0) and (latitude <= -70.0)) or ((longitude >= -30.0) and (longitude <= -20.0) and (latitude >= -89.0) and (latitude <= -75.0))) and (latitude <= -83.0))
// Region defined by ((((longitude >= -85.0) and (longitude <= -20.0) and (latitude >= -89.0) and (latitude <= -75.0)) or ((longitude >= -64.0) and (longitude <= -30.0) and (latitude >= -89.0) and (latitude <= -70.0)) or ((longitude >= -30.0) and (longitude <= -20.0) and (latitude >= -89.0) and (latitude <= -75.0))) and (latitude <= -83.0))
// Open contours closed with a line formed by points spaced 0.1 degrees apart
// Paths found: 348

// == Boundary Representation description =========================

// == Header ======================================================
Point ( 0 ) = { 0, 0, 0 };
Point ( 1 ) = { 0, 0, 6.37101e+06 };
PolarSphere ( 0 ) = { 0, 1 };

Delete { Point{ 0 }; }
Delete { Point{ 1 }; }

// Merged paths that cross the date line: 

// == Ice-Land mass number 1 ======================================
// Path 1: points 317 (of 59599) area 23814.8 (required closing in 2 parts of the path)

// == Ice-Land mass number 2 ======================================
//   Skipped (no points found in region)

// == Ice-Land mass number 3 ======================================
//   Skipped (no points found in region)

// == Ice-Land mass number 4 ======================================
//   Skipped (no points found in region)

// == Ice-Land mass number 5 ======================================
//   Skipped (no points found in region)

// == Ice-Land mass number 6 ======================================
//   Skipped (no points found in region)

// == Ice-Land mass number 7 ======================================
//   Skipped (no points found in region)

// == Ice-Land mass number 8 ======================================
//   Skipped (no points found in region)

// == Ice-Land mass number 9 ======================================
//   Skipped (no points found in region)

// == Ice-Land mass number 10 =====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 11 =====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 12 =====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 13 =====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 14 =====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 15 =====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 16 =====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 17 =====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 18 =====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 19 =====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 20 =====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 21 =====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 22 =====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 23 =====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 24 =====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 25 =====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 26 =====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 27 =====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 28 =====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 29 =====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 30 =====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 31 =====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 32 =====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 33 =====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 34 =====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 35 =====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 36 =====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 37 =====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 38 =====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 39 =====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 40 =====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 41 =====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 42 =====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 43 =====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 44 =====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 45 =====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 46 =====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 47 =====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 48 =====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 49 =====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 50 =====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 51 =====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 52 =====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 53 =====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 54 =====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 55 =====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 56 =====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 57 =====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 58 =====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 59 =====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 60 =====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 61 =====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 62 =====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 63 =====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 64 =====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 65 =====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 66 =====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 67 =====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 68 =====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 69 =====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 70 =====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 71 =====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 72 =====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 73 =====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 74 =====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 75 =====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 76 =====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 77 =====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 78 =====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 79 =====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 80 =====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 81 =====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 82 =====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 83 =====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 84 =====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 85 =====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 86 =====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 87 =====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 88 =====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 89 =====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 90 =====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 91 =====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 92 =====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 93 =====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 94 =====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 95 =====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 96 =====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 97 =====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 98 =====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 99 =====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 100 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 101 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 102 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 103 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 104 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 105 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 106 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 107 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 108 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 109 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 110 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 111 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 112 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 113 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 114 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 115 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 116 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 117 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 118 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 119 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 120 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 121 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 122 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 123 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 124 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 125 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 126 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 127 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 128 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 129 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 130 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 131 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 132 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 133 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 134 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 135 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 136 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 137 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 138 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 139 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 140 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 141 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 142 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 143 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 144 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 145 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 146 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 147 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 148 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 149 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 150 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 151 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 152 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 153 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 154 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 155 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 156 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 157 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 158 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 159 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 160 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 161 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 162 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 163 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 164 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 165 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 166 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 167 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 168 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 169 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 170 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 171 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 172 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 173 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 174 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 175 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 176 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 177 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 178 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 179 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 180 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 181 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 182 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 183 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 184 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 185 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 186 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 187 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 188 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 189 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 190 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 191 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 192 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 193 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 194 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 195 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 196 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 197 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 198 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 199 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 200 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 201 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 202 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 203 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 204 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 205 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 206 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 207 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 208 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 209 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 210 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 211 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 212 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 213 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 214 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 215 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 216 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 217 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 218 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 219 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 220 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 221 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 222 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 223 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 224 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 225 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 226 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 227 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 228 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 229 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 230 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 231 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 232 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 233 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 234 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 235 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 236 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 237 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 238 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 239 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 240 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 241 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 242 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 243 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 244 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 245 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 246 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 247 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 248 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 249 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 250 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 251 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 252 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 253 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 254 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 255 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 256 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 257 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 258 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 259 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 260 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 261 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 262 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 263 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 264 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 265 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 266 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 267 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 268 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 269 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 270 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 271 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 272 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 273 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 274 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 275 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 276 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 277 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 278 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 279 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 280 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 281 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 282 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 283 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 284 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 285 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 286 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 287 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 288 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 289 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 290 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 291 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 292 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 293 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 294 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 295 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 296 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 297 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 298 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 299 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 300 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 301 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 302 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 303 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 304 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 305 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 306 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 307 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 308 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 309 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 310 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 311 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 312 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 313 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 314 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 315 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 316 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 317 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 318 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 319 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 320 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 321 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 322 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 323 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 324 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 325 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 326 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 327 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 328 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 329 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 330 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 331 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 332 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 333 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 334 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 335 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 336 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 337 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 338 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 339 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 340 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 341 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 342 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 343 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 344 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 345 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 346 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 347 ====================================
//   Skipped (no points found in region)

// == Ice-Land mass number 348 ====================================
//   Skipped (no points found in region)
// Paths found valid (renumbered order): 1, including 1

// == Ice-Land mass number 1 ======================================
Point ( 2 ) = { -8.69030439, 13.84905714, 0.00000000 };
Point ( 3 ) = { -8.69867315, 13.86687400, 0.00000000 };
Point ( 4 ) = { -8.69464005, 13.86940314, 0.00000000 };
Point ( 5 ) = { -8.69060438, 13.87193226, 0.00000000 };
Point ( 6 ) = { -8.68656982, 13.87445905, 0.00000000 };
Point ( 7 ) = { -8.68253267, 13.87698582, 0.00000000 };
Point ( 8 ) = { -8.67849664, 13.87951027, 0.00000000 };
Point ( 9 ) = { -8.67445802, 13.88203469, 0.00000000 };
Point ( 10 ) = { -8.67041867, 13.88455794, 0.00000000 };
Point ( 11 ) = { -8.66638044, 13.88707886, 0.00000000 };
Point ( 12 ) = { -8.67472736, 13.90495739, 0.00000000 };
Point ( 13 ) = { -8.69552662, 13.93829710, 0.00000000 };
Point ( 14 ) = { -8.70393815, 13.95630078, 0.00000000 };
Point ( 15 ) = { -8.69987905, 13.95883144, 0.00000000 };
Point ( 16 ) = { -8.69581735, 13.96136209, 0.00000000 };
Point ( 17 ) = { -8.69175678, 13.96389039, 0.00000000 };
Point ( 18 ) = { -8.68769361, 13.96641867, 0.00000000 };
Point ( 19 ) = { -8.68363157, 13.96894461, 0.00000000 };
Point ( 20 ) = { -8.69203679, 13.98700338, 0.00000000 };
Point ( 21 ) = { -8.70045717, 14.00509746, 0.00000000 };
Point ( 22 ) = { -8.70889849, 14.02323412, 0.00000000 };
Point ( 23 ) = { -8.72993953, 14.05711480, 0.00000000 };
Point ( 24 ) = { -8.73844666, 14.07537939, 0.00000000 };
Point ( 25 ) = { -8.74697317, 14.09368832, 0.00000000 };
Point ( 26 ) = { -8.75552491, 14.11204902, 0.00000000 };
Point ( 27 ) = { -8.75142052, 14.11459468, 0.00000000 };
Point ( 28 ) = { -8.74731350, 14.11714031, 0.00000000 };
Point ( 29 ) = { -8.74320762, 14.11968358, 0.00000000 };
Point ( 30 ) = { -8.73909913, 14.12222682, 0.00000000 };
Point ( 31 ) = { -8.73498989, 14.12476887, 0.00000000 };
Point ( 32 ) = { -8.74353629, 14.14318555, 0.00000000 };
Point ( 33 ) = { -8.76480433, 14.17758788, 0.00000000 };
Point ( 34 ) = { -8.78618554, 14.21217323, 0.00000000 };
Point ( 35 ) = { -8.79484106, 14.23080008, 0.00000000 };
Point ( 36 ) = { -8.79070023, 14.23335834, 0.00000000 };
Point ( 37 ) = { -8.79937120, 14.25203279, 0.00000000 };
Point ( 38 ) = { -8.80806804, 14.27076048, 0.00000000 };
Point ( 39 ) = { -8.80391559, 14.27332259, 0.00000000 };
Point ( 40 ) = { -8.79976429, 14.27588231, 0.00000000 };
Point ( 41 ) = { -8.79561034, 14.27844200, 0.00000000 };
Point ( 42 ) = { -8.79145755, 14.28099931, 0.00000000 };
Point ( 43 ) = { -8.80015263, 14.29978318, 0.00000000 };
Point ( 44 ) = { -8.80886382, 14.31860464, 0.00000000 };
Point ( 45 ) = { -8.80469935, 14.32116580, 0.00000000 };
Point ( 46 ) = { -8.81342617, 14.34003558, 0.00000000 };
Point ( 47 ) = { -8.82217914, 14.35895939, 0.00000000 };
Point ( 48 ) = { -8.81800294, 14.36152442, 0.00000000 };
Point ( 49 ) = { -8.81382407, 14.36408942, 0.00000000 };
Point ( 50 ) = { -8.80964638, 14.36665202, 0.00000000 };
Point ( 51 ) = { -8.80546602, 14.36921458, 0.00000000 };
Point ( 52 ) = { -8.80128492, 14.37177593, 0.00000000 };
Point ( 53 ) = { -8.79710499, 14.37433488, 0.00000000 };
Point ( 54 ) = { -8.79292240, 14.37689380, 0.00000000 };
Point ( 55 ) = { -8.78874098, 14.37945032, 0.00000000 };
Point ( 56 ) = { -8.78455690, 14.38200680, 0.00000000 };
Point ( 57 ) = { -8.78037399, 14.38456089, 0.00000000 };
Point ( 58 ) = { -8.77618843, 14.38711494, 0.00000000 };
Point ( 59 ) = { -8.78490289, 14.40611230, 0.00000000 };
Point ( 60 ) = { -8.79363361, 14.42514791, 0.00000000 };
Point ( 61 ) = { -8.78943623, 14.42770581, 0.00000000 };
Point ( 62 ) = { -8.78524004, 14.43026132, 0.00000000 };
Point ( 63 ) = { -8.78104117, 14.43281678, 0.00000000 };
Point ( 64 ) = { -8.77684349, 14.43536985, 0.00000000 };
Point ( 65 ) = { -8.78557230, 14.45446274, 0.00000000 };
Point ( 66 ) = { -8.80732017, 14.49024341, 0.00000000 };
Point ( 67 ) = { -8.81612371, 14.50948271, 0.00000000 };
Point ( 68 ) = { -8.81190373, 14.51204598, 0.00000000 };
Point ( 69 ) = { -8.80768107, 14.51460919, 0.00000000 };
Point ( 70 ) = { -8.80345767, 14.51717117, 0.00000000 };
Point ( 71 ) = { -8.79923545, 14.51973076, 0.00000000 };
Point ( 72 ) = { -8.80803811, 14.53902759, 0.00000000 };
Point ( 73 ) = { -8.81685735, 14.55836362, 0.00000000 };
Point ( 74 ) = { -8.82569921, 14.57774669, 0.00000000 };
Point ( 75 ) = { -8.83456783, 14.59718587, 0.00000000 };
Point ( 76 ) = { -8.84345732, 14.61667365, 0.00000000 };
Point ( 77 ) = { -8.85236366, 14.63620126, 0.00000000 };
Point ( 78 ) = { -8.84810683, 14.63877506, 0.00000000 };
Point ( 79 ) = { -8.85702945, 14.65835359, 0.00000000 };
Point ( 80 ) = { -8.86597919, 14.67798905, 0.00000000 };
Point ( 81 ) = { -8.86171021, 14.68056681, 0.00000000 };
Point ( 82 ) = { -8.85743852, 14.68314451, 0.00000000 };
Point ( 83 ) = { -8.85316803, 14.68571978, 0.00000000 };
Point ( 84 ) = { -8.84889484, 14.68829499, 0.00000000 };
Point ( 85 ) = { -8.85784480, 14.70798904, 0.00000000 };
Point ( 86 ) = { -8.88008959, 14.74492534, 0.00000000 };
Point ( 87 ) = { -8.88911208, 14.76476412, 0.00000000 };
Point ( 88 ) = { -8.89815602, 14.78465299, 0.00000000 };
Point ( 89 ) = { -8.90721736, 14.80458301, 0.00000000 };
Point ( 90 ) = { -8.90291155, 14.80717275, 0.00000000 };
Point ( 91 ) = { -8.89860302, 14.80976243, 0.00000000 };
Point ( 92 ) = { -8.90767532, 14.82974756, 0.00000000 };
Point ( 93 ) = { -8.91677541, 14.84979131, 0.00000000 };
Point ( 94 ) = { -8.91245646, 14.85238384, 0.00000000 };
Point ( 95 ) = { -8.90813478, 14.85497629, 0.00000000 };
Point ( 96 ) = { -8.90381432, 14.85756630, 0.00000000 };
Point ( 97 ) = { -8.91291963, 14.87766827, 0.00000000 };
Point ( 98 ) = { -8.92204256, 14.89781208, 0.00000000 };
Point ( 99 ) = { -8.91770964, 14.90040613, 0.00000000 };
Point ( 100 ) = { -8.92684956, 14.92060322, 0.00000000 };
Point ( 101 ) = { -8.93601760, 14.94085982, 0.00000000 };
Point ( 102 ) = { -8.93167216, 14.94345793, 0.00000000 };
Point ( 103 ) = { -8.92732398, 14.94605597, 0.00000000 };
Point ( 104 ) = { -8.92297703, 14.94865156, 0.00000000 };
Point ( 105 ) = { -8.91862734, 14.95124707, 0.00000000 };
Point ( 106 ) = { -8.91427888, 14.95384013, 0.00000000 };
Point ( 107 ) = { -8.90992768, 14.95643311, 0.00000000 };
Point ( 108 ) = { -8.90557771, 14.95902364, 0.00000000 };
Point ( 109 ) = { -8.90122500, 14.96161409, 0.00000000 };
Point ( 110 ) = { -8.89687154, 14.96420327, 0.00000000 };
Point ( 111 ) = { -8.89251932, 14.96679000, 0.00000000 };
Point ( 112 ) = { -8.88816435, 14.96937664, 0.00000000 };
Point ( 113 ) = { -8.88381062, 14.97196084, 0.00000000 };
Point ( 114 ) = { -8.87945415, 14.97454496, 0.00000000 };
Point ( 115 ) = { -8.87509892, 14.97712662, 0.00000000 };
Point ( 116 ) = { -8.87074094, 14.97970820, 0.00000000 };
Point ( 117 ) = { -8.86638421, 14.98228733, 0.00000000 };
Point ( 118 ) = { -8.86202473, 14.98486637, 0.00000000 };
Point ( 119 ) = { -8.85766650, 14.98744297, 0.00000000 };
Point ( 120 ) = { -8.85330552, 14.99001948, 0.00000000 };
Point ( 121 ) = { -8.84894579, 14.99259354, 0.00000000 };
Point ( 122 ) = { -8.84458332, 14.99516751, 0.00000000 };
Point ( 123 ) = { -8.84022209, 14.99773903, 0.00000000 };
Point ( 124 ) = { -8.83585812, 15.00031046, 0.00000000 };
Point ( 125 ) = { -8.83149340, 15.00288062, 0.00000000 };
Point ( 126 ) = { -8.82712993, 15.00544834, 0.00000000 };
Point ( 127 ) = { -8.82276372, 15.00801596, 0.00000000 };
Point ( 128 ) = { -8.81839876, 15.01058113, 0.00000000 };
Point ( 129 ) = { -8.81403105, 15.01314621, 0.00000000 };
Point ( 130 ) = { -8.80966460, 15.01570885, 0.00000000 };
Point ( 131 ) = { -8.80529540, 15.01827139, 0.00000000 };
Point ( 132 ) = { -8.80092745, 15.02083149, 0.00000000 };
Point ( 133 ) = { -8.79655676, 15.02339148, 0.00000000 };
Point ( 134 ) = { -8.79218733, 15.02594904, 0.00000000 };
Point ( 135 ) = { -8.78781515, 15.02850649, 0.00000000 };
Point ( 136 ) = { -8.78344424, 15.03106150, 0.00000000 };
Point ( 137 ) = { -8.77907057, 15.03361641, 0.00000000 };
Point ( 138 ) = { -8.77469817, 15.03616888, 0.00000000 };
Point ( 139 ) = { -8.77032302, 15.03872125, 0.00000000 };
Point ( 140 ) = { -8.76594712, 15.04127234, 0.00000000 };
Point ( 141 ) = { -8.76157249, 15.04382099, 0.00000000 };
Point ( 142 ) = { -8.75719512, 15.04636954, 0.00000000 };
Point ( 143 ) = { -8.75281900, 15.04891564, 0.00000000 };
Point ( 144 ) = { -8.74844015, 15.05146164, 0.00000000 };
Point ( 145 ) = { -8.74406255, 15.05400520, 0.00000000 };
Point ( 146 ) = { -8.73968221, 15.05654865, 0.00000000 };
Point ( 147 ) = { -8.73530314, 15.05908967, 0.00000000 };
Point ( 148 ) = { -8.73092132, 15.06163057, 0.00000000 };
Point ( 149 ) = { -8.73983492, 15.08206140, 0.00000000 };
Point ( 150 ) = { -8.74876584, 15.10253500, 0.00000000 };
Point ( 151 ) = { -8.74437138, 15.10507982, 0.00000000 };
Point ( 152 ) = { -8.73997820, 15.10762219, 0.00000000 };
Point ( 153 ) = { -8.73558226, 15.11016445, 0.00000000 };
Point ( 154 ) = { -8.73118759, 15.11270427, 0.00000000 };
Point ( 155 ) = { -8.72679018, 15.11524398, 0.00000000 };
Point ( 156 ) = { -8.72239202, 15.11778240, 0.00000000 };
Point ( 157 ) = { -8.71799514, 15.12031838, 0.00000000 };
Point ( 158 ) = { -8.71359551, 15.12285424, 0.00000000 };
Point ( 159 ) = { -8.70919716, 15.12538767, 0.00000000 };
Point ( 160 ) = { -8.70479605, 15.12792097, 0.00000000 };
Point ( 161 ) = { -8.71368972, 15.14847224, 0.00000000 };
Point ( 162 ) = { -8.72261091, 15.16908436, 0.00000000 };
Point ( 163 ) = { -8.71819709, 15.17162157, 0.00000000 };
Point ( 164 ) = { -8.71378456, 15.17415633, 0.00000000 };
Point ( 165 ) = { -8.70936926, 15.17669096, 0.00000000 };
Point ( 166 ) = { -8.70495525, 15.17922315, 0.00000000 };
Point ( 167 ) = { -8.70053848, 15.18175522, 0.00000000 };
Point ( 168 ) = { -8.69612300, 15.18428485, 0.00000000 };
Point ( 169 ) = { -8.69170476, 15.18681434, 0.00000000 };
Point ( 170 ) = { -8.68728780, 15.18934140, 0.00000000 };
Point ( 171 ) = { -8.68286809, 15.19186832, 0.00000000 };
Point ( 172 ) = { -8.67844765, 15.19439397, 0.00000000 };
Point ( 173 ) = { -8.67402849, 15.19691716, 0.00000000 };
Point ( 174 ) = { -8.66960657, 15.19944023, 0.00000000 };
Point ( 175 ) = { -8.67847811, 15.22013567, 0.00000000 };
Point ( 176 ) = { -8.68736700, 15.24087468, 0.00000000 };
Point ( 177 ) = { -8.68293229, 15.24340163, 0.00000000 };
Point ( 178 ) = { -8.67849888, 15.24592613, 0.00000000 };
Point ( 179 ) = { -8.67406271, 15.24845050, 0.00000000 };
Point ( 180 ) = { -8.66962783, 15.25097242, 0.00000000 };
Point ( 181 ) = { -8.66519019, 15.25349420, 0.00000000 };
Point ( 182 ) = { -8.66075384, 15.25601355, 0.00000000 };
Point ( 183 ) = { -8.65631473, 15.25853275, 0.00000000 };
Point ( 184 ) = { -8.65187693, 15.26104951, 0.00000000 };
Point ( 185 ) = { -8.63860280, 15.24280334, 0.00000000 };
Point ( 186 ) = { -8.62535725, 15.22459437, 0.00000000 };
Point ( 187 ) = { -8.62092931, 15.22710213, 0.00000000 };
Point ( 188 ) = { -8.61649862, 15.22960975, 0.00000000 };
Point ( 189 ) = { -8.61206719, 15.23211608, 0.00000000 };
Point ( 190 ) = { -8.60763707, 15.23461997, 0.00000000 };
Point ( 191 ) = { -8.60320419, 15.23712372, 0.00000000 };
Point ( 192 ) = { -8.59877260, 15.23962504, 0.00000000 };
Point ( 193 ) = { -8.59433827, 15.24212621, 0.00000000 };
Point ( 194 ) = { -8.58990523, 15.24462494, 0.00000000 };
Point ( 195 ) = { -8.58546944, 15.24712353, 0.00000000 };
Point ( 196 ) = { -8.58103495, 15.24961969, 0.00000000 };
Point ( 197 ) = { -8.57659770, 15.25211570, 0.00000000 };
Point ( 198 ) = { -8.57216176, 15.25460928, 0.00000000 };
Point ( 199 ) = { -8.56772307, 15.25710271, 0.00000000 };
Point ( 200 ) = { -8.56328568, 15.25959370, 0.00000000 };
Point ( 201 ) = { -8.55014771, 15.24137704, 0.00000000 };
Point ( 202 ) = { -8.53704792, 15.22321517, 0.00000000 };
Point ( 203 ) = { -8.53262039, 15.22569725, 0.00000000 };
Point ( 204 ) = { -8.52819010, 15.22817917, 0.00000000 };
Point ( 205 ) = { -8.52375910, 15.23065980, 0.00000000 };
Point ( 206 ) = { -8.51932940, 15.23313802, 0.00000000 };
Point ( 207 ) = { -8.51489695, 15.23561607, 0.00000000 };
Point ( 208 ) = { -8.51046581, 15.23809171, 0.00000000 };
Point ( 209 ) = { -8.50603192, 15.24056719, 0.00000000 };
Point ( 210 ) = { -8.50159935, 15.24304024, 0.00000000 };
Point ( 211 ) = { -8.48857479, 15.22489372, 0.00000000 };
Point ( 212 ) = { -8.47557811, 15.20678396, 0.00000000 };
Point ( 213 ) = { -8.47115536, 15.20924816, 0.00000000 };
Point ( 214 ) = { -8.46672986, 15.21171220, 0.00000000 };
Point ( 215 ) = { -8.46230568, 15.21417383, 0.00000000 };
Point ( 216 ) = { -8.45787875, 15.21663529, 0.00000000 };
Point ( 217 ) = { -8.45345313, 15.21909435, 0.00000000 };
Point ( 218 ) = { -8.44902478, 15.22155324, 0.00000000 };
Point ( 219 ) = { -8.44459773, 15.22400971, 0.00000000 };
Point ( 220 ) = { -8.43167057, 15.20591907, 0.00000000 };
Point ( 221 ) = { -8.41878080, 15.18788260, 0.00000000 };
Point ( 222 ) = { -8.41436152, 15.19033141, 0.00000000 };
Point ( 223 ) = { -8.40994356, 15.19277781, 0.00000000 };
Point ( 224 ) = { -8.40552286, 15.19522404, 0.00000000 };
Point ( 225 ) = { -8.40110347, 15.19766787, 0.00000000 };
Point ( 226 ) = { -8.39668135, 15.20011153, 0.00000000 };
Point ( 227 ) = { -8.38385111, 15.18210097, 0.00000000 };
Point ( 228 ) = { -8.37104819, 15.16412668, 0.00000000 };
Point ( 229 ) = { -8.36663583, 15.16656160, 0.00000000 };
Point ( 230 ) = { -8.36222478, 15.16899412, 0.00000000 };
Point ( 231 ) = { -8.35781100, 15.17142647, 0.00000000 };
Point ( 232 ) = { -8.35339853, 15.17385642, 0.00000000 };
Point ( 233 ) = { -8.34898334, 15.17628620, 0.00000000 };
Point ( 234 ) = { -8.34456946, 15.17871359, 0.00000000 };
Point ( 235 ) = { -8.33182890, 15.16076249, 0.00000000 };
Point ( 236 ) = { -8.31912501, 15.14286492, 0.00000000 };
Point ( 237 ) = { -8.31472086, 15.14528363, 0.00000000 };
Point ( 238 ) = { -8.31031398, 15.14770216, 0.00000000 };
Point ( 239 ) = { -8.30590640, 15.15011941, 0.00000000 };
Point ( 240 ) = { -8.30150013, 15.15253427, 0.00000000 };
Point ( 241 ) = { -8.29709114, 15.15494895, 0.00000000 };
Point ( 242 ) = { -8.29268347, 15.15736124, 0.00000000 };
Point ( 243 ) = { -8.28004248, 15.13948616, 0.00000000 };
Point ( 244 ) = { -8.26742825, 15.12164684, 0.00000000 };
Point ( 245 ) = { -8.26303026, 15.12405051, 0.00000000 };
Point ( 246 ) = { -8.25862956, 15.12645400, 0.00000000 };
Point ( 247 ) = { -8.25423018, 15.12885512, 0.00000000 };
Point ( 248 ) = { -8.24982809, 15.13125605, 0.00000000 };
Point ( 249 ) = { -8.24542731, 15.13365460, 0.00000000 };
Point ( 250 ) = { -8.23287040, 15.11584134, 0.00000000 };
Point ( 251 ) = { -8.22034946, 15.09808096, 0.00000000 };
Point ( 252 ) = { -8.21595833, 15.10047094, 0.00000000 };
Point ( 253 ) = { -8.21156449, 15.10286074, 0.00000000 };
Point ( 254 ) = { -8.20717198, 15.10524816, 0.00000000 };
Point ( 255 ) = { -8.19469760, 15.08752091, 0.00000000 };
Point ( 256 ) = { -8.18224949, 15.06982890, 0.00000000 };
Point ( 257 ) = { -8.16983224, 15.05218063, 0.00000000 };
Point ( 258 ) = { -8.16182437, 15.03221050, 0.00000000 };
Point ( 259 ) = { -8.15383620, 15.01228967, 0.00000000 };
Point ( 260 ) = { -8.14586301, 14.99240940, 0.00000000 };
Point ( 261 ) = { -8.15022272, 14.99003981, 0.00000000 };
Point ( 262 ) = { -8.14226334, 14.97021084, 0.00000000 };
Point ( 263 ) = { -8.13432810, 14.95043916, 0.00000000 };
Point ( 264 ) = { -8.13867561, 14.94807293, 0.00000000 };
Point ( 265 ) = { -8.14302441, 14.94570435, 0.00000000 };
Point ( 266 ) = { -8.14737053, 14.94333558, 0.00000000 };
Point ( 267 ) = { -8.13943751, 14.92361938, 0.00000000 };
Point ( 268 ) = { -8.13151928, 14.90394310, 0.00000000 };
Point ( 269 ) = { -8.13585325, 14.90157769, 0.00000000 };
Point ( 270 ) = { -8.12794865, 14.88195194, 0.00000000 };
Point ( 271 ) = { -8.12006334, 14.86237423, 0.00000000 };
Point ( 272 ) = { -8.12438523, 14.86001215, 0.00000000 };
Point ( 273 ) = { -8.11651344, 14.84048461, 0.00000000 };
Point ( 274 ) = { -8.10866539, 14.82101312, 0.00000000 };
Point ( 275 ) = { -8.11297525, 14.81865435, 0.00000000 };
Point ( 276 ) = { -8.10514062, 14.79923261, 0.00000000 };
Point ( 277 ) = { -8.09732044, 14.77984984, 0.00000000 };
Point ( 278 ) = { -8.10161833, 14.77749438, 0.00000000 };
Point ( 279 ) = { -8.10591750, 14.77513658, 0.00000000 };
Point ( 280 ) = { -8.11021599, 14.77277754, 0.00000000 };
Point ( 281 ) = { -8.10239691, 14.75344928, 0.00000000 };
Point ( 282 ) = { -8.09460131, 14.73417627, 0.00000000 };
Point ( 283 ) = { -8.09888789, 14.73182052, 0.00000000 };
Point ( 284 ) = { -8.09110554, 14.71259652, 0.00000000 };
Point ( 285 ) = { -8.08333745, 14.69341087, 0.00000000 };
Point ( 286 ) = { -8.07558907, 14.67427113, 0.00000000 };
Point ( 287 ) = { -8.06786388, 14.65518586, 0.00000000 };
Point ( 288 ) = { -8.07212552, 14.65283897, 0.00000000 };
Point ( 289 ) = { -8.07638842, 14.65048976, 0.00000000 };
Point ( 290 ) = { -8.08064870, 14.64814039, 0.00000000 };
Point ( 291 ) = { -8.07292547, 14.62910793, 0.00000000 };
Point ( 292 ) = { -8.06521630, 14.61011320, 0.00000000 };
Point ( 293 ) = { -8.06946483, 14.60776708, 0.00000000 };
Point ( 294 ) = { -8.07371462, 14.60541865, 0.00000000 };
Point ( 295 ) = { -8.06601196, 14.58647470, 0.00000000 };
Point ( 296 ) = { -8.05833225, 14.56758443, 0.00000000 };
Point ( 297 ) = { -8.05067189, 14.54873900, 0.00000000 };
Point ( 298 ) = { -8.04302537, 14.52993073, 0.00000000 };
Point ( 299 ) = { -8.04725058, 14.52759106, 0.00000000 };
Point ( 300 ) = { -8.03961687, 14.50883009, 0.00000000 };
Point ( 301 ) = { -8.03200582, 14.49012207, 0.00000000 };
Point ( 302 ) = { -8.03622138, 14.48778454, 0.00000000 };
Point ( 303 ) = { -8.04043434, 14.48544685, 0.00000000 };
Point ( 304 ) = { -8.04464855, 14.48310687, 0.00000000 };
Point ( 305 ) = { -8.03703837, 14.46445073, 0.00000000 };
Point ( 306 ) = { -8.02944186, 14.44583115, 0.00000000 };
Point ( 307 ) = { -8.03364454, 14.44349437, 0.00000000 };
Point ( 308 ) = { -8.02606068, 14.42492142, 0.00000000 };
Point ( 309 ) = { -8.01849924, 14.40640066, 0.00000000 };
Point ( 310 ) = { -8.01095667, 14.38792342, 0.00000000 };
Point ( 311 ) = { -8.00342756, 14.36948217, 0.00000000 };
Point ( 312 ) = { -7.99591530, 14.35108525, 0.00000000 };
Point ( 313 ) = { -7.98425662, 14.33506236, 0.00000000 };
Point ( 314 ) = { -7.97262462, 14.31907788, 0.00000000 };
Point ( 315 ) = { -7.96101581, 14.30312331, 0.00000000 };
Point ( 316 ) = { -7.95685588, 14.30543790, 0.00000000 };
Point ( 317 ) = { -7.95269337, 14.30775235, 0.00000000 };
// Keeping path 1 open to be closed by a later component
BSpline ( 0 ) = { 2 : 317 };


// == BRep component: ExtendToParallel83S =========================
// Extending exterior boundary developed in filchner_ronne_back_brep to parallel -83.0
// Closing path with parallels and meridians, from (-60.94166565, -83.00000000) to  (-57.89166641, -83.00000000)
// Drawing parallel index 317 at -60.94 (to match -57.89), -83.00
Point ( 318 ) = { -7.96605406, 14.27794652, 0.00000000 };
Point ( 319 ) = { -7.99096164, 14.26402139, 0.00000000 };
Point ( 320 ) = { -8.01584487, 14.25005281, 0.00000000 };
Point ( 321 ) = { -8.04070368, 14.23604083, 0.00000000 };
Point ( 322 ) = { -8.06553800, 14.22198548, 0.00000000 };
Point ( 323 ) = { -8.09034775, 14.20788680, 0.00000000 };
Point ( 324 ) = { -8.11513285, 14.19374485, 0.00000000 };
Point ( 325 ) = { -8.13989324, 14.17955966, 0.00000000 };
Point ( 326 ) = { -8.16462883, 14.16533128, 0.00000000 };
Point ( 327 ) = { -8.18933955, 14.15105974, 0.00000000 };
Point ( 328 ) = { -8.21402532, 14.13674510, 0.00000000 };
Point ( 329 ) = { -8.23868607, 14.12238740, 0.00000000 };
Point ( 330 ) = { -8.26332173, 14.10798668, 0.00000000 };
Point ( 331 ) = { -8.28793221, 14.09354298, 0.00000000 };
Point ( 332 ) = { -8.31251745, 14.07905635, 0.00000000 };
Point ( 333 ) = { -8.33707736, 14.06452684, 0.00000000 };
Point ( 334 ) = { -8.36161188, 14.04995448, 0.00000000 };
Point ( 335 ) = { -8.38612093, 14.03533932, 0.00000000 };
Point ( 336 ) = { -8.41060444, 14.02068141, 0.00000000 };
Point ( 337 ) = { -8.43506232, 14.00598079, 0.00000000 };
Point ( 338 ) = { -8.45949451, 13.99123750, 0.00000000 };
Point ( 339 ) = { -8.48390093, 13.97645159, 0.00000000 };
Point ( 340 ) = { -8.50828150, 13.96162311, 0.00000000 };
Point ( 341 ) = { -8.53263616, 13.94675210, 0.00000000 };
Point ( 342 ) = { -8.55696483, 13.93183861, 0.00000000 };
Point ( 343 ) = { -8.58126743, 13.91688268, 0.00000000 };
Point ( 344 ) = { -8.60554389, 13.90188435, 0.00000000 };
Point ( 345 ) = { -8.62979413, 13.88684368, 0.00000000 };
Point ( 346 ) = { -8.65401809, 13.87176070, 0.00000000 };
BSpline ( 1 ) = { 317 : 346, 2 };
Line Loop( 0 ) = { 0, 1 };


// == Physical entities ===========================================
// Boundary OpenOcean (ID 4): 2
Physical Line( 4 ) = { 1 };
// Boundary Coast (ID 3): 1
Physical Line( 3 ) = { 0 };
Plane Surface( 10 ) = { 0 };
Physical Surface( 10 ) = { 10 };

// == End of contour definitions ==================================
// Do not extent the elements sizes from the boundary inside the domain
Mesh.CharacteristicLengthExtendFromBoundary = 0;

// == Field definitions ===========================================

Field[ 1 ] = MathEval;
Field[ 1 ].F = "5.000000e+02";

Background Field = 1;


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
General.RotationX = 180;
General.RotationY = 0;
General.RotationZ = 270;


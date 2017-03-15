// Surface Geoid Boundary Representation, for project: Pine_Island_Glacier
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
// Project name: Pine_Island_Glacier
// Boundary Specification authors: Adam S. Candy (A.S.Candy@tudelft.nl, Technische Universiteit Delft)
// Created at: 2017/03/15 12:29:01 
// Project description:
//   Use the RTopo dataset, 50S version (RTopo105b 50S.nc),
//   selecting the region
//   [-103:-99.0,-75.5:-73.9] for the Pine Island Glacier ice shelf ocean cavity,
//   extended out to the 105W meridian.
//   Ice shelf ocean cavities are included.

// == Source Shingle surface geoid boundnary representation =======
// <?xml version='1.0' encoding='utf-8'?>
// <boundary_representation>
//   <model_name>
//     <string_value lines="1">Pine_Island_Glacier</string_value>
//     <comment>Use the RTopo dataset, 50S version (RTopo105b 50S.nc),
// selecting the region
// [-103:-99.0,-75.5:-73.9] for the Pine Island Glacier ice shelf ocean cavity,
// extended out to the 105W meridian.
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
//   <geoid_surface_representation name="Amundsen_Sea">
//     <id>
//       <integer_value rank="0">9</integer_value>
//     </id>
//     <brep_component name="Amundsen_Sea_brep">
//       <form name="Raster">
//         <source name="RTopo"/>
//         <box>-103:-99.0,-75.5:-73.9</box>
//         <contourtype name="iceshelfcavity"/>
//         <boundary>1</boundary>
//       </form>
//       <identification name="Coast"/>
//       <id>
//         <integer_value rank="0">3</integer_value>
//       </id>
//       <representation_type name="BSplines"/>
//     </brep_component>
//     <brep_component name="ExtendTo64S">
//       <form name="ExtendToMeridian">
//         <longitude>
//           <real_value rank="0">-105</real_value>
//         </longitude>
//       </form>
//       <identification name="OpenOcean"/>
//       <representation_type name="BSplines"/>
//     </brep_component>
//     <closure>
//       <no_open/>
//       <open_id>
//         <integer_value rank="0">4</integer_value>
//       </open_id>
//       <extend_to_latitude>
//         <real_value rank="0">-64.0</real_value>
//       </extend_to_latitude>
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
//     <form name="Proximity">
//       <boundary name="Coast"/>
//       <edge_length_minimum>
//         <real_value rank="0">2.0E3</real_value>
//       </edge_length_minimum>
//       <edge_length_maximum>
//         <real_value rank="0">5.0E4</real_value>
//       </edge_length_maximum>
//       <proximity_minimum>
//         <real_value rank="0">3.0E3</real_value>
//       </proximity_minimum>
//       <proximity_maximum>
//         <real_value rank="0">4.0E5</real_value>
//       </proximity_maximum>
//     </form>
//   </geoid_metric>
//   <geoid_mesh>
//     <library name="Gmsh"/>
//   </geoid_mesh>
//   <validation>
//     <test file_name="data/Pine_Island_Glacier_valid.geo" name="BrepDescription"/>
//   </validation>
// </boundary_representation>

// == Boundary Representation Specification Parameters ============
// Output to Pine_Island_Glacier.geo
// Projection type cartesian
// Extending region to meet parallel on latitude -64.0
//   1. Amundsen_Sea_brep
//       Path:           /geoid_surface_representation::Amundsen_Sea/brep_component::Amundsen_Sea_brep
//       Form:           Raster
//       Identification: Coast
//   2. ExtendTo64S
//       Path:           /geoid_surface_representation::Amundsen_Sea/brep_component::ExtendTo64S
//       Form:           ExtendToMeridian
//       Identification: OpenOcean

// == BRep component: Amundsen_Sea_brep ===========================
// Reading boundary representation Amundsen_Sea_brep
// Boundaries restricted to paths: 1
// Imposing box region: 
//   -103:-99.0,-75.5:-73.9
// Region of interest: ((longitude >= -103) and (longitude <= -99.0) and (latitude >= -75.5) and (latitude <= -73.9))
// Region defined by ((longitude >= -103) and (longitude <= -99.0) and (latitude >= -75.5) and (latitude <= -73.9))
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
// Path 1: points 635 (of 59599) area 73279.2 (required closing in 2 parts of the path)

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
Point ( 2 ) = { 1.57149324, 6.89374423, 0.00000000 };
Point ( 3 ) = { 1.57131472, 6.89758934, 0.00000000 };
Point ( 4 ) = { 1.56930780, 6.89804623, 0.00000000 };
Point ( 5 ) = { 1.56730166, 6.89850232, 0.00000000 };
Point ( 6 ) = { 1.56529447, 6.89895803, 0.00000000 };
Point ( 7 ) = { 1.56328807, 6.89941295, 0.00000000 };
Point ( 8 ) = { 1.56128062, 6.89986750, 0.00000000 };
Point ( 9 ) = { 1.56109580, 6.90371627, 0.00000000 };
Point ( 10 ) = { 1.56091111, 6.90757053, 0.00000000 };
Point ( 11 ) = { 1.55890220, 6.90802418, 0.00000000 };
Point ( 12 ) = { 1.55689225, 6.90847745, 0.00000000 };
Point ( 13 ) = { 1.55488308, 6.90892993, 0.00000000 };
Point ( 14 ) = { 1.55287285, 6.90938203, 0.00000000 };
Point ( 15 ) = { 1.55086342, 6.90983334, 0.00000000 };
Point ( 16 ) = { 1.54885294, 6.91028427, 0.00000000 };
Point ( 17 ) = { 1.54684324, 6.91073441, 0.00000000 };
Point ( 18 ) = { 1.54483250, 6.91118417, 0.00000000 };
Point ( 19 ) = { 1.54282254, 6.91163314, 0.00000000 };
Point ( 20 ) = { 1.54081153, 6.91208174, 0.00000000 };
Point ( 21 ) = { 1.53880132, 6.91252954, 0.00000000 };
Point ( 22 ) = { 1.53679005, 6.91297696, 0.00000000 };
Point ( 23 ) = { 1.53659211, 6.91683427, 0.00000000 };
Point ( 24 ) = { 1.53639355, 6.92069376, 0.00000000 };
Point ( 25 ) = { 1.53437990, 6.92114048, 0.00000000 };
Point ( 26 ) = { 1.53236613, 6.92158662, 0.00000000 };
Point ( 27 ) = { 1.53035315, 6.92203196, 0.00000000 };
Point ( 28 ) = { 1.52833912, 6.92247693, 0.00000000 };
Point ( 29 ) = { 1.52632588, 6.92292110, 0.00000000 };
Point ( 30 ) = { 1.52431159, 6.92336489, 0.00000000 };
Point ( 31 ) = { 1.52229809, 6.92380790, 0.00000000 };
Point ( 32 ) = { 1.52028354, 6.92425052, 0.00000000 };
Point ( 33 ) = { 1.51826978, 6.92469235, 0.00000000 };
Point ( 34 ) = { 1.51625498, 6.92513380, 0.00000000 };
Point ( 35 ) = { 1.51424097, 6.92557446, 0.00000000 };
Point ( 36 ) = { 1.51222590, 6.92601473, 0.00000000 };
Point ( 37 ) = { 1.51021164, 6.92645422, 0.00000000 };
Point ( 38 ) = { 1.50819632, 6.92689332, 0.00000000 };
Point ( 39 ) = { 1.50618179, 6.92733164, 0.00000000 };
Point ( 40 ) = { 1.50416622, 6.92776957, 0.00000000 };
Point ( 41 ) = { 1.50394896, 6.93163203, 0.00000000 };
Point ( 42 ) = { 1.50373178, 6.93550000, 0.00000000 };
Point ( 43 ) = { 1.50171476, 6.93593702, 0.00000000 };
Point ( 44 ) = { 1.49969668, 6.93637365, 0.00000000 };
Point ( 45 ) = { 1.49767940, 6.93680949, 0.00000000 };
Point ( 46 ) = { 1.49566107, 6.93724495, 0.00000000 };
Point ( 47 ) = { 1.49364354, 6.93767962, 0.00000000 };
Point ( 48 ) = { 1.49162495, 6.93811390, 0.00000000 };
Point ( 49 ) = { 1.48960717, 6.93854740, 0.00000000 };
Point ( 50 ) = { 1.48758833, 6.93898051, 0.00000000 };
Point ( 51 ) = { 1.48557029, 6.93941283, 0.00000000 };
Point ( 52 ) = { 1.48355121, 6.93984476, 0.00000000 };
Point ( 53 ) = { 1.48153292, 6.94027591, 0.00000000 };
Point ( 54 ) = { 1.48130308, 6.94414702, 0.00000000 };
Point ( 55 ) = { 1.48107295, 6.94802199, 0.00000000 };
Point ( 56 ) = { 1.47905228, 6.94845242, 0.00000000 };
Point ( 57 ) = { 1.47703056, 6.94888245, 0.00000000 };
Point ( 58 ) = { 1.47500872, 6.94931190, 0.00000000 };
Point ( 59 ) = { 1.47298768, 6.94974056, 0.00000000 };
Point ( 60 ) = { 1.47096559, 6.95016884, 0.00000000 };
Point ( 61 ) = { 1.46894429, 6.95059632, 0.00000000 };
Point ( 62 ) = { 1.46870711, 6.95447475, 0.00000000 };
Point ( 63 ) = { 1.46846926, 6.95835536, 0.00000000 };
Point ( 64 ) = { 1.46644559, 6.95878212, 0.00000000 };
Point ( 65 ) = { 1.46442087, 6.95920849, 0.00000000 };
Point ( 66 ) = { 1.46239695, 6.95963407, 0.00000000 };
Point ( 67 ) = { 1.46037198, 6.96005926, 0.00000000 };
Point ( 68 ) = { 1.45834781, 6.96048367, 0.00000000 };
Point ( 69 ) = { 1.45632260, 6.96090768, 0.00000000 };
Point ( 70 ) = { 1.45607814, 6.96479165, 0.00000000 };
Point ( 71 ) = { 1.45583338, 6.96867949, 0.00000000 };
Point ( 72 ) = { 1.45380578, 6.96910277, 0.00000000 };
Point ( 73 ) = { 1.45177899, 6.96952527, 0.00000000 };
Point ( 74 ) = { 1.44975114, 6.96994737, 0.00000000 };
Point ( 75 ) = { 1.44772317, 6.97036888, 0.00000000 };
Point ( 76 ) = { 1.44569600, 6.97078961, 0.00000000 };
Point ( 77 ) = { 1.44366779, 6.97120994, 0.00000000 };
Point ( 78 ) = { 1.44164038, 6.97162949, 0.00000000 };
Point ( 79 ) = { 1.44138693, 6.97552081, 0.00000000 };
Point ( 80 ) = { 1.44113351, 6.97941770, 0.00000000 };
Point ( 81 ) = { 1.43910371, 6.97983651, 0.00000000 };
Point ( 82 ) = { 1.43707287, 6.98025492, 0.00000000 };
Point ( 83 ) = { 1.43504283, 6.98067255, 0.00000000 };
Point ( 84 ) = { 1.43478569, 6.98457312, 0.00000000 };
Point ( 85 ) = { 1.43452824, 6.98847760, 0.00000000 };
Point ( 86 ) = { 1.43249581, 6.98889449, 0.00000000 };
Point ( 87 ) = { 1.43223690, 6.99280280, 0.00000000 };
Point ( 88 ) = { 1.43197732, 6.99671333, 0.00000000 };
Point ( 89 ) = { 1.42994250, 6.99712947, 0.00000000 };
Point ( 90 ) = { 1.42968146, 7.00104385, 0.00000000 };
Point ( 91 ) = { 1.42942045, 7.00496384, 0.00000000 };
Point ( 92 ) = { 1.42915958, 7.00888768, 0.00000000 };
Point ( 93 ) = { 1.42889805, 7.01281376, 0.00000000 };
Point ( 94 ) = { 1.42685761, 7.01322920, 0.00000000 };
Point ( 95 ) = { 1.42481705, 7.01364405, 0.00000000 };
Point ( 96 ) = { 1.42455290, 7.01757392, 0.00000000 };
Point ( 97 ) = { 1.42428877, 7.02150944, 0.00000000 };
Point ( 98 ) = { 1.42224580, 7.02192354, 0.00000000 };
Point ( 99 ) = { 1.42198020, 7.02586295, 0.00000000 };
Point ( 100 ) = { 1.42171393, 7.02980461, 0.00000000 };
Point ( 101 ) = { 1.41966855, 7.03021796, 0.00000000 };
Point ( 102 ) = { 1.41940080, 7.03416351, 0.00000000 };
Point ( 103 ) = { 1.41913306, 7.03811475, 0.00000000 };
Point ( 104 ) = { 1.41708526, 7.03852735, 0.00000000 };
Point ( 105 ) = { 1.41681605, 7.04248250, 0.00000000 };
Point ( 106 ) = { 1.41654615, 7.04643992, 0.00000000 };
Point ( 107 ) = { 1.41627546, 7.05040142, 0.00000000 };
Point ( 108 ) = { 1.41778732, 7.05792768, 0.00000000 };
Point ( 109 ) = { 1.41930166, 7.06546627, 0.00000000 };
Point ( 110 ) = { 1.42081988, 7.07302413, 0.00000000 };
Point ( 111 ) = { 1.42260966, 7.07660214, 0.00000000 };
Point ( 112 ) = { 1.42440085, 7.08018384, 0.00000000 };
Point ( 113 ) = { 1.42413342, 7.08418188, 0.00000000 };
Point ( 114 ) = { 1.42386519, 7.08818407, 0.00000000 };
Point ( 115 ) = { 1.42359662, 7.09219033, 0.00000000 };
Point ( 116 ) = { 1.42332819, 7.09620056, 0.00000000 };
Point ( 117 ) = { 1.42305978, 7.10021661, 0.00000000 };
Point ( 118 ) = { 1.42279056, 7.10423685, 0.00000000 };
Point ( 119 ) = { 1.42432038, 7.11187550, 0.00000000 };
Point ( 120 ) = { 1.42612129, 7.11549173, 0.00000000 };
Point ( 121 ) = { 1.42792362, 7.11911172, 0.00000000 };
Point ( 122 ) = { 1.42972820, 7.12273713, 0.00000000 };
Point ( 123 ) = { 1.43180050, 7.12232085, 0.00000000 };
Point ( 124 ) = { 1.43387173, 7.12190416, 0.00000000 };
Point ( 125 ) = { 1.43594379, 7.12148667, 0.00000000 };
Point ( 126 ) = { 1.43775344, 7.12511419, 0.00000000 };
Point ( 127 ) = { 1.43956463, 7.12874363, 0.00000000 };
Point ( 128 ) = { 1.44163868, 7.12832448, 0.00000000 };
Point ( 129 ) = { 1.44371166, 7.12790493, 0.00000000 };
Point ( 130 ) = { 1.44552734, 7.13153690, 0.00000000 };
Point ( 131 ) = { 1.44708807, 7.13923678, 0.00000000 };
Point ( 132 ) = { 1.44865139, 7.14694946, 0.00000000 };
Point ( 133 ) = { 1.44839438, 7.15102449, 0.00000000 };
Point ( 134 ) = { 1.44813751, 7.15510361, 0.00000000 };
Point ( 135 ) = { 1.44787996, 7.15918513, 0.00000000 };
Point ( 136 ) = { 1.44762161, 7.16327094, 0.00000000 };
Point ( 137 ) = { 1.44736329, 7.16736273, 0.00000000 };
Point ( 138 ) = { 1.44710513, 7.17145863, 0.00000000 };
Point ( 139 ) = { 1.44684628, 7.17555696, 0.00000000 };
Point ( 140 ) = { 1.44658662, 7.17965960, 0.00000000 };
Point ( 141 ) = { 1.44632699, 7.18376825, 0.00000000 };
Point ( 142 ) = { 1.44423777, 7.18418857, 0.00000000 };
Point ( 143 ) = { 1.44397662, 7.18830138, 0.00000000 };
Point ( 144 ) = { 1.44371514, 7.19241843, 0.00000000 };
Point ( 145 ) = { 1.44162340, 7.19283798, 0.00000000 };
Point ( 146 ) = { 1.44136039, 7.19695921, 0.00000000 };
Point ( 147 ) = { 1.44109669, 7.20108289, 0.00000000 };
Point ( 148 ) = { 1.43900243, 7.20150168, 0.00000000 };
Point ( 149 ) = { 1.43690709, 7.20192006, 0.00000000 };
Point ( 150 ) = { 1.43664114, 7.20604775, 0.00000000 };
Point ( 151 ) = { 1.43637485, 7.21017971, 0.00000000 };
Point ( 152 ) = { 1.43427698, 7.21059732, 0.00000000 };
Point ( 153 ) = { 1.43217900, 7.21101431, 0.00000000 };
Point ( 154 ) = { 1.43008185, 7.21143051, 0.00000000 };
Point ( 155 ) = { 1.42798362, 7.21184629, 0.00000000 };
Point ( 156 ) = { 1.42588623, 7.21226127, 0.00000000 };
Point ( 157 ) = { 1.42378776, 7.21267582, 0.00000000 };
Point ( 158 ) = { 1.42351391, 7.21681158, 0.00000000 };
Point ( 159 ) = { 1.42324008, 7.22095341, 0.00000000 };
Point ( 160 ) = { 1.42113908, 7.22136720, 0.00000000 };
Point ( 161 ) = { 1.41903892, 7.22178019, 0.00000000 };
Point ( 162 ) = { 1.41693768, 7.22219275, 0.00000000 };
Point ( 163 ) = { 1.41483729, 7.22260452, 0.00000000 };
Point ( 164 ) = { 1.41273581, 7.22301586, 0.00000000 };
Point ( 165 ) = { 1.41063517, 7.22342640, 0.00000000 };
Point ( 166 ) = { 1.40853345, 7.22383652, 0.00000000 };
Point ( 167 ) = { 1.40643258, 7.22424584, 0.00000000 };
Point ( 168 ) = { 1.40433062, 7.22465474, 0.00000000 };
Point ( 169 ) = { 1.40222855, 7.22506302, 0.00000000 };
Point ( 170 ) = { 1.40012731, 7.22547051, 0.00000000 };
Point ( 171 ) = { 1.39802500, 7.22587757, 0.00000000 };
Point ( 172 ) = { 1.39592353, 7.22628383, 0.00000000 };
Point ( 173 ) = { 1.39382098, 7.22668967, 0.00000000 };
Point ( 174 ) = { 1.39171928, 7.22709471, 0.00000000 };
Point ( 175 ) = { 1.38961650, 7.22749933, 0.00000000 };
Point ( 176 ) = { 1.38751456, 7.22790315, 0.00000000 };
Point ( 177 ) = { 1.38541154, 7.22830654, 0.00000000 };
Point ( 178 ) = { 1.38330936, 7.22870913, 0.00000000 };
Point ( 179 ) = { 1.38120611, 7.22911130, 0.00000000 };
Point ( 180 ) = { 1.37910370, 7.22951268, 0.00000000 };
Point ( 181 ) = { 1.37700021, 7.22991362, 0.00000000 };
Point ( 182 ) = { 1.37489757, 7.23031377, 0.00000000 };
Point ( 183 ) = { 1.37279385, 7.23071349, 0.00000000 };
Point ( 184 ) = { 1.37069001, 7.23111260, 0.00000000 };
Point ( 185 ) = { 1.36889217, 7.22737127, 0.00000000 };
Point ( 186 ) = { 1.36709659, 7.22363558, 0.00000000 };
Point ( 187 ) = { 1.36499481, 7.22403303, 0.00000000 };
Point ( 188 ) = { 1.36289388, 7.22442969, 0.00000000 };
Point ( 189 ) = { 1.36079187, 7.22482592, 0.00000000 };
Point ( 190 ) = { 1.35869071, 7.22522136, 0.00000000 };
Point ( 191 ) = { 1.35658848, 7.22561636, 0.00000000 };
Point ( 192 ) = { 1.35448708, 7.22601058, 0.00000000 };
Point ( 193 ) = { 1.35238462, 7.22640436, 0.00000000 };
Point ( 194 ) = { 1.35028300, 7.22679735, 0.00000000 };
Point ( 195 ) = { 1.34818030, 7.22718991, 0.00000000 };
Point ( 196 ) = { 1.34607845, 7.22758168, 0.00000000 };
Point ( 197 ) = { 1.34397553, 7.22797301, 0.00000000 };
Point ( 198 ) = { 1.34187345, 7.22836356, 0.00000000 };
Point ( 199 ) = { 1.33977030, 7.22875367, 0.00000000 };
Point ( 200 ) = { 1.33766704, 7.22914317, 0.00000000 };
Point ( 201 ) = { 1.33556462, 7.22953188, 0.00000000 };
Point ( 202 ) = { 1.33346113, 7.22992016, 0.00000000 };
Point ( 203 ) = { 1.33135849, 7.23030765, 0.00000000 };
Point ( 204 ) = { 1.32925477, 7.23069470, 0.00000000 };
Point ( 205 ) = { 1.32715190, 7.23108097, 0.00000000 };
Point ( 206 ) = { 1.32504796, 7.23146679, 0.00000000 };
Point ( 207 ) = { 1.32294487, 7.23185184, 0.00000000 };
Point ( 208 ) = { 1.32084071, 7.23223644, 0.00000000 };
Point ( 209 ) = { 1.31873739, 7.23262026, 0.00000000 };
Point ( 210 ) = { 1.31663300, 7.23300364, 0.00000000 };
Point ( 211 ) = { 1.31629783, 7.23713488, 0.00000000 };
Point ( 212 ) = { 1.31596259, 7.24127220, 0.00000000 };
Point ( 213 ) = { 1.31385568, 7.24165477, 0.00000000 };
Point ( 214 ) = { 1.31174963, 7.24203655, 0.00000000 };
Point ( 215 ) = { 1.30964250, 7.24241790, 0.00000000 };
Point ( 216 ) = { 1.30753526, 7.24279864, 0.00000000 };
Point ( 217 ) = { 1.30542887, 7.24317858, 0.00000000 };
Point ( 218 ) = { 1.30332141, 7.24355809, 0.00000000 };
Point ( 219 ) = { 1.30121481, 7.24393681, 0.00000000 };
Point ( 220 ) = { 1.29910713, 7.24431510, 0.00000000 };
Point ( 221 ) = { 1.29700030, 7.24469259, 0.00000000 };
Point ( 222 ) = { 1.29489240, 7.24506965, 0.00000000 };
Point ( 223 ) = { 1.29278535, 7.24544592, 0.00000000 };
Point ( 224 ) = { 1.29243597, 7.24958651, 0.00000000 };
Point ( 225 ) = { 1.29208616, 7.25373139, 0.00000000 };
Point ( 226 ) = { 1.28997659, 7.25410684, 0.00000000 };
Point ( 227 ) = { 1.28786595, 7.25448186, 0.00000000 };
Point ( 228 ) = { 1.28575617, 7.25485608, 0.00000000 };
Point ( 229 ) = { 1.28540232, 7.25900495, 0.00000000 };
Point ( 230 ) = { 1.28504771, 7.26315630, 0.00000000 };
Point ( 231 ) = { 1.28469316, 7.26731188, 0.00000000 };
Point ( 232 ) = { 1.28433851, 7.27147358, 0.00000000 };
Point ( 233 ) = { 1.28398294, 7.27563969, 0.00000000 };
Point ( 234 ) = { 1.28574463, 7.27943453, 0.00000000 };
Point ( 235 ) = { 1.28750772, 7.28323338, 0.00000000 };
Point ( 236 ) = { 1.28891987, 7.29122168, 0.00000000 };
Point ( 237 ) = { 1.28856596, 7.29540790, 0.00000000 };
Point ( 238 ) = { 1.28821113, 7.29959856, 0.00000000 };
Point ( 239 ) = { 1.28785620, 7.30379543, 0.00000000 };
Point ( 240 ) = { 1.28750083, 7.30799668, 0.00000000 };
Point ( 241 ) = { 1.28714471, 7.31220048, 0.00000000 };
Point ( 242 ) = { 1.28678865, 7.31640858, 0.00000000 };
Point ( 243 ) = { 1.28820600, 7.32446735, 0.00000000 };
Point ( 244 ) = { 1.28998112, 7.32831394, 0.00000000 };
Point ( 245 ) = { 1.29175863, 7.33216444, 0.00000000 };
Point ( 246 ) = { 1.29318449, 7.34025776, 0.00000000 };
Point ( 247 ) = { 1.29496698, 7.34412269, 0.00000000 };
Point ( 248 ) = { 1.29675140, 7.34799167, 0.00000000 };
Point ( 249 ) = { 1.29853742, 7.35186282, 0.00000000 };
Point ( 250 ) = { 1.30032488, 7.35573811, 0.00000000 };
Point ( 251 ) = { 1.30176413, 7.36387973, 0.00000000 };
Point ( 252 ) = { 1.30355662, 7.36776958, 0.00000000 };
Point ( 253 ) = { 1.30570022, 7.36739000, 0.00000000 };
Point ( 254 ) = { 1.30784272, 7.36700997, 0.00000000 };
Point ( 255 ) = { 1.30963991, 7.37090277, 0.00000000 };
Point ( 256 ) = { 1.31143904, 7.37479965, 0.00000000 };
Point ( 257 ) = { 1.31358370, 7.37441795, 0.00000000 };
Point ( 258 ) = { 1.31572924, 7.37403545, 0.00000000 };
Point ( 259 ) = { 1.31787368, 7.37365250, 0.00000000 };
Point ( 260 ) = { 1.31967817, 7.37755189, 0.00000000 };
Point ( 261 ) = { 1.32148429, 7.38145351, 0.00000000 };
Point ( 262 ) = { 1.32363088, 7.38106888, 0.00000000 };
Point ( 263 ) = { 1.32577835, 7.38068346, 0.00000000 };
Point ( 264 ) = { 1.32792473, 7.38029759, 0.00000000 };
Point ( 265 ) = { 1.33007197, 7.37991092, 0.00000000 };
Point ( 266 ) = { 1.33221812, 7.37952380, 0.00000000 };
Point ( 267 ) = { 1.33403188, 7.38342687, 0.00000000 };
Point ( 268 ) = { 1.33584795, 7.38733593, 0.00000000 };
Point ( 269 ) = { 1.33799724, 7.38694695, 0.00000000 };
Point ( 270 ) = { 1.34014543, 7.38655753, 0.00000000 };
Point ( 271 ) = { 1.34229450, 7.38616730, 0.00000000 };
Point ( 272 ) = { 1.34444247, 7.38577662, 0.00000000 };
Point ( 273 ) = { 1.34626507, 7.38968767, 0.00000000 };
Point ( 274 ) = { 1.34808931, 7.39360096, 0.00000000 };
Point ( 275 ) = { 1.35023944, 7.39320860, 0.00000000 };
Point ( 276 ) = { 1.35239044, 7.39281543, 0.00000000 };
Point ( 277 ) = { 1.35454034, 7.39242182, 0.00000000 };
Point ( 278 ) = { 1.35669111, 7.39202740, 0.00000000 };
Point ( 279 ) = { 1.35852140, 7.39594277, 0.00000000 };
Point ( 280 ) = { 1.36035404, 7.39986414, 0.00000000 };
Point ( 281 ) = { 1.36250697, 7.39946803, 0.00000000 };
Point ( 282 ) = { 1.36434275, 7.40339300, 0.00000000 };
Point ( 283 ) = { 1.36586423, 7.41164913, 0.00000000 };
Point ( 284 ) = { 1.36554825, 7.41598451, 0.00000000 };
Point ( 285 ) = { 1.36339050, 7.41638150, 0.00000000 };
Point ( 286 ) = { 1.36307286, 7.42072140, 0.00000000 };
Point ( 287 ) = { 1.36275446, 7.42506401, 0.00000000 };
Point ( 288 ) = { 1.36059408, 7.42546019, 0.00000000 };
Point ( 289 ) = { 1.35843457, 7.42585556, 0.00000000 };
Point ( 290 ) = { 1.35627396, 7.42625049, 0.00000000 };
Point ( 291 ) = { 1.35595137, 7.43059743, 0.00000000 };
Point ( 292 ) = { 1.35562872, 7.43495091, 0.00000000 };
Point ( 293 ) = { 1.35346547, 7.43534502, 0.00000000 };
Point ( 294 ) = { 1.35130308, 7.43573831, 0.00000000 };
Point ( 295 ) = { 1.34913959, 7.43613116, 0.00000000 };
Point ( 296 ) = { 1.34697698, 7.43652320, 0.00000000 };
Point ( 297 ) = { 1.34481327, 7.43691479, 0.00000000 };
Point ( 298 ) = { 1.34264944, 7.43730575, 0.00000000 };
Point ( 299 ) = { 1.34048648, 7.43769590, 0.00000000 };
Point ( 300 ) = { 1.34015406, 7.44205343, 0.00000000 };
Point ( 301 ) = { 1.33982089, 7.44641370, 0.00000000 };
Point ( 302 ) = { 1.33765529, 7.44680303, 0.00000000 };
Point ( 303 ) = { 1.33548858, 7.44719190, 0.00000000 };
Point ( 304 ) = { 1.33332275, 7.44757997, 0.00000000 };
Point ( 305 ) = { 1.33115582, 7.44796759, 0.00000000 };
Point ( 306 ) = { 1.32898977, 7.44835439, 0.00000000 };
Point ( 307 ) = { 1.32682261, 7.44874075, 0.00000000 };
Point ( 308 ) = { 1.32465633, 7.44912630, 0.00000000 };
Point ( 309 ) = { 1.32248895, 7.44951139, 0.00000000 };
Point ( 310 ) = { 1.32032245, 7.44989568, 0.00000000 };
Point ( 311 ) = { 1.31815484, 7.45027951, 0.00000000 };
Point ( 312 ) = { 1.31598812, 7.45066254, 0.00000000 };
Point ( 313 ) = { 1.31382029, 7.45104511, 0.00000000 };
Point ( 314 ) = { 1.31165235, 7.45142705, 0.00000000 };
Point ( 315 ) = { 1.30948529, 7.45180819, 0.00000000 };
Point ( 316 ) = { 1.30731713, 7.45218887, 0.00000000 };
Point ( 317 ) = { 1.30514985, 7.45256874, 0.00000000 };
Point ( 318 ) = { 1.30298146, 7.45294816, 0.00000000 };
Point ( 319 ) = { 1.30081396, 7.45332677, 0.00000000 };
Point ( 320 ) = { 1.30045752, 7.45768988, 0.00000000 };
Point ( 321 ) = { 1.30010097, 7.46205955, 0.00000000 };
Point ( 322 ) = { 1.29793082, 7.46243733, 0.00000000 };
Point ( 323 ) = { 1.29575957, 7.46281465, 0.00000000 };
Point ( 324 ) = { 1.29358920, 7.46319116, 0.00000000 };
Point ( 325 ) = { 1.29141773, 7.46356721, 0.00000000 };
Point ( 326 ) = { 1.28924714, 7.46394246, 0.00000000 };
Point ( 327 ) = { 1.28707545, 7.46431726, 0.00000000 };
Point ( 328 ) = { 1.28490464, 7.46469124, 0.00000000 };
Point ( 329 ) = { 1.28273273, 7.46506477, 0.00000000 };
Point ( 330 ) = { 1.28236556, 7.46943826, 0.00000000 };
Point ( 331 ) = { 1.28199794, 7.47381643, 0.00000000 };
Point ( 332 ) = { 1.27982437, 7.47418894, 0.00000000 };
Point ( 333 ) = { 1.27764970, 7.47456099, 0.00000000 };
Point ( 334 ) = { 1.27547591, 7.47493223, 0.00000000 };
Point ( 335 ) = { 1.27510401, 7.47931475, 0.00000000 };
Point ( 336 ) = { 1.27473132, 7.48370003, 0.00000000 };
Point ( 337 ) = { 1.27255488, 7.48407043, 0.00000000 };
Point ( 338 ) = { 1.27037734, 7.48444036, 0.00000000 };
Point ( 339 ) = { 1.26820068, 7.48480949, 0.00000000 };
Point ( 340 ) = { 1.26782370, 7.48919913, 0.00000000 };
Point ( 341 ) = { 1.26744626, 7.49359347, 0.00000000 };
Point ( 342 ) = { 1.26526694, 7.49396174, 0.00000000 };
Point ( 343 ) = { 1.26308651, 7.49432956, 0.00000000 };
Point ( 344 ) = { 1.26270655, 7.49872829, 0.00000000 };
Point ( 345 ) = { 1.26232644, 7.50313367, 0.00000000 };
Point ( 346 ) = { 1.26014335, 7.50350063, 0.00000000 };
Point ( 347 ) = { 1.25796115, 7.50386678, 0.00000000 };
Point ( 348 ) = { 1.25757750, 7.50827675, 0.00000000 };
Point ( 349 ) = { 1.25719339, 7.51269144, 0.00000000 };
Point ( 350 ) = { 1.25500751, 7.51305690, 0.00000000 };
Point ( 351 ) = { 1.25282253, 7.51342156, 0.00000000 };
Point ( 352 ) = { 1.25243537, 7.51784077, 0.00000000 };
Point ( 353 ) = { 1.25204741, 7.52226279, 0.00000000 };
Point ( 354 ) = { 1.24985976, 7.52262659, 0.00000000 };
Point ( 355 ) = { 1.24947003, 7.52705324, 0.00000000 };
Point ( 356 ) = { 1.24908015, 7.53148660, 0.00000000 };
Point ( 357 ) = { 1.24869029, 7.53592464, 0.00000000 };
Point ( 358 ) = { 1.24829962, 7.54036551, 0.00000000 };
Point ( 359 ) = { 1.24790797, 7.54481125, 0.00000000 };
Point ( 360 ) = { 1.24751616, 7.54926373, 0.00000000 };
Point ( 361 ) = { 1.24712437, 7.55372093, 0.00000000 };
Point ( 362 ) = { 1.24892977, 7.55781809, 0.00000000 };
Point ( 363 ) = { 1.25112867, 7.55745440, 0.00000000 };
Point ( 364 ) = { 1.25293727, 7.56155543, 0.00000000 };
Point ( 365 ) = { 1.25474820, 7.56566285, 0.00000000 };
Point ( 366 ) = { 1.25694938, 7.56529746, 0.00000000 };
Point ( 367 ) = { 1.25914945, 7.56493160, 0.00000000 };
Point ( 368 ) = { 1.26135041, 7.56456492, 0.00000000 };
Point ( 369 ) = { 1.26355027, 7.56419778, 0.00000000 };
Point ( 370 ) = { 1.26536850, 7.56830742, 0.00000000 };
Point ( 371 ) = { 1.26718844, 7.57241952, 0.00000000 };
Point ( 372 ) = { 1.26939158, 7.57205051, 0.00000000 };
Point ( 373 ) = { 1.27159361, 7.57168102, 0.00000000 };
Point ( 374 ) = { 1.27379654, 7.57131073, 0.00000000 };
Point ( 375 ) = { 1.27562159, 7.57542575, 0.00000000 };
Point ( 376 ) = { 1.27744900, 7.57954718, 0.00000000 };
Point ( 377 ) = { 1.27965422, 7.57917518, 0.00000000 };
Point ( 378 ) = { 1.28185832, 7.57880272, 0.00000000 };
Point ( 379 ) = { 1.28369068, 7.58292744, 0.00000000 };
Point ( 380 ) = { 1.28331724, 7.58742834, 0.00000000 };
Point ( 381 ) = { 1.28294383, 7.59193404, 0.00000000 };
Point ( 382 ) = { 1.28257030, 7.59644661, 0.00000000 };
Point ( 383 ) = { 1.28219579, 7.60096417, 0.00000000 };
Point ( 384 ) = { 1.28182081, 7.60548664, 0.00000000 };
Point ( 385 ) = { 1.28144588, 7.61001394, 0.00000000 };
Point ( 386 ) = { 1.28107013, 7.61454419, 0.00000000 };
Point ( 387 ) = { 1.28069341, 7.61907944, 0.00000000 };
Point ( 388 ) = { 1.28031622, 7.62361964, 0.00000000 };
Point ( 389 ) = { 1.27809909, 7.62399166, 0.00000000 };
Point ( 390 ) = { 1.27772010, 7.62853670, 0.00000000 };
Point ( 391 ) = { 1.27918350, 7.63727380, 0.00000000 };
Point ( 392 ) = { 1.28065019, 7.64603061, 0.00000000 };
Point ( 393 ) = { 1.28249738, 7.65022792, 0.00000000 };
Point ( 394 ) = { 1.28472214, 7.64985463, 0.00000000 };
Point ( 395 ) = { 1.28694782, 7.64948051, 0.00000000 };
Point ( 396 ) = { 1.28879902, 7.65368141, 0.00000000 };
Point ( 397 ) = { 1.29065264, 7.65788890, 0.00000000 };
Point ( 398 ) = { 1.29288065, 7.65751306, 0.00000000 };
Point ( 399 ) = { 1.29510753, 7.65713674, 0.00000000 };
Point ( 400 ) = { 1.29733532, 7.65675961, 0.00000000 };
Point ( 401 ) = { 1.29956198, 7.65638199, 0.00000000 };
Point ( 402 ) = { 1.30178956, 7.65600356, 0.00000000 };
Point ( 403 ) = { 1.30401600, 7.65562466, 0.00000000 };
Point ( 404 ) = { 1.30624335, 7.65524493, 0.00000000 };
Point ( 405 ) = { 1.30846957, 7.65486473, 0.00000000 };
Point ( 406 ) = { 1.31069670, 7.65448370, 0.00000000 };
Point ( 407 ) = { 1.31292270, 7.65410221, 0.00000000 };
Point ( 408 ) = { 1.31514961, 7.65371989, 0.00000000 };
Point ( 409 ) = { 1.31737641, 7.65333692, 0.00000000 };
Point ( 410 ) = { 1.31960207, 7.65295348, 0.00000000 };
Point ( 411 ) = { 1.32182865, 7.65256922, 0.00000000 };
Point ( 412 ) = { 1.32405409, 7.65218448, 0.00000000 };
Point ( 413 ) = { 1.32628044, 7.65179893, 0.00000000 };
Point ( 414 ) = { 1.32850566, 7.65141290, 0.00000000 };
Point ( 415 ) = { 1.33073178, 7.65102604, 0.00000000 };
Point ( 416 ) = { 1.33295677, 7.65063872, 0.00000000 };
Point ( 417 ) = { 1.33330410, 7.64605403, 0.00000000 };
Point ( 418 ) = { 1.33365133, 7.64147636, 0.00000000 };
Point ( 419 ) = { 1.33587354, 7.64108819, 0.00000000 };
Point ( 420 ) = { 1.33809667, 7.64069919, 0.00000000 };
Point ( 421 ) = { 1.34031866, 7.64030973, 0.00000000 };
Point ( 422 ) = { 1.34254155, 7.63991944, 0.00000000 };
Point ( 423 ) = { 1.34476331, 7.63952868, 0.00000000 };
Point ( 424 ) = { 1.34698598, 7.63913710, 0.00000000 };
Point ( 425 ) = { 1.34920853, 7.63874487, 0.00000000 };
Point ( 426 ) = { 1.35142995, 7.63835217, 0.00000000 };
Point ( 427 ) = { 1.35365228, 7.63795865, 0.00000000 };
Point ( 428 ) = { 1.35587347, 7.63756466, 0.00000000 };
Point ( 429 ) = { 1.35809556, 7.63716984, 0.00000000 };
Point ( 430 ) = { 1.36031653, 7.63677456, 0.00000000 };
Point ( 431 ) = { 1.36253839, 7.63637846, 0.00000000 };
Point ( 432 ) = { 1.36475912, 7.63598188, 0.00000000 };
Point ( 433 ) = { 1.36698076, 7.63558448, 0.00000000 };
Point ( 434 ) = { 1.36920126, 7.63518662, 0.00000000 };
Point ( 435 ) = { 1.37109807, 7.63936726, 0.00000000 };
Point ( 436 ) = { 1.37299738, 7.64355446, 0.00000000 };
Point ( 437 ) = { 1.37522020, 7.64315485, 0.00000000 };
Point ( 438 ) = { 1.37744392, 7.64275440, 0.00000000 };
Point ( 439 ) = { 1.37966650, 7.64235349, 0.00000000 };
Point ( 440 ) = { 1.38188999, 7.64195176, 0.00000000 };
Point ( 441 ) = { 1.38411336, 7.64154937, 0.00000000 };
Point ( 442 ) = { 1.38633560, 7.64114652, 0.00000000 };
Point ( 443 ) = { 1.38855873, 7.64074285, 0.00000000 };
Point ( 444 ) = { 1.39078073, 7.64033871, 0.00000000 };
Point ( 445 ) = { 1.39269193, 7.64452604, 0.00000000 };
Point ( 446 ) = { 1.39460491, 7.64871593, 0.00000000 };
Point ( 447 ) = { 1.39682923, 7.64831003, 0.00000000 };
Point ( 448 ) = { 1.39905445, 7.64790330, 0.00000000 };
Point ( 449 ) = { 1.40127853, 7.64749611, 0.00000000 };
Point ( 450 ) = { 1.40350351, 7.64708808, 0.00000000 };
Point ( 451 ) = { 1.40572736, 7.64667960, 0.00000000 };
Point ( 452 ) = { 1.40795210, 7.64627028, 0.00000000 };
Point ( 453 ) = { 1.41017571, 7.64586050, 0.00000000 };
Point ( 454 ) = { 1.41240021, 7.64544988, 0.00000000 };
Point ( 455 ) = { 1.41462358, 7.64503881, 0.00000000 };
Point ( 456 ) = { 1.41684785, 7.64462690, 0.00000000 };
Point ( 457 ) = { 1.41907200, 7.64421434, 0.00000000 };
Point ( 458 ) = { 1.42129500, 7.64380133, 0.00000000 };
Point ( 459 ) = { 1.42351891, 7.64338748, 0.00000000 };
Point ( 460 ) = { 1.42574168, 7.64297317, 0.00000000 };
Point ( 461 ) = { 1.42796534, 7.64255803, 0.00000000 };
Point ( 462 ) = { 1.43018787, 7.64214243, 0.00000000 };
Point ( 463 ) = { 1.43212251, 7.64632794, 0.00000000 };
Point ( 464 ) = { 1.43405970, 7.65052003, 0.00000000 };
Point ( 465 ) = { 1.43628454, 7.65010266, 0.00000000 };
Point ( 466 ) = { 1.43851028, 7.64968445, 0.00000000 };
Point ( 467 ) = { 1.44073488, 7.64926578, 0.00000000 };
Point ( 468 ) = { 1.44296038, 7.64884627, 0.00000000 };
Point ( 469 ) = { 1.44518473, 7.64842631, 0.00000000 };
Point ( 470 ) = { 1.44713021, 7.65262017, 0.00000000 };
Point ( 471 ) = { 1.44907751, 7.65681659, 0.00000000 };
Point ( 472 ) = { 1.45130418, 7.65639485, 0.00000000 };
Point ( 473 ) = { 1.45353175, 7.65597227, 0.00000000 };
Point ( 474 ) = { 1.45575920, 7.65554904, 0.00000000 };
Point ( 475 ) = { 1.45798550, 7.65512535, 0.00000000 };
Point ( 476 ) = { 1.45993988, 7.65932409, 0.00000000 };
Point ( 477 ) = { 1.46189685, 7.66352946, 0.00000000 };
Point ( 478 ) = { 1.46412548, 7.66310399, 0.00000000 };
Point ( 479 ) = { 1.46635500, 7.66267768, 0.00000000 };
Point ( 480 ) = { 1.46858337, 7.66225091, 0.00000000 };
Point ( 481 ) = { 1.47081265, 7.66182330, 0.00000000 };
Point ( 482 ) = { 1.47304077, 7.66139524, 0.00000000 };
Point ( 483 ) = { 1.47526980, 7.66096633, 0.00000000 };
Point ( 484 ) = { 1.47749767, 7.66053698, 0.00000000 };
Point ( 485 ) = { 1.47972645, 7.66010677, 0.00000000 };
Point ( 486 ) = { 1.48195408, 7.65967612, 0.00000000 };
Point ( 487 ) = { 1.48418260, 7.65924462, 0.00000000 };
Point ( 488 ) = { 1.48640998, 7.65881267, 0.00000000 };
Point ( 489 ) = { 1.48863825, 7.65837988, 0.00000000 };
Point ( 490 ) = { 1.49086639, 7.65794643, 0.00000000 };
Point ( 491 ) = { 1.49309339, 7.65751254, 0.00000000 };
Point ( 492 ) = { 1.49532128, 7.65707780, 0.00000000 };
Point ( 493 ) = { 1.49754803, 7.65664261, 0.00000000 };
Point ( 494 ) = { 1.49977567, 7.65620657, 0.00000000 };
Point ( 495 ) = { 1.50200216, 7.65577009, 0.00000000 };
Point ( 496 ) = { 1.50422955, 7.65533276, 0.00000000 };
Point ( 497 ) = { 1.50447489, 7.65070097, 0.00000000 };
Point ( 498 ) = { 1.50472030, 7.64607629, 0.00000000 };
Point ( 499 ) = { 1.50694487, 7.64563817, 0.00000000 };
Point ( 500 ) = { 1.50916829, 7.64519960, 0.00000000 };
Point ( 501 ) = { 1.51139260, 7.64476019, 0.00000000 };
Point ( 502 ) = { 1.51361576, 7.64432032, 0.00000000 };
Point ( 503 ) = { 1.51385597, 7.63970034, 0.00000000 };
Point ( 504 ) = { 1.51409546, 7.63508343, 0.00000000 };
Point ( 505 ) = { 1.51631581, 7.63464278, 0.00000000 };
Point ( 506 ) = { 1.51853705, 7.63420128, 0.00000000 };
Point ( 507 ) = { 1.52075816, 7.63375914, 0.00000000 };
Point ( 508 ) = { 1.52297812, 7.63331655, 0.00000000 };
Point ( 509 ) = { 1.52519897, 7.63287312, 0.00000000 };
Point ( 510 ) = { 1.52543092, 7.62826103, 0.00000000 };
Point ( 511 ) = { 1.52566296, 7.62365600, 0.00000000 };
Point ( 512 ) = { 1.52788100, 7.62321178, 0.00000000 };
Point ( 513 ) = { 1.53009790, 7.62276713, 0.00000000 };
Point ( 514 ) = { 1.53231568, 7.62232162, 0.00000000 };
Point ( 515 ) = { 1.53453232, 7.62187568, 0.00000000 };
Point ( 516 ) = { 1.53674984, 7.62142888, 0.00000000 };
Point ( 517 ) = { 1.53896622, 7.62098165, 0.00000000 };
Point ( 518 ) = { 1.54118348, 7.62053356, 0.00000000 };
Point ( 519 ) = { 1.54140583, 7.61593312, 0.00000000 };
Point ( 520 ) = { 1.54162748, 7.61133571, 0.00000000 };
Point ( 521 ) = { 1.54384193, 7.61088685, 0.00000000 };
Point ( 522 ) = { 1.54605524, 7.61043756, 0.00000000 };
Point ( 523 ) = { 1.54826944, 7.60998741, 0.00000000 };
Point ( 524 ) = { 1.55048350, 7.60953662, 0.00000000 };
Point ( 525 ) = { 1.55269642, 7.60908539, 0.00000000 };
Point ( 526 ) = { 1.55291158, 7.60449260, 0.00000000 };
Point ( 527 ) = { 1.55312686, 7.59990682, 0.00000000 };
Point ( 528 ) = { 1.55533698, 7.59945483, 0.00000000 };
Point ( 529 ) = { 1.55754798, 7.59900198, 0.00000000 };
Point ( 530 ) = { 1.55975783, 7.59854870, 0.00000000 };
Point ( 531 ) = { 1.55996882, 7.59396775, 0.00000000 };
Point ( 532 ) = { 1.56017910, 7.58938982, 0.00000000 };
Point ( 533 ) = { 1.56238616, 7.58893578, 0.00000000 };
Point ( 534 ) = { 1.56259483, 7.58436279, 0.00000000 };
Point ( 535 ) = { 1.56080720, 7.57568622, 0.00000000 };
Point ( 536 ) = { 1.55902442, 7.56703311, 0.00000000 };
Point ( 537 ) = { 1.55703432, 7.56294043, 0.00000000 };
Point ( 538 ) = { 1.55504695, 7.55885208, 0.00000000 };
Point ( 539 ) = { 1.55306139, 7.55476617, 0.00000000 };
Point ( 540 ) = { 1.55107754, 7.55068479, 0.00000000 };
Point ( 541 ) = { 1.54909590, 7.54660782, 0.00000000 };
Point ( 542 ) = { 1.54711698, 7.54253515, 0.00000000 };
Point ( 543 ) = { 1.54535760, 7.53395780, 0.00000000 };
Point ( 544 ) = { 1.54557385, 7.52944970, 0.00000000 };
Point ( 545 ) = { 1.54579030, 7.52494639, 0.00000000 };
Point ( 546 ) = { 1.54600686, 7.52044990, 0.00000000 };
Point ( 547 ) = { 1.54622263, 7.51595837, 0.00000000 };
Point ( 548 ) = { 1.54643770, 7.51146975, 0.00000000 };
Point ( 549 ) = { 1.54862310, 7.51101950, 0.00000000 };
Point ( 550 ) = { 1.55080737, 7.51056881, 0.00000000 };
Point ( 551 ) = { 1.55102004, 7.50608481, 0.00000000 };
Point ( 552 ) = { 1.55123282, 7.50160760, 0.00000000 };
Point ( 553 ) = { 1.55341435, 7.50115616, 0.00000000 };
Point ( 554 ) = { 1.55559674, 7.50070388, 0.00000000 };
Point ( 555 ) = { 1.55777801, 7.50025117, 0.00000000 };
Point ( 556 ) = { 1.55798660, 7.49577860, 0.00000000 };
Point ( 557 ) = { 1.55819450, 7.49130892, 0.00000000 };
Point ( 558 ) = { 1.56037403, 7.49085525, 0.00000000 };
Point ( 559 ) = { 1.56255243, 7.49040115, 0.00000000 };
Point ( 560 ) = { 1.56473170, 7.48994620, 0.00000000 };
Point ( 561 ) = { 1.56690984, 7.48949084, 0.00000000 };
Point ( 562 ) = { 1.56908884, 7.48903463, 0.00000000 };
Point ( 563 ) = { 1.57126672, 7.48857799, 0.00000000 };
Point ( 564 ) = { 1.57344546, 7.48812051, 0.00000000 };
Point ( 565 ) = { 1.57562306, 7.48766261, 0.00000000 };
Point ( 566 ) = { 1.57780153, 7.48720387, 0.00000000 };
Point ( 567 ) = { 1.57997888, 7.48674470, 0.00000000 };
Point ( 568 ) = { 1.58215708, 7.48628469, 0.00000000 };
Point ( 569 ) = { 1.58433415, 7.48582425, 0.00000000 };
Point ( 570 ) = { 1.58651209, 7.48536297, 0.00000000 };
Point ( 571 ) = { 1.58868889, 7.48490127, 0.00000000 };
Point ( 572 ) = { 1.59086656, 7.48443872, 0.00000000 };
Point ( 573 ) = { 1.59304409, 7.48397554, 0.00000000 };
Point ( 574 ) = { 1.59522050, 7.48351194, 0.00000000 };
Point ( 575 ) = { 1.59739776, 7.48304750, 0.00000000 };
Point ( 576 ) = { 1.59957389, 7.48258263, 0.00000000 };
Point ( 577 ) = { 1.60156899, 7.48658773, 0.00000000 };
Point ( 578 ) = { 1.60356589, 7.49059519, 0.00000000 };
Point ( 579 ) = { 1.60574421, 7.49012853, 0.00000000 };
Point ( 580 ) = { 1.60792340, 7.48966102, 0.00000000 };
Point ( 581 ) = { 1.61010146, 7.48919309, 0.00000000 };
Point ( 582 ) = { 1.61228037, 7.48872432, 0.00000000 };
Point ( 583 ) = { 1.61445815, 7.48825512, 0.00000000 };
Point ( 584 ) = { 1.61663679, 7.48778508, 0.00000000 };
Point ( 585 ) = { 1.61881430, 7.48731462, 0.00000000 };
Point ( 586 ) = { 1.62099267, 7.48684330, 0.00000000 };
Point ( 587 ) = { 1.62316990, 7.48637158, 0.00000000 };
Point ( 588 ) = { 1.62534800, 7.48589900, 0.00000000 };
Point ( 589 ) = { 1.62752595, 7.48542578, 0.00000000 };
Point ( 590 ) = { 1.62970278, 7.48495215, 0.00000000 };
Point ( 591 ) = { 1.63171588, 7.48895692, 0.00000000 };
Point ( 592 ) = { 1.63373163, 7.49296793, 0.00000000 };
Point ( 593 ) = { 1.63591065, 7.49249249, 0.00000000 };
Point ( 594 ) = { 1.63809052, 7.49201621, 0.00000000 };
Point ( 595 ) = { 1.64026926, 7.49153950, 0.00000000 };
Point ( 596 ) = { 1.64244885, 7.49106195, 0.00000000 };
Point ( 597 ) = { 1.64462731, 7.49058398, 0.00000000 };
Point ( 598 ) = { 1.64680663, 7.49010516, 0.00000000 };
Point ( 599 ) = { 1.64898481, 7.48962592, 0.00000000 };
Point ( 600 ) = { 1.65116385, 7.48914583, 0.00000000 };
Point ( 601 ) = { 1.65334176, 7.48866533, 0.00000000 };
Point ( 602 ) = { 1.65552052, 7.48818397, 0.00000000 };
Point ( 603 ) = { 1.65769814, 7.48770220, 0.00000000 };
Point ( 604 ) = { 1.65987662, 7.48721958, 0.00000000 };
Point ( 605 ) = { 1.66205496, 7.48673632, 0.00000000 };
Point ( 606 ) = { 1.66423216, 7.48625265, 0.00000000 };
Point ( 607 ) = { 1.66641022, 7.48576812, 0.00000000 };
Point ( 608 ) = { 1.66858714, 7.48528318, 0.00000000 };
Point ( 609 ) = { 1.67076491, 7.48479739, 0.00000000 };
Point ( 610 ) = { 1.67090532, 7.48031068, 0.00000000 };
Point ( 611 ) = { 1.67104594, 7.47583075, 0.00000000 };
Point ( 612 ) = { 1.67322097, 7.47534424, 0.00000000 };
Point ( 613 ) = { 1.67539486, 7.47485732, 0.00000000 };
Point ( 614 ) = { 1.67756960, 7.47436955, 0.00000000 };
Point ( 615 ) = { 1.67974320, 7.47388137, 0.00000000 };
Point ( 616 ) = { 1.68191766, 7.47339233, 0.00000000 };
Point ( 617 ) = { 1.68409098, 7.47290288, 0.00000000 };
Point ( 618 ) = { 1.68626515, 7.47241258, 0.00000000 };
Point ( 619 ) = { 1.68843819, 7.47192187, 0.00000000 };
Point ( 620 ) = { 1.69061207, 7.47143030, 0.00000000 };
Point ( 621 ) = { 1.69278582, 7.47093810, 0.00000000 };
Point ( 622 ) = { 1.69495842, 7.47044549, 0.00000000 };
Point ( 623 ) = { 1.69713188, 7.46995203, 0.00000000 };
Point ( 624 ) = { 1.69930420, 7.46945816, 0.00000000 };
Point ( 625 ) = { 1.70147737, 7.46896343, 0.00000000 };
Point ( 626 ) = { 1.70364940, 7.46846829, 0.00000000 };
Point ( 627 ) = { 1.70582228, 7.46797230, 0.00000000 };
Point ( 628 ) = { 1.70594187, 7.46349660, 0.00000000 };
Point ( 629 ) = { 1.70606082, 7.45902379, 0.00000000 };
Point ( 630 ) = { 1.70823095, 7.45852710, 0.00000000 };
Point ( 631 ) = { 1.71039995, 7.45803000, 0.00000000 };
Point ( 632 ) = { 1.71256979, 7.45753204, 0.00000000 };
Point ( 633 ) = { 1.71473850, 7.45703368, 0.00000000 };
Point ( 634 ) = { 1.71690805, 7.45653446, 0.00000000 };
Point ( 635 ) = { 1.71907647, 7.45603484, 0.00000000 };
// Keeping path 1 open to be closed by a later component
BSpline ( 0 ) = { 2 : 635 };


// == BRep component: ExtendTo64S =================================
// Extending exterior boundary developed in Amundsen_Sea_brep to meridian -105.0
// Closing path with parallels and meridians, from (-103.00000000, -75.10833359) to  (-102.84166718, -73.90000153)
// Drawing parallel to longitude index 635 at -103.00, -75.11 (to match -105.00)
Point ( 636 ) = { 1.73425547, 7.45251886, 0.00000000 };
Point ( 637 ) = { 1.74725992, 7.44948067, 0.00000000 };
Point ( 638 ) = { 1.76025905, 7.44641978, 0.00000000 };
Point ( 639 ) = { 1.77325281, 7.44333621, 0.00000000 };
Point ( 640 ) = { 1.78624118, 7.44022996, 0.00000000 };
Point ( 641 ) = { 1.79922410, 7.43710105, 0.00000000 };
Point ( 642 ) = { 1.81220154, 7.43394949, 0.00000000 };
Point ( 643 ) = { 1.82517347, 7.43077528, 0.00000000 };
Point ( 644 ) = { 1.83813983, 7.42757844, 0.00000000 };
Point ( 645 ) = { 1.85110059, 7.42435896, 0.00000000 };
Point ( 646 ) = { 1.86405572, 7.42111688, 0.00000000 };
Point ( 647 ) = { 1.87700516, 7.41785219, 0.00000000 };
Point ( 648 ) = { 1.88994889, 7.41456490, 0.00000000 };
Point ( 649 ) = { 1.90288687, 7.41125502, 0.00000000 };
Point ( 650 ) = { 1.91581904, 7.40792257, 0.00000000 };
Point ( 651 ) = { 1.92874538, 7.40456756, 0.00000000 };
Point ( 652 ) = { 1.94166584, 7.40118998, 0.00000000 };
Point ( 653 ) = { 1.95458039, 7.39778987, 0.00000000 };
Point ( 654 ) = { 1.96748899, 7.39436722, 0.00000000 };
Point ( 655 ) = { 1.98039159, 7.39092204, 0.00000000 };
// Drawing meridian index 655 at -75.11 (to match -73.90), -105.00
Point ( 656 ) = { 1.96703123, 7.34106048, 0.00000000 };
Point ( 657 ) = { 1.95384692, 7.29185596, 0.00000000 };
Point ( 658 ) = { 1.94083518, 7.24329550, 0.00000000 };
Point ( 659 ) = { 1.92799263, 7.19536646, 0.00000000 };
Point ( 660 ) = { 1.91531598, 7.14805653, 0.00000000 };
Point ( 661 ) = { 1.90280200, 7.10135373, 0.00000000 };
Point ( 662 ) = { 1.89044757, 7.05524637, 0.00000000 };
Point ( 663 ) = { 1.87824964, 7.00972308, 0.00000000 };
Point ( 664 ) = { 1.86620523, 6.96477274, 0.00000000 };
Point ( 665 ) = { 1.85431145, 6.92038455, 0.00000000 };
Point ( 666 ) = { 1.84256547, 6.87654796, 0.00000000 };
Point ( 667 ) = { 1.83000440, 6.82966942, 0.00000000 };
// Drawing parallel to end index 667 at -105.00, -73.90 (to match -102.84)
Point ( 668 ) = { 1.81808160, 6.83285297, 0.00000000 };
Point ( 669 ) = { 1.80615326, 6.83601572, 0.00000000 };
Point ( 670 ) = { 1.79421942, 6.83915763, 0.00000000 };
Point ( 671 ) = { 1.78228011, 6.84227872, 0.00000000 };
Point ( 672 ) = { 1.77033537, 6.84537896, 0.00000000 };
Point ( 673 ) = { 1.75838524, 6.84845835, 0.00000000 };
Point ( 674 ) = { 1.74642975, 6.85151688, 0.00000000 };
Point ( 675 ) = { 1.73446895, 6.85455454, 0.00000000 };
Point ( 676 ) = { 1.72250286, 6.85757132, 0.00000000 };
Point ( 677 ) = { 1.71053152, 6.86056721, 0.00000000 };
Point ( 678 ) = { 1.69855497, 6.86354220, 0.00000000 };
Point ( 679 ) = { 1.68657325, 6.86649628, 0.00000000 };
Point ( 680 ) = { 1.67458639, 6.86942944, 0.00000000 };
Point ( 681 ) = { 1.66259443, 6.87234168, 0.00000000 };
Point ( 682 ) = { 1.65059740, 6.87523299, 0.00000000 };
Point ( 683 ) = { 1.63859535, 6.87810335, 0.00000000 };
Point ( 684 ) = { 1.62658831, 6.88095276, 0.00000000 };
Point ( 685 ) = { 1.61457631, 6.88378121, 0.00000000 };
Point ( 686 ) = { 1.60255939, 6.88658870, 0.00000000 };
Point ( 687 ) = { 1.59053759, 6.88937520, 0.00000000 };
BSpline ( 1 ) = { 635 : 687, 2 };
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

Field[ 2 ] = Attractor;
Field[ 2 ].EdgesList = { 0 };
Field[ 2 ].NNodesByEdge = 20000;

Field[ 3 ] = Threshold;
Field[ 3 ].IField = 2;
Field[ 3 ].LcMin = 2.000000e+03;
Field[ 3 ].LcMax = 5.000000e+04;
Field[ 3 ].DistMin = 3.000000e+03;
Field[ 3 ].DistMax = 4.000000e+05;

Background Field = 3;


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


// Surface Geoid Boundary Representation, for project: Earth_Global_filtered_200km_30min_metric
// 
// Created by:  Shingle 
// 
//    Shingle:  An approach and software library for the generation of
//              boundary representation from arbitrary geophysical fields
//              and initialisation for anisotropic, unstructured meshing.
// 
//              Web: https://www.shingleproject.org
// 
//              Contact: Dr Adam S. Candy, contact@shingleproject.org
//     
// Version: [Not available]
// Mesh tool version: 2.11.0
//                    (on the system where the boundry representation has been created)
// 
// Project name: Earth_Global_filtered_200km_30min_metric
// Boundary Specification authors: Adam S. Candy (A.S.Candy@tudelft.nl, Technische Universiteit Delft)
// Created at: 2017/04/11 14:02:50 
// Project description:
//   -n noshelf.nc -t noshelf -no -a 5000 -el 1.0E5 -mesh

// == Source Shingle surface geoid boundnary representation =======
// <?xml version='1.0' encoding='utf-8'?>
// <boundary_representation>
//   <model_name>
//     <string_value lines="1">Earth_Global_filtered_200km_30min_metric</string_value>
//     <comment>-n noshelf.nc -t noshelf -no -a 5000 -el 1.0E5 -mesh</comment>
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
//     <string_value lines="1">oceans</string_value>
//   </domain_type>
//   <global_parameters/>
//   <dataset name="RTopo105b_data_filtered_200km_30min">
//     <form name="Raster">
//       <source url="https://zenodo.org/record/399213/files/SouthernOcean_noshelf_30m_fg.nc" name="HTTP">
//         <comment>SouthernOcean_noshelf_30m_fg.nc
// Prepared from The GEBCO_2014 Grid, version 20150318, www.gebco.net.</comment>
//       </source>
//     </form>
//     <projection name="Automatic"/>
//   </dataset>
//   <geoid_surface_representation name="GlobalCoastlines">
//     <id>
//       <integer_value rank="0">9</integer_value>
//     </id>
//     <brep_component name="GlobalCoastlines">
//       <form name="Raster">
//         <comment>Boundaries to exclude in previous iteration:
// 77 71 69 57 1 2
// 2 3 12 17 74 76 80
// 2 3 12 17 74 76 80 8 13 22 30 34 36 37 40 42 46 47 50 60 61 72 81 84 90 91 94 99 101</comment>
//         <source name="RTopo105b_data_filtered_200km_30min"/>
//         <minimum_area>
//           <real_value rank="0">5000.0</real_value>
//         </minimum_area>
//         <contourtype field_name="Automatic" name="zmask"/>
//       </form>
//       <identification name="Coastline"/>
//       <representation_type name="BSplines"/>
//       <spacing>
//         <real_value rank="0">10.0</real_value>
//       </spacing>
//     </brep_component>
//     <boundary name="Coastline">
//       <identification_number>
//         <integer_value rank="0">3</integer_value>
//       </identification_number>
//     </boundary>
//   </geoid_surface_representation>
//   <geoid_metric>
//     <form name="Proximity">
//       <boundary name="Coastline"/>
//       <edge_length_minimum>
//         <real_value rank="0">1.0E4</real_value>
//       </edge_length_minimum>
//       <edge_length_maximum>
//         <real_value rank="0">1.0E6</real_value>
//       </edge_length_maximum>
//       <proximity_minimum>
//         <real_value rank="0">4.0E4</real_value>
//       </proximity_minimum>
//       <proximity_maximum>
//         <real_value rank="0">2.0E6</real_value>
//       </proximity_maximum>
//     </form>
//   </geoid_metric>
//   <geoid_mesh>
//     <library name="Gmsh"/>
//   </geoid_mesh>
//   <validation>
//     <test file_name="data/Earth_Global_filtered_200km_30min_metric.geo" name="BrepDescription"/>
//   </validation>
// </boundary_representation>

// == Boundary Representation Specification Parameters ============
// Output to Earth_Global_filtered_200km_30min_metric.geo
// Projection type cartesian
//   1. GlobalCoastlines
//       Path:           /geoid_surface_representation::GlobalCoastlines/brep_component::GlobalCoastlines
//       Form:           Raster
//       Identification: Coastline

// == BRep component: GlobalCoastlines ============================
// Reading boundary representation GlobalCoastlines
// Region of interest: True
// Open contours closed with a line formed by points spaced 10 degrees apart
// Paths found: 329

// == Boundary Representation description =========================

// == Header ======================================================
Point ( 0 ) = { 0, 0, 0 };
Point ( 1 ) = { 0, 0, 6.37101e+06 };
PolarSphere ( 0 ) = { 0, 1 };

Delete { Point{ 0 }; }
Delete { Point{ 1 }; }

// Merged paths that cross the date line: 1 60 96

// == Ice-Land mass number 1 ======================================
// Path 1: points 2965 (of 2966) area 3.88111e+06 (required closing in 2 parts of the path)

// == Ice-Land mass number 2 ======================================
//   Skipped (area too small)

// == Ice-Land mass number 3 ======================================
//   Skipped (area too small)

// == Ice-Land mass number 4 ======================================
//   Skipped (area too small)

// == Ice-Land mass number 5 ======================================
//   Skipped (area too small)

// == Ice-Land mass number 6 ======================================
//   Skipped (area too small)

// == Ice-Land mass number 7 ======================================
//   Skipped (area too small)

// == Ice-Land mass number 8 ======================================
//   Skipped (area too small)

// == Ice-Land mass number 9 ======================================
//   Skipped (area too small)

// == Ice-Land mass number 10 =====================================
//   Skipped (area too small)

// == Ice-Land mass number 11 =====================================
//   Skipped (area too small)

// == Ice-Land mass number 12 =====================================
//   Skipped (area too small)

// == Ice-Land mass number 13 =====================================
//   Skipped (area too small)

// == Ice-Land mass number 14 =====================================
//   Skipped (area too small)

// == Ice-Land mass number 15 =====================================
//   Skipped (area too small)

// == Ice-Land mass number 16 =====================================
//   Skipped (area too small)

// == Ice-Land mass number 17 =====================================
//   Skipped (area too small)

// == Ice-Land mass number 18 =====================================
//   Skipped (area too small)

// == Ice-Land mass number 19 =====================================
//   Skipped (area too small)

// == Ice-Land mass number 20 =====================================
//   Skipped (area too small)

// == Ice-Land mass number 21 =====================================
//   Skipped (area too small)

// == Ice-Land mass number 22 =====================================
//   Skipped (area too small)

// == Ice-Land mass number 23 =====================================
//   Skipped (area too small)

// == Ice-Land mass number 24 =====================================
//   Skipped (area too small)

// == Ice-Land mass number 25 =====================================
//   Skipped (area too small)

// == Ice-Land mass number 26 =====================================
//   Skipped (area too small)

// == Ice-Land mass number 27 =====================================
//   Skipped (area too small)

// == Ice-Land mass number 28 =====================================
//   Skipped (area too small)

// == Ice-Land mass number 29 =====================================
//   Skipped (area too small)

// == Ice-Land mass number 30 =====================================
//   Skipped (area too small)

// == Ice-Land mass number 31 =====================================
//   Skipped (area too small)

// == Ice-Land mass number 32 =====================================
//   Skipped (area too small)

// == Ice-Land mass number 33 =====================================
//   Skipped (area too small)

// == Ice-Land mass number 34 =====================================
//   Skipped (area too small)

// == Ice-Land mass number 35 =====================================
//   Skipped (area too small)

// == Ice-Land mass number 36 =====================================
//   Skipped (area too small)

// == Ice-Land mass number 37 =====================================
//   Skipped (area too small)

// == Ice-Land mass number 38 =====================================
//   Skipped (area too small)

// == Ice-Land mass number 39 =====================================
//   Skipped (area too small)

// == Ice-Land mass number 40 =====================================
//   Skipped (area too small)

// == Ice-Land mass number 41 =====================================
//   Skipped (area too small)

// == Ice-Land mass number 42 =====================================
//   Skipped (area too small)

// == Ice-Land mass number 43 =====================================
//   Skipped (area too small)

// == Ice-Land mass number 44 =====================================
//   Skipped (area too small)

// == Ice-Land mass number 45 =====================================
//   Skipped (area too small)

// == Ice-Land mass number 46 =====================================
//   Skipped (area too small)

// == Ice-Land mass number 47 =====================================
//   Skipped (area too small)

// == Ice-Land mass number 48 =====================================
//   Skipped (area too small)

// == Ice-Land mass number 49 =====================================
//   Skipped (area too small)

// == Ice-Land mass number 50 =====================================
//   Skipped (area too small)

// == Ice-Land mass number 51 =====================================
//   Skipped (area too small)

// == Ice-Land mass number 52 =====================================
//   Skipped (area too small)

// == Ice-Land mass number 53 =====================================
//   Skipped (area too small)

// == Ice-Land mass number 54 =====================================
//   Skipped (area too small)

// == Ice-Land mass number 55 =====================================
//   Skipped (area too small)

// == Ice-Land mass number 56 =====================================
//   Skipped (area too small)

// == Ice-Land mass number 57 =====================================
//   Skipped (area too small)

// == Ice-Land mass number 58 =====================================
//   Skipped (area too small)

// == Ice-Land mass number 59 =====================================
//   Skipped (area too small)

// == Ice-Land mass number 60 =====================================
//   Skipped (area too small)

// == Ice-Land mass number 61 =====================================
//   Skipped (area too small)

// == Ice-Land mass number 62 =====================================
//   Skipped (area too small)

// == Ice-Land mass number 63 =====================================
//   Skipped (area too small)

// == Ice-Land mass number 64 =====================================
//   Skipped (area too small)

// == Ice-Land mass number 65 =====================================
//   Skipped (area too small)

// == Ice-Land mass number 66 =====================================
//   Skipped (area too small)

// == Ice-Land mass number 67 =====================================
//   Skipped (area too small)

// == Ice-Land mass number 68 =====================================
//   Skipped (area too small)

// == Ice-Land mass number 69 =====================================
//   Skipped (area too small)

// == Ice-Land mass number 70 =====================================
//   Skipped (area too small)

// == Ice-Land mass number 71 =====================================
//   Skipped (area too small)

// == Ice-Land mass number 72 =====================================
//   Skipped (area too small)

// == Ice-Land mass number 73 =====================================
//   Skipped (area too small)

// == Ice-Land mass number 74 =====================================
//   Skipped (area too small)

// == Ice-Land mass number 75 =====================================
//   Skipped (area too small)

// == Ice-Land mass number 76 =====================================
//   Skipped (area too small)

// == Ice-Land mass number 77 =====================================
//   Skipped (area too small)

// == Ice-Land mass number 78 =====================================
//   Skipped (area too small)

// == Ice-Land mass number 79 =====================================
//   Skipped (area too small)

// == Ice-Land mass number 80 =====================================
//   Skipped (area too small)

// == Ice-Land mass number 81 =====================================
//   Skipped (area too small)

// == Ice-Land mass number 82 =====================================
//   Skipped (area too small)

// == Ice-Land mass number 83 =====================================
//   Skipped (area too small)

// == Ice-Land mass number 84 =====================================
//   Skipped (area too small)

// == Ice-Land mass number 85 =====================================
//   Skipped (area too small)

// == Ice-Land mass number 86 =====================================
//   Skipped (area too small)

// == Ice-Land mass number 87 =====================================
//   Skipped (area too small)

// == Ice-Land mass number 88 =====================================
//   Skipped (area too small)

// == Ice-Land mass number 89 =====================================
//   Skipped (area too small)

// == Ice-Land mass number 90 =====================================
//   Skipped (area too small)

// == Ice-Land mass number 91 =====================================
//   Skipped (area too small)

// == Ice-Land mass number 92 =====================================
//   Skipped (area too small)

// == Ice-Land mass number 93 =====================================
//   Skipped (area too small)

// == Ice-Land mass number 94 =====================================
//   Skipped (area too small)

// == Ice-Land mass number 95 =====================================
//   Skipped (area too small)

// == Ice-Land mass number 96 =====================================
//   Skipped (area too small)

// == Ice-Land mass number 97 =====================================
//   Skipped (area too small)

// == Ice-Land mass number 98 =====================================
//   Skipped (area too small)

// == Ice-Land mass number 99 =====================================
//   Skipped (area too small)

// == Ice-Land mass number 100 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 101 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 102 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 103 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 104 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 105 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 106 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 107 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 108 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 109 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 110 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 111 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 112 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 113 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 114 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 115 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 116 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 117 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 118 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 119 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 120 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 121 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 122 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 123 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 124 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 125 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 126 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 127 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 128 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 129 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 130 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 131 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 132 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 133 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 134 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 135 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 136 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 137 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 138 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 139 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 140 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 141 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 142 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 143 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 144 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 145 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 146 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 147 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 148 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 149 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 150 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 151 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 152 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 153 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 154 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 155 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 156 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 157 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 158 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 159 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 160 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 161 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 162 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 163 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 164 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 165 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 166 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 167 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 168 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 169 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 170 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 171 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 172 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 173 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 174 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 175 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 176 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 177 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 178 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 179 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 180 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 181 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 182 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 183 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 184 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 185 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 186 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 187 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 188 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 189 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 190 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 191 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 192 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 193 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 194 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 195 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 196 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 197 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 198 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 199 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 200 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 201 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 202 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 203 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 204 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 205 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 206 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 207 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 208 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 209 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 210 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 211 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 212 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 213 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 214 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 215 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 216 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 217 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 218 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 219 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 220 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 221 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 222 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 223 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 224 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 225 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 226 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 227 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 228 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 229 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 230 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 231 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 232 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 233 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 234 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 235 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 236 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 237 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 238 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 239 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 240 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 241 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 242 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 243 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 244 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 245 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 246 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 247 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 248 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 249 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 250 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 251 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 252 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 253 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 254 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 255 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 256 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 257 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 258 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 259 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 260 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 261 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 262 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 263 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 264 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 265 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 266 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 267 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 268 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 269 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 270 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 271 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 272 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 273 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 274 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 275 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 276 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 277 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 278 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 279 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 280 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 281 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 282 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 283 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 284 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 285 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 286 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 287 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 288 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 289 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 290 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 291 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 292 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 293 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 294 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 295 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 296 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 297 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 298 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 299 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 300 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 301 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 302 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 303 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 304 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 305 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 306 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 307 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 308 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 309 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 310 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 311 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 312 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 313 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 314 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 315 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 316 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 317 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 318 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 319 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 320 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 321 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 322 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 323 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 324 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 325 ====================================
//   Skipped (area too small)

// == Ice-Land mass number 326 ====================================
//   Skipped (area too small)
// Paths found valid (renumbered order): 1, including 1

// == Ice-Land mass number 1 ======================================
Point ( 2 ) = { 0.21940688, -0.00000000, 0.00000000 };
Point ( 3 ) = { 0.22169255, -0.00096732, 0.00000000 };
Point ( 4 ) = { 0.22397613, -0.00195461, 0.00000000 };
Point ( 5 ) = { 0.22395055, -0.00390907, 0.00000000 };
Point ( 6 ) = { 0.22390791, -0.00586323, 0.00000000 };
Point ( 7 ) = { 0.22384822, -0.00781695, 0.00000000 };
Point ( 8 ) = { 0.22377148, -0.00977007, 0.00000000 };
Point ( 9 ) = { 0.22601631, -0.01085634, 0.00000000 };
Point ( 10 ) = { 0.22835385, -0.00997014, 0.00000000 };
Point ( 11 ) = { 0.22843216, -0.00797703, 0.00000000 };
Point ( 12 ) = { 0.22849307, -0.00598330, 0.00000000 };
Point ( 13 ) = { 0.23081325, -0.00503636, 0.00000000 };
Point ( 14 ) = { 0.23541271, -0.00513672, 0.00000000 };
Point ( 15 ) = { 0.23773634, -0.00414970, 0.00000000 };
Point ( 16 ) = { 0.24005819, -0.00314253, 0.00000000 };
Point ( 17 ) = { 0.24467748, -0.00320300, 0.00000000 };
Point ( 18 ) = { 0.24697435, -0.00431095, 0.00000000 };
Point ( 19 ) = { 0.24692733, -0.00646602, 0.00000000 };
Point ( 20 ) = { 0.24458431, -0.00747273, 0.00000000 };
Point ( 21 ) = { 0.24223972, -0.00845920, 0.00000000 };
Point ( 22 ) = { 0.24215668, -0.01057279, 0.00000000 };
Point ( 23 ) = { 0.24205520, -0.01268558, 0.00000000 };
Point ( 24 ) = { 0.24430489, -0.01387264, 0.00000000 };
Point ( 25 ) = { 0.24655125, -0.01507972, 0.00000000 };
Point ( 26 ) = { 0.24641027, -0.01723068, 0.00000000 };
Point ( 27 ) = { 0.24625052, -0.01938034, 0.00000000 };
Point ( 28 ) = { 0.24847169, -0.02064640, 0.00000000 };
Point ( 29 ) = { 0.25068896, -0.02193244, 0.00000000 };
Point ( 30 ) = { 0.25048802, -0.02411925, 0.00000000 };
Point ( 31 ) = { 0.25026800, -0.02630423, 0.00000000 };
Point ( 32 ) = { 0.25002893, -0.02848720, 0.00000000 };
Point ( 33 ) = { 0.25220726, -0.02985070, 0.00000000 };
Point ( 34 ) = { 0.25438096, -0.03123405, 0.00000000 };
Point ( 35 ) = { 0.25409871, -0.03345273, 0.00000000 };
Point ( 36 ) = { 0.25625534, -0.03487482, 0.00000000 };
Point ( 37 ) = { 0.25840697, -0.03631673, 0.00000000 };
Point ( 38 ) = { 0.25808021, -0.03857035, 0.00000000 };
Point ( 39 ) = { 0.26021387, -0.04005075, 0.00000000 };
Point ( 40 ) = { 0.26234213, -0.04155091, 0.00000000 };
Point ( 41 ) = { 0.26196954, -0.04383867, 0.00000000 };
Point ( 42 ) = { 0.26157701, -0.04612308, 0.00000000 };
Point ( 43 ) = { 0.26116456, -0.04840399, 0.00000000 };
Point ( 44 ) = { 0.25865760, -0.04910768, 0.00000000 };
Point ( 45 ) = { 0.25615216, -0.04979094, 0.00000000 };
Point ( 46 ) = { 0.25570790, -0.05202436, 0.00000000 };
Point ( 47 ) = { 0.25524417, -0.05425382, 0.00000000 };
Point ( 48 ) = { 0.25728348, -0.05586172, 0.00000000 };
Point ( 49 ) = { 0.25931619, -0.05748901, 0.00000000 };
Point ( 50 ) = { 0.25880463, -0.05974976, 0.00000000 };
Point ( 51 ) = { 0.26081619, -0.06141406, 0.00000000 };
Point ( 52 ) = { 0.26282076, -0.06309768, 0.00000000 };
Point ( 53 ) = { 0.26027032, -0.06368774, 0.00000000 };
Point ( 54 ) = { 0.25772244, -0.06425742, 0.00000000 };
Point ( 55 ) = { 0.25715188, -0.06650400, 0.00000000 };
Point ( 56 ) = { 0.25911918, -0.06822039, 0.00000000 };
Point ( 57 ) = { 0.26107899, -0.06995591, 0.00000000 };
Point ( 58 ) = { 0.25851398, -0.07047900, 0.00000000 };
Point ( 59 ) = { 0.25595206, -0.07098179, 0.00000000 };
Point ( 60 ) = { 0.25532289, -0.07321266, 0.00000000 };
Point ( 61 ) = { 0.25724458, -0.07497996, 0.00000000 };
Point ( 62 ) = { 0.25915829, -0.07676618, 0.00000000 };
Point ( 63 ) = { 0.26106392, -0.07857132, 0.00000000 };
Point ( 64 ) = { 0.26555804, -0.07992390, 0.00000000 };
Point ( 65 ) = { 0.26815831, -0.07943211, 0.00000000 };
Point ( 66 ) = { 0.26624539, -0.07760345, 0.00000000 };
Point ( 67 ) = { 0.26432439, -0.07579380, 0.00000000 };
Point ( 68 ) = { 0.26497574, -0.07348428, 0.00000000 };
Point ( 69 ) = { 0.26755920, -0.07294501, 0.00000000 };
Point ( 70 ) = { 0.26950375, -0.07474001, 0.00000000 };
Point ( 71 ) = { 0.26884127, -0.07708899, 0.00000000 };
Point ( 72 ) = { 0.27076206, -0.07891994, 0.00000000 };
Point ( 73 ) = { 0.27267473, -0.08076993, 0.00000000 };
Point ( 74 ) = { 0.27006305, -0.08127975, 0.00000000 };
Point ( 75 ) = { 0.26745494, -0.08176918, 0.00000000 };
Point ( 76 ) = { 0.26673119, -0.08410002, 0.00000000 };
Point ( 77 ) = { 0.26860340, -0.08598062, 0.00000000 };
Point ( 78 ) = { 0.27046698, -0.08788005, 0.00000000 };
Point ( 79 ) = { 0.27232184, -0.08979828, 0.00000000 };
Point ( 80 ) = { 0.27495796, -0.08933926, 0.00000000 };
Point ( 81 ) = { 0.27572712, -0.08693643, 0.00000000 };
Point ( 82 ) = { 0.27647527, -0.08452697, 0.00000000 };
Point ( 83 ) = { 0.27910660, -0.08400155, 0.00000000 };
Point ( 84 ) = { 0.28100244, -0.08591107, 0.00000000 };
Point ( 85 ) = { 0.28288980, -0.08783962, 0.00000000 };
Point ( 86 ) = { 0.28554124, -0.08729872, 0.00000000 };
Point ( 87 ) = { 0.28819627, -0.08673723, 0.00000000 };
Point ( 88 ) = { 0.29009188, -0.08868999, 0.00000000 };
Point ( 89 ) = { 0.28930687, -0.09121811, 0.00000000 };
Point ( 90 ) = { 0.29117662, -0.09320637, 0.00000000 };
Point ( 91 ) = { 0.29303750, -0.09521366, 0.00000000 };
Point ( 92 ) = { 0.29488942, -0.09723995, 0.00000000 };
Point ( 93 ) = { 0.29943898, -0.09874017, 0.00000000 };
Point ( 94 ) = { 0.30128147, -0.10080737, 0.00000000 };
Point ( 95 ) = { 0.30039030, -0.10343267, 0.00000000 };
Point ( 96 ) = { 0.30220528, -0.10553481, 0.00000000 };
Point ( 97 ) = { 0.30401076, -0.10765585, 0.00000000 };
Point ( 98 ) = { 0.30305972, -0.11030472, 0.00000000 };
Point ( 99 ) = { 0.30483684, -0.11246025, 0.00000000 };
Point ( 100 ) = { 0.30936911, -0.11413229, 0.00000000 };
Point ( 101 ) = { 0.31113550, -0.11632880, 0.00000000 };
Point ( 102 ) = { 0.31010851, -0.11903950, 0.00000000 };
Point ( 103 ) = { 0.30905790, -0.12174114, 0.00000000 };
Point ( 104 ) = { 0.31077533, -0.12398678, 0.00000000 };
Point ( 105 ) = { 0.31528836, -0.12578730, 0.00000000 };
Point ( 106 ) = { 0.31981478, -0.12759316, 0.00000000 };
Point ( 107 ) = { 0.32151934, -0.12990224, 0.00000000 };
Point ( 108 ) = { 0.32321321, -0.13223002, 0.00000000 };
Point ( 109 ) = { 0.32489630, -0.13457645, 0.00000000 };
Point ( 110 ) = { 0.32370954, -0.13740655, 0.00000000 };
Point ( 111 ) = { 0.32249813, -0.14022618, 0.00000000 };
Point ( 112 ) = { 0.31964108, -0.14064544, 0.00000000 };
Point ( 113 ) = { 0.31516702, -0.13867681, 0.00000000 };
Point ( 114 ) = { 0.31070638, -0.13671408, 0.00000000 };
Point ( 115 ) = { 0.30625894, -0.13475716, 0.00000000 };
Point ( 116 ) = { 0.30345347, -0.13510619, 0.00000000 };
Point ( 117 ) = { 0.30065403, -0.13543477, 0.00000000 };
Point ( 118 ) = { 0.29624945, -0.13345064, 0.00000000 };
Point ( 119 ) = { 0.29185733, -0.13147214, 0.00000000 };
Point ( 120 ) = { 0.28747747, -0.12949916, 0.00000000 };
Point ( 121 ) = { 0.28310964, -0.12753159, 0.00000000 };
Point ( 122 ) = { 0.27875363, -0.12556935, 0.00000000 };
Point ( 123 ) = { 0.27440923, -0.12361234, 0.00000000 };
Point ( 124 ) = { 0.27277382, -0.12144673, 0.00000000 };
Point ( 125 ) = { 0.27382324, -0.11906173, 0.00000000 };
Point ( 126 ) = { 0.27215836, -0.11692846, 0.00000000 };
Point ( 127 ) = { 0.26780322, -0.11505734, 0.00000000 };
Point ( 128 ) = { 0.26612524, -0.11296346, 0.00000000 };
Point ( 129 ) = { 0.26710088, -0.11063681, 0.00000000 };
Point ( 130 ) = { 0.26805619, -0.10830173, 0.00000000 };
Point ( 131 ) = { 0.26633185, -0.10625564, 0.00000000 };
Point ( 132 ) = { 0.26459756, -0.10422775, 0.00000000 };
Point ( 133 ) = { 0.26549703, -0.10191476, 0.00000000 };
Point ( 134 ) = { 0.26373541, -0.09992041, 0.00000000 };
Point ( 135 ) = { 0.26196419, -0.09794440, 0.00000000 };
Point ( 136 ) = { 0.26018348, -0.09598676, 0.00000000 };
Point ( 137 ) = { 0.25839340, -0.09404751, 0.00000000 };
Point ( 138 ) = { 0.25659403, -0.09212667, 0.00000000 };
Point ( 139 ) = { 0.25478550, -0.09022428, 0.00000000 };
Point ( 140 ) = { 0.25556314, -0.08799745, 0.00000000 };
Point ( 141 ) = { 0.25372916, -0.08612945, 0.00000000 };
Point ( 142 ) = { 0.25188639, -0.08428001, 0.00000000 };
Point ( 143 ) = { 0.25261227, -0.08207870, 0.00000000 };
Point ( 144 ) = { 0.25074489, -0.08026407, 0.00000000 };
Point ( 145 ) = { 0.24886908, -0.07846812, 0.00000000 };
Point ( 146 ) = { 0.24954436, -0.07629337, 0.00000000 };
Point ( 147 ) = { 0.24764479, -0.07453262, 0.00000000 };
Point ( 148 ) = { 0.24573717, -0.07279067, 0.00000000 };
Point ( 149 ) = { 0.24382160, -0.07106752, 0.00000000 };
Point ( 150 ) = { 0.24189819, -0.06936319, 0.00000000 };
Point ( 151 ) = { 0.23996704, -0.06767771, 0.00000000 };
Point ( 152 ) = { 0.23802826, -0.06601108, 0.00000000 };
Point ( 153 ) = { 0.23859525, -0.06393140, 0.00000000 };
Point ( 154 ) = { 0.23663464, -0.06230070, 0.00000000 };
Point ( 155 ) = { 0.23412823, -0.06273447, 0.00000000 };
Point ( 156 ) = { 0.23357186, -0.06477521, 0.00000000 };
Point ( 157 ) = { 0.23299770, -0.06681102, 0.00000000 };
Point ( 158 ) = { 0.23240580, -0.06884174, 0.00000000 };
Point ( 159 ) = { 0.23431622, -0.07052118, 0.00000000 };
Point ( 160 ) = { 0.23874935, -0.07185540, 0.00000000 };
Point ( 161 ) = { 0.24065079, -0.07357433, 0.00000000 };
Point ( 162 ) = { 0.23999958, -0.07567158, 0.00000000 };
Point ( 163 ) = { 0.24187772, -0.07742567, 0.00000000 };
Point ( 164 ) = { 0.24374753, -0.07919837, 0.00000000 };
Point ( 165 ) = { 0.24304712, -0.08132243, 0.00000000 };
Point ( 166 ) = { 0.24489278, -0.08312990, 0.00000000 };
Point ( 167 ) = { 0.24672974, -0.08495586, 0.00000000 };
Point ( 168 ) = { 0.24597898, -0.08710572, 0.00000000 };
Point ( 169 ) = { 0.24520948, -0.08924895, 0.00000000 };
Point ( 170 ) = { 0.24263278, -0.08951196, 0.00000000 };
Point ( 171 ) = { 0.24083506, -0.08765679, 0.00000000 };
Point ( 172 ) = { 0.23902826, -0.08581991, 0.00000000 };
Point ( 173 ) = { 0.23647041, -0.08606819, 0.00000000 };
Point ( 174 ) = { 0.23571033, -0.08812848, 0.00000000 };
Point ( 175 ) = { 0.23493229, -0.09018206, 0.00000000 };
Point ( 176 ) = { 0.23413637, -0.09222877, 0.00000000 };
Point ( 177 ) = { 0.23332262, -0.09426846, 0.00000000 };
Point ( 178 ) = { 0.23249110, -0.09630097, 0.00000000 };
Point ( 179 ) = { 0.23164187, -0.09832614, 0.00000000 };
Point ( 180 ) = { 0.23334324, -0.10025217, 0.00000000 };
Point ( 181 ) = { 0.23503453, -0.10219592, 0.00000000 };
Point ( 182 ) = { 0.23671564, -0.10415738, 0.00000000 };
Point ( 183 ) = { 0.23838647, -0.10613650, 0.00000000 };
Point ( 184 ) = { 0.23745119, -0.10821274, 0.00000000 };
Point ( 185 ) = { 0.23909414, -0.11022391, 0.00000000 };
Point ( 186 ) = { 0.24072646, -0.11225259, 0.00000000 };
Point ( 187 ) = { 0.23973771, -0.11434902, 0.00000000 };
Point ( 188 ) = { 0.24134137, -0.11640926, 0.00000000 };
Point ( 189 ) = { 0.24395875, -0.11636235, 0.00000000 };
Point ( 190 ) = { 0.24658277, -0.11629599, 0.00000000 };
Point ( 191 ) = { 0.24818975, -0.11838044, 0.00000000 };
Point ( 192 ) = { 0.24714725, -0.12054177, 0.00000000 };
Point ( 193 ) = { 0.24608593, -0.12269392, 0.00000000 };
Point ( 194 ) = { 0.24500586, -0.12483672, 0.00000000 };
Point ( 195 ) = { 0.24654627, -0.12697967, 0.00000000 };
Point ( 196 ) = { 0.24807513, -0.12913974, 0.00000000 };
Point ( 197 ) = { 0.24693874, -0.13129966, 0.00000000 };
Point ( 198 ) = { 0.24578355, -0.13344958, 0.00000000 };
Point ( 199 ) = { 0.24313785, -0.13338999, 0.00000000 };
Point ( 200 ) = { 0.24165406, -0.13120745, 0.00000000 };
Point ( 201 ) = { 0.24015838, -0.12904175, 0.00000000 };
Point ( 202 ) = { 0.23753448, -0.12897070, 0.00000000 };
Point ( 203 ) = { 0.23639997, -0.13103864, 0.00000000 };
Point ( 204 ) = { 0.23524745, -0.13309660, 0.00000000 };
Point ( 205 ) = { 0.23407702, -0.13514443, 0.00000000 };
Point ( 206 ) = { 0.23288876, -0.13718197, 0.00000000 };
Point ( 207 ) = { 0.23430108, -0.13939449, 0.00000000 };
Point ( 208 ) = { 0.23570087, -0.14162337, 0.00000000 };
Point ( 209 ) = { 0.23445602, -0.14367483, 0.00000000 };
Point ( 210 ) = { 0.23319331, -0.14571535, 0.00000000 };
Point ( 211 ) = { 0.23191284, -0.14774477, 0.00000000 };
Point ( 212 ) = { 0.23061471, -0.14976294, 0.00000000 };
Point ( 213 ) = { 0.22929901, -0.15176971, 0.00000000 };
Point ( 214 ) = { 0.22796586, -0.15376491, 0.00000000 };
Point ( 215 ) = { 0.22661534, -0.15574841, 0.00000000 };
Point ( 216 ) = { 0.22524757, -0.15772005, 0.00000000 };
Point ( 217 ) = { 0.22386264, -0.15967967, 0.00000000 };
Point ( 218 ) = { 0.22246067, -0.16162714, 0.00000000 };
Point ( 219 ) = { 0.22104175, -0.16356229, 0.00000000 };
Point ( 220 ) = { 0.21960601, -0.16548499, 0.00000000 };
Point ( 221 ) = { 0.21815353, -0.16739509, 0.00000000 };
Point ( 222 ) = { 0.21927763, -0.16978288, 0.00000000 };
Point ( 223 ) = { 0.22038724, -0.17218538, 0.00000000 };
Point ( 224 ) = { 0.21887627, -0.17410204, 0.00000000 };
Point ( 225 ) = { 0.21995017, -0.17652868, 0.00000000 };
Point ( 226 ) = { 0.22100929, -0.17896979, 0.00000000 };
Point ( 227 ) = { 0.22205352, -0.18142533, 0.00000000 };
Point ( 228 ) = { 0.22308277, -0.18389525, 0.00000000 };
Point ( 229 ) = { 0.22146951, -0.18583498, 0.00000000 };
Point ( 230 ) = { 0.22246198, -0.18832797, 0.00000000 };
Point ( 231 ) = { 0.22343916, -0.19083507, 0.00000000 };
Point ( 232 ) = { 0.22176533, -0.19277766, 0.00000000 };
Point ( 233 ) = { 0.22270510, -0.19530713, 0.00000000 };
Point ( 234 ) = { 0.22362928, -0.19785047, 0.00000000 };
Point ( 235 ) = { 0.22453778, -0.20040763, 0.00000000 };
Point ( 236 ) = { 0.22543052, -0.20297855, 0.00000000 };
Point ( 237 ) = { 0.22365064, -0.20493805, 0.00000000 };
Point ( 238 ) = { 0.22450492, -0.20753021, 0.00000000 };
Point ( 239 ) = { 0.22534314, -0.21013588, 0.00000000 };
Point ( 240 ) = { 0.22350080, -0.21209434, 0.00000000 };
Point ( 241 ) = { 0.22429997, -0.21472051, 0.00000000 };
Point ( 242 ) = { 0.22508278, -0.21735991, 0.00000000 };
Point ( 243 ) = { 0.22317741, -0.21931583, 0.00000000 };
Point ( 244 ) = { 0.22392059, -0.22197499, 0.00000000 };
Point ( 245 ) = { 0.22659895, -0.22267817, 0.00000000 };
Point ( 246 ) = { 0.22853353, -0.22069226, 0.00000000 };
Point ( 247 ) = { 0.23045071, -0.21868955, 0.00000000 };
Point ( 248 ) = { 0.22965448, -0.21603737, 0.00000000 };
Point ( 249 ) = { 0.22884195, -0.21339857, 0.00000000 };
Point ( 250 ) = { 0.23069547, -0.21139345, 0.00000000 };
Point ( 251 ) = { 0.23253142, -0.20937223, 0.00000000 };
Point ( 252 ) = { 0.23523099, -0.20995168, 0.00000000 };
Point ( 253 ) = { 0.23609636, -0.21258212, 0.00000000 };
Point ( 254 ) = { 0.23423227, -0.21463433, 0.00000000 };
Point ( 255 ) = { 0.23235033, -0.21667019, 0.00000000 };
Point ( 256 ) = { 0.23315339, -0.21932880, 0.00000000 };
Point ( 257 ) = { 0.23666207, -0.22262945, 0.00000000 };
Point ( 258 ) = { 0.23939649, -0.22324084, 0.00000000 };
Point ( 259 ) = { 0.24133550, -0.22114324, 0.00000000 };
Point ( 260 ) = { 0.24325612, -0.21902879, 0.00000000 };
Point ( 261 ) = { 0.24515822, -0.21689767, 0.00000000 };
Point ( 262 ) = { 0.24428756, -0.21423444, 0.00000000 };
Point ( 263 ) = { 0.24340095, -0.21158521, 0.00000000 };
Point ( 264 ) = { 0.24523808, -0.20945311, 0.00000000 };
Point ( 265 ) = { 0.24705655, -0.20730506, 0.00000000 };
Point ( 266 ) = { 0.24981185, -0.20776633, 0.00000000 };
Point ( 267 ) = { 0.25257850, -0.20820964, 0.00000000 };
Point ( 268 ) = { 0.25535640, -0.20863493, 0.00000000 };
Point ( 269 ) = { 0.25910815, -0.21170024, 0.00000000 };
Point ( 270 ) = { 0.26191607, -0.21209545, 0.00000000 };
Point ( 271 ) = { 0.26473511, -0.21247239, 0.00000000 };
Point ( 272 ) = { 0.26853576, -0.21552274, 0.00000000 };
Point ( 273 ) = { 0.26949073, -0.21822929, 0.00000000 };
Point ( 274 ) = { 0.27043002, -0.22095059, 0.00000000 };
Point ( 275 ) = { 0.27422682, -0.22405271, 0.00000000 };
Point ( 276 ) = { 0.27514259, -0.22681005, 0.00000000 };
Point ( 277 ) = { 0.27604242, -0.22958206, 0.00000000 };
Point ( 278 ) = { 0.27894346, -0.22994324, 0.00000000 };
Point ( 279 ) = { 0.28185587, -0.23028591, 0.00000000 };
Point ( 280 ) = { 0.28568853, -0.23341732, 0.00000000 };
Point ( 281 ) = { 0.28658142, -0.23623949, 0.00000000 };
Point ( 282 ) = { 0.28745818, -0.23907645, 0.00000000 };
Point ( 283 ) = { 0.29128811, -0.24226177, 0.00000000 };
Point ( 284 ) = { 0.29214100, -0.24513541, 0.00000000 };
Point ( 285 ) = { 0.29297750, -0.24802376, 0.00000000 };
Point ( 286 ) = { 0.29379750, -0.25092677, 0.00000000 };
Point ( 287 ) = { 0.29460091, -0.25384438, 0.00000000 };
Point ( 288 ) = { 0.29538764, -0.25677655, 0.00000000 };
Point ( 289 ) = { 0.29615758, -0.25972322, 0.00000000 };
Point ( 290 ) = { 0.29691063, -0.26268434, 0.00000000 };
Point ( 291 ) = { 0.29764671, -0.26565985, 0.00000000 };
Point ( 292 ) = { 0.29836571, -0.26864969, 0.00000000 };
Point ( 293 ) = { 0.29906754, -0.27165382, 0.00000000 };
Point ( 294 ) = { 0.29975209, -0.27467218, 0.00000000 };
Point ( 295 ) = { 0.30041927, -0.27770472, 0.00000000 };
Point ( 296 ) = { 0.30106898, -0.28075137, 0.00000000 };
Point ( 297 ) = { 0.30170113, -0.28381209, 0.00000000 };
Point ( 298 ) = { 0.30231562, -0.28688681, 0.00000000 };
Point ( 299 ) = { 0.30291235, -0.28997549, 0.00000000 };
Point ( 300 ) = { 0.30349122, -0.29307806, 0.00000000 };
Point ( 301 ) = { 0.30405214, -0.29619448, 0.00000000 };
Point ( 302 ) = { 0.30459500, -0.29932467, 0.00000000 };
Point ( 303 ) = { 0.30511972, -0.30246860, 0.00000000 };
Point ( 304 ) = { 0.30562619, -0.30562619, 0.00000000 };
Point ( 305 ) = { 0.30294749, -0.30828161, 0.00000000 };
Point ( 306 ) = { 0.30340793, -0.31145695, 0.00000000 };
Point ( 307 ) = { 0.30384980, -0.31464568, 0.00000000 };
Point ( 308 ) = { 0.30109247, -0.31728526, 0.00000000 };
Point ( 309 ) = { 0.29831220, -0.31990067, 0.00000000 };
Point ( 310 ) = { 0.29550922, -0.32249172, 0.00000000 };
Point ( 311 ) = { 0.29235341, -0.32185600, 0.00000000 };
Point ( 312 ) = { 0.28921210, -0.32120258, 0.00000000 };
Point ( 313 ) = { 0.28953359, -0.32439498, 0.00000000 };
Point ( 314 ) = { 0.28983595, -0.32759995, 0.00000000 };
Point ( 315 ) = { 0.28696611, -0.33011674, 0.00000000 };
Point ( 316 ) = { 0.28722117, -0.33333657, 0.00000000 };
Point ( 317 ) = { 0.28745680, -0.33656867, 0.00000000 };
Point ( 318 ) = { 0.28450878, -0.33906436, 0.00000000 };
Point ( 319 ) = { 0.28469659, -0.34231044, 0.00000000 };
Point ( 320 ) = { 0.28804627, -0.34633799, 0.00000000 };
Point ( 321 ) = { 0.29140914, -0.35038141, 0.00000000 };
Point ( 322 ) = { 0.29155513, -0.35368466, 0.00000000 };
Point ( 323 ) = { 0.29168115, -0.35699990, 0.00000000 };
Point ( 324 ) = { 0.29178711, -0.36032707, 0.00000000 };
Point ( 325 ) = { 0.28863159, -0.36285964, 0.00000000 };
Point ( 326 ) = { 0.28545409, -0.36536458, 0.00000000 };
Point ( 327 ) = { 0.28548161, -0.36870460, 0.00000000 };
Point ( 328 ) = { 0.28874041, -0.37291341, 0.00000000 };
Point ( 329 ) = { 0.29201266, -0.37713958, 0.00000000 };
Point ( 330 ) = { 0.29530592, -0.37797434, 0.00000000 };
Point ( 331 ) = { 0.29861547, -0.37879192, 0.00000000 };
Point ( 332 ) = { 0.30194127, -0.37959220, 0.00000000 };
Point ( 333 ) = { 0.30528328, -0.38037508, 0.00000000 };
Point ( 334 ) = { 0.30864145, -0.38114044, 0.00000000 };
Point ( 335 ) = { 0.31201574, -0.38188819, 0.00000000 };
Point ( 336 ) = { 0.31545524, -0.38609793, 0.00000000 };
Point ( 337 ) = { 0.31890974, -0.39032603, 0.00000000 };
Point ( 338 ) = { 0.32235200, -0.39104425, 0.00000000 };
Point ( 339 ) = { 0.32581044, -0.39174448, 0.00000000 };
Point ( 340 ) = { 0.32584797, -0.39528519, 0.00000000 };
Point ( 341 ) = { 0.32586466, -0.39883842, 0.00000000 };
Point ( 342 ) = { 0.32586041, -0.40240410, 0.00000000 };
Point ( 343 ) = { 0.32233641, -0.40523241, 0.00000000 };
Point ( 344 ) = { 0.32227991, -0.40881012, 0.00000000 };
Point ( 345 ) = { 0.32220217, -0.41239997, 0.00000000 };
Point ( 346 ) = { 0.31859108, -0.41519598, 0.00000000 };
Point ( 347 ) = { 0.31495573, -0.41796037, 0.00000000 };
Point ( 348 ) = { 0.31479380, -0.42156002, 0.00000000 };
Point ( 349 ) = { 0.31461023, -0.42517132, 0.00000000 };
Point ( 350 ) = { 0.31110306, -0.42429103, 0.00000000 };
Point ( 351 ) = { 0.30781632, -0.41980849, 0.00000000 };
Point ( 352 ) = { 0.30454448, -0.41534626, 0.00000000 };
Point ( 353 ) = { 0.30471378, -0.41179703, 0.00000000 };
Point ( 354 ) = { 0.30486161, -0.40825921, 0.00000000 };
Point ( 355 ) = { 0.30144455, -0.40737893, 0.00000000 };
Point ( 356 ) = { 0.29804460, -0.40648154, 0.00000000 };
Point ( 357 ) = { 0.29481612, -0.40207845, 0.00000000 };
Point ( 358 ) = { 0.29160165, -0.39769447, 0.00000000 };
Point ( 359 ) = { 0.28827111, -0.39677115, 0.00000000 };
Point ( 360 ) = { 0.28479770, -0.39927165, 0.00000000 };
Point ( 361 ) = { 0.28149252, -0.39830270, 0.00000000 };
Point ( 362 ) = { 0.27838179, -0.39390113, 0.00000000 };
Point ( 363 ) = { 0.27528413, -0.38951804, 0.00000000 };
Point ( 364 ) = { 0.27219934, -0.38515316, 0.00000000 };
Point ( 365 ) = { 0.26898809, -0.38415480, 0.00000000 };
Point ( 366 ) = { 0.26562550, -0.38648750, 0.00000000 };
Point ( 367 ) = { 0.26224269, -0.38879078, 0.00000000 };
Point ( 368 ) = { 0.25883991, -0.39106444, 0.00000000 };
Point ( 369 ) = { 0.25859188, -0.39441816, 0.00000000 };
Point ( 370 ) = { 0.25832246, -0.39778171, 0.00000000 };
Point ( 371 ) = { 0.25484137, -0.40002082, 0.00000000 };
Point ( 372 ) = { 0.25134087, -0.40222948, 0.00000000 };
Point ( 373 ) = { 0.25099117, -0.40559721, 0.00000000 };
Point ( 374 ) = { 0.25061974, -0.40897425, 0.00000000 };
Point ( 375 ) = { 0.24744215, -0.40777204, 0.00000000 };
Point ( 376 ) = { 0.24466935, -0.40320261, 0.00000000 };
Point ( 377 ) = { 0.24503428, -0.39985960, 0.00000000 };
Point ( 378 ) = { 0.24537758, -0.39652575, 0.00000000 };
Point ( 379 ) = { 0.24569935, -0.39320115, 0.00000000 };
Point ( 380 ) = { 0.24599966, -0.38988587, 0.00000000 };
Point ( 381 ) = { 0.24289573, -0.38871442, 0.00000000 };
Point ( 382 ) = { 0.23949435, -0.39081925, 0.00000000 };
Point ( 383 ) = { 0.23607473, -0.39289433, 0.00000000 };
Point ( 384 ) = { 0.23570934, -0.39619178, 0.00000000 };
Point ( 385 ) = { 0.23532235, -0.39949807, 0.00000000 };
Point ( 386 ) = { 0.23182715, -0.40153641, 0.00000000 };
Point ( 387 ) = { 0.23138956, -0.40484776, 0.00000000 };
Point ( 388 ) = { 0.23093011, -0.40816759, 0.00000000 };
Point ( 389 ) = { 0.23044874, -0.41149583, 0.00000000 };
Point ( 390 ) = { 0.22994535, -0.41483240, 0.00000000 };
Point ( 391 ) = { 0.22631655, -0.41682323, 0.00000000 };
Point ( 392 ) = { 0.22267051, -0.41878232, 0.00000000 };
Point ( 393 ) = { 0.22208673, -0.42211745, 0.00000000 };
Point ( 394 ) = { 0.22458578, -0.42686736, 0.00000000 };
Point ( 395 ) = { 0.22771005, -0.42826032, 0.00000000 };
Point ( 396 ) = { 0.23143861, -0.42625689, 0.00000000 };
Point ( 397 ) = { 0.23514954, -0.42422101, 0.00000000 };
Point ( 398 ) = { 0.23831650, -0.42554474, 0.00000000 };
Point ( 399 ) = { 0.23776814, -0.42894509, 0.00000000 };
Point ( 400 ) = { 0.23719741, -0.43235379, 0.00000000 };
Point ( 401 ) = { 0.24039798, -0.43368943, 0.00000000 };
Point ( 402 ) = { 0.24417343, -0.43157508, 0.00000000 };
Point ( 403 ) = { 0.24793029, -0.42942786, 0.00000000 };
Point ( 404 ) = { 0.24843383, -0.42599653, 0.00000000 };
Point ( 405 ) = { 0.24891514, -0.42257406, 0.00000000 };
Point ( 406 ) = { 0.25259327, -0.42038580, 0.00000000 };
Point ( 407 ) = { 0.25583066, -0.42159588, 0.00000000 };
Point ( 408 ) = { 0.25908644, -0.42279064, 0.00000000 };
Point ( 409 ) = { 0.25949999, -0.41934731, 0.00000000 };
Point ( 410 ) = { 0.25989154, -0.41591341, 0.00000000 };
Point ( 411 ) = { 0.26314956, -0.41706681, 0.00000000 };
Point ( 412 ) = { 0.26642569, -0.41820457, 0.00000000 };
Point ( 413 ) = { 0.26971992, -0.41932658, 0.00000000 };
Point ( 414 ) = { 0.26935290, -0.42279936, 0.00000000 };
Point ( 415 ) = { 0.26565307, -0.42513377, 0.00000000 };
Point ( 416 ) = { 0.26193301, -0.42743582, 0.00000000 };
Point ( 417 ) = { 0.25819300, -0.42970531, 0.00000000 };
Point ( 418 ) = { 0.25771293, -0.43317649, 0.00000000 };
Point ( 419 ) = { 0.25721052, -0.43665681, 0.00000000 };
Point ( 420 ) = { 0.25668566, -0.44014617, 0.00000000 };
Point ( 421 ) = { 0.25613828, -0.44364452, 0.00000000 };
Point ( 422 ) = { 0.25556829, -0.44715177, 0.00000000 };
Point ( 423 ) = { 0.25497560, -0.45066785, 0.00000000 };
Point ( 424 ) = { 0.25436012, -0.45419267, 0.00000000 };
Point ( 425 ) = { 0.25770646, -0.45549463, 0.00000000 };
Point ( 426 ) = { 0.26107213, -0.45678149, 0.00000000 };
Point ( 427 ) = { 0.26445711, -0.45805315, 0.00000000 };
Point ( 428 ) = { 0.26786138, -0.45930949, 0.00000000 };
Point ( 429 ) = { 0.27128491, -0.46055038, 0.00000000 };
Point ( 430 ) = { 0.27472769, -0.46177572, 0.00000000 };
Point ( 431 ) = { 0.27760950, -0.46661961, 0.00000000 };
Point ( 432 ) = { 0.28109947, -0.46782809, 0.00000000 };
Point ( 433 ) = { 0.28460876, -0.46902071, 0.00000000 };
Point ( 434 ) = { 0.28813732, -0.47019737, 0.00000000 };
Point ( 435 ) = { 0.29168514, -0.47135794, 0.00000000 };
Point ( 436 ) = { 0.29111765, -0.47506083, 0.00000000 };
Point ( 437 ) = { 0.29052698, -0.47877365, 0.00000000 };
Point ( 438 ) = { 0.29411252, -0.47994801, 0.00000000 };
Point ( 439 ) = { 0.29771751, -0.48110614, 0.00000000 };
Point ( 440 ) = { 0.29712213, -0.48485924, 0.00000000 };
Point ( 441 ) = { 0.29287967, -0.48743363, 0.00000000 };
Point ( 442 ) = { 0.29222807, -0.49119123, 0.00000000 };
Point ( 443 ) = { 0.29586107, -0.49239551, 0.00000000 };
Point ( 444 ) = { 0.30014671, -0.48979491, 0.00000000 };
Point ( 445 ) = { 0.30380975, -0.49095109, 0.00000000 };
Point ( 446 ) = { 0.30749245, -0.49209078, 0.00000000 };
Point ( 447 ) = { 0.31119479, -0.49321389, 0.00000000 };
Point ( 448 ) = { 0.31059106, -0.49704959, 0.00000000 };
Point ( 449 ) = { 0.30996369, -0.50089574, 0.00000000 };
Point ( 450 ) = { 0.31306439, -0.50590641, 0.00000000 };
Point ( 451 ) = { 0.31239938, -0.50978945, 0.00000000 };
Point ( 452 ) = { 0.31171042, -0.51368288, 0.00000000 };
Point ( 453 ) = { 0.31099742, -0.51758662, 0.00000000 };
Point ( 454 ) = { 0.31026026, -0.52150061, 0.00000000 };
Point ( 455 ) = { 0.30949885, -0.52542479, 0.00000000 };
Point ( 456 ) = { 0.30871309, -0.52935908, 0.00000000 };
Point ( 457 ) = { 0.30790287, -0.53330341, 0.00000000 };
Point ( 458 ) = { 0.30706809, -0.53725773, 0.00000000 };
Point ( 459 ) = { 0.31007049, -0.54251083, 0.00000000 };
Point ( 460 ) = { 0.31308930, -0.54779266, 0.00000000 };
Point ( 461 ) = { 0.31220018, -0.55181196, 0.00000000 };
Point ( 462 ) = { 0.31128606, -0.55584126, 0.00000000 };
Point ( 463 ) = { 0.31034683, -0.55988050, 0.00000000 };
Point ( 464 ) = { 0.30544919, -0.56256743, 0.00000000 };
Point ( 465 ) = { 0.30444944, -0.56660796, 0.00000000 };
Point ( 466 ) = { 0.30342428, -0.57065807, 0.00000000 };
Point ( 467 ) = { 0.30237361, -0.57471769, 0.00000000 };
Point ( 468 ) = { 0.30129731, -0.57878675, 0.00000000 };
Point ( 469 ) = { 0.29623504, -0.58139399, 0.00000000 };
Point ( 470 ) = { 0.29509747, -0.58546265, 0.00000000 };
Point ( 471 ) = { 0.29791366, -0.59104987, 0.00000000 };
Point ( 472 ) = { 0.29673383, -0.59515599, 0.00000000 };
Point ( 473 ) = { 0.29152888, -0.59772279, 0.00000000 };
Point ( 474 ) = { 0.28630173, -0.60024407, 0.00000000 };
Point ( 475 ) = { 0.28105278, -0.60271963, 0.00000000 };
Point ( 476 ) = { 0.27973949, -0.60680187, 0.00000000 };
Point ( 477 ) = { 0.27839972, -0.61089244, 0.00000000 };
Point ( 478 ) = { 0.27443356, -0.60921992, 0.00000000 };
Point ( 479 ) = { 0.27049107, -0.60753288, 0.00000000 };
Point ( 480 ) = { 0.26910673, -0.61159158, 0.00000000 };
Point ( 481 ) = { 0.26769578, -0.61565814, 0.00000000 };
Point ( 482 ) = { 0.26625809, -0.61973250, 0.00000000 };
Point ( 483 ) = { 0.26479358, -0.62381457, 0.00000000 };
Point ( 484 ) = { 0.25933975, -0.62610155, 0.00000000 };
Point ( 485 ) = { 0.25386618, -0.62834085, 0.00000000 };
Point ( 486 ) = { 0.25230358, -0.63240391, 0.00000000 };
Point ( 487 ) = { 0.25071381, -0.63647408, 0.00000000 };
Point ( 488 ) = { 0.24515005, -0.63863771, 0.00000000 };
Point ( 489 ) = { 0.24349748, -0.64270062, 0.00000000 };
Point ( 490 ) = { 0.24578044, -0.64872638, 0.00000000 };
Point ( 491 ) = { 0.24807726, -0.65478872, 0.00000000 };
Point ( 492 ) = { 0.25038815, -0.66088823, 0.00000000 };
Point ( 493 ) = { 0.25271334, -0.66702546, 0.00000000 };
Point ( 494 ) = { 0.25095506, -0.67120980, 0.00000000 };
Point ( 495 ) = { 0.24916863, -0.67540112, 0.00000000 };
Point ( 496 ) = { 0.24735393, -0.67959934, 0.00000000 };
Point ( 497 ) = { 0.24141397, -0.68173201, 0.00000000 };
Point ( 498 ) = { 0.23545562, -0.68381276, 0.00000000 };
Point ( 499 ) = { 0.23140330, -0.68169215, 0.00000000 };
Point ( 500 ) = { 0.22928054, -0.67543870, 0.00000000 };
Point ( 501 ) = { 0.22717095, -0.66922405, 0.00000000 };
Point ( 502 ) = { 0.22902542, -0.66513812, 0.00000000 };
Point ( 503 ) = { 0.23482105, -0.66311419, 0.00000000 };
Point ( 504 ) = { 0.24059880, -0.66103977, 0.00000000 };
Point ( 505 ) = { 0.24235377, -0.65692865, 0.00000000 };
Point ( 506 ) = { 0.23837476, -0.65492928, 0.00000000 };
Point ( 507 ) = { 0.23442117, -0.65291703, 0.00000000 };
Point ( 508 ) = { 0.23224373, -0.64685235, 0.00000000 };
Point ( 509 ) = { 0.22834845, -0.64483614, 0.00000000 };
Point ( 510 ) = { 0.22447837, -0.64280733, 0.00000000 };
Point ( 511 ) = { 0.22063345, -0.64076606, 0.00000000 };
Point ( 512 ) = { 0.21503338, -0.64266702, 0.00000000 };
Point ( 513 ) = { 0.21322565, -0.64662712, 0.00000000 };
Point ( 514 ) = { 0.21139036, -0.65059264, 0.00000000 };
Point ( 515 ) = { 0.20952743, -0.65456350, 0.00000000 };
Point ( 516 ) = { 0.20763674, -0.65853962, 0.00000000 };
Point ( 517 ) = { 0.20188207, -0.66032649, 0.00000000 };
Point ( 518 ) = { 0.19992887, -0.66429089, 0.00000000 };
Point ( 519 ) = { 0.19794767, -0.66826014, 0.00000000 };
Point ( 520 ) = { 0.19593839, -0.67223415, 0.00000000 };
Point ( 521 ) = { 0.19390091, -0.67621283, 0.00000000 };
Point ( 522 ) = { 0.19183514, -0.68019611, 0.00000000 };
Point ( 523 ) = { 0.19361659, -0.68651265, 0.00000000 };
Point ( 524 ) = { 0.19540916, -0.69286863, 0.00000000 };
Point ( 525 ) = { 0.19934494, -0.69519841, 0.00000000 };
Point ( 526 ) = { 0.20330768, -0.69751705, 0.00000000 };
Point ( 527 ) = { 0.20729743, -0.69982441, 0.00000000 };
Point ( 528 ) = { 0.21131425, -0.70212037, 0.00000000 };
Point ( 529 ) = { 0.21535816, -0.70440480, 0.00000000 };
Point ( 530 ) = { 0.21942922, -0.70667758, 0.00000000 };
Point ( 531 ) = { 0.22352748, -0.70893858, 0.00000000 };
Point ( 532 ) = { 0.22765297, -0.71118768, 0.00000000 };
Point ( 533 ) = { 0.23180575, -0.71342473, 0.00000000 };
Point ( 534 ) = { 0.23598585, -0.71564962, 0.00000000 };
Point ( 535 ) = { 0.24019334, -0.71786222, 0.00000000 };
Point ( 536 ) = { 0.24442825, -0.72006240, 0.00000000 };
Point ( 537 ) = { 0.24664918, -0.72660504, 0.00000000 };
Point ( 538 ) = { 0.25094761, -0.72880478, 0.00000000 };
Point ( 539 ) = { 0.25527377, -0.73099182, 0.00000000 };
Point ( 540 ) = { 0.25758256, -0.73760318, 0.00000000 };
Point ( 541 ) = { 0.25990715, -0.74425977, 0.00000000 };
Point ( 542 ) = { 0.26224778, -0.75096232, 0.00000000 };
Point ( 543 ) = { 0.26460472, -0.75771155, 0.00000000 };
Point ( 544 ) = { 0.26697822, -0.76450821, 0.00000000 };
Point ( 545 ) = { 0.26936856, -0.77135308, 0.00000000 };
Point ( 546 ) = { 0.26718688, -0.77596704, 0.00000000 };
Point ( 547 ) = { 0.26040520, -0.77826911, 0.00000000 };
Point ( 548 ) = { 0.25815232, -0.78287155, 0.00000000 };
Point ( 549 ) = { 0.25586828, -0.78748161, 0.00000000 };
Point ( 550 ) = { 0.25355296, -0.79209923, 0.00000000 };
Point ( 551 ) = { 0.25120622, -0.79672434, 0.00000000 };
Point ( 552 ) = { 0.24424401, -0.79888616, 0.00000000 };
Point ( 553 ) = { 0.24182538, -0.80349778, 0.00000000 };
Point ( 554 ) = { 0.23937501, -0.80811648, 0.00000000 };
Point ( 555 ) = { 0.23689275, -0.81274219, 0.00000000 };
Point ( 556 ) = { 0.23437847, -0.81737487, 0.00000000 };
Point ( 557 ) = { 0.22723670, -0.81938906, 0.00000000 };
Point ( 558 ) = { 0.22464988, -0.82400622, 0.00000000 };
Point ( 559 ) = { 0.22203072, -0.82862992, 0.00000000 };
Point ( 560 ) = { 0.21745061, -0.82593526, 0.00000000 };
Point ( 561 ) = { 0.21553646, -0.81866482, 0.00000000 };
Point ( 562 ) = { 0.21813895, -0.81410566, 0.00000000 };
Point ( 563 ) = { 0.22070940, -0.80955269, 0.00000000 };
Point ( 564 ) = { 0.21621450, -0.80692350, 0.00000000 };
Point ( 565 ) = { 0.20916462, -0.80877957, 0.00000000 };
Point ( 566 ) = { 0.20472353, -0.80610084, 0.00000000 };
Point ( 567 ) = { 0.20031306, -0.80341181, 0.00000000 };
Point ( 568 ) = { 0.19593313, -0.80071261, 0.00000000 };
Point ( 569 ) = { 0.19158366, -0.79800337, 0.00000000 };
Point ( 570 ) = { 0.18461256, -0.79964485, 0.00000000 };
Point ( 571 ) = { 0.18031737, -0.79688810, 0.00000000 };
Point ( 572 ) = { 0.17871726, -0.78981664, 0.00000000 };
Point ( 573 ) = { 0.17448888, -0.78706847, 0.00000000 };
Point ( 574 ) = { 0.17029059, -0.78431088, 0.00000000 };
Point ( 575 ) = { 0.16612230, -0.78154400, 0.00000000 };
Point ( 576 ) = { 0.15929581, -0.78296391, 0.00000000 };
Point ( 577 ) = { 0.15245718, -0.78432420, 0.00000000 };
Point ( 578 ) = { 0.14836792, -0.78147633, 0.00000000 };
Point ( 579 ) = { 0.14430868, -0.77861994, 0.00000000 };
Point ( 580 ) = { 0.14154269, -0.78274131, 0.00000000 };
Point ( 581 ) = { 0.13874562, -0.78686548, 0.00000000 };
Point ( 582 ) = { 0.13591735, -0.79099236, 0.00000000 };
Point ( 583 ) = { 0.13713652, -0.79808756, 0.00000000 };
Point ( 584 ) = { 0.13836435, -0.80523308, 0.00000000 };
Point ( 585 ) = { 0.13960096, -0.81242972, 0.00000000 };
Point ( 586 ) = { 0.13666060, -0.81665154, 0.00000000 };
Point ( 587 ) = { 0.13368818, -0.82087621, 0.00000000 };
Point ( 588 ) = { 0.13487903, -0.82818829, 0.00000000 };
Point ( 589 ) = { 0.13607863, -0.83555410, 0.00000000 };
Point ( 590 ) = { 0.14034239, -0.83865306, 0.00000000 };
Point ( 591 ) = { 0.14336494, -0.83433479, 0.00000000 };
Point ( 592 ) = { 0.14635489, -0.83001981, 0.00000000 };
Point ( 593 ) = { 0.15064033, -0.83305194, 0.00000000 };
Point ( 594 ) = { 0.14765558, -0.83739642, 0.00000000 };
Point ( 595 ) = { 0.14463814, -0.84174439, 0.00000000 };
Point ( 596 ) = { 0.14896597, -0.84482798, 0.00000000 };
Point ( 597 ) = { 0.15332597, -0.84790371, 0.00000000 };
Point ( 598 ) = { 0.15468396, -0.85541353, 0.00000000 };
Point ( 599 ) = { 0.15605230, -0.86298053, 0.00000000 };
Point ( 600 ) = { 0.16052096, -0.86609361, 0.00000000 };
Point ( 601 ) = { 0.16502253, -0.86919869, 0.00000000 };
Point ( 602 ) = { 0.16955709, -0.87229563, 0.00000000 };
Point ( 603 ) = { 0.17716276, -0.87078277, 0.00000000 };
Point ( 604 ) = { 0.18175721, -0.87383149, 0.00000000 };
Point ( 605 ) = { 0.18638480, -0.87687156, 0.00000000 };
Point ( 606 ) = { 0.19104563, -0.87990284, 0.00000000 };
Point ( 607 ) = { 0.19573981, -0.88292522, 0.00000000 };
Point ( 608 ) = { 0.20046744, -0.88593859, 0.00000000 };
Point ( 609 ) = { 0.20522862, -0.88894281, 0.00000000 };
Point ( 610 ) = { 0.21002346, -0.89193776, 0.00000000 };
Point ( 611 ) = { 0.21187066, -0.89978253, 0.00000000 };
Point ( 612 ) = { 0.21373282, -0.90769084, 0.00000000 };
Point ( 613 ) = { 0.21561020, -0.91566377, 0.00000000 };
Point ( 614 ) = { 0.21750305, -0.92370243, 0.00000000 };
Point ( 615 ) = { 0.22250133, -0.92678473, 0.00000000 };
Point ( 616 ) = { 0.22753474, -0.92985774, 0.00000000 };
Point ( 617 ) = { 0.23260342, -0.93292134, 0.00000000 };
Point ( 618 ) = { 0.23770747, -0.93597541, 0.00000000 };
Point ( 619 ) = { 0.23979192, -0.94418295, 0.00000000 };
Point ( 620 ) = { 0.24497629, -0.94725303, 0.00000000 };
Point ( 621 ) = { 0.25019664, -0.95031340, 0.00000000 };
Point ( 622 ) = { 0.24712380, -0.95555684, 0.00000000 };
Point ( 623 ) = { 0.23877569, -0.95767699, 0.00000000 };
Point ( 624 ) = { 0.23357328, -0.95453519, 0.00000000 };
Point ( 625 ) = { 0.22840713, -0.95138419, 0.00000000 };
Point ( 626 ) = { 0.22523460, -0.95653713, 0.00000000 };
Point ( 627 ) = { 0.22720892, -0.96492177, 0.00000000 };
Point ( 628 ) = { 0.23242898, -0.96813639, 0.00000000 };
Point ( 629 ) = { 0.23768589, -0.97134207, 0.00000000 };
Point ( 630 ) = { 0.23976920, -0.97985583, 0.00000000 };
Point ( 631 ) = { 0.24510955, -0.98308073, 0.00000000 };
Point ( 632 ) = { 0.24831081, -0.97772617, 0.00000000 };
Point ( 633 ) = { 0.25147488, -0.97238122, 0.00000000 };
Point ( 634 ) = { 0.25683352, -0.97552204, 0.00000000 };
Point ( 635 ) = { 0.25367911, -0.98090434, 0.00000000 };
Point ( 636 ) = { 0.25048741, -0.98629654, 0.00000000 };
Point ( 637 ) = { 0.25268342, -0.99494336, 0.00000000 };
Point ( 638 ) = { 0.25814664, -0.99817899, 0.00000000 };
Point ( 639 ) = { 0.26364804, -1.00140538, 0.00000000 };
Point ( 640 ) = { 0.26918777, -1.00462242, 0.00000000 };
Point ( 641 ) = { 0.27237680, -0.99906652, 0.00000000 };
Point ( 642 ) = { 0.27552795, -0.99352168, 0.00000000 };
Point ( 643 ) = { 0.28418746, -0.99107945, 0.00000000 };
Point ( 644 ) = { 0.28977143, -0.99416073, 0.00000000 };
Point ( 645 ) = { 0.29231320, -1.00288116, 0.00000000 };
Point ( 646 ) = { 0.29798503, -1.00598061, 0.00000000 };
Point ( 647 ) = { 0.30369550, -1.00906967, 0.00000000 };
Point ( 648 ) = { 0.30060043, -1.01481005, 0.00000000 };
Point ( 649 ) = { 0.29173321, -1.01739461, 0.00000000 };
Point ( 650 ) = { 0.28854970, -1.02312005, 0.00000000 };
Point ( 651 ) = { 0.29108425, -1.03210688, 0.00000000 };
Point ( 652 ) = { 0.29364262, -1.04117821, 0.00000000 };
Point ( 653 ) = { 0.29622527, -1.05033558, 0.00000000 };
Point ( 654 ) = { 0.29883263, -1.05958058, 0.00000000 };
Point ( 655 ) = { 0.30478646, -1.06291669, 0.00000000 };
Point ( 656 ) = { 0.31078160, -1.06624338, 0.00000000 };
Point ( 657 ) = { 0.31681827, -1.06956055, 0.00000000 };
Point ( 658 ) = { 0.32613976, -1.06675510, 0.00000000 };
Point ( 659 ) = { 0.33543642, -1.06386841, 0.00000000 };
Point ( 660 ) = { 0.34470753, -1.06090070, 0.00000000 };
Point ( 661 ) = { 0.35395240, -1.05785220, 0.00000000 };
Point ( 662 ) = { 0.36014249, -1.06094557, 0.00000000 };
Point ( 663 ) = { 0.36637413, -1.06402772, 0.00000000 };
Point ( 664 ) = { 0.37564545, -1.06079003, 0.00000000 };
Point ( 665 ) = { 0.38488817, -1.05747156, 0.00000000 };
Point ( 666 ) = { 0.39410158, -1.05407255, 0.00000000 };
Point ( 667 ) = { 0.39694957, -1.04773048, 0.00000000 };
Point ( 668 ) = { 0.39975838, -1.04140618, 0.00000000 };
Point ( 669 ) = { 0.40607751, -1.04422659, 0.00000000 };
Point ( 670 ) = { 0.41243766, -1.04703399, 0.00000000 };
Point ( 671 ) = { 0.42155893, -1.04339497, 0.00000000 };
Point ( 672 ) = { 0.43064810, -1.03967649, 0.00000000 };
Point ( 673 ) = { 0.43970448, -1.03587884, 0.00000000 };
Point ( 674 ) = { 0.44872737, -1.03200230, 0.00000000 };
Point ( 675 ) = { 0.45771609, -1.02804717, 0.00000000 };
Point ( 676 ) = { 0.46423321, -1.03055952, 0.00000000 };
Point ( 677 ) = { 0.46175817, -1.03712583, 0.00000000 };
Point ( 678 ) = { 0.45269007, -1.04111588, 0.00000000 };
Point ( 679 ) = { 0.44358750, -1.04502666, 0.00000000 };
Point ( 680 ) = { 0.44095934, -1.05156867, 0.00000000 };
Point ( 681 ) = { 0.44750918, -1.05426556, 0.00000000 };
Point ( 682 ) = { 0.45669223, -1.05032021, 0.00000000 };
Point ( 683 ) = { 0.46584049, -1.04629488, 0.00000000 };
Point ( 684 ) = { 0.47247799, -1.04886225, 0.00000000 };
Point ( 685 ) = { 0.47666269, -1.05815194, 0.00000000 };
Point ( 686 ) = { 0.47412894, -1.06491104, 0.00000000 };
Point ( 687 ) = { 0.46741054, -1.06227126, 0.00000000 };
Point ( 688 ) = { 0.46073458, -1.05961700, 0.00000000 };
Point ( 689 ) = { 0.45147025, -1.06359727, 0.00000000 };
Point ( 690 ) = { 0.44217154, -1.06749654, 0.00000000 };
Point ( 691 ) = { 0.43283916, -1.07131452, 0.00000000 };
Point ( 692 ) = { 0.42347382, -1.07505091, 0.00000000 };
Point ( 693 ) = { 0.41407622, -1.07870544, 0.00000000 };
Point ( 694 ) = { 0.40464709, -1.08227781, 0.00000000 };
Point ( 695 ) = { 0.39816213, -1.07926567, 0.00000000 };
Point ( 696 ) = { 0.39171989, -1.07624155, 0.00000000 };
Point ( 697 ) = { 0.38231311, -1.07961892, 0.00000000 };
Point ( 698 ) = { 0.37287722, -1.08291408, 0.00000000 };
Point ( 699 ) = { 0.36341294, -1.08612678, 0.00000000 };
Point ( 700 ) = { 0.35392097, -1.08925676, 0.00000000 };
Point ( 701 ) = { 0.34440206, -1.09230378, 0.00000000 };
Point ( 702 ) = { 0.33814086, -1.08899153, 0.00000000 };
Point ( 703 ) = { 0.33192245, -1.08566941, 0.00000000 };
Point ( 704 ) = { 0.32574662, -1.08233753, 0.00000000 };
Point ( 705 ) = { 0.31961318, -1.07899602, 0.00000000 };
Point ( 706 ) = { 0.31018511, -1.08174405, 0.00000000 };
Point ( 707 ) = { 0.30412333, -1.07833999, 0.00000000 };
Point ( 708 ) = { 0.30146516, -1.06891483, 0.00000000 };
Point ( 709 ) = { 0.29549927, -1.06553595, 0.00000000 };
Point ( 710 ) = { 0.28618958, -1.06807406, 0.00000000 };
Point ( 711 ) = { 0.27685810, -1.07053083, 0.00000000 };
Point ( 712 ) = { 0.27099364, -1.06704002, 0.00000000 };
Point ( 713 ) = { 0.26517055, -1.06354099, 0.00000000 };
Point ( 714 ) = { 0.25938863, -1.06003386, 0.00000000 };
Point ( 715 ) = { 0.25364771, -1.05651874, 0.00000000 };
Point ( 716 ) = { 0.24441830, -1.05869198, 0.00000000 };
Point ( 717 ) = { 0.23874914, -1.05511938, 0.00000000 };
Point ( 718 ) = { 0.23312067, -1.05153937, 0.00000000 };
Point ( 719 ) = { 0.22753270, -1.04795206, 0.00000000 };
Point ( 720 ) = { 0.22198505, -1.04435756, 0.00000000 };
Point ( 721 ) = { 0.21647756, -1.04075599, 0.00000000 };
Point ( 722 ) = { 0.21101003, -1.03714744, 0.00000000 };
Point ( 723 ) = { 0.20558230, -1.03353204, 0.00000000 };
Point ( 724 ) = { 0.20379401, -1.02454167, 0.00000000 };
Point ( 725 ) = { 0.19845312, -1.02095280, 0.00000000 };
Point ( 726 ) = { 0.19315129, -1.01735717, 0.00000000 };
Point ( 727 ) = { 0.19147228, -1.00851354, 0.00000000 };
Point ( 728 ) = { 0.18625530, -1.00494365, 0.00000000 };
Point ( 729 ) = { 0.18107667, -1.00136709, 0.00000000 };
Point ( 730 ) = { 0.17950321, -0.99266576, 0.00000000 };
Point ( 731 ) = { 0.17440752, -0.98911419, 0.00000000 };
Point ( 732 ) = { 0.16934950, -0.98555606, 0.00000000 };
Point ( 733 ) = { 0.16432902, -0.98199148, 0.00000000 };
Point ( 734 ) = { 0.15934591, -0.97842056, 0.00000000 };
Point ( 735 ) = { 0.15440003, -0.97484342, 0.00000000 };
Point ( 736 ) = { 0.14949124, -0.97126015, 0.00000000 };
Point ( 737 ) = { 0.14819204, -0.96281916, 0.00000000 };
Point ( 738 ) = { 0.14336240, -0.95926020, 0.00000000 };
Point ( 739 ) = { 0.13856921, -0.95569524, 0.00000000 };
Point ( 740 ) = { 0.13381236, -0.95212438, 0.00000000 };
Point ( 741 ) = { 0.12909168, -0.94854774, 0.00000000 };
Point ( 742 ) = { 0.12440706, -0.94496543, 0.00000000 };
Point ( 743 ) = { 0.11975835, -0.94137755, 0.00000000 };
Point ( 744 ) = { 0.11871614, -0.93318507, 0.00000000 };
Point ( 745 ) = { 0.11414310, -0.92962092, 0.00000000 };
Point ( 746 ) = { 0.10602638, -0.93058159, 0.00000000 };
Point ( 747 ) = { 0.10152000, -0.92697253, 0.00000000 };
Point ( 748 ) = { 0.09704888, -0.92335844, 0.00000000 };
Point ( 749 ) = { 0.09261289, -0.91973944, 0.00000000 };
Point ( 750 ) = { 0.08821190, -0.91611562, 0.00000000 };
Point ( 751 ) = { 0.08384579, -0.91248710, 0.00000000 };
Point ( 752 ) = { 0.08311422, -0.90452551, 0.00000000 };
Point ( 753 ) = { 0.08667928, -0.90019872, 0.00000000 };
Point ( 754 ) = { 0.09100443, -0.90376577, 0.00000000 };
Point ( 755 ) = { 0.09536400, -0.90732784, 0.00000000 };
Point ( 756 ) = { 0.10327820, -0.90646109, 0.00000000 };
Point ( 757 ) = { 0.11118453, -0.90552532, 0.00000000 };
Point ( 758 ) = { 0.11908239, -0.90452058, 0.00000000 };
Point ( 759 ) = { 0.12356811, -0.90796131, 0.00000000 };
Point ( 760 ) = { 0.12808835, -0.91139593, 0.00000000 };
Point ( 761 ) = { 0.13264322, -0.91482433, 0.00000000 };
Point ( 762 ) = { 0.13723284, -0.91824640, 0.00000000 };
Point ( 763 ) = { 0.14185735, -0.92166202, 0.00000000 };
Point ( 764 ) = { 0.14651687, -0.92507108, 0.00000000 };
Point ( 765 ) = { 0.15121151, -0.92847347, 0.00000000 };
Point ( 766 ) = { 0.15594140, -0.93186907, 0.00000000 };
Point ( 767 ) = { 0.16070668, -0.93525778, 0.00000000 };
Point ( 768 ) = { 0.16550746, -0.93863947, 0.00000000 };
Point ( 769 ) = { 0.17034389, -0.94201403, 0.00000000 };
Point ( 770 ) = { 0.17521608, -0.94538136, 0.00000000 };
Point ( 771 ) = { 0.18345931, -0.94381633, 0.00000000 };
Point ( 772 ) = { 0.19168857, -0.94217943, 0.00000000 };
Point ( 773 ) = { 0.19494457, -0.93723215, 0.00000000 };
Point ( 774 ) = { 0.19002147, -0.93398534, 0.00000000 };
Point ( 775 ) = { 0.18513380, -0.93073048, 0.00000000 };
Point ( 776 ) = { 0.18352265, -0.92263066, 0.00000000 };
Point ( 777 ) = { 0.17871213, -0.91939419, 0.00000000 };
Point ( 778 ) = { 0.17393648, -0.91614982, 0.00000000 };
Point ( 779 ) = { 0.17242105, -0.90816781, 0.00000000 };
Point ( 780 ) = { 0.16772097, -0.90494135, 0.00000000 };
Point ( 781 ) = { 0.16305522, -0.90170717, 0.00000000 };
Point ( 782 ) = { 0.16163254, -0.89383964, 0.00000000 };
Point ( 783 ) = { 0.16022109, -0.88603422, 0.00000000 };
Point ( 784 ) = { 0.15882069, -0.87828990, 0.00000000 };
Point ( 785 ) = { 0.15430761, -0.87512196, 0.00000000 };
Point ( 786 ) = { 0.14982778, -0.87194635, 0.00000000 };
Point ( 787 ) = { 0.14538110, -0.86876318, 0.00000000 };
Point ( 788 ) = { 0.14096745, -0.86557258, 0.00000000 };
Point ( 789 ) = { 0.13658673, -0.86237467, 0.00000000 };
Point ( 790 ) = { 0.13223884, -0.85916955, 0.00000000 };
Point ( 791 ) = { 0.12792368, -0.85595736, 0.00000000 };
Point ( 792 ) = { 0.12364115, -0.85273819, 0.00000000 };
Point ( 793 ) = { 0.12255428, -0.84524213, 0.00000000 };
Point ( 794 ) = { 0.12147547, -0.83780174, 0.00000000 };
Point ( 795 ) = { 0.12457735, -0.83356650, 0.00000000 };
Point ( 796 ) = { 0.12764668, -0.82933378, 0.00000000 };
Point ( 797 ) = { 0.12347831, -0.82621265, 0.00000000 };
Point ( 798 ) = { 0.11934155, -0.82308437, 0.00000000 };
Point ( 799 ) = { 0.11828619, -0.81580565, 0.00000000 };
Point ( 800 ) = { 0.12130405, -0.81166434, 0.00000000 };
Point ( 801 ) = { 0.12429002, -0.80752523, 0.00000000 };
Point ( 802 ) = { 0.12022858, -0.80446819, 0.00000000 };
Point ( 803 ) = { 0.11320378, -0.80548674, 0.00000000 };
Point ( 804 ) = { 0.10920013, -0.80238738, 0.00000000 };
Point ( 805 ) = { 0.11219831, -0.79833244, 0.00000000 };
Point ( 806 ) = { 0.11516500, -0.79427921, 0.00000000 };
Point ( 807 ) = { 0.11810033, -0.79022778, 0.00000000 };
Point ( 808 ) = { 0.12100441, -0.78617824, 0.00000000 };
Point ( 809 ) = { 0.11704732, -0.78318192, 0.00000000 };
Point ( 810 ) = { 0.11312046, -0.78017825, 0.00000000 };
Point ( 811 ) = { 0.11210872, -0.77320040, 0.00000000 };
Point ( 812 ) = { 0.10824581, -0.77020895, 0.00000000 };
Point ( 813 ) = { 0.10441275, -0.76721035, 0.00000000 };
Point ( 814 ) = { 0.10347476, -0.76031814, 0.00000000 };
Point ( 815 ) = { 0.10254303, -0.75347194, 0.00000000 };
Point ( 816 ) = { 0.10161746, -0.74667101, 0.00000000 };
Point ( 817 ) = { 0.09791281, -0.74372161, 0.00000000 };
Point ( 818 ) = { 0.09423724, -0.74076523, 0.00000000 };
Point ( 819 ) = { 0.09338232, -0.73404505, 0.00000000 };
Point ( 820 ) = { 0.08976778, -0.73109987, 0.00000000 };
Point ( 821 ) = { 0.08697310, -0.73483200, 0.00000000 };
Point ( 822 ) = { 0.08776934, -0.74155939, 0.00000000 };
Point ( 823 ) = { 0.08491816, -0.74531715, 0.00000000 };
Point ( 824 ) = { 0.07841089, -0.74602981, 0.00000000 };
Point ( 825 ) = { 0.07549712, -0.74976256, 0.00000000 };
Point ( 826 ) = { 0.07255334, -0.75349521, 0.00000000 };
Point ( 827 ) = { 0.06597517, -0.75409965, 0.00000000 };
Point ( 828 ) = { 0.05939198, -0.75464668, 0.00000000 };
Point ( 829 ) = { 0.05584475, -0.75148192, 0.00000000 };
Point ( 830 ) = { 0.05533943, -0.74468203, 0.00000000 };
Point ( 831 ) = { 0.05483740, -0.73792632, 0.00000000 };
Point ( 832 ) = { 0.05779221, -0.73431964, 0.00000000 };
Point ( 833 ) = { 0.06071749, -0.73071206, 0.00000000 };
Point ( 834 ) = { 0.05726581, -0.72763113, 0.00000000 };
Point ( 835 ) = { 0.05384297, -0.72454467, 0.00000000 };
Point ( 836 ) = { 0.05335048, -0.71791741, 0.00000000 };
Point ( 837 ) = { 0.05286107, -0.71133164, 0.00000000 };
Point ( 838 ) = { 0.04952755, -0.70827697, 0.00000000 };
Point ( 839 ) = { 0.04622236, -0.70521696, 0.00000000 };
Point ( 840 ) = { 0.04294544, -0.70215173, 0.00000000 };
Point ( 841 ) = { 0.03969672, -0.69908137, 0.00000000 };
Point ( 842 ) = { 0.03647613, -0.69600602, 0.00000000 };
Point ( 843 ) = { 0.03328361, -0.69292578, 0.00000000 };
Point ( 844 ) = { 0.03011910, -0.68984077, 0.00000000 };
Point ( 845 ) = { 0.02698252, -0.68675109, 0.00000000 };
Point ( 846 ) = { 0.02387382, -0.68365686, 0.00000000 };
Point ( 847 ) = { 0.02079293, -0.68055820, 0.00000000 };
Point ( 848 ) = { 0.02059849, -0.67419392, 0.00000000 };
Point ( 849 ) = { 0.01757360, -0.67110889, 0.00000000 };
Point ( 850 ) = { 0.01457624, -0.66801963, 0.00000000 };
Point ( 851 ) = { 0.01160633, -0.66492625, 0.00000000 };
Point ( 852 ) = { 0.00874619, -0.66812139, 0.00000000 };
Point ( 853 ) = { 0.00585846, -0.67131338, 0.00000000 };
Point ( 854 ) = { -0.00000000, -0.67133894, 0.00000000 };
Point ( 855 ) = { -0.00294309, -0.67450210, 0.00000000 };
Point ( 856 ) = { -0.00591386, -0.67766163, 0.00000000 };
Point ( 857 ) = { -0.01182728, -0.67758422, 0.00000000 };
Point ( 858 ) = { -0.01773979, -0.67745521, 0.00000000 };
Point ( 859 ) = { -0.02365095, -0.67727461, 0.00000000 };
Point ( 860 ) = { -0.02956031, -0.67704243, 0.00000000 };
Point ( 861 ) = { -0.03266714, -0.68009166, 0.00000000 };
Point ( 862 ) = { -0.03580165, -0.68313608, 0.00000000 };
Point ( 863 ) = { -0.03896387, -0.68617558, 0.00000000 };
Point ( 864 ) = { -0.03932919, -0.69260895, 0.00000000 };
Point ( 865 ) = { -0.04254846, -0.69566121, 0.00000000 };
Point ( 866 ) = { -0.04579576, -0.69870834, 0.00000000 };
Point ( 867 ) = { -0.04907116, -0.70175022, 0.00000000 };
Point ( 868 ) = { -0.05519314, -0.70129528, 0.00000000 };
Point ( 869 ) = { -0.05852306, -0.70430286, 0.00000000 };
Point ( 870 ) = { -0.06188115, -0.70730473, 0.00000000 };
Point ( 871 ) = { -0.06526747, -0.71030075, 0.00000000 };
Point ( 872 ) = { -0.06868209, -0.71329083, 0.00000000 };
Point ( 873 ) = { -0.07212508, -0.71627484, 0.00000000 };
Point ( 874 ) = { -0.07559650, -0.71925267, 0.00000000 };
Point ( 875 ) = { -0.07909641, -0.72222420, 0.00000000 };
Point ( 876 ) = { -0.08262489, -0.72518933, 0.00000000 };
Point ( 877 ) = { -0.08618199, -0.72814792, 0.00000000 };
Point ( 878 ) = { -0.08976778, -0.73109987, 0.00000000 };
Point ( 879 ) = { -0.09614433, -0.73028867, 0.00000000 };
Point ( 880 ) = { -0.09978444, -0.73320219, 0.00000000 };
Point ( 881 ) = { -0.10069797, -0.73991466, 0.00000000 };
Point ( 882 ) = { -0.10439919, -0.74283885, 0.00000000 };
Point ( 883 ) = { -0.11087763, -0.74189952, 0.00000000 };
Point ( 884 ) = { -0.11463319, -0.74478382, 0.00000000 };
Point ( 885 ) = { -0.11841779, -0.74766051, 0.00000000 };
Point ( 886 ) = { -0.12493777, -0.74659866, 0.00000000 };
Point ( 887 ) = { -0.12877636, -0.74943424, 0.00000000 };
Point ( 888 ) = { -0.12994644, -0.75624376, 0.00000000 };
Point ( 889 ) = { -0.13112440, -0.76309903, 0.00000000 };
Point ( 890 ) = { -0.13231033, -0.77000078, 0.00000000 };
Point ( 891 ) = { -0.13350438, -0.77694975, 0.00000000 };
Point ( 892 ) = { -0.13470668, -0.78394669, 0.00000000 };
Point ( 893 ) = { -0.13591735, -0.79099236, 0.00000000 };
Point ( 894 ) = { -0.13999136, -0.79393045, 0.00000000 };
Point ( 895 ) = { -0.14409584, -0.79686044, 0.00000000 };
Point ( 896 ) = { -0.14538597, -0.80399497, 0.00000000 };
Point ( 897 ) = { -0.14668534, -0.81118055, 0.00000000 };
Point ( 898 ) = { -0.14799408, -0.81841801, 0.00000000 };
Point ( 899 ) = { -0.15223749, -0.82140001, 0.00000000 };
Point ( 900 ) = { -0.15651225, -0.82437377, 0.00000000 };
Point ( 901 ) = { -0.16081844, -0.82733914, 0.00000000 };
Point ( 902 ) = { -0.16515615, -0.83029603, 0.00000000 };
Point ( 903 ) = { -0.16952547, -0.83324430, 0.00000000 };
Point ( 904 ) = { -0.17392649, -0.83618383, 0.00000000 };
Point ( 905 ) = { -0.17546896, -0.84359955, 0.00000000 };
Point ( 906 ) = { -0.17994003, -0.84655127, 0.00000000 };
Point ( 907 ) = { -0.18732064, -0.84494878, 0.00000000 };
Point ( 908 ) = { -0.19468698, -0.84328195, 0.00000000 };
Point ( 909 ) = { -0.19749169, -0.83871723, 0.00000000 };
Point ( 910 ) = { -0.19575563, -0.83134442, 0.00000000 };
Point ( 911 ) = { -0.19850200, -0.82682035, 0.00000000 };
Point ( 912 ) = { -0.20121596, -0.82230176, 0.00000000 };
Point ( 913 ) = { -0.19944214, -0.81505277, 0.00000000 };
Point ( 914 ) = { -0.19768127, -0.80785667, 0.00000000 };
Point ( 915 ) = { -0.20031306, -0.80341181, 0.00000000 };
Point ( 916 ) = { -0.20291312, -0.79897231, 0.00000000 };
Point ( 917 ) = { -0.20111568, -0.79189487, 0.00000000 };
Point ( 918 ) = { -0.20365978, -0.78749392, 0.00000000 };
Point ( 919 ) = { -0.20617259, -0.78309836, 0.00000000 };
Point ( 920 ) = { -0.20865425, -0.77870826, 0.00000000 };
Point ( 921 ) = { -0.21110487, -0.77432369, 0.00000000 };
Point ( 922 ) = { -0.20922448, -0.76742649, 0.00000000 };
Point ( 923 ) = { -0.20735709, -0.76057700, 0.00000000 };
Point ( 924 ) = { -0.20973001, -0.75626199, 0.00000000 };
Point ( 925 ) = { -0.21207252, -0.75195244, 0.00000000 };
Point ( 926 ) = { -0.21017165, -0.74521247, 0.00000000 };
Point ( 927 ) = { -0.20828358, -0.73851788, 0.00000000 };
Point ( 928 ) = { -0.21055016, -0.73427568, 0.00000000 };
Point ( 929 ) = { -0.21278693, -0.73003887, 0.00000000 };
Point ( 930 ) = { -0.21499399, -0.72580755, 0.00000000 };
Point ( 931 ) = { -0.21717147, -0.72158178, 0.00000000 };
Point ( 932 ) = { -0.21520636, -0.71505245, 0.00000000 };
Point ( 933 ) = { -0.21325402, -0.70856553, 0.00000000 };
Point ( 934 ) = { -0.21131425, -0.70212037, 0.00000000 };
Point ( 935 ) = { -0.20938685, -0.69571632, 0.00000000 };
Point ( 936 ) = { -0.21144746, -0.69161348, 0.00000000 };
Point ( 937 ) = { -0.21347939, -0.68751598, 0.00000000 };
Point ( 938 ) = { -0.21152105, -0.68120911, 0.00000000 };
Point ( 939 ) = { -0.20957486, -0.67494137, 0.00000000 };
Point ( 940 ) = { -0.20764065, -0.66871216, 0.00000000 };
Point ( 941 ) = { -0.20571821, -0.66252091, 0.00000000 };
Point ( 942 ) = { -0.20380738, -0.65636702, 0.00000000 };
Point ( 943 ) = { -0.20190797, -0.65024994, 0.00000000 };
Point ( 944 ) = { -0.20378454, -0.64632199, 0.00000000 };
Point ( 945 ) = { -0.20757471, -0.64846322, 0.00000000 };
Point ( 946 ) = { -0.21139036, -0.65059264, 0.00000000 };
Point ( 947 ) = { -0.21523152, -0.65271013, 0.00000000 };
Point ( 948 ) = { -0.21909822, -0.65481556, 0.00000000 };
Point ( 949 ) = { -0.22480415, -0.65287866, 0.00000000 };
Point ( 950 ) = { -0.23049296, -0.65089203, 0.00000000 };
Point ( 951 ) = { -0.23224373, -0.64685235, 0.00000000 };
Point ( 952 ) = { -0.23396694, -0.64281890, 0.00000000 };
Point ( 953 ) = { -0.23566272, -0.63879174, 0.00000000 };
Point ( 954 ) = { -0.23733114, -0.63477097, 0.00000000 };
Point ( 955 ) = { -0.23897232, -0.63075666, 0.00000000 };
Point ( 956 ) = { -0.23510785, -0.62882452, 0.00000000 };
Point ( 957 ) = { -0.23126802, -0.62687941, 0.00000000 };
Point ( 958 ) = { -0.23289755, -0.62291280, 0.00000000 };
Point ( 959 ) = { -0.23832455, -0.62085669, 0.00000000 };
Point ( 960 ) = { -0.23989250, -0.61688255, 0.00000000 };
Point ( 961 ) = { -0.24143365, -0.61291504, 0.00000000 };
Point ( 962 ) = { -0.24294810, -0.60895423, 0.00000000 };
Point ( 963 ) = { -0.24443595, -0.60500020, 0.00000000 };
Point ( 964 ) = { -0.24970620, -0.60284408, 0.00000000 };
Point ( 965 ) = { -0.25113303, -0.59888431, 0.00000000 };
Point ( 966 ) = { -0.24874085, -0.59317960, 0.00000000 };
Point ( 967 ) = { -0.25012327, -0.58925349, 0.00000000 };
Point ( 968 ) = { -0.25147957, -0.58533456, 0.00000000 };
Point ( 969 ) = { -0.25280986, -0.58142288, 0.00000000 };
Point ( 970 ) = { -0.25787404, -0.57919459, 0.00000000 };
Point ( 971 ) = { -0.26291859, -0.57692218, 0.00000000 };
Point ( 972 ) = { -0.26794311, -0.57460585, 0.00000000 };
Point ( 973 ) = { -0.27294722, -0.57224575, 0.00000000 };
Point ( 974 ) = { -0.27793055, -0.56984208, 0.00000000 };
Point ( 975 ) = { -0.28289272, -0.56739501, 0.00000000 };
Point ( 976 ) = { -0.28783334, -0.56490473, 0.00000000 };
Point ( 977 ) = { -0.29275204, -0.56237144, 0.00000000 };
Point ( 978 ) = { -0.29764845, -0.55979531, 0.00000000 };
Point ( 979 ) = { -0.30252219, -0.55717656, 0.00000000 };
Point ( 980 ) = { -0.30737289, -0.55451537, 0.00000000 };
Point ( 981 ) = { -0.31220018, -0.55181196, 0.00000000 };
Point ( 982 ) = { -0.31700370, -0.54906652, 0.00000000 };
Point ( 983 ) = { -0.32178308, -0.54627927, 0.00000000 };
Point ( 984 ) = { -0.32653795, -0.54345042, 0.00000000 };
Point ( 985 ) = { -0.32732155, -0.53940922, 0.00000000 };
Point ( 986 ) = { -0.32808051, -0.53537874, 0.00000000 };
Point ( 987 ) = { -0.33274002, -0.53249535, 0.00000000 };
Point ( 988 ) = { -0.33737419, -0.52957140, 0.00000000 };
Point ( 989 ) = { -0.33803837, -0.52553950, 0.00000000 };
Point ( 990 ) = { -0.33476516, -0.52045073, 0.00000000 };
Point ( 991 ) = { -0.33539184, -0.51645815, 0.00000000 };
Point ( 992 ) = { -0.33599452, -0.51247682, 0.00000000 };
Point ( 993 ) = { -0.33657330, -0.50850679, 0.00000000 };
Point ( 994 ) = { -0.34099799, -0.50555031, 0.00000000 };
Point ( 995 ) = { -0.34488730, -0.50653485, 0.00000000 };
Point ( 996 ) = { -0.34879621, -0.50750164, 0.00000000 };
Point ( 997 ) = { -0.35321166, -0.50443853, 0.00000000 };
Point ( 998 ) = { -0.35760021, -0.50133701, 0.00000000 };
Point ( 999 ) = { -0.36154466, -0.50221722, 0.00000000 };
Point ( 1000 ) = { -0.36550836, -0.50307910, 0.00000000 };
Point ( 1001 ) = { -0.36591351, -0.49904306, 0.00000000 };
Point ( 1002 ) = { -0.36629529, -0.49501967, 0.00000000 };
Point ( 1003 ) = { -0.36665379, -0.49100897, 0.00000000 };
Point ( 1004 ) = { -0.36698912, -0.48701102, 0.00000000 };
Point ( 1005 ) = { -0.36730141, -0.48302587, 0.00000000 };
Point ( 1006 ) = { -0.36759075, -0.47905359, 0.00000000 };
Point ( 1007 ) = { -0.37175723, -0.47582756, 0.00000000 };
Point ( 1008 ) = { -0.37589540, -0.47256529, 0.00000000 };
Point ( 1009 ) = { -0.37609276, -0.46860187, 0.00000000 };
Point ( 1010 ) = { -0.37238533, -0.46398251, 0.00000000 };
Point ( 1011 ) = { -0.37254977, -0.46006065, 0.00000000 };
Point ( 1012 ) = { -0.37269192, -0.45615213, 0.00000000 };
Point ( 1013 ) = { -0.36898284, -0.45161244, 0.00000000 };
Point ( 1014 ) = { -0.36909254, -0.44774506, 0.00000000 };
Point ( 1015 ) = { -0.36918028, -0.44389104, 0.00000000 };
Point ( 1016 ) = { -0.36924616, -0.44005043, 0.00000000 };
Point ( 1017 ) = { -0.37303985, -0.44065247, 0.00000000 };
Point ( 1018 ) = { -0.37685056, -0.44123531, 0.00000000 };
Point ( 1019 ) = { -0.37687102, -0.43738035, 0.00000000 };
Point ( 1020 ) = { -0.37686986, -0.43353918, 0.00000000 };
Point ( 1021 ) = { -0.38067348, -0.43407492, 0.00000000 };
Point ( 1022 ) = { -0.38449378, -0.43459116, 0.00000000 };
Point ( 1023 ) = { -0.38827162, -0.43121932, 0.00000000 };
Point ( 1024 ) = { -0.39211273, -0.43168245, 0.00000000 };
Point ( 1025 ) = { -0.39218423, -0.43556472, 0.00000000 };
Point ( 1026 ) = { -0.39223428, -0.43946138, 0.00000000 };
Point ( 1027 ) = { -0.39615796, -0.44385750, 0.00000000 };
Point ( 1028 ) = { -0.39617734, -0.44779702, 0.00000000 };
Point ( 1029 ) = { -0.39617493, -0.45175093, 0.00000000 };
Point ( 1030 ) = { -0.39615064, -0.45571918, 0.00000000 };
Point ( 1031 ) = { -0.39610434, -0.45970172, 0.00000000 };
Point ( 1032 ) = { -0.39603593, -0.46369849, 0.00000000 };
Point ( 1033 ) = { -0.39594528, -0.46770946, 0.00000000 };
Point ( 1034 ) = { -0.39583230, -0.47173457, 0.00000000 };
Point ( 1035 ) = { -0.39170062, -0.47517085, 0.00000000 };
Point ( 1036 ) = { -0.39152994, -0.47920871, 0.00000000 };
Point ( 1037 ) = { -0.39535817, -0.48389423, 0.00000000 };
Point ( 1038 ) = { -0.39515469, -0.48797540, 0.00000000 };
Point ( 1039 ) = { -0.39088131, -0.49140515, 0.00000000 };
Point ( 1040 ) = { -0.39061919, -0.49549808, 0.00000000 };
Point ( 1041 ) = { -0.39440634, -0.50030206, 0.00000000 };
Point ( 1042 ) = { -0.39849754, -0.50098007, 0.00000000 };
Point ( 1043 ) = { -0.40260751, -0.50163856, 0.00000000 };
Point ( 1044 ) = { -0.40233759, -0.50580767, 0.00000000 };
Point ( 1045 ) = { -0.39790832, -0.50929942, 0.00000000 };
Point ( 1046 ) = { -0.39344875, -0.51275239, 0.00000000 };
Point ( 1047 ) = { -0.38895921, -0.51616631, 0.00000000 };
Point ( 1048 ) = { -0.38444006, -0.51954092, 0.00000000 };
Point ( 1049 ) = { -0.37989163, -0.52287597, 0.00000000 };
Point ( 1050 ) = { -0.37580201, -0.52202193, 0.00000000 };
Point ( 1051 ) = { -0.37173214, -0.52114924, 0.00000000 };
Point ( 1052 ) = { -0.36717016, -0.52437333, 0.00000000 };
Point ( 1053 ) = { -0.36312799, -0.52344683, 0.00000000 };
Point ( 1054 ) = { -0.35964117, -0.51842061, 0.00000000 };
Point ( 1055 ) = { -0.35565045, -0.51747461, 0.00000000 };
Point ( 1056 ) = { -0.35112115, -0.52055851, 0.00000000 };
Point ( 1057 ) = { -0.35053871, -0.52461826, 0.00000000 };
Point ( 1058 ) = { -0.35393727, -0.52970456, 0.00000000 };
Point ( 1059 ) = { -0.35331785, -0.53380504, 0.00000000 };
Point ( 1060 ) = { -0.35267406, -0.53791733, 0.00000000 };
Point ( 1061 ) = { -0.35200579, -0.54204138, 0.00000000 };
Point ( 1062 ) = { -0.35131293, -0.54617712, 0.00000000 };
Point ( 1063 ) = { -0.35059537, -0.55032450, 0.00000000 };
Point ( 1064 ) = { -0.34577960, -0.55336303, 0.00000000 };
Point ( 1065 ) = { -0.34093749, -0.55635942, 0.00000000 };
Point ( 1066 ) = { -0.34012265, -0.56050478, 0.00000000 };
Point ( 1067 ) = { -0.33928270, -0.56466123, 0.00000000 };
Point ( 1068 ) = { -0.33841751, -0.56882869, 0.00000000 };
Point ( 1069 ) = { -0.33752699, -0.57300712, 0.00000000 };
Point ( 1070 ) = { -0.33661101, -0.57719643, 0.00000000 };
Point ( 1071 ) = { -0.33979984, -0.58266441, 0.00000000 };
Point ( 1072 ) = { -0.34395237, -0.58391525, 0.00000000 };
Point ( 1073 ) = { -0.34812707, -0.58514900, 0.00000000 };
Point ( 1074 ) = { -0.35232394, -0.58636551, 0.00000000 };
Point ( 1075 ) = { -0.35654298, -0.58756465, 0.00000000 };
Point ( 1076 ) = { -0.35988581, -0.59307347, 0.00000000 };
Point ( 1077 ) = { -0.36416122, -0.59425710, 0.00000000 };
Point ( 1078 ) = { -0.36933316, -0.59105660, 0.00000000 };
Point ( 1079 ) = { -0.37364091, -0.59218500, 0.00000000 };
Point ( 1080 ) = { -0.37712145, -0.59770133, 0.00000000 };
Point ( 1081 ) = { -0.38062354, -0.60325179, 0.00000000 };
Point ( 1082 ) = { -0.38502345, -0.60436576, 0.00000000 };
Point ( 1083 ) = { -0.39028281, -0.60098283, 0.00000000 };
Point ( 1084 ) = { -0.39471464, -0.60203989, 0.00000000 };
Point ( 1085 ) = { -0.39916884, -0.60307833, 0.00000000 };
Point ( 1086 ) = { -0.40364540, -0.60409803, 0.00000000 };
Point ( 1087 ) = { -0.40736095, -0.60965874, 0.00000000 };
Point ( 1088 ) = { -0.41189607, -0.61066103, 0.00000000 };
Point ( 1089 ) = { -0.41266565, -0.60608068, 0.00000000 };
Point ( 1090 ) = { -0.41340921, -0.60151414, 0.00000000 };
Point ( 1091 ) = { -0.41793892, -0.60245646, 0.00000000 };
Point ( 1092 ) = { -0.42249084, -0.60337945, 0.00000000 };
Point ( 1093 ) = { -0.42774016, -0.59966959, 0.00000000 };
Point ( 1094 ) = { -0.43232201, -0.60053316, 0.00000000 };
Point ( 1095 ) = { -0.43692591, -0.60137692, 0.00000000 };
Point ( 1096 ) = { -0.44215721, -0.59754117, 0.00000000 };
Point ( 1097 ) = { -0.44735484, -0.59365992, 0.00000000 };
Point ( 1098 ) = { -0.45199446, -0.59440289, 0.00000000 };
Point ( 1099 ) = { -0.45665578, -0.59512540, 0.00000000 };
Point ( 1100 ) = { -0.46133881, -0.59582733, 0.00000000 };
Point ( 1101 ) = { -0.46604354, -0.59650853, 0.00000000 };
Point ( 1102 ) = { -0.47076998, -0.59716887, 0.00000000 };
Point ( 1103 ) = { -0.47551812, -0.59780821, 0.00000000 };
Point ( 1104 ) = { -0.48071681, -0.59363582, 0.00000000 };
Point ( 1105 ) = { -0.48587889, -0.58941823, 0.00000000 };
Point ( 1106 ) = { -0.49065880, -0.58995309, 0.00000000 };
Point ( 1107 ) = { -0.49546005, -0.59046630, 0.00000000 };
Point ( 1108 ) = { -0.50059391, -0.58612017, 0.00000000 };
Point ( 1109 ) = { -0.50542060, -0.58656948, 0.00000000 };
Point ( 1110 ) = { -0.51026843, -0.58699669, 0.00000000 };
Point ( 1111 ) = { -0.51537145, -0.58252146, 0.00000000 };
Point ( 1112 ) = { -0.52043522, -0.57800187, 0.00000000 };
Point ( 1113 ) = { -0.52531052, -0.57832178, 0.00000000 };
Point ( 1114 ) = { -0.53020657, -0.57861894, 0.00000000 };
Point ( 1115 ) = { -0.53523572, -0.57397004, 0.00000000 };
Point ( 1116 ) = { -0.54015472, -0.57420137, 0.00000000 };
Point ( 1117 ) = { -0.54509425, -0.57440949, 0.00000000 };
Point ( 1118 ) = { -0.55008610, -0.56963083, 0.00000000 };
Point ( 1119 ) = { -0.55503606, -0.56480880, 0.00000000 };
Point ( 1120 ) = { -0.55999860, -0.56490696, 0.00000000 };
Point ( 1121 ) = { -0.56498125, -0.56498125, 0.00000000 };
Point ( 1122 ) = { -0.56989007, -0.56002941, 0.00000000 };
Point ( 1123 ) = { -0.57475549, -0.55503492, 0.00000000 };
Point ( 1124 ) = { -0.57957714, -0.54999816, 0.00000000 };
Point ( 1125 ) = { -0.58457951, -0.54991749, 0.00000000 };
Point ( 1126 ) = { -0.58982318, -0.55485025, 0.00000000 };
Point ( 1127 ) = { -0.59510404, -0.55981798, 0.00000000 };
Point ( 1128 ) = { -0.59529936, -0.56491800, 0.00000000 };
Point ( 1129 ) = { -0.59547090, -0.57003937, 0.00000000 };
Point ( 1130 ) = { -0.59561851, -0.57518210, 0.00000000 };
Point ( 1131 ) = { -0.59574204, -0.58034620, 0.00000000 };
Point ( 1132 ) = { -0.59584135, -0.58553166, 0.00000000 };
Point ( 1133 ) = { -0.59070900, -0.59070900, 0.00000000 };
Point ( 1134 ) = { -0.58552287, -0.59065494, 0.00000000 };
Point ( 1135 ) = { -0.58035789, -0.59057648, 0.00000000 };
Point ( 1136 ) = { -0.57518210, -0.59561851, 0.00000000 };
Point ( 1137 ) = { -0.56996252, -0.60061517, 0.00000000 };
Point ( 1138 ) = { -0.56469953, -0.60556610, 0.00000000 };
Point ( 1139 ) = { -0.55956015, -0.60532876, 0.00000000 };
Point ( 1140 ) = { -0.55444255, -0.60506787, 0.00000000 };
Point ( 1141 ) = { -0.54914130, -0.60988320, 0.00000000 };
Point ( 1142 ) = { -0.54379822, -0.61465208, 0.00000000 };
Point ( 1143 ) = { -0.53841373, -0.61937415, 0.00000000 };
Point ( 1144 ) = { -0.53298824, -0.62404905, 0.00000000 };
Point ( 1145 ) = { -0.52790543, -0.62358708, 0.00000000 };
Point ( 1146 ) = { -0.52284519, -0.62310263, 0.00000000 };
Point ( 1147 ) = { -0.51738775, -0.62764153, 0.00000000 };
Point ( 1148 ) = { -0.51189092, -0.63213264, 0.00000000 };
Point ( 1149 ) = { -0.51140093, -0.63719235, 0.00000000 };
Point ( 1150 ) = { -0.51597149, -0.64288716, 0.00000000 };
Point ( 1151 ) = { -0.52057506, -0.64862308, 0.00000000 };
Point ( 1152 ) = { -0.52572713, -0.64921894, 0.00000000 };
Point ( 1153 ) = { -0.53090281, -0.64979258, 0.00000000 };
Point ( 1154 ) = { -0.53562460, -0.65557176, 0.00000000 };
Point ( 1155 ) = { -0.54038140, -0.66139380, 0.00000000 };
Point ( 1156 ) = { -0.54566658, -0.66194650, 0.00000000 };
Point ( 1157 ) = { -0.55097589, -0.66247651, 0.00000000 };
Point ( 1158 ) = { -0.55630936, -0.66298368, 0.00000000 };
Point ( 1159 ) = { -0.56166701, -0.66346786, 0.00000000 };
Point ( 1160 ) = { -0.56663552, -0.66933691, 0.00000000 };
Point ( 1161 ) = { -0.57206204, -0.66979859, 0.00000000 };
Point ( 1162 ) = { -0.57751304, -0.67023688, 0.00000000 };
Point ( 1163 ) = { -0.58261035, -0.67615260, 0.00000000 };
Point ( 1164 ) = { -0.58813159, -0.67656800, 0.00000000 };
Point ( 1165 ) = { -0.59367764, -0.67695960, 0.00000000 };
Point ( 1166 ) = { -0.59890757, -0.68292320, 0.00000000 };
Point ( 1167 ) = { -0.60452527, -0.68329152, 0.00000000 };
Point ( 1168 ) = { -0.61016813, -0.68363563, 0.00000000 };
Point ( 1169 ) = { -0.61583619, -0.68395538, 0.00000000 };
Point ( 1170 ) = { -0.62152948, -0.68425060, 0.00000000 };
Point ( 1171 ) = { -0.62699219, -0.69026457, 0.00000000 };
Point ( 1172 ) = { -0.63275928, -0.69053558, 0.00000000 };
Point ( 1173 ) = { -0.63855198, -0.69078164, 0.00000000 };
Point ( 1174 ) = { -0.64437033, -0.69100258, 0.00000000 };
Point ( 1175 ) = { -0.65021438, -0.69119824, 0.00000000 };
Point ( 1176 ) = { -0.65608417, -0.69136846, 0.00000000 };
Point ( 1177 ) = { -0.66197974, -0.69151306, 0.00000000 };
Point ( 1178 ) = { -0.66790114, -0.69163188, 0.00000000 };
Point ( 1179 ) = { -0.67391126, -0.68577708, 0.00000000 };
Point ( 1180 ) = { -0.67985912, -0.68581805, 0.00000000 };
Point ( 1181 ) = { -0.68583267, -0.68583267, 0.00000000 };
Point ( 1182 ) = { -0.69179150, -0.67982161, 0.00000000 };
Point ( 1183 ) = { -0.69779046, -0.67975737, 0.00000000 };
Point ( 1184 ) = { -0.70381497, -0.67966622, 0.00000000 };
Point ( 1185 ) = { -0.70986509, -0.67954799, 0.00000000 };
Point ( 1186 ) = { -0.71594085, -0.67940250, 0.00000000 };
Point ( 1187 ) = { -0.72204231, -0.67922958, 0.00000000 };
Point ( 1188 ) = { -0.72816951, -0.67902905, 0.00000000 };
Point ( 1189 ) = { -0.73432251, -0.67880075, 0.00000000 };
Point ( 1190 ) = { -0.74050135, -0.67854448, 0.00000000 };
Point ( 1191 ) = { -0.74670610, -0.67826007, 0.00000000 };
Point ( 1192 ) = { -0.75325144, -0.68420543, 0.00000000 };
Point ( 1193 ) = { -0.75953719, -0.68389036, 0.00000000 };
Point ( 1194 ) = { -0.76584932, -0.68354665, 0.00000000 };
Point ( 1195 ) = { -0.77218787, -0.68317412, 0.00000000 };
Point ( 1196 ) = { -0.77855291, -0.68277258, 0.00000000 };
Point ( 1197 ) = { -0.78494450, -0.68234185, 0.00000000 };
Point ( 1198 ) = { -0.79136271, -0.68188173, 0.00000000 };
Point ( 1199 ) = { -0.79780759, -0.68139205, 0.00000000 };
Point ( 1200 ) = { -0.80427921, -0.68087261, 0.00000000 };
Point ( 1201 ) = { -0.81077764, -0.68032321, 0.00000000 };
Point ( 1202 ) = { -0.81730294, -0.67974368, 0.00000000 };
Point ( 1203 ) = { -0.82448192, -0.68571438, 0.00000000 };
Point ( 1204 ) = { -0.83109387, -0.68510092, 0.00000000 };
Point ( 1205 ) = { -0.83773324, -0.68445677, 0.00000000 };
Point ( 1206 ) = { -0.84510128, -0.69047670, 0.00000000 };
Point ( 1207 ) = { -0.85182956, -0.68979798, 0.00000000 };
Point ( 1208 ) = { -0.85858586, -0.68908800, 0.00000000 };
Point ( 1209 ) = { -0.86614947, -0.69515844, 0.00000000 };
Point ( 1210 ) = { -0.86690400, -0.70200502, 0.00000000 };
Point ( 1211 ) = { -0.86763365, -0.70888643, 0.00000000 };
Point ( 1212 ) = { -0.86833825, -0.71580282, 0.00000000 };
Point ( 1213 ) = { -0.86901761, -0.72275431, 0.00000000 };
Point ( 1214 ) = { -0.87600653, -0.72212405, 0.00000000 };
Point ( 1215 ) = { -0.88302557, -0.72146215, 0.00000000 };
Point ( 1216 ) = { -0.89083683, -0.72784422, 0.00000000 };
Point ( 1217 ) = { -0.89872690, -0.73429068, 0.00000000 };
Point ( 1218 ) = { -0.89947526, -0.74147019, 0.00000000 };
Point ( 1219 ) = { -0.90019813, -0.74868688, 0.00000000 };
Point ( 1220 ) = { -0.90819265, -0.75533586, 0.00000000 };
Point ( 1221 ) = { -0.91627002, -0.76205373, 0.00000000 };
Point ( 1222 ) = { -0.91699165, -0.76944736, 0.00000000 };
Point ( 1223 ) = { -0.91024213, -0.77742022, 0.00000000 };
Point ( 1224 ) = { -0.91087289, -0.78485829, 0.00000000 };
Point ( 1225 ) = { -0.91899981, -0.79186090, 0.00000000 };
Point ( 1226 ) = { -0.92655735, -0.79135474, 0.00000000 };
Point ( 1227 ) = { -0.93414989, -0.79081625, 0.00000000 };
Point ( 1228 ) = { -0.93484562, -0.79843358, 0.00000000 };
Point ( 1229 ) = { -0.93551485, -0.80609116, 0.00000000 };
Point ( 1230 ) = { -0.94322328, -0.80558879, 0.00000000 };
Point ( 1231 ) = { -0.95096795, -0.80505379, 0.00000000 };
Point ( 1232 ) = { -0.95169213, -0.81282187, 0.00000000 };
Point ( 1233 ) = { -0.95238971, -0.82063148, 0.00000000 };
Point ( 1234 ) = { -0.96096660, -0.82802180, 0.00000000 };
Point ( 1235 ) = { -0.96963896, -0.83549438, 0.00000000 };
Point ( 1236 ) = { -0.97840874, -0.84305090, 0.00000000 };
Point ( 1237 ) = { -0.98727791, -0.85069307, 0.00000000 };
Point ( 1238 ) = { -0.99624853, -0.85842265, 0.00000000 };
Point ( 1239 ) = { -1.00452558, -0.85794589, 0.00000000 };
Point ( 1240 ) = { -1.01284370, -0.85743548, 0.00000000 };
Point ( 1241 ) = { -1.02120312, -0.85689116, 0.00000000 };
Point ( 1242 ) = { -1.02960408, -0.85631267, 0.00000000 };
Point ( 1243 ) = { -1.03804682, -0.85569977, 0.00000000 };
Point ( 1244 ) = { -1.04653159, -0.85505218, 0.00000000 };
Point ( 1245 ) = { -1.05505865, -0.85436965, 0.00000000 };
Point ( 1246 ) = { -1.06247416, -0.84513011, 0.00000000 };
Point ( 1247 ) = { -1.06980876, -0.83582621, 0.00000000 };
Point ( 1248 ) = { -1.07836451, -0.83495902, 0.00000000 };
Point ( 1249 ) = { -1.08696243, -0.83405561, 0.00000000 };
Point ( 1250 ) = { -1.09560276, -0.83311570, 0.00000000 };
Point ( 1251 ) = { -1.10428579, -0.83213903, 0.00000000 };
Point ( 1252 ) = { -1.11301176, -0.83112530, 0.00000000 };
Point ( 1253 ) = { -1.12178095, -0.83007424, 0.00000000 };
Point ( 1254 ) = { -1.12898191, -0.82025337, 0.00000000 };
Point ( 1255 ) = { -1.13778476, -0.81908782, 0.00000000 };
Point ( 1256 ) = { -1.14663105, -0.81788398, 0.00000000 };
Point ( 1257 ) = { -1.15552107, -0.81664156, 0.00000000 };
Point ( 1258 ) = { -1.16445510, -0.81536024, 0.00000000 };
Point ( 1259 ) = { -1.17343344, -0.81403974, 0.00000000 };
Point ( 1260 ) = { -1.18439917, -0.82164694, 0.00000000 };
Point ( 1261 ) = { -1.18632072, -0.83067071, 0.00000000 };
Point ( 1262 ) = { -1.18822084, -0.83975146, 0.00000000 };
Point ( 1263 ) = { -1.19939877, -0.84765125, 0.00000000 };
Point ( 1264 ) = { -1.21072089, -0.85565293, 0.00000000 };
Point ( 1265 ) = { -1.21267436, -0.86499221, 0.00000000 };
Point ( 1266 ) = { -1.21460630, -0.87439142, 0.00000000 };
Point ( 1267 ) = { -1.22615453, -0.88270496, 0.00000000 };
Point ( 1268 ) = { -1.23584401, -0.88151897, 0.00000000 };
Point ( 1269 ) = { -1.24558537, -0.88029271, 0.00000000 };
Point ( 1270 ) = { -1.24766036, -0.88994749, 0.00000000 };
Point ( 1271 ) = { -1.24971434, -0.89966559, 0.00000000 };
Point ( 1272 ) = { -1.25963580, -0.89848948, 0.00000000 };
Point ( 1273 ) = { -1.26961150, -0.89727269, 0.00000000 };
Point ( 1274 ) = { -1.27964186, -0.89601488, 0.00000000 };
Point ( 1275 ) = { -1.28741225, -0.88481392, 0.00000000 };
Point ( 1276 ) = { -1.29748601, -0.88342678, 0.00000000 };
Point ( 1277 ) = { -1.30761497, -0.88199743, 0.00000000 };
Point ( 1278 ) = { -1.31526196, -0.87055290, 0.00000000 };
Point ( 1279 ) = { -1.32280879, -0.85904207, 0.00000000 };
Point ( 1280 ) = { -1.33296616, -0.85739265, 0.00000000 };
Point ( 1281 ) = { -1.34594377, -0.86574013, 0.00000000 };
Point ( 1282 ) = { -1.35910390, -0.87420500, 0.00000000 };
Point ( 1283 ) = { -1.37245093, -0.88279010, 0.00000000 };
Point ( 1284 ) = { -1.38598940, -0.89149834, 0.00000000 };
Point ( 1285 ) = { -1.39972397, -0.90033271, 0.00000000 };
Point ( 1286 ) = { -1.41060083, -0.89865184, 0.00000000 };
Point ( 1287 ) = { -1.42154066, -0.89692536, 0.00000000 };
Point ( 1288 ) = { -1.43254406, -0.89515288, 0.00000000 };
Point ( 1289 ) = { -1.44361161, -0.89333397, 0.00000000 };
Point ( 1290 ) = { -1.45474392, -0.89146822, 0.00000000 };
Point ( 1291 ) = { -1.46594160, -0.88955520, 0.00000000 };
Point ( 1292 ) = { -1.47720527, -0.88759447, 0.00000000 };
Point ( 1293 ) = { -1.48853557, -0.88558560, 0.00000000 };
Point ( 1294 ) = { -1.50364936, -0.89457736, 0.00000000 };
Point ( 1295 ) = { -1.51520186, -0.89252210, 0.00000000 };
Point ( 1296 ) = { -1.52682409, -0.89041749, 0.00000000 };
Point ( 1297 ) = { -1.53851674, -0.88826305, 0.00000000 };
Point ( 1298 ) = { -1.55028053, -0.88605832, 0.00000000 };
Point ( 1299 ) = { -1.56211619, -0.88380282, 0.00000000 };
Point ( 1300 ) = { -1.57402446, -0.88149605, 0.00000000 };
Point ( 1301 ) = { -1.58600609, -0.87913753, 0.00000000 };
Point ( 1302 ) = { -1.59806185, -0.87672676, 0.00000000 };
Point ( 1303 ) = { -1.61019253, -0.87426321, 0.00000000 };
Point ( 1304 ) = { -1.61776051, -0.86017852, 0.00000000 };
Point ( 1305 ) = { -1.62994447, -0.85755527, 0.00000000 };
Point ( 1306 ) = { -1.64220448, -0.85487754, 0.00000000 };
Point ( 1307 ) = { -1.65454136, -0.85214480, 0.00000000 };
Point ( 1308 ) = { -1.66695596, -0.84935649, 0.00000000 };
Point ( 1309 ) = { -1.67430443, -0.83477739, 0.00000000 };
Point ( 1310 ) = { -1.68152539, -0.82013473, 0.00000000 };
Point ( 1311 ) = { -1.69396702, -0.81707269, 0.00000000 };
Point ( 1312 ) = { -1.70648708, -0.81395259, 0.00000000 };
Point ( 1313 ) = { -1.70103273, -0.80225912, 0.00000000 };
Point ( 1314 ) = { -1.69558261, -0.79066316, 0.00000000 };
Point ( 1315 ) = { -1.70796890, -0.78738445, 0.00000000 };
Point ( 1316 ) = { -1.72043261, -0.78404631, 0.00000000 };
Point ( 1317 ) = { -1.72720911, -0.76900304, 0.00000000 };
Point ( 1318 ) = { -1.73385407, -0.75390121, 0.00000000 };
Point ( 1319 ) = { -1.74036700, -0.73874196, 0.00000000 };
Point ( 1320 ) = { -1.74674739, -0.72352646, 0.00000000 };
Point ( 1321 ) = { -1.75299476, -0.70825586, 0.00000000 };
Point ( 1322 ) = { -1.75910863, -0.69293132, 0.00000000 };
Point ( 1323 ) = { -1.76508854, -0.67755401, 0.00000000 };
Point ( 1324 ) = { -1.77093403, -0.66212510, 0.00000000 };
Point ( 1325 ) = { -1.78320842, -0.65786032, 0.00000000 };
Point ( 1326 ) = { -1.79555756, -0.65352951, 0.00000000 };
Point ( 1327 ) = { -1.80119224, -0.63783563, 0.00000000 };
Point ( 1328 ) = { -1.79441808, -0.62663885, 0.00000000 };
Point ( 1329 ) = { -1.78765959, -0.61554056, 0.00000000 };
Point ( 1330 ) = { -1.79296305, -0.59991705, 0.00000000 };
Point ( 1331 ) = { -1.78612428, -0.58897546, 0.00000000 };
Point ( 1332 ) = { -1.76747603, -0.58282619, 0.00000000 };
Point ( 1333 ) = { -1.76077812, -0.57211149, 0.00000000 };
Point ( 1334 ) = { -1.75409486, -0.56149019, 0.00000000 };
Point ( 1335 ) = { -1.74255152, -0.56618931, 0.00000000 };
Point ( 1336 ) = { -1.73107292, -0.57082224, 0.00000000 };
Point ( 1337 ) = { -1.71330258, -0.56496246, 0.00000000 };
Point ( 1338 ) = { -1.69580981, -0.55919421, 0.00000000 };
Point ( 1339 ) = { -1.68957673, -0.54897676, 0.00000000 };
Point ( 1340 ) = { -1.68335388, -0.53884582, 0.00000000 };
Point ( 1341 ) = { -1.67714112, -0.52880056, 0.00000000 };
Point ( 1342 ) = { -1.67093835, -0.51884015, 0.00000000 };
Point ( 1343 ) = { -1.65414307, -0.51362507, 0.00000000 };
Point ( 1344 ) = { -1.64805449, -0.50386082, 0.00000000 };
Point ( 1345 ) = { -1.64197473, -0.49417830, 0.00000000 };
Point ( 1346 ) = { -1.62563358, -0.48926018, 0.00000000 };
Point ( 1347 ) = { -1.61966228, -0.47976583, 0.00000000 };
Point ( 1348 ) = { -1.61369872, -0.47035029, 0.00000000 };
Point ( 1349 ) = { -1.60774282, -0.46101284, 0.00000000 };
Point ( 1350 ) = { -1.60179450, -0.45175277, 0.00000000 };
Point ( 1351 ) = { -1.59585369, -0.44256940, 0.00000000 };
Point ( 1352 ) = { -1.58992030, -0.43346203, 0.00000000 };
Point ( 1353 ) = { -1.57438982, -0.42922793, 0.00000000 };
Point ( 1354 ) = { -1.55907894, -0.42505371, 0.00000000 };
Point ( 1355 ) = { -1.55333508, -0.41621488, 0.00000000 };
Point ( 1356 ) = { -1.54759701, -0.40744829, 0.00000000 };
Point ( 1357 ) = { -1.53267505, -0.40351967, 0.00000000 };
Point ( 1358 ) = { -1.51795806, -0.39964501, 0.00000000 };
Point ( 1359 ) = { -1.50344130, -0.39582306, 0.00000000 };
Point ( 1360 ) = { -1.49796116, -0.38739910, 0.00000000 };
Point ( 1361 ) = { -1.49248472, -0.37904283, 0.00000000 };
Point ( 1362 ) = { -1.47832282, -0.37544617, 0.00000000 };
Point ( 1363 ) = { -1.46434817, -0.37189706, 0.00000000 };
Point ( 1364 ) = { -1.45055656, -0.36839444, 0.00000000 };
Point ( 1365 ) = { -1.43694392, -0.36493726, 0.00000000 };
Point ( 1366 ) = { -1.43177471, -0.35698153, 0.00000000 };
Point ( 1367 ) = { -1.42660691, -0.34908849, 0.00000000 };
Point ( 1368 ) = { -1.41331148, -0.34583512, 0.00000000 };
Point ( 1369 ) = { -1.40821547, -0.33808262, 0.00000000 };
Point ( 1370 ) = { -1.40312040, -0.33039100, 0.00000000 };
Point ( 1371 ) = { -1.39012965, -0.32733208, 0.00000000 };
Point ( 1372 ) = { -1.38510329, -0.31977629, 0.00000000 };
Point ( 1373 ) = { -1.38007746, -0.31227965, 0.00000000 };
Point ( 1374 ) = { -1.37505218, -0.30484173, 0.00000000 };
Point ( 1375 ) = { -1.37002748, -0.29746213, 0.00000000 };
Point ( 1376 ) = { -1.35745964, -0.29473338, 0.00000000 };
Point ( 1377 ) = { -1.35249996, -0.28748274, 0.00000000 };
Point ( 1378 ) = { -1.34754049, -0.28028882, 0.00000000 };
Point ( 1379 ) = { -1.33524954, -0.27773230, 0.00000000 };
Point ( 1380 ) = { -1.32310402, -0.27520603, 0.00000000 };
Point ( 1381 ) = { -1.31110089, -0.27270938, 0.00000000 };
Point ( 1382 ) = { -1.29923722, -0.27024173, 0.00000000 };
Point ( 1383 ) = { -1.29217067, -0.27465935, 0.00000000 };
Point ( 1384 ) = { -1.28512414, -0.27902780, 0.00000000 };
Point ( 1385 ) = { -1.27355237, -0.27651533, 0.00000000 };
Point ( 1386 ) = { -1.26211146, -0.27403126, 0.00000000 };
Point ( 1387 ) = { -1.25079878, -0.27157504, 0.00000000 };
Point ( 1388 ) = { -1.24399821, -0.27578776, 0.00000000 };
Point ( 1389 ) = { -1.23721584, -0.27995336, 0.00000000 };
Point ( 1390 ) = { -1.22617335, -0.27745470, 0.00000000 };
Point ( 1391 ) = { -1.21948060, -0.28153928, 0.00000000 };
Point ( 1392 ) = { -1.21280542, -0.28557777, 0.00000000 };
Point ( 1393 ) = { -1.20614776, -0.28957046, 0.00000000 };
Point ( 1394 ) = { -1.19950756, -0.29351763, 0.00000000 };
Point ( 1395 ) = { -1.18886331, -0.29091300, 0.00000000 };
Point ( 1396 ) = { -1.17833215, -0.28833604, 0.00000000 };
Point ( 1397 ) = { -1.16791189, -0.28578622, 0.00000000 };
Point ( 1398 ) = { -1.16397307, -0.27944521, 0.00000000 };
Point ( 1399 ) = { -1.16002823, -0.27315039, 0.00000000 };
Point ( 1400 ) = { -1.14980202, -0.27074244, 0.00000000 };
Point ( 1401 ) = { -1.13968068, -0.26835918, 0.00000000 };
Point ( 1402 ) = { -1.12966224, -0.26600015, 0.00000000 };
Point ( 1403 ) = { -1.11974475, -0.26366489, 0.00000000 };
Point ( 1404 ) = { -1.11595805, -0.25763922, 0.00000000 };
Point ( 1405 ) = { -1.11216476, -0.25165719, 0.00000000 };
Point ( 1406 ) = { -1.10242395, -0.24945307, 0.00000000 };
Point ( 1407 ) = { -1.09866273, -0.24356766, 0.00000000 };
Point ( 1408 ) = { -1.09489495, -0.23772500, 0.00000000 };
Point ( 1409 ) = { -1.08532510, -0.23564718, 0.00000000 };
Point ( 1410 ) = { -1.07584755, -0.23358940, 0.00000000 };
Point ( 1411 ) = { -1.07214743, -0.22789197, 0.00000000 };
Point ( 1412 ) = { -1.06844065, -0.22223597, 0.00000000 };
Point ( 1413 ) = { -1.05912543, -0.22029841, 0.00000000 };
Point ( 1414 ) = { -1.05544773, -0.21473327, 0.00000000 };
Point ( 1415 ) = { -1.05176345, -0.20920876, 0.00000000 };
Point ( 1416 ) = { -1.04807268, -0.20372469, 0.00000000 };
Point ( 1417 ) = { -1.04437553, -0.19828089, 0.00000000 };
Point ( 1418 ) = { -1.04067211, -0.19287718, 0.00000000 };
Point ( 1419 ) = { -1.03696253, -0.18751337, 0.00000000 };
Point ( 1420 ) = { -1.03324689, -0.18218930, 0.00000000 };
Point ( 1421 ) = { -1.02952529, -0.17690480, 0.00000000 };
Point ( 1422 ) = { -1.02579785, -0.17165969, 0.00000000 };
Point ( 1423 ) = { -1.02206466, -0.16645380, 0.00000000 };
Point ( 1424 ) = { -1.01318011, -0.16500686, 0.00000000 };
Point ( 1425 ) = { -1.00947488, -0.15988511, 0.00000000 };
Point ( 1426 ) = { -1.00576398, -0.15480188, 0.00000000 };
Point ( 1427 ) = { -1.00070251, -0.15849571, 0.00000000 };
Point ( 1428 ) = { -0.99564734, -0.16215147, 0.00000000 };
Point ( 1429 ) = { -0.98699637, -0.16074257, 0.00000000 };
Point ( 1430 ) = { -0.97842056, -0.15934591, 0.00000000 };
Point ( 1431 ) = { -0.97345892, -0.16290116, 0.00000000 };
Point ( 1432 ) = { -0.96850324, -0.16641929, 0.00000000 };
Point ( 1433 ) = { -0.96008621, -0.16497298, 0.00000000 };
Point ( 1434 ) = { -0.95174042, -0.16353891, 0.00000000 };
Point ( 1435 ) = { -0.94346468, -0.16211688, 0.00000000 };
Point ( 1436 ) = { -0.93525778, -0.16070668, 0.00000000 };
Point ( 1437 ) = { -0.92711856, -0.15930811, 0.00000000 };
Point ( 1438 ) = { -0.92375727, -0.15458395, 0.00000000 };
Point ( 1439 ) = { -0.92038900, -0.14989487, 0.00000000 };
Point ( 1440 ) = { -0.91701387, -0.14524073, 0.00000000 };
Point ( 1441 ) = { -0.91824640, -0.13723284, 0.00000000 };
Point ( 1442 ) = { -0.91482433, -0.13264322, 0.00000000 };
Point ( 1443 ) = { -0.91139593, -0.12808835, 0.00000000 };
Point ( 1444 ) = { -0.91594701, -0.12465492, 0.00000000 };
Point ( 1445 ) = { -0.92050159, -0.12118633, 0.00000000 };
Point ( 1446 ) = { -0.92152408, -0.11314893, 0.00000000 };
Point ( 1447 ) = { -0.92247638, -0.10510291, 0.00000000 };
Point ( 1448 ) = { -0.92335844, -0.09704888, 0.00000000 };
Point ( 1449 ) = { -0.91973944, -0.09261289, 0.00000000 };
Point ( 1450 ) = { -0.91611562, -0.08821190, 0.00000000 };
Point ( 1451 ) = { -0.91248710, -0.08384579, 0.00000000 };
Point ( 1452 ) = { -0.90452551, -0.08311422, 0.00000000 };
Point ( 1453 ) = { -0.90092085, -0.07882036, 0.00000000 };
Point ( 1454 ) = { -0.89731161, -0.07456084, 0.00000000 };
Point ( 1455 ) = { -0.89369790, -0.07033555, 0.00000000 };
Point ( 1456 ) = { -0.89427765, -0.06253399, 0.00000000 };
Point ( 1457 ) = { -0.89478931, -0.05472766, 0.00000000 };
Point ( 1458 ) = { -0.89523282, -0.04691716, 0.00000000 };
Point ( 1459 ) = { -0.89560816, -0.03910310, 0.00000000 };
Point ( 1460 ) = { -0.89591529, -0.03128605, 0.00000000 };
Point ( 1461 ) = { -0.89615419, -0.02346662, 0.00000000 };
Point ( 1462 ) = { -0.90018977, -0.01964221, 0.00000000 };
Point ( 1463 ) = { -0.90422448, -0.01578330, 0.00000000 };
Point ( 1464 ) = { -0.90432779, -0.00789195, 0.00000000 };
Point ( 1465 ) = { -0.90436222, 0.00000000, 0.00000000 };
Point ( 1466 ) = { -0.90832740, 0.00396335, 0.00000000 };
Point ( 1467 ) = { -0.91229091, 0.00796144, 0.00000000 };
Point ( 1468 ) = { -0.91218670, 0.01592228, 0.00000000 };
Point ( 1469 ) = { -0.91201302, 0.02388190, 0.00000000 };
Point ( 1470 ) = { -0.91590379, 0.02798339, 0.00000000 };
Point ( 1471 ) = { -0.91979209, 0.03211985, 0.00000000 };
Point ( 1472 ) = { -0.91947677, 0.04014522, 0.00000000 };
Point ( 1473 ) = { -0.91527591, 0.04396385, 0.00000000 };
Point ( 1474 ) = { -0.91107534, 0.04774744, 0.00000000 };
Point ( 1475 ) = { -0.91062398, 0.05569615, 0.00000000 };
Point ( 1476 ) = { -0.91010327, 0.06364062, 0.00000000 };
Point ( 1477 ) = { -0.90951326, 0.07158025, 0.00000000 };
Point ( 1478 ) = { -0.90885398, 0.07951442, 0.00000000 };
Point ( 1479 ) = { -0.90812549, 0.08744254, 0.00000000 };
Point ( 1480 ) = { -0.91172067, 0.09180544, 0.00000000 };
Point ( 1481 ) = { -0.91531095, 0.09620306, 0.00000000 };
Point ( 1482 ) = { -0.91443658, 0.10418689, 0.00000000 };
Point ( 1483 ) = { -0.91349257, 0.11216278, 0.00000000 };
Point ( 1484 ) = { -0.91699994, 0.11665713, 0.00000000 };
Point ( 1485 ) = { -0.92050159, 0.12118633, 0.00000000 };
Point ( 1486 ) = { -0.91594701, 0.12465492, 0.00000000 };
Point ( 1487 ) = { -0.91139593, 0.12808835, 0.00000000 };
Point ( 1488 ) = { -0.91024346, 0.13603680, 0.00000000 };
Point ( 1489 ) = { -0.90902167, 0.14397489, 0.00000000 };
Point ( 1490 ) = { -0.90441554, 0.14729342, 0.00000000 };
Point ( 1491 ) = { -0.89981366, 0.15057716, 0.00000000 };
Point ( 1492 ) = { -0.89521609, 0.15382626, 0.00000000 };
Point ( 1493 ) = { -0.89062293, 0.15704085, 0.00000000 };
Point ( 1494 ) = { -0.88603422, 0.16022109, 0.00000000 };
Point ( 1495 ) = { -0.88145006, 0.16336711, 0.00000000 };
Point ( 1496 ) = { -0.87687051, 0.16647907, 0.00000000 };
Point ( 1497 ) = { -0.87229563, 0.16955709, 0.00000000 };
Point ( 1498 ) = { -0.87078277, 0.17716276, 0.00000000 };
Point ( 1499 ) = { -0.86618626, 0.18016700, 0.00000000 };
Point ( 1500 ) = { -0.86159488, 0.18313764, 0.00000000 };
Point ( 1501 ) = { -0.85996391, 0.19064941, 0.00000000 };
Point ( 1502 ) = { -0.85535226, 0.19354646, 0.00000000 };
Point ( 1503 ) = { -0.84785214, 0.19184935, 0.00000000 };
Point ( 1504 ) = { -0.84328195, 0.19468698, 0.00000000 };
Point ( 1505 ) = { -0.83871723, 0.19749169, 0.00000000 };
Point ( 1506 ) = { -0.83134442, 0.19575563, 0.00000000 };
Point ( 1507 ) = { -0.82682035, 0.19850200, 0.00000000 };
Point ( 1508 ) = { -0.82230176, 0.20121596, 0.00000000 };
Point ( 1509 ) = { -0.81778872, 0.20389763, 0.00000000 };
Point ( 1510 ) = { -0.81328130, 0.20654714, 0.00000000 };
Point ( 1511 ) = { -0.80877957, 0.20916462, 0.00000000 };
Point ( 1512 ) = { -0.80428362, 0.21175021, 0.00000000 };
Point ( 1513 ) = { -0.79979350, 0.21430402, 0.00000000 };
Point ( 1514 ) = { -0.79530930, 0.21682620, 0.00000000 };
Point ( 1515 ) = { -0.78826431, 0.21490552, 0.00000000 };
Point ( 1516 ) = { -0.78381963, 0.21737242, 0.00000000 };
Point ( 1517 ) = { -0.78635891, 0.22177615, 0.00000000 };
Point ( 1518 ) = { -0.78888709, 0.22620973, 0.00000000 };
Point ( 1519 ) = { -0.78439363, 0.22862989, 0.00000000 };
Point ( 1520 ) = { -0.77743304, 0.22660107, 0.00000000 };
Point ( 1521 ) = { -0.77297948, 0.22896695, 0.00000000 };
Point ( 1522 ) = { -0.76853227, 0.23130196, 0.00000000 };
Point ( 1523 ) = { -0.76168665, 0.22924166, 0.00000000 };
Point ( 1524 ) = { -0.75488839, 0.22719562, 0.00000000 };
Point ( 1525 ) = { -0.74813674, 0.22516360, 0.00000000 };
Point ( 1526 ) = { -0.74379303, 0.22740035, 0.00000000 };
Point ( 1527 ) = { -0.73945545, 0.22960702, 0.00000000 };
Point ( 1528 ) = { -0.73281258, 0.22754435, 0.00000000 };
Point ( 1529 ) = { -0.73048924, 0.22333297, 0.00000000 };
Point ( 1530 ) = { -0.72815418, 0.21914953, 0.00000000 };
Point ( 1531 ) = { -0.72158178, 0.21717147, 0.00000000 };
Point ( 1532 ) = { -0.71924823, 0.21305103, 0.00000000 };
Point ( 1533 ) = { -0.71690323, 0.20895824, 0.00000000 };
Point ( 1534 ) = { -0.71039952, 0.20706258, 0.00000000 };
Point ( 1535 ) = { -0.70393768, 0.20517912, 0.00000000 };
Point ( 1536 ) = { -0.69751705, 0.20330768, 0.00000000 };
Point ( 1537 ) = { -0.69113700, 0.20144806, 0.00000000 };
Point ( 1538 ) = { -0.68479691, 0.19960010, 0.00000000 };
Point ( 1539 ) = { -0.67849616, 0.19776359, 0.00000000 };
Point ( 1540 ) = { -0.67223415, 0.19593839, 0.00000000 };
Point ( 1541 ) = { -0.66601028, 0.19412429, 0.00000000 };
Point ( 1542 ) = { -0.66206308, 0.19611202, 0.00000000 };
Point ( 1543 ) = { -0.66032649, 0.20188207, 0.00000000 };
Point ( 1544 ) = { -0.65636702, 0.20380738, 0.00000000 };
Point ( 1545 ) = { -0.65024994, 0.20190797, 0.00000000 };
Point ( 1546 ) = { -0.64807572, 0.19813663, 0.00000000 };
Point ( 1547 ) = { -0.64589004, 0.19439084, 0.00000000 };
Point ( 1548 ) = { -0.64369303, 0.19067056, 0.00000000 };
Point ( 1549 ) = { -0.64148480, 0.18697577, 0.00000000 };
Point ( 1550 ) = { -0.63544314, 0.18521478, 0.00000000 };
Point ( 1551 ) = { -0.63323369, 0.18157684, 0.00000000 };
Point ( 1552 ) = { -0.63101330, 0.17796416, 0.00000000 };
Point ( 1553 ) = { -0.62502574, 0.17627549, 0.00000000 };
Point ( 1554 ) = { -0.62280423, 0.17271890, 0.00000000 };
Point ( 1555 ) = { -0.62057206, 0.16918736, 0.00000000 };
Point ( 1556 ) = { -0.61832934, 0.16568085, 0.00000000 };
Point ( 1557 ) = { -0.61607621, 0.16219933, 0.00000000 };
Point ( 1558 ) = { -0.61016055, 0.16064187, 0.00000000 };
Point ( 1559 ) = { -0.60427737, 0.15909295, 0.00000000 };
Point ( 1560 ) = { -0.60203289, 0.15569629, 0.00000000 };
Point ( 1561 ) = { -0.60336866, 0.15043670, 0.00000000 };
Point ( 1562 ) = { -0.60108471, 0.14708449, 0.00000000 };
Point ( 1563 ) = { -0.59879098, 0.14375700, 0.00000000 };
Point ( 1564 ) = { -0.59648758, 0.14045418, 0.00000000 };
Point ( 1565 ) = { -0.59066103, 0.13908221, 0.00000000 };
Point ( 1566 ) = { -0.58835761, 0.13583306, 0.00000000 };
Point ( 1567 ) = { -0.58604479, 0.13260840, 0.00000000 };
Point ( 1568 ) = { -0.58372268, 0.12940820, 0.00000000 };
Point ( 1569 ) = { -0.58482974, 0.12430940, 0.00000000 };
Point ( 1570 ) = { -0.58589226, 0.11920113, 0.00000000 };
Point ( 1571 ) = { -0.58350592, 0.11606654, 0.00000000 };
Point ( 1572 ) = { -0.58111097, 0.11295653, 0.00000000 };
Point ( 1573 ) = { -0.57870751, 0.10987105, 0.00000000 };
Point ( 1574 ) = { -0.57629567, 0.10681009, 0.00000000 };
Point ( 1575 ) = { -0.57387557, 0.10377361, 0.00000000 };
Point ( 1576 ) = { -0.57144733, 0.10076158, 0.00000000 };
Point ( 1577 ) = { -0.56901106, 0.09777398, 0.00000000 };
Point ( 1578 ) = { -0.56329169, 0.09679122, 0.00000000 };
Point ( 1579 ) = { -0.55760079, 0.09581334, 0.00000000 };
Point ( 1580 ) = { -0.55193791, 0.09484028, 0.00000000 };
Point ( 1581 ) = { -0.54952333, 0.09195867, 0.00000000 };
Point ( 1582 ) = { -0.54710102, 0.08910106, 0.00000000 };
Point ( 1583 ) = { -0.54148475, 0.08818639, 0.00000000 };
Point ( 1584 ) = { -0.53906437, 0.08537941, 0.00000000 };
Point ( 1585 ) = { -0.53663652, 0.08259626, 0.00000000 };
Point ( 1586 ) = { -0.53420131, 0.07983692, 0.00000000 };
Point ( 1587 ) = { -0.53487767, 0.07517215, 0.00000000 };
Point ( 1588 ) = { -0.53241145, 0.07245802, 0.00000000 };
Point ( 1589 ) = { -0.52993832, 0.06976770, 0.00000000 };
Point ( 1590 ) = { -0.53052697, 0.06514052, 0.00000000 };
Point ( 1591 ) = { -0.52802386, 0.06249574, 0.00000000 };
Point ( 1592 ) = { -0.52247859, 0.06183942, 0.00000000 };
Point ( 1593 ) = { -0.51997895, 0.05924412, 0.00000000 };
Point ( 1594 ) = { -0.51747298, 0.05667251, 0.00000000 };
Point ( 1595 ) = { -0.51197266, 0.05607012, 0.00000000 };
Point ( 1596 ) = { -0.50947026, 0.05354748, 0.00000000 };
Point ( 1597 ) = { -0.50991815, 0.04909953, 0.00000000 };
Point ( 1598 ) = { -0.51287324, 0.04712643, 0.00000000 };
Point ( 1599 ) = { -0.51582695, 0.04512901, 0.00000000 };
Point ( 1600 ) = { -0.51620113, 0.04062591, 0.00000000 };
Point ( 1601 ) = { -0.51653599, 0.03611972, 0.00000000 };
Point ( 1602 ) = { -0.51683153, 0.03161077, 0.00000000 };
Point ( 1603 ) = { -0.51708770, 0.02709942, 0.00000000 };
Point ( 1604 ) = { -0.51730449, 0.02258600, 0.00000000 };
Point ( 1605 ) = { -0.51748189, 0.01807087, 0.00000000 };
Point ( 1606 ) = { -0.51761989, 0.01355435, 0.00000000 };
Point ( 1607 ) = { -0.51491128, 0.01123540, 0.00000000 };
Point ( 1608 ) = { -0.51219855, 0.00894046, 0.00000000 };
Point ( 1609 ) = { -0.51225706, 0.00447040, 0.00000000 };
Point ( 1610 ) = { -0.51227657, 0.00000000, 0.00000000 };
Point ( 1611 ) = { -0.50952060, -0.00222322, 0.00000000 };
Point ( 1612 ) = { -0.50676114, -0.00442244, 0.00000000 };
Point ( 1613 ) = { -0.50670326, -0.00884454, 0.00000000 };
Point ( 1614 ) = { -0.50392155, -0.01099561, 0.00000000 };
Point ( 1615 ) = { -0.50113678, -0.01312273, 0.00000000 };
Point ( 1616 ) = { -0.50100318, -0.01749542, 0.00000000 };
Point ( 1617 ) = { -0.50083143, -0.02186677, 0.00000000 };
Point ( 1618 ) = { -0.50062154, -0.02623646, 0.00000000 };
Point ( 1619 ) = { -0.50037352, -0.03060416, 0.00000000 };
Point ( 1620 ) = { -0.50008740, -0.03496952, 0.00000000 };
Point ( 1621 ) = { -0.49976320, -0.03933222, 0.00000000 };
Point ( 1622 ) = { -0.49940094, -0.04369192, 0.00000000 };
Point ( 1623 ) = { -0.49900064, -0.04804830, 0.00000000 };
Point ( 1624 ) = { -0.49856234, -0.05240101, 0.00000000 };
Point ( 1625 ) = { -0.49561821, -0.05427902, 0.00000000 };
Point ( 1626 ) = { -0.49267311, -0.05613301, 0.00000000 };
Point ( 1627 ) = { -0.49512567, -0.05860198, 0.00000000 };
Point ( 1628 ) = { -0.49757189, -0.06109415, 0.00000000 };
Point ( 1629 ) = { -0.49459542, -0.06292048, 0.00000000 };
Point ( 1630 ) = { -0.49161842, -0.06472279, 0.00000000 };
Point ( 1631 ) = { -0.49402751, -0.06723419, 0.00000000 };
Point ( 1632 ) = { -0.49642986, -0.06976867, 0.00000000 };
Point ( 1633 ) = { -0.49580212, -0.07409812, 0.00000000 };
Point ( 1634 ) = { -0.49277887, -0.07584592, 0.00000000 };
Point ( 1635 ) = { -0.48975571, -0.07756968, 0.00000000 };
Point ( 1636 ) = { -0.48906015, -0.08184060, 0.00000000 };
Point ( 1637 ) = { -0.48832734, -0.08610529, 0.00000000 };
Point ( 1638 ) = { -0.49062459, -0.08871938, 0.00000000 };
Point ( 1639 ) = { -0.49291411, -0.09135623, 0.00000000 };
Point ( 1640 ) = { -0.48983170, -0.09299745, 0.00000000 };
Point ( 1641 ) = { -0.48675022, -0.09461466, 0.00000000 };
Point ( 1642 ) = { -0.48900150, -0.09726845, 0.00000000 };
Point ( 1643 ) = { -0.49209812, -0.09565418, 0.00000000 };
Point ( 1644 ) = { -0.49519577, -0.09401585, 0.00000000 };
Point ( 1645 ) = { -0.50058348, -0.09503874, 0.00000000 };
Point ( 1646 ) = { -0.50286460, -0.09774698, 0.00000000 };
Point ( 1647 ) = { -0.50513761, -0.10047812, 0.00000000 };
Point ( 1648 ) = { -0.50828393, -0.09880039, 0.00000000 };
Point ( 1649 ) = { -0.51143131, -0.09709827, 0.00000000 };
Point ( 1650 ) = { -0.51457965, -0.09537170, 0.00000000 };
Point ( 1651 ) = { -0.51772886, -0.09362063, 0.00000000 };
Point ( 1652 ) = { -0.52322372, -0.09461426, 0.00000000 };
Point ( 1653 ) = { -0.52556070, -0.09740692, 0.00000000 };
Point ( 1654 ) = { -0.52469066, -0.10198953, 0.00000000 };
Point ( 1655 ) = { -0.52699494, -0.10482581, 0.00000000 };
Point ( 1656 ) = { -0.52929087, -0.10768544, 0.00000000 };
Point ( 1657 ) = { -0.53157832, -0.11056845, 0.00000000 };
Point ( 1658 ) = { -0.53385718, -0.11347485, 0.00000000 };
Point ( 1659 ) = { -0.53284661, -0.11812925, 0.00000000 };
Point ( 1660 ) = { -0.53179547, -0.12277466, 0.00000000 };
Point ( 1661 ) = { -0.53070382, -0.12741071, 0.00000000 };
Point ( 1662 ) = { -0.52957176, -0.13203707, 0.00000000 };
Point ( 1663 ) = { -0.52839937, -0.13665337, 0.00000000 };
Point ( 1664 ) = { -0.53053957, -0.13967941, 0.00000000 };
Point ( 1665 ) = { -0.53266994, -0.14272848, 0.00000000 };
Point ( 1666 ) = { -0.53479035, -0.14580058, 0.00000000 };
Point ( 1667 ) = { -0.53690068, -0.14889574, 0.00000000 };
Point ( 1668 ) = { -0.53900083, -0.15201396, 0.00000000 };
Point ( 1669 ) = { -0.54109067, -0.15515525, 0.00000000 };
Point ( 1670 ) = { -0.53971610, -0.15987119, 0.00000000 };
Point ( 1671 ) = { -0.53830042, -0.16457496, 0.00000000 };
Point ( 1672 ) = { -0.53684376, -0.16926619, 0.00000000 };
Point ( 1673 ) = { -0.53883962, -0.17248392, 0.00000000 };
Point ( 1674 ) = { -0.54082433, -0.17572448, 0.00000000 };
Point ( 1675 ) = { -0.53927027, -0.18043731, 0.00000000 };
Point ( 1676 ) = { -0.54121516, -0.18371779, 0.00000000 };
Point ( 1677 ) = { -0.54314846, -0.18702101, 0.00000000 };
Point ( 1678 ) = { -0.54149573, -0.19175370, 0.00000000 };
Point ( 1679 ) = { -0.53792641, -0.19313532, 0.00000000 };
Point ( 1680 ) = { -0.53436218, -0.19449193, 0.00000000 };
Point ( 1681 ) = { -0.53080312, -0.19582361, 0.00000000 };
Point ( 1682 ) = { -0.52894951, -0.19252188, 0.00000000 };
Point ( 1683 ) = { -0.52708389, -0.18924245, 0.00000000 };
Point ( 1684 ) = { -0.52170238, -0.18731030, 0.00000000 };
Point ( 1685 ) = { -0.51820336, -0.18861060, 0.00000000 };
Point ( 1686 ) = { -0.51470939, -0.18988632, 0.00000000 };
Point ( 1687 ) = { -0.51122057, -0.19113754, 0.00000000 };
Point ( 1688 ) = { -0.50953314, -0.19559145, 0.00000000 };
Point ( 1689 ) = { -0.50780690, -0.20003046, 0.00000000 };
Point ( 1690 ) = { -0.50604199, -0.20445424, 0.00000000 };
Point ( 1691 ) = { -0.50423855, -0.20886245, 0.00000000 };
Point ( 1692 ) = { -0.50239670, -0.21325475, 0.00000000 };
Point ( 1693 ) = { -0.50406612, -0.21656390, 0.00000000 };
Point ( 1694 ) = { -0.50572240, -0.21989436, 0.00000000 };
Point ( 1695 ) = { -0.50378423, -0.22429919, 0.00000000 };
Point ( 1696 ) = { -0.50539795, -0.22766518, 0.00000000 };
Point ( 1697 ) = { -0.50699812, -0.23105236, 0.00000000 };
Point ( 1698 ) = { -0.50496253, -0.23546789, 0.00000000 };
Point ( 1699 ) = { -0.50288848, -0.23986550, 0.00000000 };
Point ( 1700 ) = { -0.50077614, -0.24424484, 0.00000000 };
Point ( 1701 ) = { -0.50227287, -0.24769357, 0.00000000 };
Point ( 1702 ) = { -0.50375525, -0.25116310, 0.00000000 };
Point ( 1703 ) = { -0.50154429, -0.25554958, 0.00000000 };
Point ( 1704 ) = { -0.49929513, -0.25991659, 0.00000000 };
Point ( 1705 ) = { -0.49700795, -0.26426381, 0.00000000 };
Point ( 1706 ) = { -0.49468291, -0.26859091, 0.00000000 };
Point ( 1707 ) = { -0.49602813, -0.27213035, 0.00000000 };
Point ( 1708 ) = { -0.49735805, -0.27569007, 0.00000000 };
Point ( 1709 ) = { -0.49493329, -0.28001978, 0.00000000 };
Point ( 1710 ) = { -0.49120326, -0.28074579, 0.00000000 };
Point ( 1711 ) = { -0.48748251, -0.28144816, 0.00000000 };
Point ( 1712 ) = { -0.48500788, -0.28569147, 0.00000000 };
Point ( 1713 ) = { -0.48249632, -0.28991303, 0.00000000 };
Point ( 1714 ) = { -0.47994801, -0.29411252, 0.00000000 };
Point ( 1715 ) = { -0.47736315, -0.29828960, 0.00000000 };
Point ( 1716 ) = { -0.47474194, -0.30244397, 0.00000000 };
Point ( 1717 ) = { -0.47208457, -0.30657531, 0.00000000 };
Point ( 1718 ) = { -0.46939126, -0.31068330, 0.00000000 };
Point ( 1719 ) = { -0.46666219, -0.31476762, 0.00000000 };
Point ( 1720 ) = { -0.46291250, -0.31518590, 0.00000000 };
Point ( 1721 ) = { -0.45917386, -0.31558145, 0.00000000 };
Point ( 1722 ) = { -0.45544633, -0.31595436, 0.00000000 };
Point ( 1723 ) = { -0.45077095, -0.31271093, 0.00000000 };
Point ( 1724 ) = { -0.44707997, -0.31304877, 0.00000000 };
Point ( 1725 ) = { -0.44340019, -0.31336427, 0.00000000 };
Point ( 1726 ) = { -0.43879734, -0.31011130, 0.00000000 };
Point ( 1727 ) = { -0.43515381, -0.31039220, 0.00000000 };
Point ( 1728 ) = { -0.43152154, -0.31065106, 0.00000000 };
Point ( 1729 ) = { -0.42698973, -0.30738862, 0.00000000 };
Point ( 1730 ) = { -0.42247867, -0.30414113, 0.00000000 };
Point ( 1731 ) = { -0.41798807, -0.30090835, 0.00000000 };
Point ( 1732 ) = { -0.41351760, -0.29769007, 0.00000000 };
Point ( 1733 ) = { -0.40906696, -0.29448607, 0.00000000 };
Point ( 1734 ) = { -0.40812308, -0.29111137, 0.00000000 };
Point ( 1735 ) = { -0.41064794, -0.28753878, 0.00000000 };
Point ( 1736 ) = { -0.41314152, -0.28394430, 0.00000000 };
Point ( 1737 ) = { -0.41663553, -0.28367704, 0.00000000 };
Point ( 1738 ) = { -0.42014003, -0.28338803, 0.00000000 };
Point ( 1739 ) = { -0.42259702, -0.27971087, 0.00000000 };
Point ( 1740 ) = { -0.42502184, -0.27601241, 0.00000000 };
Point ( 1741 ) = { -0.42741429, -0.27229293, 0.00000000 };
Point ( 1742 ) = { -0.42628192, -0.26896386, 0.00000000 };
Point ( 1743 ) = { -0.42513377, -0.26565307, 0.00000000 };
Point ( 1744 ) = { -0.42743582, -0.26193301, 0.00000000 };
Point ( 1745 ) = { -0.42970531, -0.25819300, 0.00000000 };
Point ( 1746 ) = { -0.43317649, -0.25771293, 0.00000000 };
Point ( 1747 ) = { -0.43665681, -0.25721052, 0.00000000 };
Point ( 1748 ) = { -0.43888474, -0.25339022, 0.00000000 };
Point ( 1749 ) = { -0.44107924, -0.24955063, 0.00000000 };
Point ( 1750 ) = { -0.43977419, -0.24628538, 0.00000000 };
Point ( 1751 ) = { -0.43845435, -0.24303922, 0.00000000 };
Point ( 1752 ) = { -0.44055855, -0.23920377, 0.00000000 };
Point ( 1753 ) = { -0.43919592, -0.23598848, 0.00000000 };
Point ( 1754 ) = { -0.43781890, -0.23279244, 0.00000000 };
Point ( 1755 ) = { -0.44123856, -0.23214684, 0.00000000 };
Point ( 1756 ) = { -0.44466613, -0.23147853, 0.00000000 };
Point ( 1757 ) = { -0.44666920, -0.22758933, 0.00000000 };
Point ( 1758 ) = { -0.44522288, -0.22441080, 0.00000000 };
Point ( 1759 ) = { -0.44181501, -0.22511599, 0.00000000 };
Point ( 1760 ) = { -0.43841474, -0.22579843, 0.00000000 };
Point ( 1761 ) = { -0.43360263, -0.22332003, 0.00000000 };
Point ( 1762 ) = { -0.43216918, -0.22020120, 0.00000000 };
Point ( 1763 ) = { -0.43407432, -0.21642147, 0.00000000 };
Point ( 1764 ) = { -0.43594640, -0.21262527, 0.00000000 };
Point ( 1765 ) = { -0.43444526, -0.20955152, 0.00000000 };
Point ( 1766 ) = { -0.43111225, -0.21026749, 0.00000000 };
Point ( 1767 ) = { -0.42778635, -0.21096088, 0.00000000 };
Point ( 1768 ) = { -0.42446765, -0.21163176, 0.00000000 };
Point ( 1769 ) = { -0.42115621, -0.21228021, 0.00000000 };
Point ( 1770 ) = { -0.41969416, -0.20925179, 0.00000000 };
Point ( 1771 ) = { -0.41821863, -0.20624260, 0.00000000 };
Point ( 1772 ) = { -0.41494017, -0.20688154, 0.00000000 };
Point ( 1773 ) = { -0.41166893, -0.20749822, 0.00000000 };
Point ( 1774 ) = { -0.41020538, -0.20452086, 0.00000000 };
Point ( 1775 ) = { -0.41197452, -0.20093340, 0.00000000 };
Point ( 1776 ) = { -0.41522758, -0.20028201, 0.00000000 };
Point ( 1777 ) = { -0.41848755, -0.19960832, 0.00000000 };
Point ( 1778 ) = { -0.41695953, -0.19665088, 0.00000000 };
Point ( 1779 ) = { -0.41541854, -0.19371285, 0.00000000 };
Point ( 1780 ) = { -0.41709316, -0.19008031, 0.00000000 };
Point ( 1781 ) = { -0.41873603, -0.18643329, 0.00000000 };
Point ( 1782 ) = { -0.42196437, -0.18566877, 0.00000000 };
Point ( 1783 ) = { -0.42356928, -0.18858520, 0.00000000 };
Point ( 1784 ) = { -0.42516162, -0.19152135, 0.00000000 };
Point ( 1785 ) = { -0.42842214, -0.19074583, 0.00000000 };
Point ( 1786 ) = { -0.43007038, -0.18699992, 0.00000000 };
Point ( 1787 ) = { -0.43333007, -0.18617329, 0.00000000 };
Point ( 1788 ) = { -0.43824093, -0.18828316, 0.00000000 };
Point ( 1789 ) = { -0.43987367, -0.19126251, 0.00000000 };
Point ( 1790 ) = { -0.43818786, -0.19509380, 0.00000000 };
Point ( 1791 ) = { -0.43978180, -0.19810726, 0.00000000 };
Point ( 1792 ) = { -0.44136289, -0.20114066, 0.00000000 };
Point ( 1793 ) = { -0.44293102, -0.20419400, 0.00000000 };
Point ( 1794 ) = { -0.44627787, -0.20338054, 0.00000000 };
Point ( 1795 ) = { -0.44803568, -0.19947834, 0.00000000 };
Point ( 1796 ) = { -0.44975938, -0.19556094, 0.00000000 };
Point ( 1797 ) = { -0.45309768, -0.19466613, 0.00000000 };
Point ( 1798 ) = { -0.45809240, -0.19681203, 0.00000000 };
Point ( 1799 ) = { -0.46145697, -0.19587686, 0.00000000 };
Point ( 1800 ) = { -0.46314872, -0.19184248, 0.00000000 };
Point ( 1801 ) = { -0.46145747, -0.18878724, 0.00000000 };
Point ( 1802 ) = { -0.45975392, -0.18575264, 0.00000000 };
Point ( 1803 ) = { -0.45803818, -0.18273871, 0.00000000 };
Point ( 1804 ) = { -0.45631037, -0.17974544, 0.00000000 };
Point ( 1805 ) = { -0.45457061, -0.17677284, 0.00000000 };
Point ( 1806 ) = { -0.44954723, -0.17481936, 0.00000000 };
Point ( 1807 ) = { -0.44779776, -0.17189345, 0.00000000 };
Point ( 1808 ) = { -0.44603661, -0.16898816, 0.00000000 };
Point ( 1809 ) = { -0.44426391, -0.16610347, 0.00000000 };
Point ( 1810 ) = { -0.44247976, -0.16323940, 0.00000000 };
Point ( 1811 ) = { -0.44068428, -0.16039596, 0.00000000 };
Point ( 1812 ) = { -0.43887758, -0.15757315, 0.00000000 };
Point ( 1813 ) = { -0.43705979, -0.15477099, 0.00000000 };
Point ( 1814 ) = { -0.43523100, -0.15198947, 0.00000000 };
Point ( 1815 ) = { -0.43024615, -0.15024868, 0.00000000 };
Point ( 1816 ) = { -0.42710530, -0.15124592, 0.00000000 };
Point ( 1817 ) = { -0.42396888, -0.15222038, 0.00000000 };
Point ( 1818 ) = { -0.42215762, -0.14949385, 0.00000000 };
Point ( 1819 ) = { -0.42033551, -0.14678773, 0.00000000 };
Point ( 1820 ) = { -0.41850268, -0.14410203, 0.00000000 };
Point ( 1821 ) = { -0.41974426, -0.14044446, 0.00000000 };
Point ( 1822 ) = { -0.41787762, -0.13779537, 0.00000000 };
Point ( 1823 ) = { -0.41600065, -0.13516681, 0.00000000 };
Point ( 1824 ) = { -0.41716435, -0.13153141, 0.00000000 };
Point ( 1825 ) = { -0.41525449, -0.12893995, 0.00000000 };
Point ( 1826 ) = { -0.41333471, -0.12636910, 0.00000000 };
Point ( 1827 ) = { -0.41442174, -0.12275731, 0.00000000 };
Point ( 1828 ) = { -0.41547720, -0.11913617, 0.00000000 };
Point ( 1829 ) = { -0.41350340, -0.11662002, 0.00000000 };
Point ( 1830 ) = { -0.41152027, -0.11412467, 0.00000000 };
Point ( 1831 ) = { -0.40952792, -0.11165013, 0.00000000 };
Point ( 1832 ) = { -0.40752647, -0.10919639, 0.00000000 };
Point ( 1833 ) = { -0.40846386, -0.10563594, 0.00000000 };
Point ( 1834 ) = { -0.40643225, -0.10322064, 0.00000000 };
Point ( 1835 ) = { -0.40439195, -0.10082624, 0.00000000 };
Point ( 1836 ) = { -0.40234306, -0.09845272, 0.00000000 };
Point ( 1837 ) = { -0.40028569, -0.09610009, 0.00000000 };
Point ( 1838 ) = { -0.39821997, -0.09376836, 0.00000000 };
Point ( 1839 ) = { -0.39614599, -0.09145751, 0.00000000 };
Point ( 1840 ) = { -0.39692901, -0.08799704, 0.00000000 };
Point ( 1841 ) = { -0.39979580, -0.08680418, 0.00000000 };
Point ( 1842 ) = { -0.40478238, -0.08788687, 0.00000000 };
Point ( 1843 ) = { -0.40978701, -0.08897348, 0.00000000 };
Point ( 1844 ) = { -0.41190167, -0.09131640, 0.00000000 };
Point ( 1845 ) = { -0.41400825, -0.09368050, 0.00000000 };
Point ( 1846 ) = { -0.41610664, -0.09606579, 0.00000000 };
Point ( 1847 ) = { -0.41525248, -0.09969330, 0.00000000 };
Point ( 1848 ) = { -0.41732149, -0.10211792, 0.00000000 };
Point ( 1849 ) = { -0.42235155, -0.10334877, 0.00000000 };
Point ( 1850 ) = { -0.42441606, -0.10581881, 0.00000000 };
Point ( 1851 ) = { -0.42647181, -0.10831004, 0.00000000 };
Point ( 1852 ) = { -0.42851869, -0.11082247, 0.00000000 };
Point ( 1853 ) = { -0.43055659, -0.11335609, 0.00000000 };
Point ( 1854 ) = { -0.43258540, -0.11591091, 0.00000000 };
Point ( 1855 ) = { -0.43155743, -0.11968147, 0.00000000 };
Point ( 1856 ) = { -0.43355447, -0.12227501, 0.00000000 };
Point ( 1857 ) = { -0.43554201, -0.12488966, 0.00000000 };
Point ( 1858 ) = { -0.43443557, -0.12868568, 0.00000000 };
Point ( 1859 ) = { -0.43329605, -0.13247190, 0.00000000 };
Point ( 1860 ) = { -0.43522766, -0.13514178, 0.00000000 };
Point ( 1861 ) = { -0.43714918, -0.13783261, 0.00000000 };
Point ( 1862 ) = { -0.43592973, -0.14164216, 0.00000000 };
Point ( 1863 ) = { -0.43781729, -0.14437049, 0.00000000 };
Point ( 1864 ) = { -0.44285198, -0.14603068, 0.00000000 };
Point ( 1865 ) = { -0.44601357, -0.14491859, 0.00000000 };
Point ( 1866 ) = { -0.44410945, -0.14216056, 0.00000000 };
Point ( 1867 ) = { -0.44219497, -0.13942354, 0.00000000 };
Point ( 1868 ) = { -0.44027022, -0.13670754, 0.00000000 };
Point ( 1869 ) = { -0.43833533, -0.13401256, 0.00000000 };
Point ( 1870 ) = { -0.44144644, -0.13286030, 0.00000000 };
Point ( 1871 ) = { -0.44652286, -0.13438813, 0.00000000 };
Point ( 1872 ) = { -0.45161997, -0.13592218, 0.00000000 };
Point ( 1873 ) = { -0.45357564, -0.13867199, 0.00000000 };
Point ( 1874 ) = { -0.45552115, -0.14144308, 0.00000000 };
Point ( 1875 ) = { -0.45869763, -0.14023794, 0.00000000 };
Point ( 1876 ) = { -0.46187759, -0.13900938, 0.00000000 };
Point ( 1877 ) = { -0.46506095, -0.13775733, 0.00000000 };
Point ( 1878 ) = { -0.46824760, -0.13648173, 0.00000000 };
Point ( 1879 ) = { -0.47143745, -0.13518251, 0.00000000 };
Point ( 1880 ) = { -0.46942078, -0.13239035, 0.00000000 };
Point ( 1881 ) = { -0.46423330, -0.13092733, 0.00000000 };
Point ( 1882 ) = { -0.46107526, -0.13221120, 0.00000000 };
Point ( 1883 ) = { -0.45792029, -0.13347159, 0.00000000 };
Point ( 1884 ) = { -0.45592672, -0.13073488, 0.00000000 };
Point ( 1885 ) = { -0.45392336, -0.12801963, 0.00000000 };
Point ( 1886 ) = { -0.44880025, -0.12657476, 0.00000000 };
Point ( 1887 ) = { -0.44679141, -0.12390622, 0.00000000 };
Point ( 1888 ) = { -0.44785567, -0.12000256, 0.00000000 };
Point ( 1889 ) = { -0.44581428, -0.11737311, 0.00000000 };
Point ( 1890 ) = { -0.44376368, -0.11476509, 0.00000000 };
Point ( 1891 ) = { -0.44474829, -0.11088820, 0.00000000 };
Point ( 1892 ) = { -0.44266608, -0.10831970, 0.00000000 };
Point ( 1893 ) = { -0.44057508, -0.10577272, 0.00000000 };
Point ( 1894 ) = { -0.44148133, -0.10192400, 0.00000000 };
Point ( 1895 ) = { -0.43935968, -0.09941695, 0.00000000 };
Point ( 1896 ) = { -0.43722964, -0.09693148, 0.00000000 };
Point ( 1897 ) = { -0.43805886, -0.09311229, 0.00000000 };
Point ( 1898 ) = { -0.43589913, -0.09066715, 0.00000000 };
Point ( 1899 ) = { -0.43373142, -0.08824365, 0.00000000 };
Point ( 1900 ) = { -0.43155585, -0.08584180, 0.00000000 };
Point ( 1901 ) = { -0.42937254, -0.08346157, 0.00000000 };
Point ( 1902 ) = { -0.43008452, -0.07971145, 0.00000000 };
Point ( 1903 ) = { -0.42787307, -0.07737206, 0.00000000 };
Point ( 1904 ) = { -0.42277725, -0.07645058, 0.00000000 };
Point ( 1905 ) = { -0.41770049, -0.07553255, 0.00000000 };
Point ( 1906 ) = { -0.41549280, -0.07326259, 0.00000000 };
Point ( 1907 ) = { -0.41611631, -0.06963399, 0.00000000 };
Point ( 1908 ) = { -0.41670812, -0.06600008, 0.00000000 };
Point ( 1909 ) = { -0.41726821, -0.06236115, 0.00000000 };
Point ( 1910 ) = { -0.42008209, -0.06090900, 0.00000000 };
Point ( 1911 ) = { -0.42289592, -0.05943415, 0.00000000 };
Point ( 1912 ) = { -0.42339847, -0.05574147, 0.00000000 };
Point ( 1913 ) = { -0.42386878, -0.05204454, 0.00000000 };
Point ( 1914 ) = { -0.42665588, -0.05049805, 0.00000000 };
Point ( 1915 ) = { -0.42944232, -0.04892877, 0.00000000 };
Point ( 1916 ) = { -0.42985295, -0.04517937, 0.00000000 };
Point ( 1917 ) = { -0.43023084, -0.04142652, 0.00000000 };
Point ( 1918 ) = { -0.43057597, -0.03767052, 0.00000000 };
Point ( 1919 ) = { -0.43088831, -0.03391165, 0.00000000 };
Point ( 1920 ) = { -0.42845249, -0.03183952, 0.00000000 };
Point ( 1921 ) = { -0.42601168, -0.02978964, 0.00000000 };
Point ( 1922 ) = { -0.42871403, -0.02809940, 0.00000000 };
Point ( 1923 ) = { -0.43141452, -0.02638644, 0.00000000 };
Point ( 1924 ) = { -0.43411305, -0.02465073, 0.00000000 };
Point ( 1925 ) = { -0.43930285, -0.02494542, 0.00000000 };
Point ( 1926 ) = { -0.44451261, -0.02524126, 0.00000000 };
Point ( 1927 ) = { -0.44723160, -0.02343842, 0.00000000 };
Point ( 1928 ) = { -0.44741911, -0.01953474, 0.00000000 };
Point ( 1929 ) = { -0.45011986, -0.01768526, 0.00000000 };
Point ( 1930 ) = { -0.45281809, -0.01581276, 0.00000000 };
Point ( 1931 ) = { -0.45293884, -0.01186062, 0.00000000 };
Point ( 1932 ) = { -0.45302510, -0.00790758, 0.00000000 };
Point ( 1933 ) = { -0.45568721, -0.00596527, 0.00000000 };
Point ( 1934 ) = { -0.46096682, -0.00603439, 0.00000000 };
Point ( 1935 ) = { -0.46363665, -0.00404610, 0.00000000 };
Point ( 1936 ) = { -0.46630322, -0.00203464, 0.00000000 };
Point ( 1937 ) = { -0.46896642, 0.00000000, 0.00000000 };
Point ( 1938 ) = { -0.47162613, 0.00205787, 0.00000000 };
Point ( 1939 ) = { -0.47697099, 0.00208119, 0.00000000 };
Point ( 1940 ) = { -0.48233815, 0.00210461, 0.00000000 };
Point ( 1941 ) = { -0.48501634, 0.00423267, 0.00000000 };
Point ( 1942 ) = { -0.48769080, 0.00638422, 0.00000000 };
Point ( 1943 ) = { -0.49036142, 0.00855929, 0.00000000 };
Point ( 1944 ) = { -0.49302807, 0.01075791, 0.00000000 };
Point ( 1945 ) = { -0.49569066, 0.01298012, 0.00000000 };
Point ( 1946 ) = { -0.49834907, 0.01522594, 0.00000000 };
Point ( 1947 ) = { -0.50100318, 0.01749542, 0.00000000 };
Point ( 1948 ) = { -0.50083143, 0.02186677, 0.00000000 };
Point ( 1949 ) = { -0.50062154, 0.02623646, 0.00000000 };
Point ( 1950 ) = { -0.50037352, 0.03060416, 0.00000000 };
Point ( 1951 ) = { -0.50008740, 0.03496952, 0.00000000 };
Point ( 1952 ) = { -0.49976320, 0.03933222, 0.00000000 };
Point ( 1953 ) = { -0.50231037, 0.04173877, 0.00000000 };
Point ( 1954 ) = { -0.50485199, 0.04416883, 0.00000000 };
Point ( 1955 ) = { -0.50444732, 0.04857275, 0.00000000 };
Point ( 1956 ) = { -0.50400424, 0.05297298, 0.00000000 };
Point ( 1957 ) = { -0.50104564, 0.05487342, 0.00000000 };
Point ( 1958 ) = { -0.49808608, 0.05674974, 0.00000000 };
Point ( 1959 ) = { -0.49512567, 0.05860198, 0.00000000 };
Point ( 1960 ) = { -0.49216451, 0.06043020, 0.00000000 };
Point ( 1961 ) = { -0.49161842, 0.06472279, 0.00000000 };
Point ( 1962 ) = { -0.49103490, 0.06901045, 0.00000000 };
Point ( 1963 ) = { -0.49041398, 0.07329286, 0.00000000 };
Point ( 1964 ) = { -0.48740596, 0.07501895, 0.00000000 };
Point ( 1965 ) = { -0.48205612, 0.07419553, 0.00000000 };
Point ( 1966 ) = { -0.47906323, 0.07587616, 0.00000000 };
Point ( 1967 ) = { -0.47607053, 0.07753301, 0.00000000 };
Point ( 1968 ) = { -0.47077312, 0.07667027, 0.00000000 };
Point ( 1969 ) = { -0.46549771, 0.07581112, 0.00000000 };
Point ( 1970 ) = { -0.46319266, 0.07336251, 0.00000000 };
Point ( 1971 ) = { -0.46088054, 0.07093630, 0.00000000 };
Point ( 1972 ) = { -0.45564090, 0.07012984, 0.00000000 };
Point ( 1973 ) = { -0.45042229, 0.06932662, 0.00000000 };
Point ( 1974 ) = { -0.44522440, 0.06852659, 0.00000000 };
Point ( 1975 ) = { -0.44004690, 0.06772970, 0.00000000 };
Point ( 1976 ) = { -0.43488947, 0.06693589, 0.00000000 };
Point ( 1977 ) = { -0.43202374, 0.06842584, 0.00000000 };
Point ( 1978 ) = { -0.42915823, 0.06989286, 0.00000000 };
Point ( 1979 ) = { -0.42689934, 0.06761421, 0.00000000 };
Point ( 1980 ) = { -0.42747313, 0.06388629, 0.00000000 };
Point ( 1981 ) = { -0.42518779, 0.06164930, 0.00000000 };
Point ( 1982 ) = { -0.42289592, 0.05943415, 0.00000000 };
Point ( 1983 ) = { -0.42339847, 0.05574147, 0.00000000 };
Point ( 1984 ) = { -0.42386878, 0.05204454, 0.00000000 };
Point ( 1985 ) = { -0.42430681, 0.04834365, 0.00000000 };
Point ( 1986 ) = { -0.42471252, 0.04463908, 0.00000000 };
Point ( 1987 ) = { -0.42508590, 0.04093112, 0.00000000 };
Point ( 1988 ) = { -0.42783156, 0.03931220, 0.00000000 };
Point ( 1989 ) = { -0.43057597, 0.03767052, 0.00000000 };
Point ( 1990 ) = { -0.43088831, 0.03391165, 0.00000000 };
Point ( 1991 ) = { -0.43116783, 0.03015019, 0.00000000 };
Point ( 1992 ) = { -0.43141452, 0.02638644, 0.00000000 };
Point ( 1993 ) = { -0.43162836, 0.02262068, 0.00000000 };
Point ( 1994 ) = { -0.43180932, 0.01885320, 0.00000000 };
Point ( 1995 ) = { -0.43195740, 0.01508428, 0.00000000 };
Point ( 1996 ) = { -0.42943352, 0.01312038, 0.00000000 };
Point ( 1997 ) = { -0.42690562, 0.01117892, 0.00000000 };
Point ( 1998 ) = { -0.42437380, 0.00925987, 0.00000000 };
Point ( 1999 ) = { -0.41923501, 0.00914774, 0.00000000 };
Point ( 2000 ) = { -0.41411499, 0.00903602, 0.00000000 };
Point ( 2001 ) = { -0.40901344, 0.00892471, 0.00000000 };
Point ( 2002 ) = { -0.40393008, 0.00881379, 0.00000000 };
Point ( 2003 ) = { -0.40135309, 0.01050980, 0.00000000 };
Point ( 2004 ) = { -0.39877347, 0.01218363, 0.00000000 };
Point ( 2005 ) = { -0.39619133, 0.01383531, 0.00000000 };
Point ( 2006 ) = { -0.39360678, 0.01546485, 0.00000000 };
Point ( 2007 ) = { -0.38857892, 0.01526731, 0.00000000 };
Point ( 2008 ) = { -0.38600153, 0.01685319, 0.00000000 };
Point ( 2009 ) = { -0.38583976, 0.02022101, 0.00000000 };
Point ( 2010 ) = { -0.38564861, 0.02358728, 0.00000000 };
Point ( 2011 ) = { -0.38542809, 0.02695176, 0.00000000 };
Point ( 2012 ) = { -0.38517822, 0.03031418, 0.00000000 };
Point ( 2013 ) = { -0.38254565, 0.03178709, 0.00000000 };
Point ( 2014 ) = { -0.37756489, 0.03137322, 0.00000000 };
Point ( 2015 ) = { -0.37521312, 0.02952991, 0.00000000 };
Point ( 2016 ) = { -0.37545652, 0.02625448, 0.00000000 };
Point ( 2017 ) = { -0.37567134, 0.02297704, 0.00000000 };
Point ( 2018 ) = { -0.37585754, 0.01969786, 0.00000000 };
Point ( 2019 ) = { -0.37601512, 0.01641717, 0.00000000 };
Point ( 2020 ) = { -0.37614407, 0.01313524, 0.00000000 };
Point ( 2021 ) = { -0.37371030, 0.01141788, 0.00000000 };
Point ( 2022 ) = { -0.36874741, 0.01126625, 0.00000000 };
Point ( 2023 ) = { -0.36631731, 0.00959236, 0.00000000 };
Point ( 2024 ) = { -0.36883168, 0.00804794, 0.00000000 };
Point ( 2025 ) = { -0.37134350, 0.00648182, 0.00000000 };
Point ( 2026 ) = { -0.37138592, 0.00324104, 0.00000000 };
Point ( 2027 ) = { -0.37140007, 0.00000000, 0.00000000 };
Point ( 2028 ) = { -0.36891597, -0.00160971, 0.00000000 };
Point ( 2029 ) = { -0.36642892, -0.00319778, 0.00000000 };
Point ( 2030 ) = { -0.36638707, -0.00639531, 0.00000000 };
Point ( 2031 ) = { -0.36388362, -0.00793997, 0.00000000 };
Point ( 2032 ) = { -0.36137764, -0.00946301, 0.00000000 };
Point ( 2033 ) = { -0.35886923, -0.01096445, 0.00000000 };
Point ( 2034 ) = { -0.35395341, -0.01081425, 0.00000000 };
Point ( 2035 ) = { -0.35145100, -0.01227294, 0.00000000 };
Point ( 2036 ) = { -0.35133051, -0.01533942, 0.00000000 };
Point ( 2037 ) = { -0.35118328, -0.01840474, 0.00000000 };
Point ( 2038 ) = { -0.34865398, -0.01979801, 0.00000000 };
Point ( 2039 ) = { -0.34612298, -0.02116979, 0.00000000 };
Point ( 2040 ) = { -0.34592506, -0.02418944, 0.00000000 };
Point ( 2041 ) = { -0.34570080, -0.02720724, 0.00000000 };
Point ( 2042 ) = { -0.34314502, -0.02851315, 0.00000000 };
Point ( 2043 ) = { -0.34058813, -0.02979760, 0.00000000 };
Point ( 2044 ) = { -0.34031513, -0.03276862, 0.00000000 };
Point ( 2045 ) = { -0.33774630, -0.03400926, 0.00000000 };
Point ( 2046 ) = { -0.33547142, -0.03230222, 0.00000000 };
Point ( 2047 ) = { -0.33319167, -0.03061601, 0.00000000 };
Point ( 2048 ) = { -0.33064193, -0.03183720, 0.00000000 };
Point ( 2049 ) = { -0.33035151, -0.03472134, 0.00000000 };
Point ( 2050 ) = { -0.33003593, -0.03760284, 0.00000000 };
Point ( 2051 ) = { -0.32969522, -0.04048148, 0.00000000 };
Point ( 2052 ) = { -0.32711417, -0.04161418, 0.00000000 };
Point ( 2053 ) = { -0.32453301, -0.04272558, 0.00000000 };
Point ( 2054 ) = { -0.32414781, -0.04555600, 0.00000000 };
Point ( 2055 ) = { -0.32373792, -0.04838296, 0.00000000 };
Point ( 2056 ) = { -0.32113812, -0.04942788, 0.00000000 };
Point ( 2057 ) = { -0.31896693, -0.04766993, 0.00000000 };
Point ( 2058 ) = { -0.31678991, -0.04593235, 0.00000000 };
Point ( 2059 ) = { -0.31420934, -0.04695890, 0.00000000 };
Point ( 2060 ) = { -0.31162919, -0.04796432, 0.00000000 };
Point ( 2061 ) = { -0.30946493, -0.04624984, 0.00000000 };
Point ( 2062 ) = { -0.30729492, -0.04455564, 0.00000000 };
Point ( 2063 ) = { -0.30256679, -0.04387010, 0.00000000 };
Point ( 2064 ) = { -0.29785126, -0.04318638, 0.00000000 };
Point ( 2065 ) = { -0.29314810, -0.04250445, 0.00000000 };
Point ( 2066 ) = { -0.29061434, -0.04343260, 0.00000000 };
Point ( 2067 ) = { -0.29022426, -0.04596701, 0.00000000 };
Point ( 2068 ) = { -0.28981207, -0.04849791, 0.00000000 };
Point ( 2069 ) = { -0.28726339, -0.04936088, 0.00000000 };
Point ( 2070 ) = { -0.28471571, -0.05020306, 0.00000000 };
Point ( 2071 ) = { -0.28682171, -0.05186581, 0.00000000 };
Point ( 2072 ) = { -0.29148613, -0.05270928, 0.00000000 };
Point ( 2073 ) = { -0.29358823, -0.05441336, 0.00000000 };
Point ( 2074 ) = { -0.29568401, -0.05613736, 0.00000000 };
Point ( 2075 ) = { -0.29826712, -0.05528054, 0.00000000 };
Point ( 2076 ) = { -0.30085143, -0.05440280, 0.00000000 };
Point ( 2077 ) = { -0.30295840, -0.05615002, 0.00000000 };
Point ( 2078 ) = { -0.30505896, -0.05791725, 0.00000000 };
Point ( 2079 ) = { -0.30766232, -0.05702184, 0.00000000 };
Point ( 2080 ) = { -0.30814820, -0.05433484, 0.00000000 };
Point ( 2081 ) = { -0.31074463, -0.05339569, 0.00000000 };
Point ( 2082 ) = { -0.31547898, -0.05420920, 0.00000000 };
Point ( 2083 ) = { -0.31760977, -0.05600317, 0.00000000 };
Point ( 2084 ) = { -0.31710897, -0.05877267, 0.00000000 };
Point ( 2085 ) = { -0.31921748, -0.06060533, 0.00000000 };
Point ( 2086 ) = { -0.32131936, -0.06245816, 0.00000000 };
Point ( 2087 ) = { -0.31867646, -0.06338869, 0.00000000 };
Point ( 2088 ) = { -0.31603494, -0.06429804, 0.00000000 };
Point ( 2089 ) = { -0.31546181, -0.06705348, 0.00000000 };
Point ( 2090 ) = { -0.31486465, -0.06980381, 0.00000000 };
Point ( 2091 ) = { -0.31424352, -0.07254883, 0.00000000 };
Point ( 2092 ) = { -0.31359845, -0.07528833, 0.00000000 };
Point ( 2093 ) = { -0.31292951, -0.07802209, 0.00000000 };
Point ( 2094 ) = { -0.31492221, -0.07998005, 0.00000000 };
Point ( 2095 ) = { -0.31690706, -0.08195774, 0.00000000 };
Point ( 2096 ) = { -0.31421227, -0.08272519, 0.00000000 };
Point ( 2097 ) = { -0.31152017, -0.08347158, 0.00000000 };
Point ( 2098 ) = { -0.31077989, -0.08618689, 0.00000000 };
Point ( 2099 ) = { -0.31001595, -0.08889564, 0.00000000 };
Point ( 2100 ) = { -0.30731438, -0.08957397, 0.00000000 };
Point ( 2101 ) = { -0.30461606, -0.09023139, 0.00000000 };
Point ( 2102 ) = { -0.30381706, -0.09288620, 0.00000000 };
Point ( 2103 ) = { -0.30299491, -0.09553393, 0.00000000 };
Point ( 2104 ) = { -0.30214970, -0.09817439, 0.00000000 };
Point ( 2105 ) = { -0.30128147, -0.10080737, 0.00000000 };
Point ( 2106 ) = { -0.30311472, -0.10289358, 0.00000000 };
Point ( 2107 ) = { -0.30493864, -0.10499880, 0.00000000 };
Point ( 2108 ) = { -0.30401076, -0.10765585, 0.00000000 };
Point ( 2109 ) = { -0.30127282, -0.10816799, 0.00000000 };
Point ( 2110 ) = { -0.29853940, -0.10865945, 0.00000000 };
Point ( 2111 ) = { -0.29757981, -0.11126053, 0.00000000 };
Point ( 2112 ) = { -0.29484700, -0.11170754, 0.00000000 };
Point ( 2113 ) = { -0.29211908, -0.11213401, 0.00000000 };
Point ( 2114 ) = { -0.28939614, -0.11254000, 0.00000000 };
Point ( 2115 ) = { -0.28494340, -0.11080843, 0.00000000 };
Point ( 2116 ) = { -0.28319853, -0.10870973, 0.00000000 };
Point ( 2117 ) = { -0.28144375, -0.10662950, 0.00000000 };
Point ( 2118 ) = { -0.27875602, -0.10700441, 0.00000000 };
Point ( 2119 ) = { -0.27607331, -0.10735904, 0.00000000 };
Point ( 2120 ) = { -0.27339570, -0.10769343, 0.00000000 };
Point ( 2121 ) = { -0.27072330, -0.10800764, 0.00000000 };
Point ( 2122 ) = { -0.26805619, -0.10830173, 0.00000000 };
Point ( 2123 ) = { -0.26710088, -0.11063681, 0.00000000 };
Point ( 2124 ) = { -0.26879707, -0.11271597, 0.00000000 };
Point ( 2125 ) = { -0.27048293, -0.11481319, 0.00000000 };
Point ( 2126 ) = { -0.26947071, -0.11716920, 0.00000000 };
Point ( 2127 ) = { -0.26843797, -0.11951628, 0.00000000 };
Point ( 2128 ) = { -0.26575440, -0.11971363, 0.00000000 };
Point ( 2129 ) = { -0.26144356, -0.11777174, 0.00000000 };
Point ( 2130 ) = { -0.25979937, -0.11567013, 0.00000000 };
Point ( 2131 ) = { -0.25814454, -0.11358631, 0.00000000 };
Point ( 2132 ) = { -0.25647916, -0.11152031, 0.00000000 };
Point ( 2133 ) = { -0.25912592, -0.11132928, 0.00000000 };
Point ( 2134 ) = { -0.26177852, -0.11111839, 0.00000000 };
Point ( 2135 ) = { -0.26273823, -0.10882974, 0.00000000 };
Point ( 2136 ) = { -0.26367794, -0.10653280, 0.00000000 };
Point ( 2137 ) = { -0.26195139, -0.10450801, 0.00000000 };
Point ( 2138 ) = { -0.25931053, -0.10476826, 0.00000000 };
Point ( 2139 ) = { -0.25667510, -0.10500856, 0.00000000 };
Point ( 2140 ) = { -0.25404517, -0.10522895, 0.00000000 };
Point ( 2141 ) = { -0.25574896, -0.10724444, 0.00000000 };
Point ( 2142 ) = { -0.25744258, -0.10927789, 0.00000000 };
Point ( 2143 ) = { -0.25480335, -0.10947216, 0.00000000 };
Point ( 2144 ) = { -0.25216998, -0.10964663, 0.00000000 };
Point ( 2145 ) = { -0.25120354, -0.11184302, 0.00000000 };
Point ( 2146 ) = { -0.25021797, -0.11403090, 0.00000000 };
Point ( 2147 ) = { -0.24921335, -0.11621009, 0.00000000 };
Point ( 2148 ) = { -0.24658277, -0.11629599, 0.00000000 };
Point ( 2149 ) = { -0.24395875, -0.11636235, 0.00000000 };
Point ( 2150 ) = { -0.24293402, -0.11848684, 0.00000000 };
Point ( 2151 ) = { -0.24189079, -0.12060230, 0.00000000 };
Point ( 2152 ) = { -0.24345400, -0.12271092, 0.00000000 };
Point ( 2153 ) = { -0.24500586, -0.12483672, 0.00000000 };
Point ( 2154 ) = { -0.24390714, -0.12697002, 0.00000000 };
Point ( 2155 ) = { -0.24278985, -0.12909365, 0.00000000 };
Point ( 2156 ) = { -0.24015838, -0.12904175, 0.00000000 };
Point ( 2157 ) = { -0.23753448, -0.12897070, 0.00000000 };
Point ( 2158 ) = { -0.23639997, -0.13103864, 0.00000000 };
Point ( 2159 ) = { -0.23524745, -0.13309660, 0.00000000 };
Point ( 2160 ) = { -0.23407702, -0.13514443, 0.00000000 };
Point ( 2161 ) = { -0.23146403, -0.13498583, 0.00000000 };
Point ( 2162 ) = { -0.23002696, -0.13280613, 0.00000000 };
Point ( 2163 ) = { -0.23117714, -0.13079373, 0.00000000 };
Point ( 2164 ) = { -0.23230971, -0.12877138, 0.00000000 };
Point ( 2165 ) = { -0.23342460, -0.12673922, 0.00000000 };
Point ( 2166 ) = { -0.23191918, -0.12461467, 0.00000000 };
Point ( 2167 ) = { -0.23040207, -0.12250695, 0.00000000 };
Point ( 2168 ) = { -0.23299780, -0.12258607, 0.00000000 };
Point ( 2169 ) = { -0.23560095, -0.12264609, 0.00000000 };
Point ( 2170 ) = { -0.23666225, -0.12058544, 0.00000000 };
Point ( 2171 ) = { -0.23770554, -0.11851561, 0.00000000 };
Point ( 2172 ) = { -0.23873072, -0.11643675, 0.00000000 };
Point ( 2173 ) = { -0.23973771, -0.11434902, 0.00000000 };
Point ( 2174 ) = { -0.24072646, -0.11225259, 0.00000000 };
Point ( 2175 ) = { -0.24333623, -0.11217954, 0.00000000 };
Point ( 2176 ) = { -0.24595240, -0.11208696, 0.00000000 };
Point ( 2177 ) = { -0.24430590, -0.11005178, 0.00000000 };
Point ( 2178 ) = { -0.24264887, -0.10803424, 0.00000000 };
Point ( 2179 ) = { -0.24525697, -0.10791565, 0.00000000 };
Point ( 2180 ) = { -0.24787112, -0.10777743, 0.00000000 };
Point ( 2181 ) = { -0.24880221, -0.10561027, 0.00000000 };
Point ( 2182 ) = { -0.24710301, -0.10361889, 0.00000000 };
Point ( 2183 ) = { -0.24539373, -0.10164541, 0.00000000 };
Point ( 2184 ) = { -0.24627140, -0.09950010, 0.00000000 };
Point ( 2185 ) = { -0.24713031, -0.09734722, 0.00000000 };
Point ( 2186 ) = { -0.24537719, -0.09542197, 0.00000000 };
Point ( 2187 ) = { -0.24103362, -0.09373285, 0.00000000 };
Point ( 2188 ) = { -0.23669985, -0.09204754, 0.00000000 };
Point ( 2189 ) = { -0.23237566, -0.09036595, 0.00000000 };
Point ( 2190 ) = { -0.22806087, -0.08868802, 0.00000000 };
Point ( 2191 ) = { -0.22375529, -0.08701367, 0.00000000 };
Point ( 2192 ) = { -0.22122776, -0.08714393, 0.00000000 };
Point ( 2193 ) = { -0.22045887, -0.08907117, 0.00000000 };
Point ( 2194 ) = { -0.21793586, -0.08915991, 0.00000000 };
Point ( 2195 ) = { -0.21541849, -0.08922926, 0.00000000 };
Point ( 2196 ) = { -0.21463163, -0.09110572, 0.00000000 };
Point ( 2197 ) = { -0.21211966, -0.09113380, 0.00000000 };
Point ( 2198 ) = { -0.20961371, -0.09114263, 0.00000000 };
Point ( 2199 ) = { -0.20881036, -0.09296836, 0.00000000 };
Point ( 2200 ) = { -0.20631069, -0.09293619, 0.00000000 };
Point ( 2201 ) = { -0.20381737, -0.09288493, 0.00000000 };
Point ( 2202 ) = { -0.20299904, -0.09466001, 0.00000000 };
Point ( 2203 ) = { -0.20051288, -0.09456801, 0.00000000 };
Point ( 2204 ) = { -0.19637646, -0.09261715, 0.00000000 };
Point ( 2205 ) = { -0.19470922, -0.09079440, 0.00000000 };
Point ( 2206 ) = { -0.19549413, -0.08909181, 0.00000000 };
Point ( 2207 ) = { -0.19626414, -0.08738243, 0.00000000 };
Point ( 2208 ) = { -0.19701922, -0.08566639, 0.00000000 };
Point ( 2209 ) = { -0.19775929, -0.08394384, 0.00000000 };
Point ( 2210 ) = { -0.19848430, -0.08221489, 0.00000000 };
Point ( 2211 ) = { -0.20095454, -0.08221267, 0.00000000 };
Point ( 2212 ) = { -0.20343052, -0.08219126, 0.00000000 };
Point ( 2213 ) = { -0.20414001, -0.08041289, 0.00000000 };
Point ( 2214 ) = { -0.20662117, -0.08035058, 0.00000000 };
Point ( 2215 ) = { -0.21089185, -0.08201136, 0.00000000 };
Point ( 2216 ) = { -0.21338979, -0.08191266, 0.00000000 };
Point ( 2217 ) = { -0.21589297, -0.08179453, 0.00000000 };
Point ( 2218 ) = { -0.21840132, -0.08165691, 0.00000000 };
Point ( 2219 ) = { -0.21910559, -0.07974791, 0.00000000 };
Point ( 2220 ) = { -0.22161753, -0.07956882, 0.00000000 };
Point ( 2221 ) = { -0.22413428, -0.07937011, 0.00000000 };
Point ( 2222 ) = { -0.22481837, -0.07741117, 0.00000000 };
Point ( 2223 ) = { -0.22733781, -0.07717079, 0.00000000 };
Point ( 2224 ) = { -0.22986169, -0.07691064, 0.00000000 };
Point ( 2225 ) = { -0.23052410, -0.07490182, 0.00000000 };
Point ( 2226 ) = { -0.23304977, -0.07459982, 0.00000000 };
Point ( 2227 ) = { -0.23557951, -0.07427793, 0.00000000 };
Point ( 2228 ) = { -0.23811322, -0.07393612, 0.00000000 };
Point ( 2229 ) = { -0.24254417, -0.07531197, 0.00000000 };
Point ( 2230 ) = { -0.24698495, -0.07669087, 0.00000000 };
Point ( 2231 ) = { -0.24886908, -0.07846812, 0.00000000 };
Point ( 2232 ) = { -0.24817485, -0.08063690, 0.00000000 };
Point ( 2233 ) = { -0.25003491, -0.08244915, 0.00000000 };
Point ( 2234 ) = { -0.25188639, -0.08428001, 0.00000000 };
Point ( 2235 ) = { -0.25372916, -0.08612945, 0.00000000 };
Point ( 2236 ) = { -0.25816278, -0.08763446, 0.00000000 };
Point ( 2237 ) = { -0.26076673, -0.08725133, 0.00000000 };
Point ( 2238 ) = { -0.26337488, -0.08684801, 0.00000000 };
Point ( 2239 ) = { -0.26598713, -0.08642446, 0.00000000 };
Point ( 2240 ) = { -0.26673119, -0.08410002, 0.00000000 };
Point ( 2241 ) = { -0.26745494, -0.08176918, 0.00000000 };
Point ( 2242 ) = { -0.27006305, -0.08127975, 0.00000000 };
Point ( 2243 ) = { -0.27457917, -0.08263895, 0.00000000 };
Point ( 2244 ) = { -0.27910660, -0.08400155, 0.00000000 };
Point ( 2245 ) = { -0.28174145, -0.08345562, 0.00000000 };
Point ( 2246 ) = { -0.28437972, -0.08288913, 0.00000000 };
Point ( 2247 ) = { -0.28629218, -0.08480361, 0.00000000 };
Point ( 2248 ) = { -0.28819627, -0.08673723, 0.00000000 };
Point ( 2249 ) = { -0.29085479, -0.08615511, 0.00000000 };
Point ( 2250 ) = { -0.29159555, -0.08361368, 0.00000000 };
Point ( 2251 ) = { -0.29231410, -0.08106588, 0.00000000 };
Point ( 2252 ) = { -0.29301040, -0.07851190, 0.00000000 };
Point ( 2253 ) = { -0.29368438, -0.07595194, 0.00000000 };
Point ( 2254 ) = { -0.29632363, -0.07525661, 0.00000000 };
Point ( 2255 ) = { -0.30095420, -0.07643263, 0.00000000 };
Point ( 2256 ) = { -0.30360736, -0.07569782, 0.00000000 };
Point ( 2257 ) = { -0.30425638, -0.07304549, 0.00000000 };
Point ( 2258 ) = { -0.30488223, -0.07038761, 0.00000000 };
Point ( 2259 ) = { -0.30752425, -0.06958563, 0.00000000 };
Point ( 2260 ) = { -0.31016826, -0.06876265, 0.00000000 };
Point ( 2261 ) = { -0.31075651, -0.06605333, 0.00000000 };
Point ( 2262 ) = { -0.30869185, -0.06420800, 0.00000000 };
Point ( 2263 ) = { -0.30662029, -0.06238260, 0.00000000 };
Point ( 2264 ) = { -0.30454192, -0.06057716, 0.00000000 };
Point ( 2265 ) = { -0.30193230, -0.06142882, 0.00000000 };
Point ( 2266 ) = { -0.29932424, -0.06225953, 0.00000000 };
Point ( 2267 ) = { -0.29671783, -0.06306932, 0.00000000 };
Point ( 2268 ) = { -0.29615616, -0.06565624, 0.00000000 };
Point ( 2269 ) = { -0.29354472, -0.06642239, 0.00000000 };
Point ( 2270 ) = { -0.29151039, -0.06462630, 0.00000000 };
Point ( 2271 ) = { -0.28946904, -0.06284989, 0.00000000 };
Point ( 2272 ) = { -0.28742079, -0.06109317, 0.00000000 };
Point ( 2273 ) = { -0.28536573, -0.05935616, 0.00000000 };
Point ( 2274 ) = { -0.28073677, -0.05839333, 0.00000000 };
Point ( 2275 ) = { -0.27867668, -0.05669741, 0.00000000 };
Point ( 2276 ) = { -0.27661006, -0.05502116, 0.00000000 };
Point ( 2277 ) = { -0.27199583, -0.05410333, 0.00000000 };
Point ( 2278 ) = { -0.26992442, -0.05246799, 0.00000000 };
Point ( 2279 ) = { -0.26784672, -0.05085229, 0.00000000 };
Point ( 2280 ) = { -0.26576285, -0.04925623, 0.00000000 };
Point ( 2281 ) = { -0.26828029, -0.04851298, 0.00000000 };
Point ( 2282 ) = { -0.27289864, -0.04934811, 0.00000000 };
Point ( 2283 ) = { -0.27542652, -0.04856513, 0.00000000 };
Point ( 2284 ) = { -0.27583984, -0.04615976, 0.00000000 };
Point ( 2285 ) = { -0.27623215, -0.04375087, 0.00000000 };
Point ( 2286 ) = { -0.27874677, -0.04290323, 0.00000000 };
Point ( 2287 ) = { -0.28126208, -0.04203490, 0.00000000 };
Point ( 2288 ) = { -0.28161819, -0.03957886, 0.00000000 };
Point ( 2289 ) = { -0.28195285, -0.03711980, 0.00000000 };
Point ( 2290 ) = { -0.28445284, -0.03618697, 0.00000000 };
Point ( 2291 ) = { -0.28695295, -0.03523339, 0.00000000 };
Point ( 2292 ) = { -0.28475780, -0.03370331, 0.00000000 };
Point ( 2293 ) = { -0.28255774, -0.03219339, 0.00000000 };
Point ( 2294 ) = { -0.28282792, -0.02972641, 0.00000000 };
Point ( 2295 ) = { -0.28061014, -0.02825596, 0.00000000 };
Point ( 2296 ) = { -0.27592919, -0.02778461, 0.00000000 };
Point ( 2297 ) = { -0.27371057, -0.02635533, 0.00000000 };
Point ( 2298 ) = { -0.27148758, -0.02494620, 0.00000000 };
Point ( 2299 ) = { -0.26682513, -0.02451778, 0.00000000 };
Point ( 2300 ) = { -0.26460152, -0.02314963, 0.00000000 };
Point ( 2301 ) = { -0.26237380, -0.02180158, 0.00000000 };
Point ( 2302 ) = { -0.25772936, -0.02141566, 0.00000000 };
Point ( 2303 ) = { -0.25309540, -0.02103061, 0.00000000 };
Point ( 2304 ) = { -0.24847169, -0.02064640, 0.00000000 };
Point ( 2305 ) = { -0.24607202, -0.02152851, 0.00000000 };
Point ( 2306 ) = { -0.24587478, -0.02367505, 0.00000000 };
Point ( 2307 ) = { -0.24565882, -0.02581978, 0.00000000 };
Point ( 2308 ) = { -0.24324404, -0.02663955, 0.00000000 };
Point ( 2309 ) = { -0.24082928, -0.02743903, 0.00000000 };
Point ( 2310 ) = { -0.24058066, -0.02953959, 0.00000000 };
Point ( 2311 ) = { -0.23815932, -0.03029769, 0.00000000 };
Point ( 2312 ) = { -0.23573838, -0.03103555, 0.00000000 };
Point ( 2313 ) = { -0.23545857, -0.03309154, 0.00000000 };
Point ( 2314 ) = { -0.23303197, -0.03378803, 0.00000000 };
Point ( 2315 ) = { -0.23060616, -0.03446432, 0.00000000 };
Point ( 2316 ) = { -0.23029662, -0.03647540, 0.00000000 };
Point ( 2317 ) = { -0.22996955, -0.03848370, 0.00000000 };
Point ( 2318 ) = { -0.22753354, -0.03909741, 0.00000000 };
Point ( 2319 ) = { -0.22509889, -0.03969101, 0.00000000 };
Point ( 2320 ) = { -0.22474395, -0.04165383, 0.00000000 };
Point ( 2321 ) = { -0.22230583, -0.04220608, 0.00000000 };
Point ( 2322 ) = { -0.21986943, -0.04273829, 0.00000000 };
Point ( 2323 ) = { -0.21948810, -0.04465536, 0.00000000 };
Point ( 2324 ) = { -0.21704916, -0.04514629, 0.00000000 };
Point ( 2325 ) = { -0.21461231, -0.04561726, 0.00000000 };
Point ( 2326 ) = { -0.21217767, -0.04606829, 0.00000000 };
Point ( 2327 ) = { -0.20974534, -0.04649942, 0.00000000 };
Point ( 2328 ) = { -0.20731541, -0.04691069, 0.00000000 };
Point ( 2329 ) = { -0.20287149, -0.04590513, 0.00000000 };
Point ( 2330 ) = { -0.20045255, -0.04627812, 0.00000000 };
Point ( 2331 ) = { -0.20004107, -0.04802561, 0.00000000 };
Point ( 2332 ) = { -0.19762178, -0.04835774, 0.00000000 };
Point ( 2333 ) = { -0.19520539, -0.04867017, 0.00000000 };
Point ( 2334 ) = { -0.19477324, -0.05037178, 0.00000000 };
Point ( 2335 ) = { -0.19235740, -0.05064348, 0.00000000 };
Point ( 2336 ) = { -0.18994484, -0.05089557, 0.00000000 };
Point ( 2337 ) = { -0.18753566, -0.05112809, 0.00000000 };
Point ( 2338 ) = { -0.18317060, -0.04993804, 0.00000000 };
Point ( 2339 ) = { -0.17881276, -0.04874995, 0.00000000 };
Point ( 2340 ) = { -0.17642469, -0.04892690, 0.00000000 };
Point ( 2341 ) = { -0.17838053, -0.05030851, 0.00000000 };
Point ( 2342 ) = { -0.18032939, -0.05170862, 0.00000000 };
Point ( 2343 ) = { -0.17793472, -0.05186324, 0.00000000 };
Point ( 2344 ) = { -0.17554393, -0.05199848, 0.00000000 };
Point ( 2345 ) = { -0.17747536, -0.05341402, 0.00000000 };
Point ( 2346 ) = { -0.17939949, -0.05484793, 0.00000000 };
Point ( 2347 ) = { -0.17700248, -0.05496073, 0.00000000 };
Point ( 2348 ) = { -0.17269574, -0.05362345, 0.00000000 };
Point ( 2349 ) = { -0.17031224, -0.05369924, 0.00000000 };
Point ( 2350 ) = { -0.16983714, -0.05518343, 0.00000000 };
Point ( 2351 ) = { -0.16934912, -0.05666342, 0.00000000 };
Point ( 2352 ) = { -0.16696933, -0.05667845, 0.00000000 };
Point ( 2353 ) = { -0.16459431, -0.05667437, 0.00000000 };
Point ( 2354 ) = { -0.16409348, -0.05810855, 0.00000000 };
Point ( 2355 ) = { -0.16595473, -0.05958383, 0.00000000 };
Point ( 2356 ) = { -0.16780781, -0.06107705, 0.00000000 };
Point ( 2357 ) = { -0.16726843, -0.06253910, 0.00000000 };
Point ( 2358 ) = { -0.16671631, -0.06399640, 0.00000000 };
Point ( 2359 ) = { -0.16433813, -0.06390760, 0.00000000 };
Point ( 2360 ) = { -0.16196556, -0.06379993, 0.00000000 };
Point ( 2361 ) = { -0.16140264, -0.06521090, 0.00000000 };
Point ( 2362 ) = { -0.15903695, -0.06506373, 0.00000000 };
Point ( 2363 ) = { -0.15667721, -0.06489782, 0.00000000 };
Point ( 2364 ) = { -0.15610491, -0.06626260, 0.00000000 };
Point ( 2365 ) = { -0.15552072, -0.06762233, 0.00000000 };
Point ( 2366 ) = { -0.15317061, -0.06739668, 0.00000000 };
Point ( 2367 ) = { -0.15082697, -0.06715249, 0.00000000 };
Point ( 2368 ) = { -0.15257664, -0.06873076, 0.00000000 };
Point ( 2369 ) = { -0.15431686, -0.07032625, 0.00000000 };
Point ( 2370 ) = { -0.15369728, -0.07167022, 0.00000000 };
Point ( 2371 ) = { -0.15135388, -0.07138313, 0.00000000 };
Point ( 2372 ) = { -0.14901743, -0.07107767, 0.00000000 };
Point ( 2373 ) = { -0.14839150, -0.07237537, 0.00000000 };
Point ( 2374 ) = { -0.15008502, -0.07401374, 0.00000000 };
Point ( 2375 ) = { -0.15176851, -0.07566899, 0.00000000 };
Point ( 2376 ) = { -0.15110240, -0.07699052, 0.00000000 };
Point ( 2377 ) = { -0.14877045, -0.07662182, 0.00000000 };
Point ( 2378 ) = { -0.14644608, -0.07623500, 0.00000000 };
Point ( 2379 ) = { -0.14577524, -0.07751007, 0.00000000 };
Point ( 2380 ) = { -0.14741055, -0.07920655, 0.00000000 };
Point ( 2381 ) = { -0.14903524, -0.08091954, 0.00000000 };
Point ( 2382 ) = { -0.14832342, -0.08221702, 0.00000000 };
Point ( 2383 ) = { -0.14760030, -0.08350823, 0.00000000 };
Point ( 2384 ) = { -0.14686595, -0.08479309, 0.00000000 };
Point ( 2385 ) = { -0.14612040, -0.08607150, 0.00000000 };
Point ( 2386 ) = { -0.14767303, -0.08785622, 0.00000000 };
Point ( 2387 ) = { -0.14999098, -0.08835144, 0.00000000 };
Point ( 2388 ) = { -0.15075627, -0.08703918, 0.00000000 };
Point ( 2389 ) = { -0.15308688, -0.08749636, 0.00000000 };
Point ( 2390 ) = { -0.15465251, -0.08928867, 0.00000000 };
Point ( 2391 ) = { -0.15386745, -0.09063485, 0.00000000 };
Point ( 2392 ) = { -0.15307066, -0.09197413, 0.00000000 };
Point ( 2393 ) = { -0.15226221, -0.09330640, 0.00000000 };
Point ( 2394 ) = { -0.15144217, -0.09463157, 0.00000000 };
Point ( 2395 ) = { -0.15061060, -0.09594954, 0.00000000 };
Point ( 2396 ) = { -0.15208463, -0.09782412, 0.00000000 };
Point ( 2397 ) = { -0.15354662, -0.09971434, 0.00000000 };
Point ( 2398 ) = { -0.15267061, -0.10105047, 0.00000000 };
Point ( 2399 ) = { -0.15178298, -0.10237891, 0.00000000 };
Point ( 2400 ) = { -0.15088378, -0.10369955, 0.00000000 };
Point ( 2401 ) = { -0.14997310, -0.10501230, 0.00000000 };
Point ( 2402 ) = { -0.14905100, -0.10631704, 0.00000000 };
Point ( 2403 ) = { -0.14811754, -0.10761369, 0.00000000 };
Point ( 2404 ) = { -0.14717281, -0.10890215, 0.00000000 };
Point ( 2405 ) = { -0.14850362, -0.11089291, 0.00000000 };
Point ( 2406 ) = { -0.14982128, -0.11289843, 0.00000000 };
Point ( 2407 ) = { -0.14883036, -0.11420155, 0.00000000 };
Point ( 2408 ) = { -0.14782811, -0.11549598, 0.00000000 };
Point ( 2409 ) = { -0.14909708, -0.11753866, 0.00000000 };
Point ( 2410 ) = { -0.15035247, -0.11959575, 0.00000000 };
Point ( 2411 ) = { -0.14930308, -0.12090325, 0.00000000 };
Point ( 2412 ) = { -0.14824233, -0.12220155, 0.00000000 };
Point ( 2413 ) = { -0.14717029, -0.12349054, 0.00000000 };
Point ( 2414 ) = { -0.14835736, -0.12559378, 0.00000000 };
Point ( 2415 ) = { -0.14953031, -0.12771095, 0.00000000 };
Point ( 2416 ) = { -0.14841014, -0.12901097, 0.00000000 };
Point ( 2417 ) = { -0.14955024, -0.13115204, 0.00000000 };
Point ( 2418 ) = { -0.15296354, -0.13414542, 0.00000000 };
Point ( 2419 ) = { -0.15526284, -0.13496793, 0.00000000 };
Point ( 2420 ) = { -0.15757374, -0.13577422, 0.00000000 };
Point ( 2421 ) = { -0.15869836, -0.13795438, 0.00000000 };
Point ( 2422 ) = { -0.15748845, -0.13933401, 0.00000000 };
Point ( 2423 ) = { -0.15626655, -0.14070303, 0.00000000 };
Point ( 2424 ) = { -0.15503275, -0.14206134, 0.00000000 };
Point ( 2425 ) = { -0.15378714, -0.14340883, 0.00000000 };
Point ( 2426 ) = { -0.15252983, -0.14474540, 0.00000000 };
Point ( 2427 ) = { -0.15126089, -0.14607095, 0.00000000 };
Point ( 2428 ) = { -0.14899102, -0.14514062, 0.00000000 };
Point ( 2429 ) = { -0.14573328, -0.14196707, 0.00000000 };
Point ( 2430 ) = { -0.14471774, -0.13975230, 0.00000000 };
Point ( 2431 ) = { -0.14368713, -0.13755050, 0.00000000 };
Point ( 2432 ) = { -0.14145484, -0.13660135, 0.00000000 };
Point ( 2433 ) = { -0.13923499, -0.13563673, 0.00000000 };
Point ( 2434 ) = { -0.13819753, -0.13345580, 0.00000000 };
Point ( 2435 ) = { -0.13714508, -0.13128786, 0.00000000 };
Point ( 2436 ) = { -0.13494568, -0.13031552, 0.00000000 };
Point ( 2437 ) = { -0.13380333, -0.13148817, 0.00000000 };
Point ( 2438 ) = { -0.13265080, -0.13265080, 0.00000000 };
Point ( 2439 ) = { -0.13148817, -0.13380333, 0.00000000 };
Point ( 2440 ) = { -0.13247966, -0.13599417, 0.00000000 };
Point ( 2441 ) = { -0.13345580, -0.13819753, 0.00000000 };
Point ( 2442 ) = { -0.13224473, -0.13935687, 0.00000000 };
Point ( 2443 ) = { -0.13318608, -0.14158097, 0.00000000 };
Point ( 2444 ) = { -0.13536174, -0.14264151, 0.00000000 };
Point ( 2445 ) = { -0.13660135, -0.14145484, 0.00000000 };
Point ( 2446 ) = { -0.13783056, -0.14025740, 0.00000000 };
Point ( 2447 ) = { -0.14003724, -0.14126465, 0.00000000 };
Point ( 2448 ) = { -0.14100986, -0.14349268, 0.00000000 };
Point ( 2449 ) = { -0.14196707, -0.14573328, 0.00000000 };
Point ( 2450 ) = { -0.14290879, -0.14798638, 0.00000000 };
Point ( 2451 ) = { -0.14161194, -0.14922784, 0.00000000 };
Point ( 2452 ) = { -0.14030430, -0.15045794, 0.00000000 };
Point ( 2453 ) = { -0.13898598, -0.15167659, 0.00000000 };
Point ( 2454 ) = { -0.13679457, -0.15059908, 0.00000000 };
Point ( 2455 ) = { -0.13374207, -0.14723854, 0.00000000 };
Point ( 2456 ) = { -0.13158143, -0.14613599, 0.00000000 };
Point ( 2457 ) = { -0.13030116, -0.14727867, 0.00000000 };
Point ( 2458 ) = { -0.12901097, -0.14841014, 0.00000000 };
Point ( 2459 ) = { -0.12771095, -0.14953031, 0.00000000 };
Point ( 2460 ) = { -0.12559378, -0.14835736, 0.00000000 };
Point ( 2461 ) = { -0.12349054, -0.14717029, 0.00000000 };
Point ( 2462 ) = { -0.12220155, -0.14824233, 0.00000000 };
Point ( 2463 ) = { -0.12090325, -0.14930308, 0.00000000 };
Point ( 2464 ) = { -0.11959575, -0.15035247, 0.00000000 };
Point ( 2465 ) = { -0.11753866, -0.14909708, 0.00000000 };
Point ( 2466 ) = { -0.11549598, -0.14782811, 0.00000000 };
Point ( 2467 ) = { -0.11420155, -0.14883036, 0.00000000 };
Point ( 2468 ) = { -0.11289843, -0.14982128, 0.00000000 };
Point ( 2469 ) = { -0.11158671, -0.15080079, 0.00000000 };
Point ( 2470 ) = { -0.11226364, -0.15310829, 0.00000000 };
Point ( 2471 ) = { -0.11292364, -0.15542606, 0.00000000 };
Point ( 2472 ) = { -0.11156301, -0.15640557, 0.00000000 };
Point ( 2473 ) = { -0.11019388, -0.15737317, 0.00000000 };
Point ( 2474 ) = { -0.10821727, -0.15599455, 0.00000000 };
Point ( 2475 ) = { -0.10625586, -0.15460324, 0.00000000 };
Point ( 2476 ) = { -0.10490267, -0.15552460, 0.00000000 };
Point ( 2477 ) = { -0.10354148, -0.15643412, 0.00000000 };
Point ( 2478 ) = { -0.10217241, -0.15733172, 0.00000000 };
Point ( 2479 ) = { -0.10079556, -0.15821734, 0.00000000 };
Point ( 2480 ) = { -0.09941103, -0.15909091, 0.00000000 };
Point ( 2481 ) = { -0.09801894, -0.15995237, 0.00000000 };
Point ( 2482 ) = { -0.09661937, -0.16080164, 0.00000000 };
Point ( 2483 ) = { -0.09707203, -0.16316341, 0.00000000 };
Point ( 2484 ) = { -0.09750684, -0.16553376, 0.00000000 };
Point ( 2485 ) = { -0.09564448, -0.16400430, 0.00000000 };
Point ( 2486 ) = { -0.09379828, -0.16246339, 0.00000000 };
Point ( 2487 ) = { -0.09237697, -0.16327574, 0.00000000 };
Point ( 2488 ) = { -0.09056059, -0.16170758, 0.00000000 };
Point ( 2489 ) = { -0.09015456, -0.15934764, 0.00000000 };
Point ( 2490 ) = { -0.08973056, -0.15699592, 0.00000000 };
Point ( 2491 ) = { -0.08928867, -0.15465251, 0.00000000 };
Point ( 2492 ) = { -0.09063485, -0.15386745, 0.00000000 };
Point ( 2493 ) = { -0.09197413, -0.15307066, 0.00000000 };
Point ( 2494 ) = { -0.09147372, -0.15074403, 0.00000000 };
Point ( 2495 ) = { -0.08965698, -0.14921427, 0.00000000 };
Point ( 2496 ) = { -0.08835144, -0.14999098, 0.00000000 };
Point ( 2497 ) = { -0.08703918, -0.15075627, 0.00000000 };
Point ( 2498 ) = { -0.08749636, -0.15308688, 0.00000000 };
Point ( 2499 ) = { -0.08793569, -0.15542581, 0.00000000 };
Point ( 2500 ) = { -0.08657601, -0.15618726, 0.00000000 };
Point ( 2501 ) = { -0.08520974, -0.15693682, 0.00000000 };
Point ( 2502 ) = { -0.08383698, -0.15767443, 0.00000000 };
Point ( 2503 ) = { -0.08245784, -0.15840004, 0.00000000 };
Point ( 2504 ) = { -0.08107242, -0.15911358, 0.00000000 };
Point ( 2505 ) = { -0.07968082, -0.15981500, 0.00000000 };
Point ( 2506 ) = { -0.07828315, -0.16050425, 0.00000000 };
Point ( 2507 ) = { -0.07856050, -0.16287277, 0.00000000 };
Point ( 2508 ) = { -0.07881941, -0.16524834, 0.00000000 };
Point ( 2509 ) = { -0.07737437, -0.16592987, 0.00000000 };
Point ( 2510 ) = { -0.07592343, -0.16659876, 0.00000000 };
Point ( 2511 ) = { -0.07446671, -0.16725496, 0.00000000 };
Point ( 2512 ) = { -0.07464469, -0.16964296, 0.00000000 };
Point ( 2513 ) = { -0.07480396, -0.17203732, 0.00000000 };
Point ( 2514 ) = { -0.07329982, -0.17268355, 0.00000000 };
Point ( 2515 ) = { -0.07179010, -0.17331663, 0.00000000 };
Point ( 2516 ) = { -0.07188869, -0.17571936, 0.00000000 };
Point ( 2517 ) = { -0.07196836, -0.17812794, 0.00000000 };
Point ( 2518 ) = { -0.07041118, -0.17874919, 0.00000000 };
Point ( 2519 ) = { -0.06881101, -0.17694722, 0.00000000 };
Point ( 2520 ) = { -0.06875437, -0.17454314, 0.00000000 };
Point ( 2521 ) = { -0.06867876, -0.17214468, 0.00000000 };
Point ( 2522 ) = { -0.06858423, -0.16975193, 0.00000000 };
Point ( 2523 ) = { -0.06847082, -0.16736499, 0.00000000 };
Point ( 2524 ) = { -0.06833859, -0.16498395, 0.00000000 };
Point ( 2525 ) = { -0.06992873, -0.16676110, 0.00000000 };
Point ( 2526 ) = { -0.07153636, -0.16852911, 0.00000000 };
Point ( 2527 ) = { -0.07138132, -0.16614452, 0.00000000 };
Point ( 2528 ) = { -0.06977573, -0.16438131, 0.00000000 };
Point ( 2529 ) = { -0.06818758, -0.16260891, 0.00000000 };
Point ( 2530 ) = { -0.06644910, -0.15846311, 0.00000000 };
Point ( 2531 ) = { -0.06626260, -0.15610491, 0.00000000 };
Point ( 2532 ) = { -0.06605747, -0.15375292, 0.00000000 };
Point ( 2533 ) = { -0.06450997, -0.15197597, 0.00000000 };
Point ( 2534 ) = { -0.06318129, -0.15253313, 0.00000000 };
Point ( 2535 ) = { -0.06166684, -0.15073384, 0.00000000 };
Point ( 2536 ) = { -0.06016991, -0.14892576, 0.00000000 };
Point ( 2537 ) = { -0.05886802, -0.14944516, 0.00000000 };
Point ( 2538 ) = { -0.05740455, -0.14761554, 0.00000000 };
Point ( 2539 ) = { -0.05578455, -0.14344973, 0.00000000 };
Point ( 2540 ) = { -0.05435801, -0.14160746, 0.00000000 };
Point ( 2541 ) = { -0.05312020, -0.14207643, 0.00000000 };
Point ( 2542 ) = { -0.05187834, -0.14253457, 0.00000000 };
Point ( 2543 ) = { -0.05063253, -0.14298186, 0.00000000 };
Point ( 2544 ) = { -0.04938287, -0.14341826, 0.00000000 };
Point ( 2545 ) = { -0.04812944, -0.14384374, 0.00000000 };
Point ( 2546 ) = { -0.04687235, -0.14425827, 0.00000000 };
Point ( 2547 ) = { -0.04561169, -0.14466181, 0.00000000 };
Point ( 2548 ) = { -0.04564211, -0.14699163, 0.00000000 };
Point ( 2549 ) = { -0.04696757, -0.15126030, 0.00000000 };
Point ( 2550 ) = { -0.04829985, -0.15318755, 0.00000000 };
Point ( 2551 ) = { -0.04963481, -0.15276023, 0.00000000 };
Point ( 2552 ) = { -0.05100196, -0.15466832, 0.00000000 };
Point ( 2553 ) = { -0.05101891, -0.15702007, 0.00000000 };
Point ( 2554 ) = { -0.04964673, -0.15745931, 0.00000000 };
Point ( 2555 ) = { -0.04962404, -0.15981553, 0.00000000 };
Point ( 2556 ) = { -0.05095516, -0.16410244, 0.00000000 };
Point ( 2557 ) = { -0.05228828, -0.16839578, 0.00000000 };
Point ( 2558 ) = { -0.05362345, -0.17269574, 0.00000000 };
Point ( 2559 ) = { -0.05496073, -0.17700248, 0.00000000 };
Point ( 2560 ) = { -0.05484793, -0.17939949, 0.00000000 };
Point ( 2561 ) = { -0.05328030, -0.17987129, 0.00000000 };
Point ( 2562 ) = { -0.05312720, -0.18227116, 0.00000000 };
Point ( 2563 ) = { -0.05456422, -0.18420574, 0.00000000 };
Point ( 2564 ) = { -0.05601968, -0.18613302, 0.00000000 };
Point ( 2565 ) = { -0.05749354, -0.18805290, 0.00000000 };
Point ( 2566 ) = { -0.05898579, -0.18996528, 0.00000000 };
Point ( 2567 ) = { -0.06049639, -0.19187005, 0.00000000 };
Point ( 2568 ) = { -0.06216845, -0.19133482, 0.00000000 };
Point ( 2569 ) = { -0.06371390, -0.19321847, 0.00000000 };
Point ( 2570 ) = { -0.06527759, -0.19509415, 0.00000000 };
Point ( 2571 ) = { -0.06697760, -0.19451707, 0.00000000 };
Point ( 2572 ) = { -0.06867251, -0.19392518, 0.00000000 };
Point ( 2573 ) = { -0.07028678, -0.19576489, 0.00000000 };
Point ( 2574 ) = { -0.07019203, -0.19821619, 0.00000000 };
Point ( 2575 ) = { -0.06845962, -0.19882117, 0.00000000 };
Point ( 2576 ) = { -0.06672199, -0.19941102, 0.00000000 };
Point ( 2577 ) = { -0.06497929, -0.19998568, 0.00000000 };
Point ( 2578 ) = { -0.06341187, -0.19809861, 0.00000000 };
Point ( 2579 ) = { -0.06186278, -0.19620369, 0.00000000 };
Point ( 2580 ) = { -0.06014825, -0.19673606, 0.00000000 };
Point ( 2581 ) = { -0.05842914, -0.19725346, 0.00000000 };
Point ( 2582 ) = { -0.05693186, -0.19532435, 0.00000000 };
Point ( 2583 ) = { -0.05545309, -0.19338791, 0.00000000 };
Point ( 2584 ) = { -0.05399286, -0.19144425, 0.00000000 };
Point ( 2585 ) = { -0.05255119, -0.18949346, 0.00000000 };
Point ( 2586 ) = { -0.05112809, -0.18753566, 0.00000000 };
Point ( 2587 ) = { -0.05134108, -0.18512996, 0.00000000 };
Point ( 2588 ) = { -0.05153458, -0.18272784, 0.00000000 };
Point ( 2589 ) = { -0.05013300, -0.18077376, 0.00000000 };
Point ( 2590 ) = { -0.04855356, -0.18120437, 0.00000000 };
Point ( 2591 ) = { -0.04697043, -0.18162117, 0.00000000 };
Point ( 2592 ) = { -0.04538372, -0.18202414, 0.00000000 };
Point ( 2593 ) = { -0.04379355, -0.18241326, 0.00000000 };
Point ( 2594 ) = { -0.04247978, -0.18040518, 0.00000000 };
Point ( 2595 ) = { -0.04273996, -0.17802474, 0.00000000 };
Point ( 2596 ) = { -0.04429187, -0.17764499, 0.00000000 };
Point ( 2597 ) = { -0.04584041, -0.17725171, 0.00000000 };
Point ( 2598 ) = { -0.04738546, -0.17684494, 0.00000000 };
Point ( 2599 ) = { -0.04892690, -0.17642469, 0.00000000 };
Point ( 2600 ) = { -0.05046461, -0.17599101, 0.00000000 };
Point ( 2601 ) = { -0.05060133, -0.17360529, 0.00000000 };
Point ( 2602 ) = { -0.04934141, -0.16928269, 0.00000000 };
Point ( 2603 ) = { -0.04798250, -0.16733485, 0.00000000 };
Point ( 2604 ) = { -0.04664200, -0.16538006, 0.00000000 };
Point ( 2605 ) = { -0.04674429, -0.16301671, 0.00000000 };
Point ( 2606 ) = { -0.04682732, -0.16065725, 0.00000000 };
Point ( 2607 ) = { -0.04689112, -0.15830178, 0.00000000 };
Point ( 2608 ) = { -0.04693574, -0.15595040, 0.00000000 };
Point ( 2609 ) = { -0.04561900, -0.15400717, 0.00000000 };
Point ( 2610 ) = { -0.04427331, -0.15439940, 0.00000000 };
Point ( 2611 ) = { -0.04299194, -0.15243793, 0.00000000 };
Point ( 2612 ) = { -0.04172896, -0.15046976, 0.00000000 };
Point ( 2613 ) = { -0.04041429, -0.15082818, 0.00000000 };
Point ( 2614 ) = { -0.03918699, -0.14884261, 0.00000000 };
Point ( 2615 ) = { -0.03797817, -0.14685069, 0.00000000 };
Point ( 2616 ) = { -0.03788662, -0.14917891, 0.00000000 };
Point ( 2617 ) = { -0.03909654, -0.15117511, 0.00000000 };
Point ( 2618 ) = { -0.04032499, -0.15316503, 0.00000000 };
Point ( 2619 ) = { -0.04021644, -0.15550543, 0.00000000 };
Point ( 2620 ) = { -0.04008861, -0.15784928, 0.00000000 };
Point ( 2621 ) = { -0.03994147, -0.16019647, 0.00000000 };
Point ( 2622 ) = { -0.03870961, -0.15819310, 0.00000000 };
Point ( 2623 ) = { -0.03764575, -0.15384547, 0.00000000 };
Point ( 2624 ) = { -0.03645222, -0.15183442, 0.00000000 };
Point ( 2625 ) = { -0.03512584, -0.15214674, 0.00000000 };
Point ( 2626 ) = { -0.03396858, -0.15011954, 0.00000000 };
Point ( 2627 ) = { -0.03283002, -0.14808665, 0.00000000 };
Point ( 2628 ) = { -0.03153649, -0.14836750, 0.00000000 };
Point ( 2629 ) = { -0.03134346, -0.15068951, 0.00000000 };
Point ( 2630 ) = { -0.03113107, -0.15301409, 0.00000000 };
Point ( 2631 ) = { -0.02979460, -0.15327993, 0.00000000 };
Point ( 2632 ) = { -0.02845586, -0.15353409, 0.00000000 };
Point ( 2633 ) = { -0.02711496, -0.15377657, 0.00000000 };
Point ( 2634 ) = { -0.02577199, -0.15400733, 0.00000000 };
Point ( 2635 ) = { -0.02474065, -0.15191327, 0.00000000 };
Point ( 2636 ) = { -0.02402314, -0.14750760, 0.00000000 };
Point ( 2637 ) = { -0.02429853, -0.14520228, 0.00000000 };
Point ( 2638 ) = { -0.02455451, -0.14289883, 0.00000000 };
Point ( 2639 ) = { -0.02356323, -0.14080832, 0.00000000 };
Point ( 2640 ) = { -0.02233357, -0.14100858, 0.00000000 };
Point ( 2641 ) = { -0.02110220, -0.14119811, 0.00000000 };
Point ( 2642 ) = { -0.01986923, -0.14137688, 0.00000000 };
Point ( 2643 ) = { -0.01863474, -0.14154489, 0.00000000 };
Point ( 2644 ) = { -0.01739883, -0.14170212, 0.00000000 };
Point ( 2645 ) = { -0.01616160, -0.14184855, 0.00000000 };
Point ( 2646 ) = { -0.01530024, -0.13970551, 0.00000000 };
Point ( 2647 ) = { -0.01445804, -0.13755905, 0.00000000 };
Point ( 2648 ) = { -0.01408051, -0.13983371, 0.00000000 };
Point ( 2649 ) = { -0.01368354, -0.14210901, 0.00000000 };
Point ( 2650 ) = { -0.01244290, -0.14222300, 0.00000000 };
Point ( 2651 ) = { -0.01120131, -0.14232617, 0.00000000 };
Point ( 2652 ) = { -0.00995887, -0.14241850, 0.00000000 };
Point ( 2653 ) = { -0.00871567, -0.14249999, 0.00000000 };
Point ( 2654 ) = { -0.00796765, -0.14031480, 0.00000000 };
Point ( 2655 ) = { -0.00771555, -0.13587514, 0.00000000 };
Point ( 2656 ) = { -0.00700635, -0.13368915, 0.00000000 };
Point ( 2657 ) = { -0.00583944, -0.13374520, 0.00000000 };
Point ( 2658 ) = { -0.00516865, -0.13155100, 0.00000000 };
Point ( 2659 ) = { -0.00451717, -0.12935481, 0.00000000 };
Point ( 2660 ) = { -0.00338818, -0.12938930, 0.00000000 };
Point ( 2661 ) = { -0.00225893, -0.12941394, 0.00000000 };
Point ( 2662 ) = { -0.00112951, -0.12942873, 0.00000000 };
Point ( 2663 ) = { -0.00055508, -0.12721486, 0.00000000 };
Point ( 2664 ) = { -0.00000000, -0.12499971, 0.00000000 };
Point ( 2665 ) = { 0.00109081, -0.12499495, 0.00000000 };
Point ( 2666 ) = { 0.00218155, -0.12498067, 0.00000000 };
Point ( 2667 ) = { 0.00327211, -0.12495688, 0.00000000 };
Point ( 2668 ) = { 0.00436243, -0.12492356, 0.00000000 };
Point ( 2669 ) = { 0.00545241, -0.12488074, 0.00000000 };
Point ( 2670 ) = { 0.00589097, -0.12264316, 0.00000000 };
Point ( 2671 ) = { 0.00631018, -0.12040536, 0.00000000 };
Point ( 2672 ) = { 0.00736066, -0.12034571, 0.00000000 };
Point ( 2673 ) = { 0.00841058, -0.12027689, 0.00000000 };
Point ( 2674 ) = { 0.00945986, -0.12019892, 0.00000000 };
Point ( 2675 ) = { 0.01050842, -0.12011179, 0.00000000 };
Point ( 2676 ) = { 0.01155618, -0.12001551, 0.00000000 };
Point ( 2677 ) = { 0.01260306, -0.11991010, 0.00000000 };
Point ( 2678 ) = { 0.01336717, -0.12205477, 0.00000000 };
Point ( 2679 ) = { 0.01415037, -0.12419619, 0.00000000 };
Point ( 2680 ) = { 0.01523363, -0.12406798, 0.00000000 };
Point ( 2681 ) = { 0.01631574, -0.12393032, 0.00000000 };
Point ( 2682 ) = { 0.01655761, -0.12166303, 0.00000000 };
Point ( 2683 ) = { 0.01678018, -0.11939721, 0.00000000 };
Point ( 2684 ) = { 0.01782147, -0.11924623, 0.00000000 };
Point ( 2685 ) = { 0.01800499, -0.11698029, 0.00000000 };
Point ( 2686 ) = { 0.01816926, -0.11471619, 0.00000000 };
Point ( 2687 ) = { 0.01902514, -0.11681872, 0.00000000 };
Point ( 2688 ) = { 0.01989989, -0.11891704, 0.00000000 };
Point ( 2689 ) = { 0.02093686, -0.11873886, 0.00000000 };
Point ( 2690 ) = { 0.02197225, -0.11855163, 0.00000000 };
Point ( 2691 ) = { 0.02207657, -0.11628067, 0.00000000 };
Point ( 2692 ) = { 0.02216173, -0.11401221, 0.00000000 };
Point ( 2693 ) = { 0.02222773, -0.11174637, 0.00000000 };
Point ( 2694 ) = { 0.02227462, -0.10948324, 0.00000000 };
Point ( 2695 ) = { 0.02322918, -0.10928469, 0.00000000 };
Point ( 2696 ) = { 0.02418197, -0.10907782, 0.00000000 };
Point ( 2697 ) = { 0.02417030, -0.10681736, 0.00000000 };
Point ( 2698 ) = { 0.02413961, -0.10456015, 0.00000000 };
Point ( 2699 ) = { 0.02505114, -0.10434551, 0.00000000 };
Point ( 2700 ) = { 0.02596076, -0.10412293, 0.00000000 };
Point ( 2701 ) = { 0.02686841, -0.10389241, 0.00000000 };
Point ( 2702 ) = { 0.02777400, -0.10365399, 0.00000000 };
Point ( 2703 ) = { 0.02867749, -0.10340767, 0.00000000 };
Point ( 2704 ) = { 0.02972756, -0.10540599, 0.00000000 };
Point ( 2705 ) = { 0.03079591, -0.10739809, 0.00000000 };
Point ( 2706 ) = { 0.03173195, -0.10712526, 0.00000000 };
Point ( 2707 ) = { 0.03266557, -0.10684427, 0.00000000 };
Point ( 2708 ) = { 0.03378664, -0.10881078, 0.00000000 };
Point ( 2709 ) = { 0.03492582, -0.11077055, 0.00000000 };
Point ( 2710 ) = { 0.03589113, -0.11046155, 0.00000000 };
Point ( 2711 ) = { 0.03685371, -0.11014414, 0.00000000 };
Point ( 2712 ) = { 0.03781349, -0.10981834, 0.00000000 };
Point ( 2713 ) = { 0.03877038, -0.10948417, 0.00000000 };
Point ( 2714 ) = { 0.03972432, -0.10914167, 0.00000000 };
Point ( 2715 ) = { 0.04067524, -0.10879086, 0.00000000 };
Point ( 2716 ) = { 0.04162306, -0.10843177, 0.00000000 };
Point ( 2717 ) = { 0.04256770, -0.10806441, 0.00000000 };
Point ( 2718 ) = { 0.04350911, -0.10768883, 0.00000000 };
Point ( 2719 ) = { 0.04444720, -0.10730504, 0.00000000 };
Point ( 2720 ) = { 0.04577026, -0.10914968, 0.00000000 };
Point ( 2721 ) = { 0.04711069, -0.11098582, 0.00000000 };
Point ( 2722 ) = { 0.04807741, -0.11057048, 0.00000000 };
Point ( 2723 ) = { 0.04945108, -0.11238612, 0.00000000 };
Point ( 2724 ) = { 0.05123585, -0.11644233, 0.00000000 };
Point ( 2725 ) = { 0.05161155, -0.11869844, 0.00000000 };
Point ( 2726 ) = { 0.05057376, -0.11914431, 0.00000000 };
Point ( 2727 ) = { 0.05091146, -0.12141006, 0.00000000 };
Point ( 2728 ) = { 0.05230820, -0.12323039, 0.00000000 };
Point ( 2729 ) = { 0.05372228, -0.12504200, 0.00000000 };
Point ( 2730 ) = { 0.05404466, -0.12732125, 0.00000000 };
Point ( 2731 ) = { 0.05293153, -0.12778802, 0.00000000 };
Point ( 2732 ) = { 0.05181437, -0.12824507, 0.00000000 };
Point ( 2733 ) = { 0.05207845, -0.13053567, 0.00000000 };
Point ( 2734 ) = { 0.05348119, -0.13237058, 0.00000000 };
Point ( 2735 ) = { 0.05463429, -0.13189884, 0.00000000 };
Point ( 2736 ) = { 0.05578323, -0.13141705, 0.00000000 };
Point ( 2737 ) = { 0.05723514, -0.13321839, 0.00000000 };
Point ( 2738 ) = { 0.05870437, -0.13501081, 0.00000000 };
Point ( 2739 ) = { 0.05839549, -0.13271385, 0.00000000 };
Point ( 2740 ) = { 0.05806827, -0.13042348, 0.00000000 };
Point ( 2741 ) = { 0.05920421, -0.12991178, 0.00000000 };
Point ( 2742 ) = { 0.06033563, -0.12939019, 0.00000000 };
Point ( 2743 ) = { 0.06146247, -0.12885874, 0.00000000 };
Point ( 2744 ) = { 0.06258462, -0.12831748, 0.00000000 };
Point ( 2745 ) = { 0.06370200, -0.12776644, 0.00000000 };
Point ( 2746 ) = { 0.06481453, -0.12720568, 0.00000000 };
Point ( 2747 ) = { 0.06592213, -0.12663523, 0.00000000 };
Point ( 2748 ) = { 0.06702471, -0.12605514, 0.00000000 };
Point ( 2749 ) = { 0.06812218, -0.12546544, 0.00000000 };
Point ( 2750 ) = { 0.06921446, -0.12486620, 0.00000000 };
Point ( 2751 ) = { 0.07084671, -0.12650590, 0.00000000 };
Point ( 2752 ) = { 0.07249525, -0.12813493, 0.00000000 };
Point ( 2753 ) = { 0.07361067, -0.12749742, 0.00000000 };
Point ( 2754 ) = { 0.07528953, -0.12910108, 0.00000000 };
Point ( 2755 ) = { 0.07698450, -0.13069374, 0.00000000 };
Point ( 2756 ) = { 0.07812207, -0.13001696, 0.00000000 };
Point ( 2757 ) = { 0.07925369, -0.12933027, 0.00000000 };
Point ( 2758 ) = { 0.08037928, -0.12863374, 0.00000000 };
Point ( 2759 ) = { 0.08149875, -0.12792740, 0.00000000 };
Point ( 2760 ) = { 0.08261200, -0.12721133, 0.00000000 };
Point ( 2761 ) = { 0.08194297, -0.12498380, 0.00000000 };
Point ( 2762 ) = { 0.07949873, -0.12125572, 0.00000000 };
Point ( 2763 ) = { 0.07879799, -0.11905077, 0.00000000 };
Point ( 2764 ) = { 0.07983389, -0.11835861, 0.00000000 };
Point ( 2765 ) = { 0.08086371, -0.11765743, 0.00000000 };
Point ( 2766 ) = { 0.08188737, -0.11694728, 0.00000000 };
Point ( 2767 ) = { 0.08290480, -0.11622824, 0.00000000 };
Point ( 2768 ) = { 0.08391591, -0.11550034, 0.00000000 };
Point ( 2769 ) = { 0.08492063, -0.11476365, 0.00000000 };
Point ( 2770 ) = { 0.08591889, -0.11401822, 0.00000000 };
Point ( 2771 ) = { 0.08776345, -0.11541480, 0.00000000 };
Point ( 2772 ) = { 0.08962267, -0.11679854, 0.00000000 };
Point ( 2773 ) = { 0.09063850, -0.11601199, 0.00000000 };
Point ( 2774 ) = { 0.09164744, -0.11521662, 0.00000000 };
Point ( 2775 ) = { 0.09264939, -0.11441247, 0.00000000 };
Point ( 2776 ) = { 0.09455844, -0.11573376, 0.00000000 };
Point ( 2777 ) = { 0.09738266, -0.11919043, 0.00000000 };
Point ( 2778 ) = { 0.09826764, -0.12135042, 0.00000000 };
Point ( 2779 ) = { 0.09913654, -0.12352157, 0.00000000 };
Point ( 2780 ) = { 0.10108245, -0.12482643, 0.00000000 };
Point ( 2781 ) = { 0.10304261, -0.12611785, 0.00000000 };
Point ( 2782 ) = { 0.10501694, -0.12739573, 0.00000000 };
Point ( 2783 ) = { 0.10612466, -0.12647445, 0.00000000 };
Point ( 2784 ) = { 0.10812407, -0.12772131, 0.00000000 };
Point ( 2785 ) = { 0.11013742, -0.12895435, 0.00000000 };
Point ( 2786 ) = { 0.11125855, -0.12798832, 0.00000000 };
Point ( 2787 ) = { 0.11237121, -0.12701255, 0.00000000 };
Point ( 2788 ) = { 0.11143038, -0.12484719, 0.00000000 };
Point ( 2789 ) = { 0.11047391, -0.12269371, 0.00000000 };
Point ( 2790 ) = { 0.10950189, -0.12055218, 0.00000000 };
Point ( 2791 ) = { 0.10851438, -0.11842267, 0.00000000 };
Point ( 2792 ) = { 0.10954367, -0.11747121, 0.00000000 };
Point ( 2793 ) = { 0.11056462, -0.11651080, 0.00000000 };
Point ( 2794 ) = { 0.11262005, -0.11764444, 0.00000000 };
Point ( 2795 ) = { 0.11468856, -0.11876348, 0.00000000 };
Point ( 2796 ) = { 0.11572059, -0.11775813, 0.00000000 };
Point ( 2797 ) = { 0.11465608, -0.11566103, 0.00000000 };
Point ( 2798 ) = { 0.11357663, -0.11357663, 0.00000000 };
Point ( 2799 ) = { 0.11456343, -0.11258117, 0.00000000 };
Point ( 2800 ) = { 0.11554151, -0.11157714, 0.00000000 };
Point ( 2801 ) = { 0.11651080, -0.11056462, 0.00000000 };
Point ( 2802 ) = { 0.11747121, -0.10954367, 0.00000000 };
Point ( 2803 ) = { 0.11842267, -0.10851438, 0.00000000 };
Point ( 2804 ) = { 0.11936512, -0.10747683, 0.00000000 };
Point ( 2805 ) = { 0.12029847, -0.10643110, 0.00000000 };
Point ( 2806 ) = { 0.12122267, -0.10537726, 0.00000000 };
Point ( 2807 ) = { 0.12213763, -0.10431539, 0.00000000 };
Point ( 2808 ) = { 0.12088415, -0.10233598, 0.00000000 };
Point ( 2809 ) = { 0.11961694, -0.10037053, 0.00000000 };
Point ( 2810 ) = { 0.12048827, -0.09932286, 0.00000000 };
Point ( 2811 ) = { 0.11919043, -0.09738266, 0.00000000 };
Point ( 2812 ) = { 0.11787915, -0.09545665, 0.00000000 };
Point ( 2813 ) = { 0.11870767, -0.09442434, 0.00000000 };
Point ( 2814 ) = { 0.11952714, -0.09338484, 0.00000000 };
Point ( 2815 ) = { 0.12033752, -0.09233823, 0.00000000 };
Point ( 2816 ) = { 0.12113873, -0.09128458, 0.00000000 };
Point ( 2817 ) = { 0.12193071, -0.09022398, 0.00000000 };
Point ( 2818 ) = { 0.12271341, -0.08915651, 0.00000000 };
Point ( 2819 ) = { 0.12348677, -0.08808226, 0.00000000 };
Point ( 2820 ) = { 0.12425072, -0.08700129, 0.00000000 };
Point ( 2821 ) = { 0.12500521, -0.08591370, 0.00000000 };
Point ( 2822 ) = { 0.12575018, -0.08481957, 0.00000000 };
Point ( 2823 ) = { 0.12797541, -0.08551044, 0.00000000 };
Point ( 2824 ) = { 0.13021029, -0.08618431, 0.00000000 };
Point ( 2825 ) = { 0.13095742, -0.08504474, 0.00000000 };
Point ( 2826 ) = { 0.13169458, -0.08389870, 0.00000000 };
Point ( 2827 ) = { 0.13242171, -0.08274627, 0.00000000 };
Point ( 2828 ) = { 0.13313875, -0.08158753, 0.00000000 };
Point ( 2829 ) = { 0.13384566, -0.08042259, 0.00000000 };
Point ( 2830 ) = { 0.13454238, -0.07925152, 0.00000000 };
Point ( 2831 ) = { 0.13681810, -0.07978996, 0.00000000 };
Point ( 2832 ) = { 0.13910239, -0.08031080, 0.00000000 };
Point ( 2833 ) = { 0.13979793, -0.07909386, 0.00000000 };
Point ( 2834 ) = { 0.14209500, -0.07957702, 0.00000000 };
Point ( 2835 ) = { 0.14440030, -0.08004239, 0.00000000 };
Point ( 2836 ) = { 0.14509329, -0.07877923, 0.00000000 };
Point ( 2837 ) = { 0.14577524, -0.07751007, 0.00000000 };
Point ( 2838 ) = { 0.14809614, -0.07791715, 0.00000000 };
Point ( 2839 ) = { 0.15042479, -0.07830619, 0.00000000 };
Point ( 2840 ) = { 0.15110240, -0.07699052, 0.00000000 };
Point ( 2841 ) = { 0.15176851, -0.07566899, 0.00000000 };
Point ( 2842 ) = { 0.15242306, -0.07434169, 0.00000000 };
Point ( 2843 ) = { 0.15306600, -0.07300874, 0.00000000 };
Point ( 2844 ) = { 0.15135388, -0.07138313, 0.00000000 };
Point ( 2845 ) = { 0.14963202, -0.06977456, 0.00000000 };
Point ( 2846 ) = { 0.15023521, -0.06846613, 0.00000000 };
Point ( 2847 ) = { 0.15082697, -0.06715249, 0.00000000 };
Point ( 2848 ) = { 0.15140723, -0.06583374, 0.00000000 };
Point ( 2849 ) = { 0.15197597, -0.06450997, 0.00000000 };
Point ( 2850 ) = { 0.15253313, -0.06318129, 0.00000000 };
Point ( 2851 ) = { 0.15307867, -0.06184780, 0.00000000 };
Point ( 2852 ) = { 0.15542941, -0.06201005, 0.00000000 };
Point ( 2853 ) = { 0.15778597, -0.06215355, 0.00000000 };
Point ( 2854 ) = { 0.15832235, -0.06077425, 0.00000000 };
Point ( 2855 ) = { 0.15884667, -0.05939033, 0.00000000 };
Point ( 2856 ) = { 0.16121076, -0.05947379, 0.00000000 };
Point ( 2857 ) = { 0.16542845, -0.06102978, 0.00000000 };
Point ( 2858 ) = { 0.16780781, -0.06107705, 0.00000000 };
Point ( 2859 ) = { 0.16833441, -0.05961034, 0.00000000 };
Point ( 2860 ) = { 0.16884819, -0.05813910, 0.00000000 };
Point ( 2861 ) = { 0.16934912, -0.05666342, 0.00000000 };
Point ( 2862 ) = { 0.16983714, -0.05518343, 0.00000000 };
Point ( 2863 ) = { 0.17031224, -0.05369924, 0.00000000 };
Point ( 2864 ) = { 0.17077436, -0.05221096, 0.00000000 };
Point ( 2865 ) = { 0.17122348, -0.05071871, 0.00000000 };
Point ( 2866 ) = { 0.17165956, -0.04922259, 0.00000000 };
Point ( 2867 ) = { 0.17208257, -0.04772272, 0.00000000 };
Point ( 2868 ) = { 0.17249247, -0.04621922, 0.00000000 };
Point ( 2869 ) = { 0.17288923, -0.04471220, 0.00000000 };
Point ( 2870 ) = { 0.17327283, -0.04320177, 0.00000000 };
Point ( 2871 ) = { 0.17364324, -0.04168805, 0.00000000 };
Point ( 2872 ) = { 0.17400042, -0.04017116, 0.00000000 };
Point ( 2873 ) = { 0.17434435, -0.03865121, 0.00000000 };
Point ( 2874 ) = { 0.17467500, -0.03712832, 0.00000000 };
Point ( 2875 ) = { 0.17704026, -0.03682443, 0.00000000 };
Point ( 2876 ) = { 0.17940790, -0.03650095, 0.00000000 };
Point ( 2877 ) = { 0.17971959, -0.03493395, 0.00000000 };
Point ( 2878 ) = { 0.18208642, -0.03457019, 0.00000000 };
Point ( 2879 ) = { 0.18445524, -0.03418676, 0.00000000 };
Point ( 2880 ) = { 0.18474655, -0.03257580, 0.00000000 };
Point ( 2881 ) = { 0.18502379, -0.03096236, 0.00000000 };
Point ( 2882 ) = { 0.18292896, -0.02979187, 0.00000000 };
Point ( 2883 ) = { 0.17847802, -0.02906699, 0.00000000 };
Point ( 2884 ) = { 0.17403409, -0.02834325, 0.00000000 };
Point ( 2885 ) = { 0.17193516, -0.02723185, 0.00000000 };
Point ( 2886 ) = { 0.17216625, -0.02573042, 0.00000000 };
Point ( 2887 ) = { 0.17450224, -0.02530162, 0.00000000 };
Point ( 2888 ) = { 0.17683944, -0.02485316, 0.00000000 };
Point ( 2889 ) = { 0.17704959, -0.02330902, 0.00000000 };
Point ( 2890 ) = { 0.17724625, -0.02176310, 0.00000000 };
Point ( 2891 ) = { 0.17742942, -0.02021553, 0.00000000 };
Point ( 2892 ) = { 0.17759908, -0.01866642, 0.00000000 };
Point ( 2893 ) = { 0.17775521, -0.01711588, 0.00000000 };
Point ( 2894 ) = { 0.17789780, -0.01556404, 0.00000000 };
Point ( 2895 ) = { 0.17802685, -0.01401102, 0.00000000 };
Point ( 2896 ) = { 0.17814234, -0.01245693, 0.00000000 };
Point ( 2897 ) = { 0.17824426, -0.01090189, 0.00000000 };
Point ( 2898 ) = { 0.17833261, -0.00934602, 0.00000000 };
Point ( 2899 ) = { 0.17840738, -0.00778943, 0.00000000 };
Point ( 2900 ) = { 0.18069004, -0.00709933, 0.00000000 };
Point ( 2901 ) = { 0.18297182, -0.00638952, 0.00000000 };
Point ( 2902 ) = { 0.18302061, -0.00479256, 0.00000000 };
Point ( 2903 ) = { 0.18305547, -0.00319525, 0.00000000 };
Point ( 2904 ) = { 0.18307638, -0.00159768, 0.00000000 };
Point ( 2905 ) = { 0.18759656, 0.00000000, 0.00000000 };
Point ( 2906 ) = { 0.18758942, 0.00163707, 0.00000000 };
Point ( 2907 ) = { 0.18756799, 0.00327401, 0.00000000 };
Point ( 2908 ) = { 0.18753228, 0.00491071, 0.00000000 };
Point ( 2909 ) = { 0.18976738, 0.00579792, 0.00000000 };
Point ( 2910 ) = { 0.19200014, 0.00670479, 0.00000000 };
Point ( 2911 ) = { 0.19193432, 0.00838003, 0.00000000 };
Point ( 2912 ) = { 0.19185388, 0.01005464, 0.00000000 };
Point ( 2913 ) = { 0.19406768, 0.01101996, 0.00000000 };
Point ( 2914 ) = { 0.19627858, 0.01200491, 0.00000000 };
Point ( 2915 ) = { 0.19616635, 0.01371729, 0.00000000 };
Point ( 2916 ) = { 0.19603917, 0.01542862, 0.00000000 };
Point ( 2917 ) = { 0.19822920, 0.01647158, 0.00000000 };
Point ( 2918 ) = { 0.20041578, 0.01753411, 0.00000000 };
Point ( 2919 ) = { 0.20259880, 0.01861621, 0.00000000 };
Point ( 2920 ) = { 0.20477816, 0.01971789, 0.00000000 };
Point ( 2921 ) = { 0.20242863, 0.02038349, 0.00000000 };
Point ( 2922 ) = { 0.20007924, 0.02102918, 0.00000000 };
Point ( 2923 ) = { 0.19988811, 0.02277437, 0.00000000 };
Point ( 2924 ) = { 0.19968176, 0.02451784, 0.00000000 };
Point ( 2925 ) = { 0.20182569, 0.02567547, 0.00000000 };
Point ( 2926 ) = { 0.20396527, 0.02685254, 0.00000000 };
Point ( 2927 ) = { 0.20372317, 0.02863142, 0.00000000 };
Point ( 2928 ) = { 0.20346556, 0.03040813, 0.00000000 };
Point ( 2929 ) = { 0.20319246, 0.03218252, 0.00000000 };
Point ( 2930 ) = { 0.20529554, 0.03343450, 0.00000000 };
Point ( 2931 ) = { 0.20739356, 0.03470578, 0.00000000 };
Point ( 2932 ) = { 0.20948641, 0.03599635, 0.00000000 };
Point ( 2933 ) = { 0.21189148, 0.03545847, 0.00000000 };
Point ( 2934 ) = { 0.21429792, 0.03490063, 0.00000000 };
Point ( 2935 ) = { 0.21670562, 0.03432280, 0.00000000 };
Point ( 2936 ) = { 0.21459432, 0.03302922, 0.00000000 };
Point ( 2937 ) = { 0.21247804, 0.03175506, 0.00000000 };
Point ( 2938 ) = { 0.21274707, 0.02989965, 0.00000000 };
Point ( 2939 ) = { 0.21513808, 0.02927901, 0.00000000 };
Point ( 2940 ) = { 0.21966968, 0.02989573, 0.00000000 };
Point ( 2941 ) = { 0.22421006, 0.03051365, 0.00000000 };
Point ( 2942 ) = { 0.22661594, 0.02983455, 0.00000000 };
Point ( 2943 ) = { 0.22686766, 0.02785585, 0.00000000 };
Point ( 2944 ) = { 0.22710211, 0.02587502, 0.00000000 };
Point ( 2945 ) = { 0.22731926, 0.02389222, 0.00000000 };
Point ( 2946 ) = { 0.22513839, 0.02267024, 0.00000000 };
Point ( 2947 ) = { 0.22295348, 0.02146798, 0.00000000 };
Point ( 2948 ) = { 0.22313233, 0.01952155, 0.00000000 };
Point ( 2949 ) = { 0.22329419, 0.01757363, 0.00000000 };
Point ( 2950 ) = { 0.22108504, 0.01642946, 0.00000000 };
Point ( 2951 ) = { 0.21887241, 0.01530505, 0.00000000 };
Point ( 2952 ) = { 0.21665641, 0.01420041, 0.00000000 };
Point ( 2953 ) = { 0.21443714, 0.01311554, 0.00000000 };
Point ( 2954 ) = { 0.21454343, 0.01124374, 0.00000000 };
Point ( 2955 ) = { 0.21687124, 0.01041707, 0.00000000 };
Point ( 2956 ) = { 0.21919805, 0.00957039, 0.00000000 };
Point ( 2957 ) = { 0.21927322, 0.00765719, 0.00000000 };
Point ( 2958 ) = { 0.21933169, 0.00574340, 0.00000000 };
Point ( 2959 ) = { 0.21706961, 0.00473648, 0.00000000 };
Point ( 2960 ) = { 0.21250598, 0.00463690, 0.00000000 };
Point ( 2961 ) = { 0.21024536, 0.00366985, 0.00000000 };
Point ( 2962 ) = { 0.21026938, 0.00183499, 0.00000000 };
Point ( 2963 ) = { 0.21255454, 0.00092745, 0.00000000 };
Point ( 2964 ) = { 0.21482967, 0.00187479, 0.00000000 };
Point ( 2965 ) = { 0.21710268, 0.00284203, 0.00000000 };
Point ( 2966 ) = { 0.21939852, 0.00191466, 0.00000000 };
BSpline ( 0 ) = { 2 : 2966, 2 };
Line Loop( 0 ) = { 0 };


// == Physical entities ===========================================
// Boundary Coastline (ID 3): 1
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
Field[ 3 ].LcMin = 1.000000e+04;
Field[ 3 ].LcMax = 1.000000e+06;
Field[ 3 ].DistMin = 4.000000e+04;
Field[ 3 ].DistMax = 2.000000e+06;

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
General.RotationX = 0;
General.RotationY = 0;
General.RotationZ = 0;


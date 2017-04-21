// Surface Geoid Boundary Representation, for project: UK_NorthSea_region_opendap
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
// Project name: UK_NorthSea_region_opendap
// Boundary Specification authors: Adam S. Candy (A.S.Candy@tudelft.nl, Technische Universiteit Delft)
// Created at: 2017/04/21 10:20:46 
// Project description:
//   Example simulation domain around the UK and Ireland in the North Sea.
//       In a latitude-longitude WGS84 projection.

// == Source Shingle surface geoid boundnary representation =======
// <?xml version='1.0' encoding='utf-8'?>
// <boundary_representation>
//   <model_name>
//     <string_value lines="1">UK_NorthSea_region_opendap</string_value>
//     <comment>Example simulation domain around the UK and Ireland in the North Sea.
//     In a latitude-longitude WGS84 projection.</comment>
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
//   <output>
//     <projection>
//       <string_value>longlat</string_value>
//     </projection>
//     <orientation name="LongLat"/>
//   </output>
//   <dataset name="ETOPO2">
//     <form name="Raster">
//       <source url="http://geoport.whoi.edu/thredds/dodsC/bathy/etopo2_v2c.nc" name="OPeNDAP"/>
//     </form>
//     <projection name="Automatic"/>
//   </dataset>
//   <geoid_surface_representation name="NorthSea">
//     <id>
//       <integer_value rank="0">9</integer_value>
//     </id>
//     <brep_component name="NorthSea">
//       <form name="Raster">
//         <source name="ETOPO2"/>
//         <region name="MainRegionAroundUK">
//           <longitude>
//             <minimum>
//               <real_value rank="0">-14.0</real_value>
//             </minimum>
//             <maximum>
//               <real_value rank="0">6.0</real_value>
//             </maximum>
//           </longitude>
//           <latitude>
//             <minimum>
//               <real_value rank="0">46.0</real_value>
//             </minimum>
//             <maximum>
//               <real_value rank="0">64.0</real_value>
//             </maximum>
//           </latitude>
//         </region>
//         <minimum_area>
//           <real_value rank="0">0.1</real_value>
//         </minimum_area>
//         <contourtype field_level="-10.0" field_name="Automatic" name="gebco10m"/>
//         <boundary>1</boundary>
//       </form>
//       <identification name="Coast"/>
//       <representation_type name="BSplines"/>
//     </brep_component>
//     <brep_component name="OpenBoundary">
//       <form name="BoundingBox">
//         <region name="MainRegionAroundUK">
//           <longitude>
//             <minimum>
//               <real_value rank="0">-14.0</real_value>
//             </minimum>
//             <maximum>
//               <real_value rank="0">6.0</real_value>
//             </maximum>
//           </longitude>
//           <latitude>
//             <minimum>
//               <real_value rank="0">46.0</real_value>
//             </minimum>
//             <maximum>
//               <real_value rank="0">64.0</real_value>
//             </maximum>
//           </latitude>
//         </region>
//       </form>
//       <identification name="OpenOcean"/>
//       <representation_type name="BSplines"/>
//     </brep_component>
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
//     <form name="FromRaster">
//       <source name="ETOPO2"/>
//       <region name="MainRegionAroundUK">
//         <longitude>
//           <minimum>
//             <real_value rank="0">-14.0</real_value>
//           </minimum>
//           <maximum>
//             <real_value rank="0">6.0</real_value>
//           </maximum>
//         </longitude>
//         <latitude>
//           <minimum>
//             <real_value rank="0">46.0</real_value>
//           </minimum>
//           <maximum>
//             <real_value rank="0">64.0</real_value>
//           </maximum>
//         </latitude>
//       </region>
//     </form>
//   </geoid_metric>
//   <geoid_mesh>
//     <library name="Gmsh">
//       <extend_metric_from_boundary/>
//     </library>
//   </geoid_mesh>
//   <validation>
//     <test file_name="data/UK_NorthSea_region_opendap_valid.geo" name="BrepDescription"/>
//   </validation>
// </boundary_representation>

// == Boundary Representation Specification Parameters ============
// Output to UK_NorthSea_region_opendap.geo
// Projection type longlat
//   1. NorthSea
//       Path:           /geoid_surface_representation::NorthSea/brep_component::NorthSea
//       Form:           Raster
//       Identification: Coast
//   2. OpenBoundary
//       Path:           /geoid_surface_representation::NorthSea/brep_component::OpenBoundary
//       Form:           BoundingBox
//       Identification: OpenOcean

// == BRep component: NorthSea ====================================
// Reading boundary representation NorthSea
// Boundaries restricted to paths: 1
// Region of interest: True
// Open contours closed with a line formed by points spaced 0.1 degrees apart
// Paths found: 127

// == Boundary Representation description =========================

// == Header ======================================================
// Merged paths that cross the date line: 

// == Ice-Land mass number 1 ======================================
// Path 1: points 2252 (of 2253) area 132084 (required closing in 2 parts of the path)

// == Ice-Land mass number 2 ======================================
// Path 2: points 912 (of 912) area 16361

// == Ice-Land mass number 3 ======================================
// Path 3: points 906 (of 907) area 43312 (required closing in 2 parts of the path)

// == Ice-Land mass number 4 ======================================
//   Skipped (island crossing meridian - code needs modification to include)
// Path 4: points 370 (of 370) area 11815.8

// == Ice-Land mass number 5 ======================================
// Path 5: points 250 (of 251) area 5106.24 (required closing in 2 parts of the path)

// == Ice-Land mass number 6 ======================================
// Path 6: points 194 (of 195) area 720.844 (required closing in 2 parts of the path)

// == Ice-Land mass number 7 ======================================
// Path 7: points 172 (of 173) area 378.725 (required closing in 2 parts of the path)

// == Ice-Land mass number 8 ======================================
//   Skipped (area too small)

// == Ice-Land mass number 9 ======================================
// Path 9: points 82 (of 83) area 172.303 (required closing in 2 parts of the path)

// == Ice-Land mass number 10 =====================================
// Path 10: points 74 (of 75) area 704.936 (required closing in 2 parts of the path)

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
// Path 38: points 10 (of 10) area 12.4786

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
// Paths found valid (renumbered order): 1, including 1

// == Ice-Land mass number 1 ======================================
Point ( 2 ) = { -5.21666670, 49.93333435, 0.00000000 };
Point ( 3 ) = { -5.23333335, 49.95000076, 0.00000000 };
Point ( 4 ) = { -5.25000000, 49.96666718, 0.00000000 };
Point ( 5 ) = { -5.26666665, 49.98333359, 0.00000000 };
Point ( 6 ) = { -5.28333330, 50.00000000, 0.00000000 };
Point ( 7 ) = { -5.29999995, 50.01666641, 0.00000000 };
Point ( 8 ) = { -5.29999995, 50.04999924, 0.00000000 };
Point ( 9 ) = { -5.31666660, 50.06666565, 0.00000000 };
Point ( 10 ) = { -5.34999990, 50.06666565, 0.00000000 };
Point ( 11 ) = { -5.38333321, 50.06666565, 0.00000000 };
Point ( 12 ) = { -5.41666651, 50.06666565, 0.00000000 };
Point ( 13 ) = { -5.44999981, 50.06666565, 0.00000000 };
Point ( 14 ) = { -5.46666646, 50.08333206, 0.00000000 };
Point ( 15 ) = { -5.48333311, 50.09999847, 0.00000000 };
Point ( 16 ) = { -5.51666689, 50.09999847, 0.00000000 };
Point ( 17 ) = { -5.53333354, 50.08333206, 0.00000000 };
Point ( 18 ) = { -5.55000019, 50.06666565, 0.00000000 };
Point ( 19 ) = { -5.58333349, 50.06666565, 0.00000000 };
Point ( 20 ) = { -5.60000014, 50.04999924, 0.00000000 };
Point ( 21 ) = { -5.61666679, 50.03333282, 0.00000000 };
Point ( 22 ) = { -5.65000010, 50.03333282, 0.00000000 };
Point ( 23 ) = { -5.68333340, 50.03333282, 0.00000000 };
Point ( 24 ) = { -5.70000005, 50.04999924, 0.00000000 };
Point ( 25 ) = { -5.70000005, 50.08333206, 0.00000000 };
Point ( 26 ) = { -5.70000005, 50.11666489, 0.00000000 };
Point ( 27 ) = { -5.70000005, 50.15000153, 0.00000000 };
Point ( 28 ) = { -5.68333340, 50.16666794, 0.00000000 };
Point ( 29 ) = { -5.65000010, 50.16666794, 0.00000000 };
Point ( 30 ) = { -5.63333344, 50.18333435, 0.00000000 };
Point ( 31 ) = { -5.61666679, 50.20000076, 0.00000000 };
Point ( 32 ) = { -5.58333349, 50.20000076, 0.00000000 };
Point ( 33 ) = { -5.56666684, 50.21666718, 0.00000000 };
Point ( 34 ) = { -5.55000019, 50.23333359, 0.00000000 };
Point ( 35 ) = { -5.51666689, 50.23333359, 0.00000000 };
Point ( 36 ) = { -5.48333311, 50.23333359, 0.00000000 };
Point ( 37 ) = { -5.44999981, 50.23333359, 0.00000000 };
Point ( 38 ) = { -5.41666651, 50.23333359, 0.00000000 };
Point ( 39 ) = { -5.38333321, 50.23333359, 0.00000000 };
Point ( 40 ) = { -5.36666656, 50.25000000, 0.00000000 };
Point ( 41 ) = { -5.34999990, 50.26666641, 0.00000000 };
Point ( 42 ) = { -5.31666660, 50.26666641, 0.00000000 };
Point ( 43 ) = { -5.28333330, 50.26666641, 0.00000000 };
Point ( 44 ) = { -5.26666665, 50.28333282, 0.00000000 };
Point ( 45 ) = { -5.25000000, 50.29999924, 0.00000000 };
Point ( 46 ) = { -5.23333335, 50.31666565, 0.00000000 };
Point ( 47 ) = { -5.21666670, 50.33333206, 0.00000000 };
Point ( 48 ) = { -5.20000005, 50.34999847, 0.00000000 };
Point ( 49 ) = { -5.18333340, 50.36666679, 0.00000000 };
Point ( 50 ) = { -5.16666675, 50.38333511, 0.00000000 };
Point ( 51 ) = { -5.15000010, 50.40000153, 0.00000000 };
Point ( 52 ) = { -5.13333344, 50.41666794, 0.00000000 };
Point ( 53 ) = { -5.11666679, 50.43333435, 0.00000000 };
Point ( 54 ) = { -5.08333349, 50.43333435, 0.00000000 };
Point ( 55 ) = { -5.06666684, 50.45000076, 0.00000000 };
Point ( 56 ) = { -5.06666684, 50.48333359, 0.00000000 };
Point ( 57 ) = { -5.06666684, 50.51666641, 0.00000000 };
Point ( 58 ) = { -5.05000019, 50.53333282, 0.00000000 };
Point ( 59 ) = { -5.03333354, 50.54999924, 0.00000000 };
Point ( 60 ) = { -5.01666689, 50.56666565, 0.00000000 };
Point ( 61 ) = { -5.00000000, 50.58333206, 0.00000000 };
Point ( 62 ) = { -4.98333311, 50.59999847, 0.00000000 };
Point ( 63 ) = { -4.96666646, 50.61666489, 0.00000000 };
Point ( 64 ) = { -4.94999981, 50.63333321, 0.00000000 };
Point ( 65 ) = { -4.91666651, 50.63333321, 0.00000000 };
Point ( 66 ) = { -4.88333321, 50.63333321, 0.00000000 };
Point ( 67 ) = { -4.86666656, 50.65000153, 0.00000000 };
Point ( 68 ) = { -4.84999990, 50.66666794, 0.00000000 };
Point ( 69 ) = { -4.83333325, 50.68333435, 0.00000000 };
Point ( 70 ) = { -4.81666660, 50.70000076, 0.00000000 };
Point ( 71 ) = { -4.79999995, 50.71666718, 0.00000000 };
Point ( 72 ) = { -4.78333330, 50.73333359, 0.00000000 };
Point ( 73 ) = { -4.75000000, 50.73333359, 0.00000000 };
Point ( 74 ) = { -4.71666670, 50.73333359, 0.00000000 };
Point ( 75 ) = { -4.68333340, 50.73333359, 0.00000000 };
Point ( 76 ) = { -4.66666675, 50.75000000, 0.00000000 };
Point ( 77 ) = { -4.65000010, 50.76666641, 0.00000000 };
Point ( 78 ) = { -4.63333344, 50.78333282, 0.00000000 };
Point ( 79 ) = { -4.63333344, 50.81666565, 0.00000000 };
Point ( 80 ) = { -4.61666679, 50.83333206, 0.00000000 };
Point ( 81 ) = { -4.58333349, 50.83333206, 0.00000000 };
Point ( 82 ) = { -4.56666684, 50.84999847, 0.00000000 };
Point ( 83 ) = { -4.56666684, 50.88333511, 0.00000000 };
Point ( 84 ) = { -4.58333349, 50.90000153, 0.00000000 };
Point ( 85 ) = { -4.60000014, 50.91666794, 0.00000000 };
Point ( 86 ) = { -4.58333349, 50.93333435, 0.00000000 };
Point ( 87 ) = { -4.56666684, 50.95000076, 0.00000000 };
Point ( 88 ) = { -4.56666684, 50.98333359, 0.00000000 };
Point ( 89 ) = { -4.55000019, 51.00000000, 0.00000000 };
Point ( 90 ) = { -4.53333354, 51.01666641, 0.00000000 };
Point ( 91 ) = { -4.51666689, 51.03333282, 0.00000000 };
Point ( 92 ) = { -4.48333311, 51.03333282, 0.00000000 };
Point ( 93 ) = { -4.46666646, 51.04999924, 0.00000000 };
Point ( 94 ) = { -4.44999981, 51.06666565, 0.00000000 };
Point ( 95 ) = { -4.41666651, 51.06666565, 0.00000000 };
Point ( 96 ) = { -4.38333321, 51.06666565, 0.00000000 };
Point ( 97 ) = { -4.34999990, 51.06666565, 0.00000000 };
Point ( 98 ) = { -4.31666660, 51.06666565, 0.00000000 };
Point ( 99 ) = { -4.28333330, 51.06666565, 0.00000000 };
Point ( 100 ) = { -4.25000000, 51.06666565, 0.00000000 };
Point ( 101 ) = { -4.23333335, 51.08333206, 0.00000000 };
Point ( 102 ) = { -4.25000000, 51.09999847, 0.00000000 };
Point ( 103 ) = { -4.26666665, 51.11666489, 0.00000000 };
Point ( 104 ) = { -4.26666665, 51.15000153, 0.00000000 };
Point ( 105 ) = { -4.25000000, 51.16666794, 0.00000000 };
Point ( 106 ) = { -4.23333335, 51.18333435, 0.00000000 };
Point ( 107 ) = { -4.21666670, 51.20000076, 0.00000000 };
Point ( 108 ) = { -4.20000005, 51.21666718, 0.00000000 };
Point ( 109 ) = { -4.18333340, 51.23333359, 0.00000000 };
Point ( 110 ) = { -4.15000010, 51.23333359, 0.00000000 };
Point ( 111 ) = { -4.11666679, 51.23333359, 0.00000000 };
Point ( 112 ) = { -4.08333349, 51.23333359, 0.00000000 };
Point ( 113 ) = { -4.05000019, 51.23333359, 0.00000000 };
Point ( 114 ) = { -4.01666689, 51.23333359, 0.00000000 };
Point ( 115 ) = { -3.98333335, 51.23333359, 0.00000000 };
Point ( 116 ) = { -3.95000005, 51.23333359, 0.00000000 };
Point ( 117 ) = { -3.91666675, 51.23333359, 0.00000000 };
Point ( 118 ) = { -3.88333344, 51.23333359, 0.00000000 };
Point ( 119 ) = { -3.84999990, 51.23333359, 0.00000000 };
Point ( 120 ) = { -3.81666660, 51.23333359, 0.00000000 };
Point ( 121 ) = { -3.79999995, 51.25000000, 0.00000000 };
Point ( 122 ) = { -3.78333330, 51.26666641, 0.00000000 };
Point ( 123 ) = { -3.76666665, 51.25000000, 0.00000000 };
Point ( 124 ) = { -3.75000000, 51.23333359, 0.00000000 };
Point ( 125 ) = { -3.71666670, 51.23333359, 0.00000000 };
Point ( 126 ) = { -3.68333340, 51.23333359, 0.00000000 };
Point ( 127 ) = { -3.65000010, 51.23333359, 0.00000000 };
Point ( 128 ) = { -3.61666656, 51.23333359, 0.00000000 };
Point ( 129 ) = { -3.58333325, 51.23333359, 0.00000000 };
Point ( 130 ) = { -3.54999995, 51.23333359, 0.00000000 };
Point ( 131 ) = { -3.51666665, 51.23333359, 0.00000000 };
Point ( 132 ) = { -3.48333335, 51.23333359, 0.00000000 };
Point ( 133 ) = { -3.45000005, 51.23333359, 0.00000000 };
Point ( 134 ) = { -3.41666675, 51.23333359, 0.00000000 };
Point ( 135 ) = { -3.38333344, 51.23333359, 0.00000000 };
Point ( 136 ) = { -3.34999990, 51.23333359, 0.00000000 };
Point ( 137 ) = { -3.31666660, 51.23333359, 0.00000000 };
Point ( 138 ) = { -3.28333330, 51.23333359, 0.00000000 };
Point ( 139 ) = { -3.25000000, 51.23333359, 0.00000000 };
Point ( 140 ) = { -3.21666670, 51.23333359, 0.00000000 };
Point ( 141 ) = { -3.18333340, 51.23333359, 0.00000000 };
Point ( 142 ) = { -3.15000010, 51.23333359, 0.00000000 };
Point ( 143 ) = { -3.11666656, 51.23333359, 0.00000000 };
Point ( 144 ) = { -3.09999990, 51.25000000, 0.00000000 };
Point ( 145 ) = { -3.08333325, 51.26666641, 0.00000000 };
Point ( 146 ) = { -3.06666660, 51.28333282, 0.00000000 };
Point ( 147 ) = { -3.04999995, 51.29999924, 0.00000000 };
Point ( 148 ) = { -3.03333330, 51.31666565, 0.00000000 };
Point ( 149 ) = { -3.01666665, 51.33333206, 0.00000000 };
Point ( 150 ) = { -3.00000000, 51.34999847, 0.00000000 };
Point ( 151 ) = { -3.00000000, 51.38333511, 0.00000000 };
Point ( 152 ) = { -3.00000000, 51.41666794, 0.00000000 };
Point ( 153 ) = { -2.98333335, 51.43333435, 0.00000000 };
Point ( 154 ) = { -2.95000005, 51.43333435, 0.00000000 };
Point ( 155 ) = { -2.91666675, 51.43333435, 0.00000000 };
Point ( 156 ) = { -2.90000010, 51.45000076, 0.00000000 };
Point ( 157 ) = { -2.91666675, 51.46666718, 0.00000000 };
Point ( 158 ) = { -2.95000005, 51.46666718, 0.00000000 };
Point ( 159 ) = { -2.96666670, 51.48333359, 0.00000000 };
Point ( 160 ) = { -2.98333335, 51.50000000, 0.00000000 };
Point ( 161 ) = { -3.00000000, 51.48333359, 0.00000000 };
Point ( 162 ) = { -3.01666665, 51.46666718, 0.00000000 };
Point ( 163 ) = { -3.03333330, 51.45000076, 0.00000000 };
Point ( 164 ) = { -3.04999995, 51.43333435, 0.00000000 };
Point ( 165 ) = { -3.08333325, 51.43333435, 0.00000000 };
Point ( 166 ) = { -3.09999990, 51.41666794, 0.00000000 };
Point ( 167 ) = { -3.11666656, 51.40000153, 0.00000000 };
Point ( 168 ) = { -3.15000010, 51.40000153, 0.00000000 };
Point ( 169 ) = { -3.18333340, 51.40000153, 0.00000000 };
Point ( 170 ) = { -3.21666670, 51.40000153, 0.00000000 };
Point ( 171 ) = { -3.25000000, 51.40000153, 0.00000000 };
Point ( 172 ) = { -3.28333330, 51.40000153, 0.00000000 };
Point ( 173 ) = { -3.31666660, 51.40000153, 0.00000000 };
Point ( 174 ) = { -3.33333325, 51.38333511, 0.00000000 };
Point ( 175 ) = { -3.34999990, 51.36666679, 0.00000000 };
Point ( 176 ) = { -3.36666667, 51.34999847, 0.00000000 };
Point ( 177 ) = { -3.38333344, 51.33333206, 0.00000000 };
Point ( 178 ) = { -3.41666675, 51.33333206, 0.00000000 };
Point ( 179 ) = { -3.45000005, 51.33333206, 0.00000000 };
Point ( 180 ) = { -3.48333335, 51.33333206, 0.00000000 };
Point ( 181 ) = { -3.51666665, 51.33333206, 0.00000000 };
Point ( 182 ) = { -3.54999995, 51.33333206, 0.00000000 };
Point ( 183 ) = { -3.56666660, 51.34999847, 0.00000000 };
Point ( 184 ) = { -3.56666660, 51.38333511, 0.00000000 };
Point ( 185 ) = { -3.58333325, 51.40000153, 0.00000000 };
Point ( 186 ) = { -3.61666656, 51.40000153, 0.00000000 };
Point ( 187 ) = { -3.65000010, 51.40000153, 0.00000000 };
Point ( 188 ) = { -3.68333340, 51.40000153, 0.00000000 };
Point ( 189 ) = { -3.70000005, 51.41666794, 0.00000000 };
Point ( 190 ) = { -3.71666670, 51.43333435, 0.00000000 };
Point ( 191 ) = { -3.73333335, 51.45000076, 0.00000000 };
Point ( 192 ) = { -3.73333335, 51.48333359, 0.00000000 };
Point ( 193 ) = { -3.75000000, 51.50000000, 0.00000000 };
Point ( 194 ) = { -3.78333330, 51.50000000, 0.00000000 };
Point ( 195 ) = { -3.79999995, 51.48333359, 0.00000000 };
Point ( 196 ) = { -3.81666660, 51.46666718, 0.00000000 };
Point ( 197 ) = { -3.83333325, 51.48333359, 0.00000000 };
Point ( 198 ) = { -3.81666660, 51.50000000, 0.00000000 };
Point ( 199 ) = { -3.79999995, 51.51666641, 0.00000000 };
Point ( 200 ) = { -3.79999995, 51.54999924, 0.00000000 };
Point ( 201 ) = { -3.81666660, 51.56666565, 0.00000000 };
Point ( 202 ) = { -3.83333325, 51.58333206, 0.00000000 };
Point ( 203 ) = { -3.84999990, 51.59999847, 0.00000000 };
Point ( 204 ) = { -3.88333344, 51.59999847, 0.00000000 };
Point ( 205 ) = { -3.90000010, 51.58333206, 0.00000000 };
Point ( 206 ) = { -3.91666675, 51.56666565, 0.00000000 };
Point ( 207 ) = { -3.95000005, 51.56666565, 0.00000000 };
Point ( 208 ) = { -3.98333335, 51.56666565, 0.00000000 };
Point ( 209 ) = { -4.01666689, 51.56666565, 0.00000000 };
Point ( 210 ) = { -4.05000019, 51.56666565, 0.00000000 };
Point ( 211 ) = { -4.08333349, 51.56666565, 0.00000000 };
Point ( 212 ) = { -4.11666679, 51.56666565, 0.00000000 };
Point ( 213 ) = { -4.13333344, 51.54999924, 0.00000000 };
Point ( 214 ) = { -4.15000010, 51.53333282, 0.00000000 };
Point ( 215 ) = { -4.18333340, 51.53333282, 0.00000000 };
Point ( 216 ) = { -4.21666670, 51.53333282, 0.00000000 };
Point ( 217 ) = { -4.25000000, 51.53333282, 0.00000000 };
Point ( 218 ) = { -4.26666665, 51.54999924, 0.00000000 };
Point ( 219 ) = { -4.28333330, 51.56666565, 0.00000000 };
Point ( 220 ) = { -4.31666660, 51.56666565, 0.00000000 };
Point ( 221 ) = { -4.33333325, 51.58333206, 0.00000000 };
Point ( 222 ) = { -4.34999990, 51.59999847, 0.00000000 };
Point ( 223 ) = { -4.36666656, 51.61666489, 0.00000000 };
Point ( 224 ) = { -4.36666656, 51.65000153, 0.00000000 };
Point ( 225 ) = { -4.38333321, 51.66666794, 0.00000000 };
Point ( 226 ) = { -4.41666651, 51.66666794, 0.00000000 };
Point ( 227 ) = { -4.43333316, 51.68333435, 0.00000000 };
Point ( 228 ) = { -4.44999981, 51.70000076, 0.00000000 };
Point ( 229 ) = { -4.48333311, 51.70000076, 0.00000000 };
Point ( 230 ) = { -4.51666689, 51.70000076, 0.00000000 };
Point ( 231 ) = { -4.55000019, 51.70000076, 0.00000000 };
Point ( 232 ) = { -4.58333349, 51.70000076, 0.00000000 };
Point ( 233 ) = { -4.61666679, 51.70000076, 0.00000000 };
Point ( 234 ) = { -4.63333344, 51.68333435, 0.00000000 };
Point ( 235 ) = { -4.65000010, 51.66666794, 0.00000000 };
Point ( 236 ) = { -4.66666675, 51.65000153, 0.00000000 };
Point ( 237 ) = { -4.68333340, 51.63333321, 0.00000000 };
Point ( 238 ) = { -4.71666670, 51.63333321, 0.00000000 };
Point ( 239 ) = { -4.73333335, 51.65000153, 0.00000000 };
Point ( 240 ) = { -4.75000000, 51.66666794, 0.00000000 };
Point ( 241 ) = { -4.76666665, 51.65000153, 0.00000000 };
Point ( 242 ) = { -4.78333330, 51.63333321, 0.00000000 };
Point ( 243 ) = { -4.81666660, 51.63333321, 0.00000000 };
Point ( 244 ) = { -4.84999990, 51.63333321, 0.00000000 };
Point ( 245 ) = { -4.88333321, 51.63333321, 0.00000000 };
Point ( 246 ) = { -4.89999986, 51.61666489, 0.00000000 };
Point ( 247 ) = { -4.91666651, 51.59999847, 0.00000000 };
Point ( 248 ) = { -4.94999981, 51.59999847, 0.00000000 };
Point ( 249 ) = { -4.98333311, 51.59999847, 0.00000000 };
Point ( 250 ) = { -5.01666689, 51.59999847, 0.00000000 };
Point ( 251 ) = { -5.03333354, 51.61666489, 0.00000000 };
Point ( 252 ) = { -5.05000019, 51.63333321, 0.00000000 };
Point ( 253 ) = { -5.08333349, 51.63333321, 0.00000000 };
Point ( 254 ) = { -5.10000014, 51.65000153, 0.00000000 };
Point ( 255 ) = { -5.11666679, 51.66666794, 0.00000000 };
Point ( 256 ) = { -5.15000010, 51.66666794, 0.00000000 };
Point ( 257 ) = { -5.16666675, 51.68333435, 0.00000000 };
Point ( 258 ) = { -5.18333340, 51.70000076, 0.00000000 };
Point ( 259 ) = { -5.20000005, 51.71666718, 0.00000000 };
Point ( 260 ) = { -5.20000005, 51.75000000, 0.00000000 };
Point ( 261 ) = { -5.18333340, 51.76666641, 0.00000000 };
Point ( 262 ) = { -5.15000010, 51.76666641, 0.00000000 };
Point ( 263 ) = { -5.13333344, 51.78333282, 0.00000000 };
Point ( 264 ) = { -5.13333344, 51.81666565, 0.00000000 };
Point ( 265 ) = { -5.13333344, 51.84999847, 0.00000000 };
Point ( 266 ) = { -5.15000010, 51.86666679, 0.00000000 };
Point ( 267 ) = { -5.18333340, 51.86666679, 0.00000000 };
Point ( 268 ) = { -5.21666670, 51.86666679, 0.00000000 };
Point ( 269 ) = { -5.25000000, 51.86666679, 0.00000000 };
Point ( 270 ) = { -5.28333330, 51.86666679, 0.00000000 };
Point ( 271 ) = { -5.31666660, 51.86666679, 0.00000000 };
Point ( 272 ) = { -5.33333325, 51.88333511, 0.00000000 };
Point ( 273 ) = { -5.31666660, 51.90000153, 0.00000000 };
Point ( 274 ) = { -5.29999995, 51.91666794, 0.00000000 };
Point ( 275 ) = { -5.28333330, 51.93333435, 0.00000000 };
Point ( 276 ) = { -5.25000000, 51.93333435, 0.00000000 };
Point ( 277 ) = { -5.21666670, 51.93333435, 0.00000000 };
Point ( 278 ) = { -5.20000005, 51.95000076, 0.00000000 };
Point ( 279 ) = { -5.18333340, 51.96666718, 0.00000000 };
Point ( 280 ) = { -5.15000010, 51.96666718, 0.00000000 };
Point ( 281 ) = { -5.11666679, 51.96666718, 0.00000000 };
Point ( 282 ) = { -5.10000014, 51.98333359, 0.00000000 };
Point ( 283 ) = { -5.10000014, 52.01666641, 0.00000000 };
Point ( 284 ) = { -5.08333349, 52.03333282, 0.00000000 };
Point ( 285 ) = { -5.05000019, 52.03333282, 0.00000000 };
Point ( 286 ) = { -5.01666689, 52.03333282, 0.00000000 };
Point ( 287 ) = { -4.98333311, 52.03333282, 0.00000000 };
Point ( 288 ) = { -4.94999981, 52.03333282, 0.00000000 };
Point ( 289 ) = { -4.91666651, 52.03333282, 0.00000000 };
Point ( 290 ) = { -4.88333321, 52.03333282, 0.00000000 };
Point ( 291 ) = { -4.86666656, 52.04999924, 0.00000000 };
Point ( 292 ) = { -4.84999990, 52.06666565, 0.00000000 };
Point ( 293 ) = { -4.83333325, 52.08333206, 0.00000000 };
Point ( 294 ) = { -4.81666660, 52.09999847, 0.00000000 };
Point ( 295 ) = { -4.79999995, 52.11666489, 0.00000000 };
Point ( 296 ) = { -4.78333330, 52.13333321, 0.00000000 };
Point ( 297 ) = { -4.76666665, 52.15000153, 0.00000000 };
Point ( 298 ) = { -4.75000000, 52.16666794, 0.00000000 };
Point ( 299 ) = { -4.71666670, 52.16666794, 0.00000000 };
Point ( 300 ) = { -4.68333340, 52.16666794, 0.00000000 };
Point ( 301 ) = { -4.65000010, 52.16666794, 0.00000000 };
Point ( 302 ) = { -4.61666679, 52.16666794, 0.00000000 };
Point ( 303 ) = { -4.58333349, 52.16666794, 0.00000000 };
Point ( 304 ) = { -4.55000019, 52.16666794, 0.00000000 };
Point ( 305 ) = { -4.51666689, 52.16666794, 0.00000000 };
Point ( 306 ) = { -4.50000000, 52.18333435, 0.00000000 };
Point ( 307 ) = { -4.50000000, 52.21666718, 0.00000000 };
Point ( 308 ) = { -4.48333311, 52.23333359, 0.00000000 };
Point ( 309 ) = { -4.44999981, 52.23333359, 0.00000000 };
Point ( 310 ) = { -4.41666651, 52.23333359, 0.00000000 };
Point ( 311 ) = { -4.39999986, 52.25000000, 0.00000000 };
Point ( 312 ) = { -4.38333321, 52.26666641, 0.00000000 };
Point ( 313 ) = { -4.36666656, 52.28333282, 0.00000000 };
Point ( 314 ) = { -4.34999990, 52.29999924, 0.00000000 };
Point ( 315 ) = { -4.33333325, 52.31666565, 0.00000000 };
Point ( 316 ) = { -4.31666660, 52.33333206, 0.00000000 };
Point ( 317 ) = { -4.29999995, 52.34999847, 0.00000000 };
Point ( 318 ) = { -4.28333330, 52.36666679, 0.00000000 };
Point ( 319 ) = { -4.26666665, 52.38333511, 0.00000000 };
Point ( 320 ) = { -4.25000000, 52.40000153, 0.00000000 };
Point ( 321 ) = { -4.23333335, 52.41666794, 0.00000000 };
Point ( 322 ) = { -4.23333335, 52.45000076, 0.00000000 };
Point ( 323 ) = { -4.21666670, 52.46666718, 0.00000000 };
Point ( 324 ) = { -4.18333340, 52.46666718, 0.00000000 };
Point ( 325 ) = { -4.16666675, 52.48333359, 0.00000000 };
Point ( 326 ) = { -4.16666675, 52.51666641, 0.00000000 };
Point ( 327 ) = { -4.16666675, 52.54999924, 0.00000000 };
Point ( 328 ) = { -4.18333340, 52.56666565, 0.00000000 };
Point ( 329 ) = { -4.21666670, 52.56666565, 0.00000000 };
Point ( 330 ) = { -4.23333335, 52.58333206, 0.00000000 };
Point ( 331 ) = { -4.23333335, 52.61666489, 0.00000000 };
Point ( 332 ) = { -4.21666670, 52.63333321, 0.00000000 };
Point ( 333 ) = { -4.18333340, 52.63333321, 0.00000000 };
Point ( 334 ) = { -4.16666675, 52.65000153, 0.00000000 };
Point ( 335 ) = { -4.16666675, 52.68333435, 0.00000000 };
Point ( 336 ) = { -4.18333340, 52.70000076, 0.00000000 };
Point ( 337 ) = { -4.21666670, 52.70000076, 0.00000000 };
Point ( 338 ) = { -4.25000000, 52.70000076, 0.00000000 };
Point ( 339 ) = { -4.26666665, 52.71666718, 0.00000000 };
Point ( 340 ) = { -4.28333330, 52.73333359, 0.00000000 };
Point ( 341 ) = { -4.29999995, 52.71666718, 0.00000000 };
Point ( 342 ) = { -4.31666660, 52.70000076, 0.00000000 };
Point ( 343 ) = { -4.33333325, 52.68333435, 0.00000000 };
Point ( 344 ) = { -4.34999990, 52.66666794, 0.00000000 };
Point ( 345 ) = { -4.38333321, 52.66666794, 0.00000000 };
Point ( 346 ) = { -4.39999986, 52.68333435, 0.00000000 };
Point ( 347 ) = { -4.38333321, 52.70000076, 0.00000000 };
Point ( 348 ) = { -4.36666656, 52.71666718, 0.00000000 };
Point ( 349 ) = { -4.34999990, 52.73333359, 0.00000000 };
Point ( 350 ) = { -4.33333325, 52.75000000, 0.00000000 };
Point ( 351 ) = { -4.31666660, 52.76666641, 0.00000000 };
Point ( 352 ) = { -4.29999995, 52.78333282, 0.00000000 };
Point ( 353 ) = { -4.28333330, 52.79999924, 0.00000000 };
Point ( 354 ) = { -4.25000000, 52.79999924, 0.00000000 };
Point ( 355 ) = { -4.23333335, 52.81666565, 0.00000000 };
Point ( 356 ) = { -4.25000000, 52.83333206, 0.00000000 };
Point ( 357 ) = { -4.26666665, 52.84999847, 0.00000000 };
Point ( 358 ) = { -4.28333330, 52.86666679, 0.00000000 };
Point ( 359 ) = { -4.31666660, 52.86666679, 0.00000000 };
Point ( 360 ) = { -4.34999990, 52.86666679, 0.00000000 };
Point ( 361 ) = { -4.38333321, 52.86666679, 0.00000000 };
Point ( 362 ) = { -4.39999986, 52.84999847, 0.00000000 };
Point ( 363 ) = { -4.39999986, 52.81666565, 0.00000000 };
Point ( 364 ) = { -4.41666651, 52.79999924, 0.00000000 };
Point ( 365 ) = { -4.44999981, 52.79999924, 0.00000000 };
Point ( 366 ) = { -4.46666646, 52.78333282, 0.00000000 };
Point ( 367 ) = { -4.48333311, 52.76666641, 0.00000000 };
Point ( 368 ) = { -4.51666689, 52.76666641, 0.00000000 };
Point ( 369 ) = { -4.55000019, 52.76666641, 0.00000000 };
Point ( 370 ) = { -4.56666684, 52.78333282, 0.00000000 };
Point ( 371 ) = { -4.58333349, 52.79999924, 0.00000000 };
Point ( 372 ) = { -4.61666679, 52.79999924, 0.00000000 };
Point ( 373 ) = { -4.65000010, 52.79999924, 0.00000000 };
Point ( 374 ) = { -4.66666675, 52.78333282, 0.00000000 };
Point ( 375 ) = { -4.68333340, 52.76666641, 0.00000000 };
Point ( 376 ) = { -4.70000005, 52.78333282, 0.00000000 };
Point ( 377 ) = { -4.71666670, 52.79999924, 0.00000000 };
Point ( 378 ) = { -4.73333335, 52.78333282, 0.00000000 };
Point ( 379 ) = { -4.75000000, 52.76666641, 0.00000000 };
Point ( 380 ) = { -4.76666665, 52.75000000, 0.00000000 };
Point ( 381 ) = { -4.78333330, 52.73333359, 0.00000000 };
Point ( 382 ) = { -4.79999995, 52.75000000, 0.00000000 };
Point ( 383 ) = { -4.79999995, 52.78333282, 0.00000000 };
Point ( 384 ) = { -4.79999995, 52.81666565, 0.00000000 };
Point ( 385 ) = { -4.78333330, 52.83333206, 0.00000000 };
Point ( 386 ) = { -4.75000000, 52.83333206, 0.00000000 };
Point ( 387 ) = { -4.73333335, 52.84999847, 0.00000000 };
Point ( 388 ) = { -4.71666670, 52.86666679, 0.00000000 };
Point ( 389 ) = { -4.70000005, 52.88333511, 0.00000000 };
Point ( 390 ) = { -4.68333340, 52.90000153, 0.00000000 };
Point ( 391 ) = { -4.66666675, 52.91666794, 0.00000000 };
Point ( 392 ) = { -4.65000010, 52.93333435, 0.00000000 };
Point ( 393 ) = { -4.61666679, 52.93333435, 0.00000000 };
Point ( 394 ) = { -4.60000014, 52.95000076, 0.00000000 };
Point ( 395 ) = { -4.58333349, 52.96666718, 0.00000000 };
Point ( 396 ) = { -4.55000019, 52.96666718, 0.00000000 };
Point ( 397 ) = { -4.53333354, 52.98333359, 0.00000000 };
Point ( 398 ) = { -4.51666689, 53.00000000, 0.00000000 };
Point ( 399 ) = { -4.50000000, 53.01666641, 0.00000000 };
Point ( 400 ) = { -4.48333311, 53.03333282, 0.00000000 };
Point ( 401 ) = { -4.44999981, 53.03333282, 0.00000000 };
Point ( 402 ) = { -4.41666651, 53.03333282, 0.00000000 };
Point ( 403 ) = { -4.39999986, 53.04999924, 0.00000000 };
Point ( 404 ) = { -4.39999986, 53.08333206, 0.00000000 };
Point ( 405 ) = { -4.41666651, 53.09999847, 0.00000000 };
Point ( 406 ) = { -4.43333316, 53.11666489, 0.00000000 };
Point ( 407 ) = { -4.44999981, 53.13333321, 0.00000000 };
Point ( 408 ) = { -4.48333311, 53.13333321, 0.00000000 };
Point ( 409 ) = { -4.50000000, 53.15000153, 0.00000000 };
Point ( 410 ) = { -4.51666689, 53.16666794, 0.00000000 };
Point ( 411 ) = { -4.53333354, 53.18333435, 0.00000000 };
Point ( 412 ) = { -4.55000019, 53.20000076, 0.00000000 };
Point ( 413 ) = { -4.56666684, 53.21666718, 0.00000000 };
Point ( 414 ) = { -4.58333349, 53.23333359, 0.00000000 };
Point ( 415 ) = { -4.61666679, 53.23333359, 0.00000000 };
Point ( 416 ) = { -4.63333344, 53.25000000, 0.00000000 };
Point ( 417 ) = { -4.65000010, 53.26666641, 0.00000000 };
Point ( 418 ) = { -4.68333340, 53.26666641, 0.00000000 };
Point ( 419 ) = { -4.70000005, 53.28333282, 0.00000000 };
Point ( 420 ) = { -4.70000005, 53.31666565, 0.00000000 };
Point ( 421 ) = { -4.68333340, 53.33333206, 0.00000000 };
Point ( 422 ) = { -4.65000010, 53.33333206, 0.00000000 };
Point ( 423 ) = { -4.61666679, 53.33333206, 0.00000000 };
Point ( 424 ) = { -4.60000014, 53.34999847, 0.00000000 };
Point ( 425 ) = { -4.60000014, 53.38333511, 0.00000000 };
Point ( 426 ) = { -4.61666679, 53.40000153, 0.00000000 };
Point ( 427 ) = { -4.63333344, 53.41666794, 0.00000000 };
Point ( 428 ) = { -4.61666679, 53.43333435, 0.00000000 };
Point ( 429 ) = { -4.58333349, 53.43333435, 0.00000000 };
Point ( 430 ) = { -4.55000019, 53.43333435, 0.00000000 };
Point ( 431 ) = { -4.51666689, 53.43333435, 0.00000000 };
Point ( 432 ) = { -4.48333311, 53.43333435, 0.00000000 };
Point ( 433 ) = { -4.44999981, 53.43333435, 0.00000000 };
Point ( 434 ) = { -4.41666651, 53.43333435, 0.00000000 };
Point ( 435 ) = { -4.38333321, 53.43333435, 0.00000000 };
Point ( 436 ) = { -4.34999990, 53.43333435, 0.00000000 };
Point ( 437 ) = { -4.31666660, 53.43333435, 0.00000000 };
Point ( 438 ) = { -4.28333330, 53.43333435, 0.00000000 };
Point ( 439 ) = { -4.26666665, 53.41666794, 0.00000000 };
Point ( 440 ) = { -4.25000000, 53.40000153, 0.00000000 };
Point ( 441 ) = { -4.23333335, 53.38333511, 0.00000000 };
Point ( 442 ) = { -4.21666670, 53.36666679, 0.00000000 };
Point ( 443 ) = { -4.20000005, 53.34999847, 0.00000000 };
Point ( 444 ) = { -4.18333340, 53.33333206, 0.00000000 };
Point ( 445 ) = { -4.15000010, 53.33333206, 0.00000000 };
Point ( 446 ) = { -4.11666679, 53.33333206, 0.00000000 };
Point ( 447 ) = { -4.08333349, 53.33333206, 0.00000000 };
Point ( 448 ) = { -4.05000019, 53.33333206, 0.00000000 };
Point ( 449 ) = { -4.01666689, 53.33333206, 0.00000000 };
Point ( 450 ) = { -3.98333335, 53.33333206, 0.00000000 };
Point ( 451 ) = { -3.95000005, 53.33333206, 0.00000000 };
Point ( 452 ) = { -3.91666675, 53.33333206, 0.00000000 };
Point ( 453 ) = { -3.90000010, 53.34999847, 0.00000000 };
Point ( 454 ) = { -3.88333344, 53.36666679, 0.00000000 };
Point ( 455 ) = { -3.86666667, 53.34999847, 0.00000000 };
Point ( 456 ) = { -3.84999990, 53.33333206, 0.00000000 };
Point ( 457 ) = { -3.81666660, 53.33333206, 0.00000000 };
Point ( 458 ) = { -3.79999995, 53.34999847, 0.00000000 };
Point ( 459 ) = { -3.78333330, 53.36666679, 0.00000000 };
Point ( 460 ) = { -3.76666665, 53.34999847, 0.00000000 };
Point ( 461 ) = { -3.75000000, 53.33333206, 0.00000000 };
Point ( 462 ) = { -3.71666670, 53.33333206, 0.00000000 };
Point ( 463 ) = { -3.68333340, 53.33333206, 0.00000000 };
Point ( 464 ) = { -3.65000010, 53.33333206, 0.00000000 };
Point ( 465 ) = { -3.61666656, 53.33333206, 0.00000000 };
Point ( 466 ) = { -3.59999990, 53.34999847, 0.00000000 };
Point ( 467 ) = { -3.58333325, 53.36666679, 0.00000000 };
Point ( 468 ) = { -3.54999995, 53.36666679, 0.00000000 };
Point ( 469 ) = { -3.51666665, 53.36666679, 0.00000000 };
Point ( 470 ) = { -3.50000000, 53.38333511, 0.00000000 };
Point ( 471 ) = { -3.48333335, 53.40000153, 0.00000000 };
Point ( 472 ) = { -3.45000005, 53.40000153, 0.00000000 };
Point ( 473 ) = { -3.43333340, 53.41666794, 0.00000000 };
Point ( 474 ) = { -3.41666675, 53.43333435, 0.00000000 };
Point ( 475 ) = { -3.38333344, 53.43333435, 0.00000000 };
Point ( 476 ) = { -3.34999990, 53.43333435, 0.00000000 };
Point ( 477 ) = { -3.31666660, 53.43333435, 0.00000000 };
Point ( 478 ) = { -3.28333330, 53.43333435, 0.00000000 };
Point ( 479 ) = { -3.25000000, 53.43333435, 0.00000000 };
Point ( 480 ) = { -3.23333335, 53.45000076, 0.00000000 };
Point ( 481 ) = { -3.23333335, 53.48333359, 0.00000000 };
Point ( 482 ) = { -3.25000000, 53.50000000, 0.00000000 };
Point ( 483 ) = { -3.26666665, 53.51666641, 0.00000000 };
Point ( 484 ) = { -3.26666665, 53.54999924, 0.00000000 };
Point ( 485 ) = { -3.25000000, 53.56666565, 0.00000000 };
Point ( 486 ) = { -3.21666670, 53.56666565, 0.00000000 };
Point ( 487 ) = { -3.20000005, 53.58333206, 0.00000000 };
Point ( 488 ) = { -3.20000005, 53.61666489, 0.00000000 };
Point ( 489 ) = { -3.18333340, 53.63333321, 0.00000000 };
Point ( 490 ) = { -3.16666675, 53.65000153, 0.00000000 };
Point ( 491 ) = { -3.15000010, 53.66666794, 0.00000000 };
Point ( 492 ) = { -3.13333333, 53.68333435, 0.00000000 };
Point ( 493 ) = { -3.13333333, 53.71666718, 0.00000000 };
Point ( 494 ) = { -3.13333333, 53.75000000, 0.00000000 };
Point ( 495 ) = { -3.13333333, 53.78333282, 0.00000000 };
Point ( 496 ) = { -3.13333333, 53.81666565, 0.00000000 };
Point ( 497 ) = { -3.11666656, 53.83333206, 0.00000000 };
Point ( 498 ) = { -3.09999990, 53.84999847, 0.00000000 };
Point ( 499 ) = { -3.09999990, 53.88333511, 0.00000000 };
Point ( 500 ) = { -3.08333325, 53.90000153, 0.00000000 };
Point ( 501 ) = { -3.06666660, 53.91666794, 0.00000000 };
Point ( 502 ) = { -3.08333325, 53.93333435, 0.00000000 };
Point ( 503 ) = { -3.09999990, 53.95000076, 0.00000000 };
Point ( 504 ) = { -3.11666656, 53.96666718, 0.00000000 };
Point ( 505 ) = { -3.15000010, 53.96666718, 0.00000000 };
Point ( 506 ) = { -3.16666675, 53.98333359, 0.00000000 };
Point ( 507 ) = { -3.18333340, 54.00000000, 0.00000000 };
Point ( 508 ) = { -3.21666670, 54.00000000, 0.00000000 };
Point ( 509 ) = { -3.25000000, 54.00000000, 0.00000000 };
Point ( 510 ) = { -3.26666665, 54.01666641, 0.00000000 };
Point ( 511 ) = { -3.28333330, 54.03333282, 0.00000000 };
Point ( 512 ) = { -3.29999995, 54.04999924, 0.00000000 };
Point ( 513 ) = { -3.31666660, 54.06666565, 0.00000000 };
Point ( 514 ) = { -3.33333325, 54.08333206, 0.00000000 };
Point ( 515 ) = { -3.33333325, 54.11666489, 0.00000000 };
Point ( 516 ) = { -3.33333325, 54.15000153, 0.00000000 };
Point ( 517 ) = { -3.34999990, 54.16666794, 0.00000000 };
Point ( 518 ) = { -3.38333344, 54.16666794, 0.00000000 };
Point ( 519 ) = { -3.40000010, 54.18333435, 0.00000000 };
Point ( 520 ) = { -3.40000010, 54.21666718, 0.00000000 };
Point ( 521 ) = { -3.41666675, 54.23333359, 0.00000000 };
Point ( 522 ) = { -3.43333340, 54.25000000, 0.00000000 };
Point ( 523 ) = { -3.45000005, 54.26666641, 0.00000000 };
Point ( 524 ) = { -3.46666670, 54.28333282, 0.00000000 };
Point ( 525 ) = { -3.46666670, 54.31666565, 0.00000000 };
Point ( 526 ) = { -3.48333335, 54.33333206, 0.00000000 };
Point ( 527 ) = { -3.51666665, 54.33333206, 0.00000000 };
Point ( 528 ) = { -3.54999995, 54.33333206, 0.00000000 };
Point ( 529 ) = { -3.56666660, 54.34999847, 0.00000000 };
Point ( 530 ) = { -3.56666660, 54.38333511, 0.00000000 };
Point ( 531 ) = { -3.58333325, 54.40000153, 0.00000000 };
Point ( 532 ) = { -3.59999990, 54.41666794, 0.00000000 };
Point ( 533 ) = { -3.61666656, 54.43333435, 0.00000000 };
Point ( 534 ) = { -3.65000010, 54.43333435, 0.00000000 };
Point ( 535 ) = { -3.66666675, 54.45000076, 0.00000000 };
Point ( 536 ) = { -3.66666675, 54.48333359, 0.00000000 };
Point ( 537 ) = { -3.66666675, 54.51666641, 0.00000000 };
Point ( 538 ) = { -3.66666675, 54.54999924, 0.00000000 };
Point ( 539 ) = { -3.65000010, 54.56666565, 0.00000000 };
Point ( 540 ) = { -3.63333333, 54.58333206, 0.00000000 };
Point ( 541 ) = { -3.63333333, 54.61666489, 0.00000000 };
Point ( 542 ) = { -3.61666656, 54.63333321, 0.00000000 };
Point ( 543 ) = { -3.59999990, 54.65000153, 0.00000000 };
Point ( 544 ) = { -3.59999990, 54.68333435, 0.00000000 };
Point ( 545 ) = { -3.59999990, 54.71666718, 0.00000000 };
Point ( 546 ) = { -3.61666656, 54.73333359, 0.00000000 };
Point ( 547 ) = { -3.65000010, 54.73333359, 0.00000000 };
Point ( 548 ) = { -3.66666675, 54.71666718, 0.00000000 };
Point ( 549 ) = { -3.66666675, 54.68333435, 0.00000000 };
Point ( 550 ) = { -3.68333340, 54.66666794, 0.00000000 };
Point ( 551 ) = { -3.70000005, 54.68333435, 0.00000000 };
Point ( 552 ) = { -3.71666670, 54.70000076, 0.00000000 };
Point ( 553 ) = { -3.73333335, 54.71666718, 0.00000000 };
Point ( 554 ) = { -3.75000000, 54.73333359, 0.00000000 };
Point ( 555 ) = { -3.78333330, 54.73333359, 0.00000000 };
Point ( 556 ) = { -3.79999995, 54.75000000, 0.00000000 };
Point ( 557 ) = { -3.78333330, 54.76666641, 0.00000000 };
Point ( 558 ) = { -3.76666665, 54.78333282, 0.00000000 };
Point ( 559 ) = { -3.76666665, 54.81666565, 0.00000000 };
Point ( 560 ) = { -3.78333330, 54.83333206, 0.00000000 };
Point ( 561 ) = { -3.79999995, 54.81666565, 0.00000000 };
Point ( 562 ) = { -3.81666660, 54.79999924, 0.00000000 };
Point ( 563 ) = { -3.83333325, 54.78333282, 0.00000000 };
Point ( 564 ) = { -3.84999990, 54.76666641, 0.00000000 };
Point ( 565 ) = { -3.88333344, 54.76666641, 0.00000000 };
Point ( 566 ) = { -3.91666675, 54.76666641, 0.00000000 };
Point ( 567 ) = { -3.95000005, 54.76666641, 0.00000000 };
Point ( 568 ) = { -3.98333335, 54.76666641, 0.00000000 };
Point ( 569 ) = { -4.01666689, 54.76666641, 0.00000000 };
Point ( 570 ) = { -4.05000019, 54.76666641, 0.00000000 };
Point ( 571 ) = { -4.08333349, 54.76666641, 0.00000000 };
Point ( 572 ) = { -4.11666679, 54.76666641, 0.00000000 };
Point ( 573 ) = { -4.15000010, 54.76666641, 0.00000000 };
Point ( 574 ) = { -4.18333340, 54.76666641, 0.00000000 };
Point ( 575 ) = { -4.20000005, 54.78333282, 0.00000000 };
Point ( 576 ) = { -4.21666670, 54.79999924, 0.00000000 };
Point ( 577 ) = { -4.25000000, 54.79999924, 0.00000000 };
Point ( 578 ) = { -4.28333330, 54.79999924, 0.00000000 };
Point ( 579 ) = { -4.31666660, 54.79999924, 0.00000000 };
Point ( 580 ) = { -4.33333325, 54.78333282, 0.00000000 };
Point ( 581 ) = { -4.33333325, 54.75000000, 0.00000000 };
Point ( 582 ) = { -4.33333325, 54.71666718, 0.00000000 };
Point ( 583 ) = { -4.33333325, 54.68333435, 0.00000000 };
Point ( 584 ) = { -4.34999990, 54.66666794, 0.00000000 };
Point ( 585 ) = { -4.38333321, 54.66666794, 0.00000000 };
Point ( 586 ) = { -4.41666651, 54.66666794, 0.00000000 };
Point ( 587 ) = { -4.44999981, 54.66666794, 0.00000000 };
Point ( 588 ) = { -4.48333311, 54.66666794, 0.00000000 };
Point ( 589 ) = { -4.50000000, 54.68333435, 0.00000000 };
Point ( 590 ) = { -4.51666689, 54.70000076, 0.00000000 };
Point ( 591 ) = { -4.55000019, 54.70000076, 0.00000000 };
Point ( 592 ) = { -4.56666684, 54.71666718, 0.00000000 };
Point ( 593 ) = { -4.58333349, 54.73333359, 0.00000000 };
Point ( 594 ) = { -4.60000014, 54.75000000, 0.00000000 };
Point ( 595 ) = { -4.61666679, 54.76666641, 0.00000000 };
Point ( 596 ) = { -4.65000010, 54.76666641, 0.00000000 };
Point ( 597 ) = { -4.68333340, 54.76666641, 0.00000000 };
Point ( 598 ) = { -4.71666670, 54.76666641, 0.00000000 };
Point ( 599 ) = { -4.75000000, 54.76666641, 0.00000000 };
Point ( 600 ) = { -4.78333330, 54.76666641, 0.00000000 };
Point ( 601 ) = { -4.79999995, 54.78333282, 0.00000000 };
Point ( 602 ) = { -4.79999995, 54.81666565, 0.00000000 };
Point ( 603 ) = { -4.81666660, 54.83333206, 0.00000000 };
Point ( 604 ) = { -4.84999990, 54.83333206, 0.00000000 };
Point ( 605 ) = { -4.88333321, 54.83333206, 0.00000000 };
Point ( 606 ) = { -4.89999986, 54.81666565, 0.00000000 };
Point ( 607 ) = { -4.89999986, 54.78333282, 0.00000000 };
Point ( 608 ) = { -4.88333321, 54.76666641, 0.00000000 };
Point ( 609 ) = { -4.86666656, 54.75000000, 0.00000000 };
Point ( 610 ) = { -4.84999990, 54.73333359, 0.00000000 };
Point ( 611 ) = { -4.83333325, 54.71666718, 0.00000000 };
Point ( 612 ) = { -4.83333325, 54.68333435, 0.00000000 };
Point ( 613 ) = { -4.84999990, 54.66666794, 0.00000000 };
Point ( 614 ) = { -4.86666656, 54.65000153, 0.00000000 };
Point ( 615 ) = { -4.88333321, 54.63333321, 0.00000000 };
Point ( 616 ) = { -4.91666651, 54.63333321, 0.00000000 };
Point ( 617 ) = { -4.94999981, 54.63333321, 0.00000000 };
Point ( 618 ) = { -4.96666646, 54.65000153, 0.00000000 };
Point ( 619 ) = { -4.98333311, 54.66666794, 0.00000000 };
Point ( 620 ) = { -5.00000000, 54.68333435, 0.00000000 };
Point ( 621 ) = { -5.00000000, 54.71666718, 0.00000000 };
Point ( 622 ) = { -5.00000000, 54.75000000, 0.00000000 };
Point ( 623 ) = { -5.01666689, 54.76666641, 0.00000000 };
Point ( 624 ) = { -5.03333354, 54.78333282, 0.00000000 };
Point ( 625 ) = { -5.05000019, 54.79999924, 0.00000000 };
Point ( 626 ) = { -5.08333349, 54.79999924, 0.00000000 };
Point ( 627 ) = { -5.10000014, 54.81666565, 0.00000000 };
Point ( 628 ) = { -5.11666679, 54.83333206, 0.00000000 };
Point ( 629 ) = { -5.15000010, 54.83333206, 0.00000000 };
Point ( 630 ) = { -5.16666675, 54.84999847, 0.00000000 };
Point ( 631 ) = { -5.16666675, 54.88333511, 0.00000000 };
Point ( 632 ) = { -5.18333340, 54.90000153, 0.00000000 };
Point ( 633 ) = { -5.20000005, 54.91666794, 0.00000000 };
Point ( 634 ) = { -5.20000005, 54.95000076, 0.00000000 };
Point ( 635 ) = { -5.20000005, 54.98333359, 0.00000000 };
Point ( 636 ) = { -5.18333340, 55.00000000, 0.00000000 };
Point ( 637 ) = { -5.16666675, 55.01666641, 0.00000000 };
Point ( 638 ) = { -5.15000010, 55.03333282, 0.00000000 };
Point ( 639 ) = { -5.13333344, 55.04999924, 0.00000000 };
Point ( 640 ) = { -5.11666679, 55.06666565, 0.00000000 };
Point ( 641 ) = { -5.08333349, 55.06666565, 0.00000000 };
Point ( 642 ) = { -5.06666684, 55.08333206, 0.00000000 };
Point ( 643 ) = { -5.06666684, 55.11666489, 0.00000000 };
Point ( 644 ) = { -5.05000019, 55.13333321, 0.00000000 };
Point ( 645 ) = { -5.03333354, 55.15000153, 0.00000000 };
Point ( 646 ) = { -5.01666689, 55.16666794, 0.00000000 };
Point ( 647 ) = { -5.00000000, 55.18333435, 0.00000000 };
Point ( 648 ) = { -4.98333311, 55.20000076, 0.00000000 };
Point ( 649 ) = { -4.96666646, 55.21666718, 0.00000000 };
Point ( 650 ) = { -4.94999981, 55.23333359, 0.00000000 };
Point ( 651 ) = { -4.91666651, 55.23333359, 0.00000000 };
Point ( 652 ) = { -4.89999986, 55.25000000, 0.00000000 };
Point ( 653 ) = { -4.89999986, 55.28333282, 0.00000000 };
Point ( 654 ) = { -4.88333321, 55.29999924, 0.00000000 };
Point ( 655 ) = { -4.86666656, 55.31666565, 0.00000000 };
Point ( 656 ) = { -4.84999990, 55.33333206, 0.00000000 };
Point ( 657 ) = { -4.83333325, 55.34999847, 0.00000000 };
Point ( 658 ) = { -4.81666660, 55.36666679, 0.00000000 };
Point ( 659 ) = { -4.79999995, 55.38333511, 0.00000000 };
Point ( 660 ) = { -4.78333330, 55.40000153, 0.00000000 };
Point ( 661 ) = { -4.76666665, 55.41666794, 0.00000000 };
Point ( 662 ) = { -4.75000000, 55.43333435, 0.00000000 };
Point ( 663 ) = { -4.73333335, 55.45000076, 0.00000000 };
Point ( 664 ) = { -4.73333335, 55.48333359, 0.00000000 };
Point ( 665 ) = { -4.75000000, 55.50000000, 0.00000000 };
Point ( 666 ) = { -4.76666665, 55.51666641, 0.00000000 };
Point ( 667 ) = { -4.75000000, 55.53333282, 0.00000000 };
Point ( 668 ) = { -4.73333335, 55.54999924, 0.00000000 };
Point ( 669 ) = { -4.73333335, 55.58333206, 0.00000000 };
Point ( 670 ) = { -4.75000000, 55.59999847, 0.00000000 };
Point ( 671 ) = { -4.78333330, 55.59999847, 0.00000000 };
Point ( 672 ) = { -4.79999995, 55.61666489, 0.00000000 };
Point ( 673 ) = { -4.81666660, 55.63333321, 0.00000000 };
Point ( 674 ) = { -4.84999990, 55.63333321, 0.00000000 };
Point ( 675 ) = { -4.88333321, 55.63333321, 0.00000000 };
Point ( 676 ) = { -4.89999986, 55.65000153, 0.00000000 };
Point ( 677 ) = { -4.91666651, 55.66666794, 0.00000000 };
Point ( 678 ) = { -4.93333316, 55.68333435, 0.00000000 };
Point ( 679 ) = { -4.94999981, 55.70000076, 0.00000000 };
Point ( 680 ) = { -4.98333311, 55.70000076, 0.00000000 };
Point ( 681 ) = { -5.01666689, 55.70000076, 0.00000000 };
Point ( 682 ) = { -5.03333354, 55.71666718, 0.00000000 };
Point ( 683 ) = { -5.05000019, 55.73333359, 0.00000000 };
Point ( 684 ) = { -5.08333349, 55.73333359, 0.00000000 };
Point ( 685 ) = { -5.10000014, 55.75000000, 0.00000000 };
Point ( 686 ) = { -5.11666679, 55.76666641, 0.00000000 };
Point ( 687 ) = { -5.15000010, 55.76666641, 0.00000000 };
Point ( 688 ) = { -5.16666675, 55.78333282, 0.00000000 };
Point ( 689 ) = { -5.16666675, 55.81666565, 0.00000000 };
Point ( 690 ) = { -5.18333340, 55.83333206, 0.00000000 };
Point ( 691 ) = { -5.20000005, 55.81666565, 0.00000000 };
Point ( 692 ) = { -5.21666670, 55.79999924, 0.00000000 };
Point ( 693 ) = { -5.23333335, 55.81666565, 0.00000000 };
Point ( 694 ) = { -5.25000000, 55.83333206, 0.00000000 };
Point ( 695 ) = { -5.28333330, 55.83333206, 0.00000000 };
Point ( 696 ) = { -5.31666660, 55.83333206, 0.00000000 };
Point ( 697 ) = { -5.33333325, 55.81666565, 0.00000000 };
Point ( 698 ) = { -5.31666660, 55.79999924, 0.00000000 };
Point ( 699 ) = { -5.29999995, 55.78333282, 0.00000000 };
Point ( 700 ) = { -5.31666660, 55.76666641, 0.00000000 };
Point ( 701 ) = { -5.33333325, 55.75000000, 0.00000000 };
Point ( 702 ) = { -5.34999990, 55.73333359, 0.00000000 };
Point ( 703 ) = { -5.38333321, 55.73333359, 0.00000000 };
Point ( 704 ) = { -5.41666651, 55.73333359, 0.00000000 };
Point ( 705 ) = { -5.43333316, 55.71666718, 0.00000000 };
Point ( 706 ) = { -5.43333316, 55.68333435, 0.00000000 };
Point ( 707 ) = { -5.44999981, 55.66666794, 0.00000000 };
Point ( 708 ) = { -5.46666646, 55.65000153, 0.00000000 };
Point ( 709 ) = { -5.46666646, 55.61666489, 0.00000000 };
Point ( 710 ) = { -5.46666646, 55.58333206, 0.00000000 };
Point ( 711 ) = { -5.46666646, 55.54999924, 0.00000000 };
Point ( 712 ) = { -5.48333311, 55.53333282, 0.00000000 };
Point ( 713 ) = { -5.50000000, 55.51666641, 0.00000000 };
Point ( 714 ) = { -5.50000000, 55.48333359, 0.00000000 };
Point ( 715 ) = { -5.51666689, 55.46666718, 0.00000000 };
Point ( 716 ) = { -5.53333354, 55.45000076, 0.00000000 };
Point ( 717 ) = { -5.51666689, 55.43333435, 0.00000000 };
Point ( 718 ) = { -5.50000000, 55.41666794, 0.00000000 };
Point ( 719 ) = { -5.50000000, 55.38333511, 0.00000000 };
Point ( 720 ) = { -5.50000000, 55.34999847, 0.00000000 };
Point ( 721 ) = { -5.51666689, 55.33333206, 0.00000000 };
Point ( 722 ) = { -5.55000019, 55.33333206, 0.00000000 };
Point ( 723 ) = { -5.56666684, 55.31666565, 0.00000000 };
Point ( 724 ) = { -5.55000019, 55.29999924, 0.00000000 };
Point ( 725 ) = { -5.53333354, 55.28333282, 0.00000000 };
Point ( 726 ) = { -5.55000019, 55.26666641, 0.00000000 };
Point ( 727 ) = { -5.58333349, 55.26666641, 0.00000000 };
Point ( 728 ) = { -5.60000014, 55.28333282, 0.00000000 };
Point ( 729 ) = { -5.61666679, 55.29999924, 0.00000000 };
Point ( 730 ) = { -5.65000010, 55.29999924, 0.00000000 };
Point ( 731 ) = { -5.68333340, 55.29999924, 0.00000000 };
Point ( 732 ) = { -5.70000005, 55.28333282, 0.00000000 };
Point ( 733 ) = { -5.71666670, 55.26666641, 0.00000000 };
Point ( 734 ) = { -5.75000000, 55.26666641, 0.00000000 };
Point ( 735 ) = { -5.76666665, 55.28333282, 0.00000000 };
Point ( 736 ) = { -5.78333330, 55.29999924, 0.00000000 };
Point ( 737 ) = { -5.79999995, 55.31666565, 0.00000000 };
Point ( 738 ) = { -5.79999995, 55.34999847, 0.00000000 };
Point ( 739 ) = { -5.81666660, 55.36666679, 0.00000000 };
Point ( 740 ) = { -5.83333325, 55.38333511, 0.00000000 };
Point ( 741 ) = { -5.81666660, 55.40000153, 0.00000000 };
Point ( 742 ) = { -5.79999995, 55.41666794, 0.00000000 };
Point ( 743 ) = { -5.78333330, 55.43333435, 0.00000000 };
Point ( 744 ) = { -5.76666665, 55.45000076, 0.00000000 };
Point ( 745 ) = { -5.76666665, 55.48333359, 0.00000000 };
Point ( 746 ) = { -5.75000000, 55.50000000, 0.00000000 };
Point ( 747 ) = { -5.73333335, 55.51666641, 0.00000000 };
Point ( 748 ) = { -5.73333335, 55.54999924, 0.00000000 };
Point ( 749 ) = { -5.75000000, 55.56666565, 0.00000000 };
Point ( 750 ) = { -5.76666665, 55.58333206, 0.00000000 };
Point ( 751 ) = { -5.76666665, 55.61666489, 0.00000000 };
Point ( 752 ) = { -5.78333330, 55.63333321, 0.00000000 };
Point ( 753 ) = { -5.79999995, 55.65000153, 0.00000000 };
Point ( 754 ) = { -5.79999995, 55.68333435, 0.00000000 };
Point ( 755 ) = { -5.78333330, 55.70000076, 0.00000000 };
Point ( 756 ) = { -5.76666665, 55.71666718, 0.00000000 };
Point ( 757 ) = { -5.75000000, 55.73333359, 0.00000000 };
Point ( 758 ) = { -5.71666670, 55.73333359, 0.00000000 };
Point ( 759 ) = { -5.70000005, 55.75000000, 0.00000000 };
Point ( 760 ) = { -5.68333340, 55.76666641, 0.00000000 };
Point ( 761 ) = { -5.66666675, 55.78333282, 0.00000000 };
Point ( 762 ) = { -5.68333340, 55.79999924, 0.00000000 };
Point ( 763 ) = { -5.70000005, 55.81666565, 0.00000000 };
Point ( 764 ) = { -5.70000005, 55.84999847, 0.00000000 };
Point ( 765 ) = { -5.71666670, 55.86666679, 0.00000000 };
Point ( 766 ) = { -5.73333335, 55.88333511, 0.00000000 };
Point ( 767 ) = { -5.75000000, 55.90000153, 0.00000000 };
Point ( 768 ) = { -5.76666665, 55.91666794, 0.00000000 };
Point ( 769 ) = { -5.78333330, 55.93333435, 0.00000000 };
Point ( 770 ) = { -5.81666660, 55.93333435, 0.00000000 };
Point ( 771 ) = { -5.83333325, 55.91666794, 0.00000000 };
Point ( 772 ) = { -5.83333325, 55.88333511, 0.00000000 };
Point ( 773 ) = { -5.83333325, 55.84999847, 0.00000000 };
Point ( 774 ) = { -5.84999990, 55.83333206, 0.00000000 };
Point ( 775 ) = { -5.88333321, 55.83333206, 0.00000000 };
Point ( 776 ) = { -5.91666651, 55.83333206, 0.00000000 };
Point ( 777 ) = { -5.93333316, 55.81666565, 0.00000000 };
Point ( 778 ) = { -5.94999981, 55.79999924, 0.00000000 };
Point ( 779 ) = { -5.96666646, 55.78333282, 0.00000000 };
Point ( 780 ) = { -5.98333311, 55.76666641, 0.00000000 };
Point ( 781 ) = { -6.01666689, 55.76666641, 0.00000000 };
Point ( 782 ) = { -6.03333354, 55.75000000, 0.00000000 };
Point ( 783 ) = { -6.01666689, 55.73333359, 0.00000000 };
Point ( 784 ) = { -6.00000000, 55.71666718, 0.00000000 };
Point ( 785 ) = { -6.00000000, 55.68333435, 0.00000000 };
Point ( 786 ) = { -6.01666689, 55.66666794, 0.00000000 };
Point ( 787 ) = { -6.03333354, 55.65000153, 0.00000000 };
Point ( 788 ) = { -6.05000019, 55.63333321, 0.00000000 };
Point ( 789 ) = { -6.08333349, 55.63333321, 0.00000000 };
Point ( 790 ) = { -6.10000014, 55.61666489, 0.00000000 };
Point ( 791 ) = { -6.11666679, 55.59999847, 0.00000000 };
Point ( 792 ) = { -6.13333344, 55.58333206, 0.00000000 };
Point ( 793 ) = { -6.15000010, 55.56666565, 0.00000000 };
Point ( 794 ) = { -6.18333340, 55.56666565, 0.00000000 };
Point ( 795 ) = { -6.21666670, 55.56666565, 0.00000000 };
Point ( 796 ) = { -6.25000000, 55.56666565, 0.00000000 };
Point ( 797 ) = { -6.28333330, 55.56666565, 0.00000000 };
Point ( 798 ) = { -6.31666660, 55.56666565, 0.00000000 };
Point ( 799 ) = { -6.33333325, 55.58333206, 0.00000000 };
Point ( 800 ) = { -6.34999990, 55.59999847, 0.00000000 };
Point ( 801 ) = { -6.36666656, 55.61666489, 0.00000000 };
Point ( 802 ) = { -6.34999990, 55.63333321, 0.00000000 };
Point ( 803 ) = { -6.33333325, 55.65000153, 0.00000000 };
Point ( 804 ) = { -6.33333325, 55.68333435, 0.00000000 };
Point ( 805 ) = { -6.34999990, 55.70000076, 0.00000000 };
Point ( 806 ) = { -6.36666656, 55.71666718, 0.00000000 };
Point ( 807 ) = { -6.38333321, 55.73333359, 0.00000000 };
Point ( 808 ) = { -6.39999986, 55.71666718, 0.00000000 };
Point ( 809 ) = { -6.41666651, 55.70000076, 0.00000000 };
Point ( 810 ) = { -6.43333316, 55.68333435, 0.00000000 };
Point ( 811 ) = { -6.44999981, 55.66666794, 0.00000000 };
Point ( 812 ) = { -6.48333311, 55.66666794, 0.00000000 };
Point ( 813 ) = { -6.51666689, 55.66666794, 0.00000000 };
Point ( 814 ) = { -6.55000019, 55.66666794, 0.00000000 };
Point ( 815 ) = { -6.56666684, 55.68333435, 0.00000000 };
Point ( 816 ) = { -6.56666684, 55.71666718, 0.00000000 };
Point ( 817 ) = { -6.55000019, 55.73333359, 0.00000000 };
Point ( 818 ) = { -6.53333354, 55.75000000, 0.00000000 };
Point ( 819 ) = { -6.51666689, 55.76666641, 0.00000000 };
Point ( 820 ) = { -6.50000000, 55.78333282, 0.00000000 };
Point ( 821 ) = { -6.50000000, 55.81666565, 0.00000000 };
Point ( 822 ) = { -6.50000000, 55.84999847, 0.00000000 };
Point ( 823 ) = { -6.48333311, 55.86666679, 0.00000000 };
Point ( 824 ) = { -6.44999981, 55.86666679, 0.00000000 };
Point ( 825 ) = { -6.43333316, 55.88333511, 0.00000000 };
Point ( 826 ) = { -6.41666651, 55.90000153, 0.00000000 };
Point ( 827 ) = { -6.38333321, 55.90000153, 0.00000000 };
Point ( 828 ) = { -6.36666656, 55.91666794, 0.00000000 };
Point ( 829 ) = { -6.34999990, 55.93333435, 0.00000000 };
Point ( 830 ) = { -6.31666660, 55.93333435, 0.00000000 };
Point ( 831 ) = { -6.29999995, 55.91666794, 0.00000000 };
Point ( 832 ) = { -6.28333330, 55.90000153, 0.00000000 };
Point ( 833 ) = { -6.25000000, 55.90000153, 0.00000000 };
Point ( 834 ) = { -6.23333335, 55.91666794, 0.00000000 };
Point ( 835 ) = { -6.21666670, 55.93333435, 0.00000000 };
Point ( 836 ) = { -6.18333340, 55.93333435, 0.00000000 };
Point ( 837 ) = { -6.15000010, 55.93333435, 0.00000000 };
Point ( 838 ) = { -6.11666679, 55.93333435, 0.00000000 };
Point ( 839 ) = { -6.08333349, 55.93333435, 0.00000000 };
Point ( 840 ) = { -6.06666684, 55.95000076, 0.00000000 };
Point ( 841 ) = { -6.05000019, 55.96666718, 0.00000000 };
Point ( 842 ) = { -6.03333354, 55.98333359, 0.00000000 };
Point ( 843 ) = { -6.01666689, 56.00000000, 0.00000000 };
Point ( 844 ) = { -6.00000000, 56.01666641, 0.00000000 };
Point ( 845 ) = { -5.98333311, 56.03333282, 0.00000000 };
Point ( 846 ) = { -5.96666646, 56.04999924, 0.00000000 };
Point ( 847 ) = { -5.94999981, 56.06666565, 0.00000000 };
Point ( 848 ) = { -5.91666651, 56.06666565, 0.00000000 };
Point ( 849 ) = { -5.89999986, 56.08333206, 0.00000000 };
Point ( 850 ) = { -5.88333321, 56.09999847, 0.00000000 };
Point ( 851 ) = { -5.84999990, 56.09999847, 0.00000000 };
Point ( 852 ) = { -5.83333325, 56.11666489, 0.00000000 };
Point ( 853 ) = { -5.81666660, 56.13333321, 0.00000000 };
Point ( 854 ) = { -5.78333330, 56.13333321, 0.00000000 };
Point ( 855 ) = { -5.76666665, 56.15000153, 0.00000000 };
Point ( 856 ) = { -5.76666665, 56.18333435, 0.00000000 };
Point ( 857 ) = { -5.75000000, 56.20000076, 0.00000000 };
Point ( 858 ) = { -5.73333335, 56.21666718, 0.00000000 };
Point ( 859 ) = { -5.75000000, 56.23333359, 0.00000000 };
Point ( 860 ) = { -5.78333330, 56.23333359, 0.00000000 };
Point ( 861 ) = { -5.79999995, 56.21666718, 0.00000000 };
Point ( 862 ) = { -5.81666660, 56.20000076, 0.00000000 };
Point ( 863 ) = { -5.84999990, 56.20000076, 0.00000000 };
Point ( 864 ) = { -5.86666656, 56.21666718, 0.00000000 };
Point ( 865 ) = { -5.84999990, 56.23333359, 0.00000000 };
Point ( 866 ) = { -5.81666660, 56.23333359, 0.00000000 };
Point ( 867 ) = { -5.79999995, 56.25000000, 0.00000000 };
Point ( 868 ) = { -5.78333330, 56.26666641, 0.00000000 };
Point ( 869 ) = { -5.75000000, 56.26666641, 0.00000000 };
Point ( 870 ) = { -5.73333335, 56.28333282, 0.00000000 };
Point ( 871 ) = { -5.75000000, 56.29999924, 0.00000000 };
Point ( 872 ) = { -5.78333330, 56.29999924, 0.00000000 };
Point ( 873 ) = { -5.81666660, 56.29999924, 0.00000000 };
Point ( 874 ) = { -5.84999990, 56.29999924, 0.00000000 };
Point ( 875 ) = { -5.88333321, 56.29999924, 0.00000000 };
Point ( 876 ) = { -5.91666651, 56.29999924, 0.00000000 };
Point ( 877 ) = { -5.93333316, 56.28333282, 0.00000000 };
Point ( 878 ) = { -5.94999981, 56.26666641, 0.00000000 };
Point ( 879 ) = { -5.98333311, 56.26666641, 0.00000000 };
Point ( 880 ) = { -6.01666689, 56.26666641, 0.00000000 };
Point ( 881 ) = { -6.05000019, 56.26666641, 0.00000000 };
Point ( 882 ) = { -6.08333349, 56.26666641, 0.00000000 };
Point ( 883 ) = { -6.11666679, 56.26666641, 0.00000000 };
Point ( 884 ) = { -6.15000010, 56.26666641, 0.00000000 };
Point ( 885 ) = { -6.18333340, 56.26666641, 0.00000000 };
Point ( 886 ) = { -6.21666670, 56.26666641, 0.00000000 };
Point ( 887 ) = { -6.25000000, 56.26666641, 0.00000000 };
Point ( 888 ) = { -6.28333330, 56.26666641, 0.00000000 };
Point ( 889 ) = { -6.31666660, 56.26666641, 0.00000000 };
Point ( 890 ) = { -6.33333325, 56.25000000, 0.00000000 };
Point ( 891 ) = { -6.34999990, 56.23333359, 0.00000000 };
Point ( 892 ) = { -6.36666656, 56.21666718, 0.00000000 };
Point ( 893 ) = { -6.38333321, 56.20000076, 0.00000000 };
Point ( 894 ) = { -6.41666651, 56.20000076, 0.00000000 };
Point ( 895 ) = { -6.44999981, 56.20000076, 0.00000000 };
Point ( 896 ) = { -6.46666646, 56.21666718, 0.00000000 };
Point ( 897 ) = { -6.46666646, 56.25000000, 0.00000000 };
Point ( 898 ) = { -6.48333311, 56.26666641, 0.00000000 };
Point ( 899 ) = { -6.50000000, 56.28333282, 0.00000000 };
Point ( 900 ) = { -6.48333311, 56.29999924, 0.00000000 };
Point ( 901 ) = { -6.46666646, 56.31666565, 0.00000000 };
Point ( 902 ) = { -6.48333311, 56.33333206, 0.00000000 };
Point ( 903 ) = { -6.50000000, 56.34999847, 0.00000000 };
Point ( 904 ) = { -6.48333311, 56.36666679, 0.00000000 };
Point ( 905 ) = { -6.44999981, 56.36666679, 0.00000000 };
Point ( 906 ) = { -6.41666651, 56.36666679, 0.00000000 };
Point ( 907 ) = { -6.38333321, 56.36666679, 0.00000000 };
Point ( 908 ) = { -6.34999990, 56.36666679, 0.00000000 };
Point ( 909 ) = { -6.31666660, 56.36666679, 0.00000000 };
Point ( 910 ) = { -6.28333330, 56.36666679, 0.00000000 };
Point ( 911 ) = { -6.25000000, 56.36666679, 0.00000000 };
Point ( 912 ) = { -6.23333335, 56.38333511, 0.00000000 };
Point ( 913 ) = { -6.25000000, 56.40000153, 0.00000000 };
Point ( 914 ) = { -6.26666665, 56.41666794, 0.00000000 };
Point ( 915 ) = { -6.28333330, 56.43333435, 0.00000000 };
Point ( 916 ) = { -6.31666660, 56.43333435, 0.00000000 };
Point ( 917 ) = { -6.33333325, 56.45000076, 0.00000000 };
Point ( 918 ) = { -6.33333325, 56.48333359, 0.00000000 };
Point ( 919 ) = { -6.34999990, 56.50000000, 0.00000000 };
Point ( 920 ) = { -6.38333321, 56.50000000, 0.00000000 };
Point ( 921 ) = { -6.39999986, 56.48333359, 0.00000000 };
Point ( 922 ) = { -6.41666651, 56.46666718, 0.00000000 };
Point ( 923 ) = { -6.43333316, 56.48333359, 0.00000000 };
Point ( 924 ) = { -6.43333316, 56.51666641, 0.00000000 };
Point ( 925 ) = { -6.41666651, 56.53333282, 0.00000000 };
Point ( 926 ) = { -6.38333321, 56.53333282, 0.00000000 };
Point ( 927 ) = { -6.36666656, 56.54999924, 0.00000000 };
Point ( 928 ) = { -6.34999990, 56.56666565, 0.00000000 };
Point ( 929 ) = { -6.33333325, 56.58333206, 0.00000000 };
Point ( 930 ) = { -6.31666660, 56.59999847, 0.00000000 };
Point ( 931 ) = { -6.29999995, 56.61666489, 0.00000000 };
Point ( 932 ) = { -6.28333330, 56.63333321, 0.00000000 };
Point ( 933 ) = { -6.25000000, 56.63333321, 0.00000000 };
Point ( 934 ) = { -6.23333335, 56.65000153, 0.00000000 };
Point ( 935 ) = { -6.21666670, 56.66666794, 0.00000000 };
Point ( 936 ) = { -6.20000005, 56.68333435, 0.00000000 };
Point ( 937 ) = { -6.21666670, 56.70000076, 0.00000000 };
Point ( 938 ) = { -6.23333335, 56.71666718, 0.00000000 };
Point ( 939 ) = { -6.21666670, 56.73333359, 0.00000000 };
Point ( 940 ) = { -6.20000005, 56.75000000, 0.00000000 };
Point ( 941 ) = { -6.18333340, 56.76666641, 0.00000000 };
Point ( 942 ) = { -6.15000010, 56.76666641, 0.00000000 };
Point ( 943 ) = { -6.13333344, 56.78333282, 0.00000000 };
Point ( 944 ) = { -6.11666679, 56.79999924, 0.00000000 };
Point ( 945 ) = { -6.08333349, 56.79999924, 0.00000000 };
Point ( 946 ) = { -6.06666684, 56.81666565, 0.00000000 };
Point ( 947 ) = { -6.05000019, 56.83333206, 0.00000000 };
Point ( 948 ) = { -6.01666689, 56.83333206, 0.00000000 };
Point ( 949 ) = { -5.98333311, 56.83333206, 0.00000000 };
Point ( 950 ) = { -5.96666646, 56.81666565, 0.00000000 };
Point ( 951 ) = { -5.94999981, 56.79999924, 0.00000000 };
Point ( 952 ) = { -5.91666651, 56.79999924, 0.00000000 };
Point ( 953 ) = { -5.89999986, 56.81666565, 0.00000000 };
Point ( 954 ) = { -5.88333321, 56.83333206, 0.00000000 };
Point ( 955 ) = { -5.86666656, 56.84999847, 0.00000000 };
Point ( 956 ) = { -5.88333321, 56.86666679, 0.00000000 };
Point ( 957 ) = { -5.91666651, 56.86666679, 0.00000000 };
Point ( 958 ) = { -5.93333316, 56.88333511, 0.00000000 };
Point ( 959 ) = { -5.93333316, 56.91666794, 0.00000000 };
Point ( 960 ) = { -5.91666651, 56.93333435, 0.00000000 };
Point ( 961 ) = { -5.89999986, 56.95000076, 0.00000000 };
Point ( 962 ) = { -5.88333321, 56.96666718, 0.00000000 };
Point ( 963 ) = { -5.86666656, 56.98333359, 0.00000000 };
Point ( 964 ) = { -5.84999990, 57.00000000, 0.00000000 };
Point ( 965 ) = { -5.83333325, 57.01666641, 0.00000000 };
Point ( 966 ) = { -5.83333325, 57.04999924, 0.00000000 };
Point ( 967 ) = { -5.84999990, 57.06666565, 0.00000000 };
Point ( 968 ) = { -5.88333321, 57.06666565, 0.00000000 };
Point ( 969 ) = { -5.89999986, 57.04999924, 0.00000000 };
Point ( 970 ) = { -5.91666651, 57.03333282, 0.00000000 };
Point ( 971 ) = { -5.94999981, 57.03333282, 0.00000000 };
Point ( 972 ) = { -5.98333311, 57.03333282, 0.00000000 };
Point ( 973 ) = { -6.00000000, 57.01666641, 0.00000000 };
Point ( 974 ) = { -6.01666689, 57.00000000, 0.00000000 };
Point ( 975 ) = { -6.03333354, 57.01666641, 0.00000000 };
Point ( 976 ) = { -6.05000019, 57.03333282, 0.00000000 };
Point ( 977 ) = { -6.06666684, 57.04999924, 0.00000000 };
Point ( 978 ) = { -6.05000019, 57.06666565, 0.00000000 };
Point ( 979 ) = { -6.03333354, 57.08333206, 0.00000000 };
Point ( 980 ) = { -6.03333354, 57.11666489, 0.00000000 };
Point ( 981 ) = { -6.05000019, 57.13333321, 0.00000000 };
Point ( 982 ) = { -6.06666684, 57.11666489, 0.00000000 };
Point ( 983 ) = { -6.08333349, 57.09999847, 0.00000000 };
Point ( 984 ) = { -6.10000014, 57.11666489, 0.00000000 };
Point ( 985 ) = { -6.11666679, 57.13333321, 0.00000000 };
Point ( 986 ) = { -6.15000010, 57.13333321, 0.00000000 };
Point ( 987 ) = { -6.18333340, 57.13333321, 0.00000000 };
Point ( 988 ) = { -6.21666670, 57.13333321, 0.00000000 };
Point ( 989 ) = { -6.25000000, 57.13333321, 0.00000000 };
Point ( 990 ) = { -6.28333330, 57.13333321, 0.00000000 };
Point ( 991 ) = { -6.31666660, 57.13333321, 0.00000000 };
Point ( 992 ) = { -6.33333325, 57.15000153, 0.00000000 };
Point ( 993 ) = { -6.34999990, 57.16666794, 0.00000000 };
Point ( 994 ) = { -6.38333321, 57.16666794, 0.00000000 };
Point ( 995 ) = { -6.41666651, 57.16666794, 0.00000000 };
Point ( 996 ) = { -6.43333316, 57.18333435, 0.00000000 };
Point ( 997 ) = { -6.43333316, 57.21666718, 0.00000000 };
Point ( 998 ) = { -6.44999981, 57.23333359, 0.00000000 };
Point ( 999 ) = { -6.46666646, 57.25000000, 0.00000000 };
Point ( 1000 ) = { -6.48333311, 57.26666641, 0.00000000 };
Point ( 1001 ) = { -6.50000000, 57.28333282, 0.00000000 };
Point ( 1002 ) = { -6.50000000, 57.31666565, 0.00000000 };
Point ( 1003 ) = { -6.51666689, 57.33333206, 0.00000000 };
Point ( 1004 ) = { -6.55000019, 57.33333206, 0.00000000 };
Point ( 1005 ) = { -6.58333349, 57.33333206, 0.00000000 };
Point ( 1006 ) = { -6.61666679, 57.33333206, 0.00000000 };
Point ( 1007 ) = { -6.65000010, 57.33333206, 0.00000000 };
Point ( 1008 ) = { -6.68333340, 57.33333206, 0.00000000 };
Point ( 1009 ) = { -6.70000005, 57.34999847, 0.00000000 };
Point ( 1010 ) = { -6.71666670, 57.36666679, 0.00000000 };
Point ( 1011 ) = { -6.73333335, 57.38333511, 0.00000000 };
Point ( 1012 ) = { -6.75000000, 57.40000153, 0.00000000 };
Point ( 1013 ) = { -6.78333330, 57.40000153, 0.00000000 };
Point ( 1014 ) = { -6.79999995, 57.41666794, 0.00000000 };
Point ( 1015 ) = { -6.79999995, 57.45000076, 0.00000000 };
Point ( 1016 ) = { -6.78333330, 57.46666718, 0.00000000 };
Point ( 1017 ) = { -6.76666665, 57.48333359, 0.00000000 };
Point ( 1018 ) = { -6.75000000, 57.50000000, 0.00000000 };
Point ( 1019 ) = { -6.73333335, 57.51666641, 0.00000000 };
Point ( 1020 ) = { -6.71666670, 57.53333282, 0.00000000 };
Point ( 1021 ) = { -6.68333340, 57.53333282, 0.00000000 };
Point ( 1022 ) = { -6.66666675, 57.54999924, 0.00000000 };
Point ( 1023 ) = { -6.66666675, 57.58333206, 0.00000000 };
Point ( 1024 ) = { -6.65000010, 57.59999847, 0.00000000 };
Point ( 1025 ) = { -6.61666679, 57.59999847, 0.00000000 };
Point ( 1026 ) = { -6.58333349, 57.59999847, 0.00000000 };
Point ( 1027 ) = { -6.55000019, 57.59999847, 0.00000000 };
Point ( 1028 ) = { -6.51666689, 57.59999847, 0.00000000 };
Point ( 1029 ) = { -6.50000000, 57.58333206, 0.00000000 };
Point ( 1030 ) = { -6.51666689, 57.56666565, 0.00000000 };
Point ( 1031 ) = { -6.53333354, 57.54999924, 0.00000000 };
Point ( 1032 ) = { -6.51666689, 57.53333282, 0.00000000 };
Point ( 1033 ) = { -6.48333311, 57.53333282, 0.00000000 };
Point ( 1034 ) = { -6.44999981, 57.53333282, 0.00000000 };
Point ( 1035 ) = { -6.41666651, 57.53333282, 0.00000000 };
Point ( 1036 ) = { -6.39999986, 57.54999924, 0.00000000 };
Point ( 1037 ) = { -6.39999986, 57.58333206, 0.00000000 };
Point ( 1038 ) = { -6.39999986, 57.61666489, 0.00000000 };
Point ( 1039 ) = { -6.41666651, 57.63333321, 0.00000000 };
Point ( 1040 ) = { -6.43333316, 57.65000153, 0.00000000 };
Point ( 1041 ) = { -6.43333316, 57.68333435, 0.00000000 };
Point ( 1042 ) = { -6.43333316, 57.71666718, 0.00000000 };
Point ( 1043 ) = { -6.41666651, 57.73333359, 0.00000000 };
Point ( 1044 ) = { -6.38333321, 57.73333359, 0.00000000 };
Point ( 1045 ) = { -6.34999990, 57.73333359, 0.00000000 };
Point ( 1046 ) = { -6.31666660, 57.73333359, 0.00000000 };
Point ( 1047 ) = { -6.28333330, 57.73333359, 0.00000000 };
Point ( 1048 ) = { -6.26666665, 57.71666718, 0.00000000 };
Point ( 1049 ) = { -6.25000000, 57.70000076, 0.00000000 };
Point ( 1050 ) = { -6.23333335, 57.68333435, 0.00000000 };
Point ( 1051 ) = { -6.21666670, 57.66666794, 0.00000000 };
Point ( 1052 ) = { -6.20000005, 57.65000153, 0.00000000 };
Point ( 1053 ) = { -6.18333340, 57.63333321, 0.00000000 };
Point ( 1054 ) = { -6.15000010, 57.63333321, 0.00000000 };
Point ( 1055 ) = { -6.13333344, 57.61666489, 0.00000000 };
Point ( 1056 ) = { -6.13333344, 57.58333206, 0.00000000 };
Point ( 1057 ) = { -6.13333344, 57.54999924, 0.00000000 };
Point ( 1058 ) = { -6.13333344, 57.51666641, 0.00000000 };
Point ( 1059 ) = { -6.13333344, 57.48333359, 0.00000000 };
Point ( 1060 ) = { -6.13333344, 57.45000076, 0.00000000 };
Point ( 1061 ) = { -6.11666679, 57.43333435, 0.00000000 };
Point ( 1062 ) = { -6.10000014, 57.45000076, 0.00000000 };
Point ( 1063 ) = { -6.08333349, 57.46666718, 0.00000000 };
Point ( 1064 ) = { -6.05000019, 57.46666718, 0.00000000 };
Point ( 1065 ) = { -6.03333354, 57.48333359, 0.00000000 };
Point ( 1066 ) = { -6.03333354, 57.51666641, 0.00000000 };
Point ( 1067 ) = { -6.01666689, 57.53333282, 0.00000000 };
Point ( 1068 ) = { -6.00000000, 57.54999924, 0.00000000 };
Point ( 1069 ) = { -6.00000000, 57.58333206, 0.00000000 };
Point ( 1070 ) = { -5.98333311, 57.59999847, 0.00000000 };
Point ( 1071 ) = { -5.96666646, 57.58333206, 0.00000000 };
Point ( 1072 ) = { -5.96666646, 57.54999924, 0.00000000 };
Point ( 1073 ) = { -5.96666646, 57.51666641, 0.00000000 };
Point ( 1074 ) = { -5.96666646, 57.48333359, 0.00000000 };
Point ( 1075 ) = { -5.98333311, 57.46666718, 0.00000000 };
Point ( 1076 ) = { -6.00000000, 57.45000076, 0.00000000 };
Point ( 1077 ) = { -6.00000000, 57.41666794, 0.00000000 };
Point ( 1078 ) = { -6.00000000, 57.38333511, 0.00000000 };
Point ( 1079 ) = { -5.98333311, 57.36666679, 0.00000000 };
Point ( 1080 ) = { -5.96666646, 57.34999847, 0.00000000 };
Point ( 1081 ) = { -5.94999981, 57.33333206, 0.00000000 };
Point ( 1082 ) = { -5.91666651, 57.33333206, 0.00000000 };
Point ( 1083 ) = { -5.88333321, 57.33333206, 0.00000000 };
Point ( 1084 ) = { -5.86666656, 57.34999847, 0.00000000 };
Point ( 1085 ) = { -5.84999990, 57.36666679, 0.00000000 };
Point ( 1086 ) = { -5.83333325, 57.38333511, 0.00000000 };
Point ( 1087 ) = { -5.83333325, 57.41666794, 0.00000000 };
Point ( 1088 ) = { -5.84999990, 57.43333435, 0.00000000 };
Point ( 1089 ) = { -5.86666656, 57.45000076, 0.00000000 };
Point ( 1090 ) = { -5.88333321, 57.46666718, 0.00000000 };
Point ( 1091 ) = { -5.89999986, 57.48333359, 0.00000000 };
Point ( 1092 ) = { -5.89999986, 57.51666641, 0.00000000 };
Point ( 1093 ) = { -5.88333321, 57.53333282, 0.00000000 };
Point ( 1094 ) = { -5.86666656, 57.54999924, 0.00000000 };
Point ( 1095 ) = { -5.86666656, 57.58333206, 0.00000000 };
Point ( 1096 ) = { -5.84999990, 57.59999847, 0.00000000 };
Point ( 1097 ) = { -5.81666660, 57.59999847, 0.00000000 };
Point ( 1098 ) = { -5.79999995, 57.61666489, 0.00000000 };
Point ( 1099 ) = { -5.81666660, 57.63333321, 0.00000000 };
Point ( 1100 ) = { -5.83333325, 57.65000153, 0.00000000 };
Point ( 1101 ) = { -5.81666660, 57.66666794, 0.00000000 };
Point ( 1102 ) = { -5.79999995, 57.68333435, 0.00000000 };
Point ( 1103 ) = { -5.79999995, 57.71666718, 0.00000000 };
Point ( 1104 ) = { -5.81666660, 57.73333359, 0.00000000 };
Point ( 1105 ) = { -5.83333325, 57.75000000, 0.00000000 };
Point ( 1106 ) = { -5.81666660, 57.76666641, 0.00000000 };
Point ( 1107 ) = { -5.79999995, 57.78333282, 0.00000000 };
Point ( 1108 ) = { -5.81666660, 57.79999924, 0.00000000 };
Point ( 1109 ) = { -5.83333325, 57.81666565, 0.00000000 };
Point ( 1110 ) = { -5.83333325, 57.84999847, 0.00000000 };
Point ( 1111 ) = { -5.81666660, 57.86666679, 0.00000000 };
Point ( 1112 ) = { -5.78333330, 57.86666679, 0.00000000 };
Point ( 1113 ) = { -5.75000000, 57.86666679, 0.00000000 };
Point ( 1114 ) = { -5.73333335, 57.88333511, 0.00000000 };
Point ( 1115 ) = { -5.71666670, 57.90000153, 0.00000000 };
Point ( 1116 ) = { -5.68333340, 57.90000153, 0.00000000 };
Point ( 1117 ) = { -5.65000010, 57.90000153, 0.00000000 };
Point ( 1118 ) = { -5.63333344, 57.91666794, 0.00000000 };
Point ( 1119 ) = { -5.61666679, 57.93333435, 0.00000000 };
Point ( 1120 ) = { -5.58333349, 57.93333435, 0.00000000 };
Point ( 1121 ) = { -5.55000019, 57.93333435, 0.00000000 };
Point ( 1122 ) = { -5.53333354, 57.95000076, 0.00000000 };
Point ( 1123 ) = { -5.53333354, 57.98333359, 0.00000000 };
Point ( 1124 ) = { -5.51666689, 58.00000000, 0.00000000 };
Point ( 1125 ) = { -5.50000000, 58.01666641, 0.00000000 };
Point ( 1126 ) = { -5.48333311, 58.03333282, 0.00000000 };
Point ( 1127 ) = { -5.46666646, 58.04999924, 0.00000000 };
Point ( 1128 ) = { -5.46666646, 58.08333206, 0.00000000 };
Point ( 1129 ) = { -5.44999981, 58.09999847, 0.00000000 };
Point ( 1130 ) = { -5.41666651, 58.09999847, 0.00000000 };
Point ( 1131 ) = { -5.38333321, 58.09999847, 0.00000000 };
Point ( 1132 ) = { -5.34999990, 58.09999847, 0.00000000 };
Point ( 1133 ) = { -5.33333325, 58.11666489, 0.00000000 };
Point ( 1134 ) = { -5.33333325, 58.15000153, 0.00000000 };
Point ( 1135 ) = { -5.33333325, 58.18333435, 0.00000000 };
Point ( 1136 ) = { -5.34999990, 58.20000076, 0.00000000 };
Point ( 1137 ) = { -5.38333321, 58.20000076, 0.00000000 };
Point ( 1138 ) = { -5.39999986, 58.21666718, 0.00000000 };
Point ( 1139 ) = { -5.39999986, 58.25000000, 0.00000000 };
Point ( 1140 ) = { -5.38333321, 58.26666641, 0.00000000 };
Point ( 1141 ) = { -5.34999990, 58.26666641, 0.00000000 };
Point ( 1142 ) = { -5.31666660, 58.26666641, 0.00000000 };
Point ( 1143 ) = { -5.28333330, 58.26666641, 0.00000000 };
Point ( 1144 ) = { -5.25000000, 58.26666641, 0.00000000 };
Point ( 1145 ) = { -5.23333335, 58.28333282, 0.00000000 };
Point ( 1146 ) = { -5.21666670, 58.29999924, 0.00000000 };
Point ( 1147 ) = { -5.20000005, 58.31666565, 0.00000000 };
Point ( 1148 ) = { -5.20000005, 58.34999847, 0.00000000 };
Point ( 1149 ) = { -5.21666670, 58.36666679, 0.00000000 };
Point ( 1150 ) = { -5.23333335, 58.38333511, 0.00000000 };
Point ( 1151 ) = { -5.21666670, 58.40000153, 0.00000000 };
Point ( 1152 ) = { -5.18333340, 58.40000153, 0.00000000 };
Point ( 1153 ) = { -5.16666675, 58.41666794, 0.00000000 };
Point ( 1154 ) = { -5.15000010, 58.43333435, 0.00000000 };
Point ( 1155 ) = { -5.11666679, 58.43333435, 0.00000000 };
Point ( 1156 ) = { -5.10000014, 58.45000076, 0.00000000 };
Point ( 1157 ) = { -5.11666679, 58.46666718, 0.00000000 };
Point ( 1158 ) = { -5.13333344, 58.48333359, 0.00000000 };
Point ( 1159 ) = { -5.13333344, 58.51666641, 0.00000000 };
Point ( 1160 ) = { -5.11666679, 58.53333282, 0.00000000 };
Point ( 1161 ) = { -5.10000014, 58.54999924, 0.00000000 };
Point ( 1162 ) = { -5.08333349, 58.56666565, 0.00000000 };
Point ( 1163 ) = { -5.05000019, 58.56666565, 0.00000000 };
Point ( 1164 ) = { -5.03333354, 58.58333206, 0.00000000 };
Point ( 1165 ) = { -5.03333354, 58.61666489, 0.00000000 };
Point ( 1166 ) = { -5.01666689, 58.63333321, 0.00000000 };
Point ( 1167 ) = { -4.98333311, 58.63333321, 0.00000000 };
Point ( 1168 ) = { -4.94999981, 58.63333321, 0.00000000 };
Point ( 1169 ) = { -4.91666651, 58.63333321, 0.00000000 };
Point ( 1170 ) = { -4.88333321, 58.63333321, 0.00000000 };
Point ( 1171 ) = { -4.86666656, 58.61666489, 0.00000000 };
Point ( 1172 ) = { -4.84999990, 58.59999847, 0.00000000 };
Point ( 1173 ) = { -4.81666660, 58.59999847, 0.00000000 };
Point ( 1174 ) = { -4.78333330, 58.59999847, 0.00000000 };
Point ( 1175 ) = { -4.75000000, 58.59999847, 0.00000000 };
Point ( 1176 ) = { -4.73333335, 58.58333206, 0.00000000 };
Point ( 1177 ) = { -4.71666670, 58.56666565, 0.00000000 };
Point ( 1178 ) = { -4.68333340, 58.56666565, 0.00000000 };
Point ( 1179 ) = { -4.65000010, 58.56666565, 0.00000000 };
Point ( 1180 ) = { -4.61666679, 58.56666565, 0.00000000 };
Point ( 1181 ) = { -4.60000014, 58.58333206, 0.00000000 };
Point ( 1182 ) = { -4.58333349, 58.59999847, 0.00000000 };
Point ( 1183 ) = { -4.55000019, 58.59999847, 0.00000000 };
Point ( 1184 ) = { -4.53333354, 58.58333206, 0.00000000 };
Point ( 1185 ) = { -4.51666689, 58.56666565, 0.00000000 };
Point ( 1186 ) = { -4.48333311, 58.56666565, 0.00000000 };
Point ( 1187 ) = { -4.44999981, 58.56666565, 0.00000000 };
Point ( 1188 ) = { -4.41666651, 58.56666565, 0.00000000 };
Point ( 1189 ) = { -4.38333321, 58.56666565, 0.00000000 };
Point ( 1190 ) = { -4.34999990, 58.56666565, 0.00000000 };
Point ( 1191 ) = { -4.31666660, 58.56666565, 0.00000000 };
Point ( 1192 ) = { -4.28333330, 58.56666565, 0.00000000 };
Point ( 1193 ) = { -4.25000000, 58.56666565, 0.00000000 };
Point ( 1194 ) = { -4.21666670, 58.56666565, 0.00000000 };
Point ( 1195 ) = { -4.18333340, 58.56666565, 0.00000000 };
Point ( 1196 ) = { -4.15000010, 58.56666565, 0.00000000 };
Point ( 1197 ) = { -4.11666679, 58.56666565, 0.00000000 };
Point ( 1198 ) = { -4.08333349, 58.56666565, 0.00000000 };
Point ( 1199 ) = { -4.06666684, 58.58333206, 0.00000000 };
Point ( 1200 ) = { -4.05000019, 58.59999847, 0.00000000 };
Point ( 1201 ) = { -4.01666689, 58.59999847, 0.00000000 };
Point ( 1202 ) = { -4.00000012, 58.58333206, 0.00000000 };
Point ( 1203 ) = { -3.98333335, 58.56666565, 0.00000000 };
Point ( 1204 ) = { -3.95000005, 58.56666565, 0.00000000 };
Point ( 1205 ) = { -3.91666675, 58.56666565, 0.00000000 };
Point ( 1206 ) = { -3.88333344, 58.56666565, 0.00000000 };
Point ( 1207 ) = { -3.84999990, 58.56666565, 0.00000000 };
Point ( 1208 ) = { -3.81666660, 58.56666565, 0.00000000 };
Point ( 1209 ) = { -3.79999995, 58.58333206, 0.00000000 };
Point ( 1210 ) = { -3.78333330, 58.59999847, 0.00000000 };
Point ( 1211 ) = { -3.76666665, 58.61666489, 0.00000000 };
Point ( 1212 ) = { -3.75000000, 58.63333321, 0.00000000 };
Point ( 1213 ) = { -3.71666670, 58.63333321, 0.00000000 };
Point ( 1214 ) = { -3.68333340, 58.63333321, 0.00000000 };
Point ( 1215 ) = { -3.65000010, 58.63333321, 0.00000000 };
Point ( 1216 ) = { -3.61666656, 58.63333321, 0.00000000 };
Point ( 1217 ) = { -3.58333325, 58.63333321, 0.00000000 };
Point ( 1218 ) = { -3.54999995, 58.63333321, 0.00000000 };
Point ( 1219 ) = { -3.51666665, 58.63333321, 0.00000000 };
Point ( 1220 ) = { -3.48333335, 58.63333321, 0.00000000 };
Point ( 1221 ) = { -3.45000005, 58.63333321, 0.00000000 };
Point ( 1222 ) = { -3.43333340, 58.65000153, 0.00000000 };
Point ( 1223 ) = { -3.41666675, 58.66666794, 0.00000000 };
Point ( 1224 ) = { -3.38333344, 58.66666794, 0.00000000 };
Point ( 1225 ) = { -3.34999990, 58.66666794, 0.00000000 };
Point ( 1226 ) = { -3.31666660, 58.66666794, 0.00000000 };
Point ( 1227 ) = { -3.28333330, 58.66666794, 0.00000000 };
Point ( 1228 ) = { -3.25000000, 58.66666794, 0.00000000 };
Point ( 1229 ) = { -3.21666670, 58.66666794, 0.00000000 };
Point ( 1230 ) = { -3.18333340, 58.66666794, 0.00000000 };
Point ( 1231 ) = { -3.16666675, 58.65000153, 0.00000000 };
Point ( 1232 ) = { -3.15000010, 58.63333321, 0.00000000 };
Point ( 1233 ) = { -3.13333333, 58.65000153, 0.00000000 };
Point ( 1234 ) = { -3.13333333, 58.68333435, 0.00000000 };
Point ( 1235 ) = { -3.11666656, 58.70000076, 0.00000000 };
Point ( 1236 ) = { -3.09999990, 58.68333435, 0.00000000 };
Point ( 1237 ) = { -3.08333325, 58.66666794, 0.00000000 };
Point ( 1238 ) = { -3.04999995, 58.66666794, 0.00000000 };
Point ( 1239 ) = { -3.01666665, 58.66666794, 0.00000000 };
Point ( 1240 ) = { -3.00000000, 58.65000153, 0.00000000 };
Point ( 1241 ) = { -3.01666665, 58.63333321, 0.00000000 };
Point ( 1242 ) = { -3.03333330, 58.61666489, 0.00000000 };
Point ( 1243 ) = { -3.04999995, 58.59999847, 0.00000000 };
Point ( 1244 ) = { -3.06666660, 58.58333206, 0.00000000 };
Point ( 1245 ) = { -3.06666660, 58.54999924, 0.00000000 };
Point ( 1246 ) = { -3.08333325, 58.53333282, 0.00000000 };
Point ( 1247 ) = { -3.11666656, 58.53333282, 0.00000000 };
Point ( 1248 ) = { -3.13333333, 58.51666641, 0.00000000 };
Point ( 1249 ) = { -3.11666656, 58.50000000, 0.00000000 };
Point ( 1250 ) = { -3.08333325, 58.50000000, 0.00000000 };
Point ( 1251 ) = { -3.04999995, 58.50000000, 0.00000000 };
Point ( 1252 ) = { -3.03333330, 58.48333359, 0.00000000 };
Point ( 1253 ) = { -3.03333330, 58.45000076, 0.00000000 };
Point ( 1254 ) = { -3.04999995, 58.43333435, 0.00000000 };
Point ( 1255 ) = { -3.06666660, 58.41666794, 0.00000000 };
Point ( 1256 ) = { -3.08333325, 58.40000153, 0.00000000 };
Point ( 1257 ) = { -3.09999990, 58.38333511, 0.00000000 };
Point ( 1258 ) = { -3.11666656, 58.36666679, 0.00000000 };
Point ( 1259 ) = { -3.13333333, 58.34999847, 0.00000000 };
Point ( 1260 ) = { -3.15000010, 58.33333206, 0.00000000 };
Point ( 1261 ) = { -3.18333340, 58.33333206, 0.00000000 };
Point ( 1262 ) = { -3.20000005, 58.31666565, 0.00000000 };
Point ( 1263 ) = { -3.21666670, 58.29999924, 0.00000000 };
Point ( 1264 ) = { -3.25000000, 58.29999924, 0.00000000 };
Point ( 1265 ) = { -3.28333330, 58.29999924, 0.00000000 };
Point ( 1266 ) = { -3.29999995, 58.28333282, 0.00000000 };
Point ( 1267 ) = { -3.31666660, 58.26666641, 0.00000000 };
Point ( 1268 ) = { -3.34999990, 58.26666641, 0.00000000 };
Point ( 1269 ) = { -3.38333344, 58.26666641, 0.00000000 };
Point ( 1270 ) = { -3.40000010, 58.25000000, 0.00000000 };
Point ( 1271 ) = { -3.41666675, 58.23333359, 0.00000000 };
Point ( 1272 ) = { -3.43333340, 58.21666718, 0.00000000 };
Point ( 1273 ) = { -3.45000005, 58.20000076, 0.00000000 };
Point ( 1274 ) = { -3.46666670, 58.18333435, 0.00000000 };
Point ( 1275 ) = { -3.48333335, 58.16666794, 0.00000000 };
Point ( 1276 ) = { -3.51666665, 58.16666794, 0.00000000 };
Point ( 1277 ) = { -3.53333330, 58.15000153, 0.00000000 };
Point ( 1278 ) = { -3.54999995, 58.13333321, 0.00000000 };
Point ( 1279 ) = { -3.58333325, 58.13333321, 0.00000000 };
Point ( 1280 ) = { -3.59999990, 58.11666489, 0.00000000 };
Point ( 1281 ) = { -3.61666656, 58.09999847, 0.00000000 };
Point ( 1282 ) = { -3.65000010, 58.09999847, 0.00000000 };
Point ( 1283 ) = { -3.68333340, 58.09999847, 0.00000000 };
Point ( 1284 ) = { -3.70000005, 58.08333206, 0.00000000 };
Point ( 1285 ) = { -3.71666670, 58.06666565, 0.00000000 };
Point ( 1286 ) = { -3.75000000, 58.06666565, 0.00000000 };
Point ( 1287 ) = { -3.76666665, 58.04999924, 0.00000000 };
Point ( 1288 ) = { -3.78333330, 58.03333282, 0.00000000 };
Point ( 1289 ) = { -3.81666660, 58.03333282, 0.00000000 };
Point ( 1290 ) = { -3.83333325, 58.01666641, 0.00000000 };
Point ( 1291 ) = { -3.83333325, 57.98333359, 0.00000000 };
Point ( 1292 ) = { -3.84999990, 57.96666718, 0.00000000 };
Point ( 1293 ) = { -3.86666667, 57.95000076, 0.00000000 };
Point ( 1294 ) = { -3.84999990, 57.93333435, 0.00000000 };
Point ( 1295 ) = { -3.83333325, 57.91666794, 0.00000000 };
Point ( 1296 ) = { -3.81666660, 57.90000153, 0.00000000 };
Point ( 1297 ) = { -3.78333330, 57.90000153, 0.00000000 };
Point ( 1298 ) = { -3.76666665, 57.88333511, 0.00000000 };
Point ( 1299 ) = { -3.75000000, 57.86666679, 0.00000000 };
Point ( 1300 ) = { -3.73333335, 57.84999847, 0.00000000 };
Point ( 1301 ) = { -3.73333335, 57.81666565, 0.00000000 };
Point ( 1302 ) = { -3.75000000, 57.79999924, 0.00000000 };
Point ( 1303 ) = { -3.76666665, 57.78333282, 0.00000000 };
Point ( 1304 ) = { -3.78333330, 57.76666641, 0.00000000 };
Point ( 1305 ) = { -3.81666660, 57.76666641, 0.00000000 };
Point ( 1306 ) = { -3.83333325, 57.75000000, 0.00000000 };
Point ( 1307 ) = { -3.84999990, 57.73333359, 0.00000000 };
Point ( 1308 ) = { -3.86666667, 57.71666718, 0.00000000 };
Point ( 1309 ) = { -3.88333344, 57.70000076, 0.00000000 };
Point ( 1310 ) = { -3.90000010, 57.68333435, 0.00000000 };
Point ( 1311 ) = { -3.88333344, 57.66666794, 0.00000000 };
Point ( 1312 ) = { -3.84999990, 57.66666794, 0.00000000 };
Point ( 1313 ) = { -3.81666660, 57.66666794, 0.00000000 };
Point ( 1314 ) = { -3.78333330, 57.66666794, 0.00000000 };
Point ( 1315 ) = { -3.75000000, 57.66666794, 0.00000000 };
Point ( 1316 ) = { -3.71666670, 57.66666794, 0.00000000 };
Point ( 1317 ) = { -3.68333340, 57.66666794, 0.00000000 };
Point ( 1318 ) = { -3.65000010, 57.66666794, 0.00000000 };
Point ( 1319 ) = { -3.61666656, 57.66666794, 0.00000000 };
Point ( 1320 ) = { -3.59999990, 57.68333435, 0.00000000 };
Point ( 1321 ) = { -3.58333325, 57.70000076, 0.00000000 };
Point ( 1322 ) = { -3.56666660, 57.71666718, 0.00000000 };
Point ( 1323 ) = { -3.54999995, 57.73333359, 0.00000000 };
Point ( 1324 ) = { -3.51666665, 57.73333359, 0.00000000 };
Point ( 1325 ) = { -3.48333335, 57.73333359, 0.00000000 };
Point ( 1326 ) = { -3.45000005, 57.73333359, 0.00000000 };
Point ( 1327 ) = { -3.41666675, 57.73333359, 0.00000000 };
Point ( 1328 ) = { -3.38333344, 57.73333359, 0.00000000 };
Point ( 1329 ) = { -3.34999990, 57.73333359, 0.00000000 };
Point ( 1330 ) = { -3.31666660, 57.73333359, 0.00000000 };
Point ( 1331 ) = { -3.28333330, 57.73333359, 0.00000000 };
Point ( 1332 ) = { -3.25000000, 57.73333359, 0.00000000 };
Point ( 1333 ) = { -3.21666670, 57.73333359, 0.00000000 };
Point ( 1334 ) = { -3.20000005, 57.71666718, 0.00000000 };
Point ( 1335 ) = { -3.18333340, 57.70000076, 0.00000000 };
Point ( 1336 ) = { -3.15000010, 57.70000076, 0.00000000 };
Point ( 1337 ) = { -3.13333333, 57.71666718, 0.00000000 };
Point ( 1338 ) = { -3.11666656, 57.73333359, 0.00000000 };
Point ( 1339 ) = { -3.08333325, 57.73333359, 0.00000000 };
Point ( 1340 ) = { -3.04999995, 57.73333359, 0.00000000 };
Point ( 1341 ) = { -3.03333330, 57.71666718, 0.00000000 };
Point ( 1342 ) = { -3.01666665, 57.70000076, 0.00000000 };
Point ( 1343 ) = { -2.98333335, 57.70000076, 0.00000000 };
Point ( 1344 ) = { -2.96666670, 57.71666718, 0.00000000 };
Point ( 1345 ) = { -2.95000005, 57.73333359, 0.00000000 };
Point ( 1346 ) = { -2.91666675, 57.73333359, 0.00000000 };
Point ( 1347 ) = { -2.88333344, 57.73333359, 0.00000000 };
Point ( 1348 ) = { -2.84999990, 57.73333359, 0.00000000 };
Point ( 1349 ) = { -2.81666660, 57.73333359, 0.00000000 };
Point ( 1350 ) = { -2.78333330, 57.73333359, 0.00000000 };
Point ( 1351 ) = { -2.75000000, 57.73333359, 0.00000000 };
Point ( 1352 ) = { -2.73333335, 57.71666718, 0.00000000 };
Point ( 1353 ) = { -2.71666670, 57.70000076, 0.00000000 };
Point ( 1354 ) = { -2.68333340, 57.70000076, 0.00000000 };
Point ( 1355 ) = { -2.65000010, 57.70000076, 0.00000000 };
Point ( 1356 ) = { -2.61666656, 57.70000076, 0.00000000 };
Point ( 1357 ) = { -2.58333325, 57.70000076, 0.00000000 };
Point ( 1358 ) = { -2.56666660, 57.68333435, 0.00000000 };
Point ( 1359 ) = { -2.54999995, 57.66666794, 0.00000000 };
Point ( 1360 ) = { -2.51666665, 57.66666794, 0.00000000 };
Point ( 1361 ) = { -2.48333335, 57.66666794, 0.00000000 };
Point ( 1362 ) = { -2.45000005, 57.66666794, 0.00000000 };
Point ( 1363 ) = { -2.41666675, 57.66666794, 0.00000000 };
Point ( 1364 ) = { -2.38333344, 57.66666794, 0.00000000 };
Point ( 1365 ) = { -2.36666667, 57.68333435, 0.00000000 };
Point ( 1366 ) = { -2.34999990, 57.70000076, 0.00000000 };
Point ( 1367 ) = { -2.31666660, 57.70000076, 0.00000000 };
Point ( 1368 ) = { -2.28333330, 57.70000076, 0.00000000 };
Point ( 1369 ) = { -2.25000000, 57.70000076, 0.00000000 };
Point ( 1370 ) = { -2.21666670, 57.70000076, 0.00000000 };
Point ( 1371 ) = { -2.18333340, 57.70000076, 0.00000000 };
Point ( 1372 ) = { -2.15000010, 57.70000076, 0.00000000 };
Point ( 1373 ) = { -2.11666656, 57.70000076, 0.00000000 };
Point ( 1374 ) = { -2.08333325, 57.70000076, 0.00000000 };
Point ( 1375 ) = { -2.04999995, 57.70000076, 0.00000000 };
Point ( 1376 ) = { -2.01666665, 57.70000076, 0.00000000 };
Point ( 1377 ) = { -1.98333335, 57.70000076, 0.00000000 };
Point ( 1378 ) = { -1.95000005, 57.70000076, 0.00000000 };
Point ( 1379 ) = { -1.91666663, 57.70000076, 0.00000000 };
Point ( 1380 ) = { -1.89999998, 57.68333435, 0.00000000 };
Point ( 1381 ) = { -1.88333333, 57.66666794, 0.00000000 };
Point ( 1382 ) = { -1.86666667, 57.65000153, 0.00000000 };
Point ( 1383 ) = { -1.85000002, 57.63333321, 0.00000000 };
Point ( 1384 ) = { -1.81666672, 57.63333321, 0.00000000 };
Point ( 1385 ) = { -1.80000001, 57.61666489, 0.00000000 };
Point ( 1386 ) = { -1.80000001, 57.58333206, 0.00000000 };
Point ( 1387 ) = { -1.80000001, 57.54999924, 0.00000000 };
Point ( 1388 ) = { -1.78333330, 57.53333282, 0.00000000 };
Point ( 1389 ) = { -1.76666665, 57.51666641, 0.00000000 };
Point ( 1390 ) = { -1.76666665, 57.48333359, 0.00000000 };
Point ( 1391 ) = { -1.76666665, 57.45000076, 0.00000000 };
Point ( 1392 ) = { -1.78333330, 57.43333435, 0.00000000 };
Point ( 1393 ) = { -1.80000001, 57.41666794, 0.00000000 };
Point ( 1394 ) = { -1.81666672, 57.40000153, 0.00000000 };
Point ( 1395 ) = { -1.85000002, 57.40000153, 0.00000000 };
Point ( 1396 ) = { -1.86666667, 57.38333511, 0.00000000 };
Point ( 1397 ) = { -1.88333333, 57.36666679, 0.00000000 };
Point ( 1398 ) = { -1.89999998, 57.34999847, 0.00000000 };
Point ( 1399 ) = { -1.91666663, 57.33333206, 0.00000000 };
Point ( 1400 ) = { -1.93333334, 57.31666565, 0.00000000 };
Point ( 1401 ) = { -1.95000005, 57.29999924, 0.00000000 };
Point ( 1402 ) = { -1.98333335, 57.29999924, 0.00000000 };
Point ( 1403 ) = { -2.00000000, 57.28333282, 0.00000000 };
Point ( 1404 ) = { -2.01666665, 57.26666641, 0.00000000 };
Point ( 1405 ) = { -2.03333330, 57.25000000, 0.00000000 };
Point ( 1406 ) = { -2.03333330, 57.21666718, 0.00000000 };
Point ( 1407 ) = { -2.03333330, 57.18333435, 0.00000000 };
Point ( 1408 ) = { -2.03333330, 57.15000153, 0.00000000 };
Point ( 1409 ) = { -2.03333330, 57.11666489, 0.00000000 };
Point ( 1410 ) = { -2.04999995, 57.09999847, 0.00000000 };
Point ( 1411 ) = { -2.06666660, 57.08333206, 0.00000000 };
Point ( 1412 ) = { -2.08333325, 57.06666565, 0.00000000 };
Point ( 1413 ) = { -2.09999990, 57.04999924, 0.00000000 };
Point ( 1414 ) = { -2.11666656, 57.03333282, 0.00000000 };
Point ( 1415 ) = { -2.13333333, 57.01666641, 0.00000000 };
Point ( 1416 ) = { -2.15000010, 57.00000000, 0.00000000 };
Point ( 1417 ) = { -2.16666675, 56.98333359, 0.00000000 };
Point ( 1418 ) = { -2.18333340, 56.96666718, 0.00000000 };
Point ( 1419 ) = { -2.20000005, 56.95000076, 0.00000000 };
Point ( 1420 ) = { -2.20000005, 56.91666794, 0.00000000 };
Point ( 1421 ) = { -2.20000005, 56.88333511, 0.00000000 };
Point ( 1422 ) = { -2.21666670, 56.86666679, 0.00000000 };
Point ( 1423 ) = { -2.23333335, 56.84999847, 0.00000000 };
Point ( 1424 ) = { -2.25000000, 56.83333206, 0.00000000 };
Point ( 1425 ) = { -2.26666665, 56.81666565, 0.00000000 };
Point ( 1426 ) = { -2.28333330, 56.79999924, 0.00000000 };
Point ( 1427 ) = { -2.31666660, 56.79999924, 0.00000000 };
Point ( 1428 ) = { -2.33333325, 56.78333282, 0.00000000 };
Point ( 1429 ) = { -2.34999990, 56.76666641, 0.00000000 };
Point ( 1430 ) = { -2.38333344, 56.76666641, 0.00000000 };
Point ( 1431 ) = { -2.40000010, 56.75000000, 0.00000000 };
Point ( 1432 ) = { -2.41666675, 56.73333359, 0.00000000 };
Point ( 1433 ) = { -2.43333340, 56.71666718, 0.00000000 };
Point ( 1434 ) = { -2.43333340, 56.68333435, 0.00000000 };
Point ( 1435 ) = { -2.45000005, 56.66666794, 0.00000000 };
Point ( 1436 ) = { -2.48333335, 56.66666794, 0.00000000 };
Point ( 1437 ) = { -2.50000000, 56.65000153, 0.00000000 };
Point ( 1438 ) = { -2.48333335, 56.63333321, 0.00000000 };
Point ( 1439 ) = { -2.46666670, 56.61666489, 0.00000000 };
Point ( 1440 ) = { -2.48333335, 56.59999847, 0.00000000 };
Point ( 1441 ) = { -2.50000000, 56.58333206, 0.00000000 };
Point ( 1442 ) = { -2.51666665, 56.56666565, 0.00000000 };
Point ( 1443 ) = { -2.54999995, 56.56666565, 0.00000000 };
Point ( 1444 ) = { -2.56666660, 56.54999924, 0.00000000 };
Point ( 1445 ) = { -2.58333325, 56.53333282, 0.00000000 };
Point ( 1446 ) = { -2.61666656, 56.53333282, 0.00000000 };
Point ( 1447 ) = { -2.63333333, 56.51666641, 0.00000000 };
Point ( 1448 ) = { -2.65000010, 56.50000000, 0.00000000 };
Point ( 1449 ) = { -2.68333340, 56.50000000, 0.00000000 };
Point ( 1450 ) = { -2.70000005, 56.48333359, 0.00000000 };
Point ( 1451 ) = { -2.70000005, 56.45000076, 0.00000000 };
Point ( 1452 ) = { -2.71666670, 56.43333435, 0.00000000 };
Point ( 1453 ) = { -2.73333335, 56.41666794, 0.00000000 };
Point ( 1454 ) = { -2.75000000, 56.40000153, 0.00000000 };
Point ( 1455 ) = { -2.76666665, 56.38333511, 0.00000000 };
Point ( 1456 ) = { -2.76666665, 56.34999847, 0.00000000 };
Point ( 1457 ) = { -2.75000000, 56.33333206, 0.00000000 };
Point ( 1458 ) = { -2.71666670, 56.33333206, 0.00000000 };
Point ( 1459 ) = { -2.68333340, 56.33333206, 0.00000000 };
Point ( 1460 ) = { -2.65000010, 56.33333206, 0.00000000 };
Point ( 1461 ) = { -2.63333333, 56.31666565, 0.00000000 };
Point ( 1462 ) = { -2.61666656, 56.29999924, 0.00000000 };
Point ( 1463 ) = { -2.58333325, 56.29999924, 0.00000000 };
Point ( 1464 ) = { -2.56666660, 56.28333282, 0.00000000 };
Point ( 1465 ) = { -2.58333325, 56.26666641, 0.00000000 };
Point ( 1466 ) = { -2.59999990, 56.25000000, 0.00000000 };
Point ( 1467 ) = { -2.61666656, 56.23333359, 0.00000000 };
Point ( 1468 ) = { -2.65000010, 56.23333359, 0.00000000 };
Point ( 1469 ) = { -2.66666675, 56.21666718, 0.00000000 };
Point ( 1470 ) = { -2.68333340, 56.20000076, 0.00000000 };
Point ( 1471 ) = { -2.71666670, 56.20000076, 0.00000000 };
Point ( 1472 ) = { -2.75000000, 56.20000076, 0.00000000 };
Point ( 1473 ) = { -2.78333330, 56.20000076, 0.00000000 };
Point ( 1474 ) = { -2.79999995, 56.18333435, 0.00000000 };
Point ( 1475 ) = { -2.81666660, 56.16666794, 0.00000000 };
Point ( 1476 ) = { -2.84999990, 56.16666794, 0.00000000 };
Point ( 1477 ) = { -2.88333344, 56.16666794, 0.00000000 };
Point ( 1478 ) = { -2.91666675, 56.16666794, 0.00000000 };
Point ( 1479 ) = { -2.93333340, 56.18333435, 0.00000000 };
Point ( 1480 ) = { -2.95000005, 56.20000076, 0.00000000 };
Point ( 1481 ) = { -2.96666670, 56.18333435, 0.00000000 };
Point ( 1482 ) = { -2.98333335, 56.16666794, 0.00000000 };
Point ( 1483 ) = { -3.01666665, 56.16666794, 0.00000000 };
Point ( 1484 ) = { -3.03333330, 56.15000153, 0.00000000 };
Point ( 1485 ) = { -3.04999995, 56.13333321, 0.00000000 };
Point ( 1486 ) = { -3.08333325, 56.13333321, 0.00000000 };
Point ( 1487 ) = { -3.09999990, 56.11666489, 0.00000000 };
Point ( 1488 ) = { -3.11666656, 56.09999847, 0.00000000 };
Point ( 1489 ) = { -3.13333333, 56.08333206, 0.00000000 };
Point ( 1490 ) = { -3.15000010, 56.06666565, 0.00000000 };
Point ( 1491 ) = { -3.16666675, 56.04999924, 0.00000000 };
Point ( 1492 ) = { -3.15000010, 56.03333282, 0.00000000 };
Point ( 1493 ) = { -3.13333333, 56.01666641, 0.00000000 };
Point ( 1494 ) = { -3.11666656, 56.00000000, 0.00000000 };
Point ( 1495 ) = { -3.08333325, 56.00000000, 0.00000000 };
Point ( 1496 ) = { -3.04999995, 56.00000000, 0.00000000 };
Point ( 1497 ) = { -3.01666665, 56.00000000, 0.00000000 };
Point ( 1498 ) = { -2.98333335, 56.00000000, 0.00000000 };
Point ( 1499 ) = { -2.95000005, 56.00000000, 0.00000000 };
Point ( 1500 ) = { -2.93333340, 56.01666641, 0.00000000 };
Point ( 1501 ) = { -2.91666675, 56.03333282, 0.00000000 };
Point ( 1502 ) = { -2.90000010, 56.04999924, 0.00000000 };
Point ( 1503 ) = { -2.88333344, 56.06666565, 0.00000000 };
Point ( 1504 ) = { -2.84999990, 56.06666565, 0.00000000 };
Point ( 1505 ) = { -2.81666660, 56.06666565, 0.00000000 };
Point ( 1506 ) = { -2.78333330, 56.06666565, 0.00000000 };
Point ( 1507 ) = { -2.75000000, 56.06666565, 0.00000000 };
Point ( 1508 ) = { -2.71666670, 56.06666565, 0.00000000 };
Point ( 1509 ) = { -2.68333340, 56.06666565, 0.00000000 };
Point ( 1510 ) = { -2.65000010, 56.06666565, 0.00000000 };
Point ( 1511 ) = { -2.61666656, 56.06666565, 0.00000000 };
Point ( 1512 ) = { -2.59999990, 56.04999924, 0.00000000 };
Point ( 1513 ) = { -2.58333325, 56.03333282, 0.00000000 };
Point ( 1514 ) = { -2.54999995, 56.03333282, 0.00000000 };
Point ( 1515 ) = { -2.53333330, 56.01666641, 0.00000000 };
Point ( 1516 ) = { -2.51666665, 56.00000000, 0.00000000 };
Point ( 1517 ) = { -2.48333335, 56.00000000, 0.00000000 };
Point ( 1518 ) = { -2.45000005, 56.00000000, 0.00000000 };
Point ( 1519 ) = { -2.41666675, 56.00000000, 0.00000000 };
Point ( 1520 ) = { -2.40000010, 55.98333359, 0.00000000 };
Point ( 1521 ) = { -2.38333344, 55.96666718, 0.00000000 };
Point ( 1522 ) = { -2.34999990, 55.96666718, 0.00000000 };
Point ( 1523 ) = { -2.33333325, 55.95000076, 0.00000000 };
Point ( 1524 ) = { -2.31666660, 55.93333435, 0.00000000 };
Point ( 1525 ) = { -2.28333330, 55.93333435, 0.00000000 };
Point ( 1526 ) = { -2.25000000, 55.93333435, 0.00000000 };
Point ( 1527 ) = { -2.21666670, 55.93333435, 0.00000000 };
Point ( 1528 ) = { -2.18333340, 55.93333435, 0.00000000 };
Point ( 1529 ) = { -2.15000010, 55.93333435, 0.00000000 };
Point ( 1530 ) = { -2.13333333, 55.91666794, 0.00000000 };
Point ( 1531 ) = { -2.11666656, 55.90000153, 0.00000000 };
Point ( 1532 ) = { -2.08333325, 55.90000153, 0.00000000 };
Point ( 1533 ) = { -2.06666660, 55.88333511, 0.00000000 };
Point ( 1534 ) = { -2.06666660, 55.84999847, 0.00000000 };
Point ( 1535 ) = { -2.04999995, 55.83333206, 0.00000000 };
Point ( 1536 ) = { -2.03333330, 55.81666565, 0.00000000 };
Point ( 1537 ) = { -2.01666665, 55.79999924, 0.00000000 };
Point ( 1538 ) = { -2.00000000, 55.78333282, 0.00000000 };
Point ( 1539 ) = { -1.98333335, 55.76666641, 0.00000000 };
Point ( 1540 ) = { -1.95000005, 55.76666641, 0.00000000 };
Point ( 1541 ) = { -1.93333334, 55.75000000, 0.00000000 };
Point ( 1542 ) = { -1.91666663, 55.73333359, 0.00000000 };
Point ( 1543 ) = { -1.89999998, 55.71666718, 0.00000000 };
Point ( 1544 ) = { -1.88333333, 55.70000076, 0.00000000 };
Point ( 1545 ) = { -1.85000002, 55.70000076, 0.00000000 };
Point ( 1546 ) = { -1.81666672, 55.70000076, 0.00000000 };
Point ( 1547 ) = { -1.78333330, 55.70000076, 0.00000000 };
Point ( 1548 ) = { -1.76666665, 55.68333435, 0.00000000 };
Point ( 1549 ) = { -1.76666665, 55.65000153, 0.00000000 };
Point ( 1550 ) = { -1.75000000, 55.63333321, 0.00000000 };
Point ( 1551 ) = { -1.71666670, 55.63333321, 0.00000000 };
Point ( 1552 ) = { -1.68333328, 55.63333321, 0.00000000 };
Point ( 1553 ) = { -1.64999998, 55.63333321, 0.00000000 };
Point ( 1554 ) = { -1.63333333, 55.65000153, 0.00000000 };
Point ( 1555 ) = { -1.61666667, 55.66666794, 0.00000000 };
Point ( 1556 ) = { -1.60000002, 55.65000153, 0.00000000 };
Point ( 1557 ) = { -1.61666667, 55.63333321, 0.00000000 };
Point ( 1558 ) = { -1.63333333, 55.61666489, 0.00000000 };
Point ( 1559 ) = { -1.63333333, 55.58333206, 0.00000000 };
Point ( 1560 ) = { -1.61666667, 55.56666565, 0.00000000 };
Point ( 1561 ) = { -1.60000002, 55.54999924, 0.00000000 };
Point ( 1562 ) = { -1.60000002, 55.51666641, 0.00000000 };
Point ( 1563 ) = { -1.58333337, 55.50000000, 0.00000000 };
Point ( 1564 ) = { -1.56666666, 55.48333359, 0.00000000 };
Point ( 1565 ) = { -1.56666666, 55.45000076, 0.00000000 };
Point ( 1566 ) = { -1.56666666, 55.41666794, 0.00000000 };
Point ( 1567 ) = { -1.56666666, 55.38333511, 0.00000000 };
Point ( 1568 ) = { -1.56666666, 55.34999847, 0.00000000 };
Point ( 1569 ) = { -1.54999995, 55.33333206, 0.00000000 };
Point ( 1570 ) = { -1.53333330, 55.31666565, 0.00000000 };
Point ( 1571 ) = { -1.54999995, 55.29999924, 0.00000000 };
Point ( 1572 ) = { -1.56666666, 55.28333282, 0.00000000 };
Point ( 1573 ) = { -1.54999995, 55.26666641, 0.00000000 };
Point ( 1574 ) = { -1.53333330, 55.25000000, 0.00000000 };
Point ( 1575 ) = { -1.51666665, 55.23333359, 0.00000000 };
Point ( 1576 ) = { -1.50000000, 55.21666718, 0.00000000 };
Point ( 1577 ) = { -1.50000000, 55.18333435, 0.00000000 };
Point ( 1578 ) = { -1.50000000, 55.15000153, 0.00000000 };
Point ( 1579 ) = { -1.48333335, 55.13333321, 0.00000000 };
Point ( 1580 ) = { -1.46666670, 55.11666489, 0.00000000 };
Point ( 1581 ) = { -1.45000005, 55.09999847, 0.00000000 };
Point ( 1582 ) = { -1.43333334, 55.08333206, 0.00000000 };
Point ( 1583 ) = { -1.43333334, 55.04999924, 0.00000000 };
Point ( 1584 ) = { -1.41666663, 55.03333282, 0.00000000 };
Point ( 1585 ) = { -1.39999998, 55.01666641, 0.00000000 };
Point ( 1586 ) = { -1.38333333, 55.00000000, 0.00000000 };
Point ( 1587 ) = { -1.36666667, 54.98333359, 0.00000000 };
Point ( 1588 ) = { -1.35000002, 54.96666718, 0.00000000 };
Point ( 1589 ) = { -1.33333337, 54.95000076, 0.00000000 };
Point ( 1590 ) = { -1.33333337, 54.91666794, 0.00000000 };
Point ( 1591 ) = { -1.33333337, 54.88333511, 0.00000000 };
Point ( 1592 ) = { -1.33333337, 54.84999847, 0.00000000 };
Point ( 1593 ) = { -1.31666672, 54.83333206, 0.00000000 };
Point ( 1594 ) = { -1.30000001, 54.81666565, 0.00000000 };
Point ( 1595 ) = { -1.28333330, 54.79999924, 0.00000000 };
Point ( 1596 ) = { -1.26666665, 54.78333282, 0.00000000 };
Point ( 1597 ) = { -1.26666665, 54.75000000, 0.00000000 };
Point ( 1598 ) = { -1.25000000, 54.73333359, 0.00000000 };
Point ( 1599 ) = { -1.21666670, 54.73333359, 0.00000000 };
Point ( 1600 ) = { -1.19999999, 54.71666718, 0.00000000 };
Point ( 1601 ) = { -1.18333328, 54.70000076, 0.00000000 };
Point ( 1602 ) = { -1.16666663, 54.68333435, 0.00000000 };
Point ( 1603 ) = { -1.14999998, 54.66666794, 0.00000000 };
Point ( 1604 ) = { -1.11666667, 54.66666794, 0.00000000 };
Point ( 1605 ) = { -1.10000002, 54.65000153, 0.00000000 };
Point ( 1606 ) = { -1.08333337, 54.63333321, 0.00000000 };
Point ( 1607 ) = { -1.04999995, 54.63333321, 0.00000000 };
Point ( 1608 ) = { -1.01666665, 54.63333321, 0.00000000 };
Point ( 1609 ) = { -1.00000000, 54.61666489, 0.00000000 };
Point ( 1610 ) = { -0.98333335, 54.59999847, 0.00000000 };
Point ( 1611 ) = { -0.94999999, 54.59999847, 0.00000000 };
Point ( 1612 ) = { -0.91666669, 54.59999847, 0.00000000 };
Point ( 1613 ) = { -0.88333333, 54.59999847, 0.00000000 };
Point ( 1614 ) = { -0.86666667, 54.58333206, 0.00000000 };
Point ( 1615 ) = { -0.85000002, 54.56666565, 0.00000000 };
Point ( 1616 ) = { -0.81666666, 54.56666565, 0.00000000 };
Point ( 1617 ) = { -0.78333336, 54.56666565, 0.00000000 };
Point ( 1618 ) = { -0.75000000, 54.56666565, 0.00000000 };
Point ( 1619 ) = { -0.73333332, 54.54999924, 0.00000000 };
Point ( 1620 ) = { -0.71666664, 54.53333282, 0.00000000 };
Point ( 1621 ) = { -0.68333334, 54.53333282, 0.00000000 };
Point ( 1622 ) = { -0.66666666, 54.51666641, 0.00000000 };
Point ( 1623 ) = { -0.64999998, 54.50000000, 0.00000000 };
Point ( 1624 ) = { -0.61666667, 54.50000000, 0.00000000 };
Point ( 1625 ) = { -0.58333331, 54.50000000, 0.00000000 };
Point ( 1626 ) = { -0.56666666, 54.48333359, 0.00000000 };
Point ( 1627 ) = { -0.55000001, 54.46666718, 0.00000000 };
Point ( 1628 ) = { -0.51666665, 54.46666718, 0.00000000 };
Point ( 1629 ) = { -0.49999999, 54.45000076, 0.00000000 };
Point ( 1630 ) = { -0.49999999, 54.41666794, 0.00000000 };
Point ( 1631 ) = { -0.48333332, 54.40000153, 0.00000000 };
Point ( 1632 ) = { -0.44999999, 54.40000153, 0.00000000 };
Point ( 1633 ) = { -0.43333332, 54.38333511, 0.00000000 };
Point ( 1634 ) = { -0.43333332, 54.34999847, 0.00000000 };
Point ( 1635 ) = { -0.41666666, 54.33333206, 0.00000000 };
Point ( 1636 ) = { -0.39999999, 54.31666565, 0.00000000 };
Point ( 1637 ) = { -0.38333333, 54.29999924, 0.00000000 };
Point ( 1638 ) = { -0.36666666, 54.28333282, 0.00000000 };
Point ( 1639 ) = { -0.34999999, 54.26666641, 0.00000000 };
Point ( 1640 ) = { -0.33333333, 54.25000000, 0.00000000 };
Point ( 1641 ) = { -0.31666666, 54.23333359, 0.00000000 };
Point ( 1642 ) = { -0.28333333, 54.23333359, 0.00000000 };
Point ( 1643 ) = { -0.26666667, 54.21666718, 0.00000000 };
Point ( 1644 ) = { -0.25000000, 54.20000076, 0.00000000 };
Point ( 1645 ) = { -0.23333333, 54.18333435, 0.00000000 };
Point ( 1646 ) = { -0.21666667, 54.16666794, 0.00000000 };
Point ( 1647 ) = { -0.18333334, 54.16666794, 0.00000000 };
Point ( 1648 ) = { -0.15000001, 54.16666794, 0.00000000 };
Point ( 1649 ) = { -0.13333334, 54.15000153, 0.00000000 };
Point ( 1650 ) = { -0.11666667, 54.13333321, 0.00000000 };
Point ( 1651 ) = { -0.08333334, 54.13333321, 0.00000000 };
Point ( 1652 ) = { -0.06666667, 54.11666489, 0.00000000 };
Point ( 1653 ) = { -0.08333334, 54.09999847, 0.00000000 };
Point ( 1654 ) = { -0.10000000, 54.08333206, 0.00000000 };
Point ( 1655 ) = { -0.11666667, 54.06666565, 0.00000000 };
Point ( 1656 ) = { -0.13333334, 54.04999924, 0.00000000 };
Point ( 1657 ) = { -0.13333334, 54.01666641, 0.00000000 };
Point ( 1658 ) = { -0.15000001, 54.00000000, 0.00000000 };
Point ( 1659 ) = { -0.16666667, 53.98333359, 0.00000000 };
Point ( 1660 ) = { -0.16666667, 53.95000076, 0.00000000 };
Point ( 1661 ) = { -0.15000001, 53.93333435, 0.00000000 };
Point ( 1662 ) = { -0.13333334, 53.91666794, 0.00000000 };
Point ( 1663 ) = { -0.11666667, 53.90000153, 0.00000000 };
Point ( 1664 ) = { -0.10000000, 53.88333511, 0.00000000 };
Point ( 1665 ) = { -0.08333334, 53.86666679, 0.00000000 };
Point ( 1666 ) = { -0.06666667, 53.84999847, 0.00000000 };
Point ( 1667 ) = { -0.05000000, 53.83333206, 0.00000000 };
Point ( 1668 ) = { -0.03333333, 53.81666565, 0.00000000 };
Point ( 1669 ) = { -0.01666667, 53.79999924, 0.00000000 };
Point ( 1670 ) = { 0.00000000, 53.78333282, 0.00000000 };
Point ( 1671 ) = { 0.01666667, 53.76666641, 0.00000000 };
Point ( 1672 ) = { 0.03333333, 53.75000000, 0.00000000 };
Point ( 1673 ) = { 0.05000000, 53.73333359, 0.00000000 };
Point ( 1674 ) = { 0.06666667, 53.71666718, 0.00000000 };
Point ( 1675 ) = { 0.08333334, 53.70000076, 0.00000000 };
Point ( 1676 ) = { 0.11666667, 53.70000076, 0.00000000 };
Point ( 1677 ) = { 0.13333334, 53.68333435, 0.00000000 };
Point ( 1678 ) = { 0.15000001, 53.66666794, 0.00000000 };
Point ( 1679 ) = { 0.16666667, 53.65000153, 0.00000000 };
Point ( 1680 ) = { 0.16666667, 53.61666489, 0.00000000 };
Point ( 1681 ) = { 0.16666667, 53.58333206, 0.00000000 };
Point ( 1682 ) = { 0.15000001, 53.56666565, 0.00000000 };
Point ( 1683 ) = { 0.11666667, 53.56666565, 0.00000000 };
Point ( 1684 ) = { 0.08333334, 53.56666565, 0.00000000 };
Point ( 1685 ) = { 0.05000000, 53.56666565, 0.00000000 };
Point ( 1686 ) = { 0.03333333, 53.54999924, 0.00000000 };
Point ( 1687 ) = { 0.05000000, 53.53333282, 0.00000000 };
Point ( 1688 ) = { 0.08333334, 53.53333282, 0.00000000 };
Point ( 1689 ) = { 0.11666667, 53.53333282, 0.00000000 };
Point ( 1690 ) = { 0.15000001, 53.53333282, 0.00000000 };
Point ( 1691 ) = { 0.18333334, 53.53333282, 0.00000000 };
Point ( 1692 ) = { 0.20000000, 53.51666641, 0.00000000 };
Point ( 1693 ) = { 0.21666667, 53.50000000, 0.00000000 };
Point ( 1694 ) = { 0.25000000, 53.50000000, 0.00000000 };
Point ( 1695 ) = { 0.28333333, 53.50000000, 0.00000000 };
Point ( 1696 ) = { 0.30000000, 53.48333359, 0.00000000 };
Point ( 1697 ) = { 0.31666666, 53.46666718, 0.00000000 };
Point ( 1698 ) = { 0.33333333, 53.45000076, 0.00000000 };
Point ( 1699 ) = { 0.33333333, 53.41666794, 0.00000000 };
Point ( 1700 ) = { 0.33333333, 53.38333511, 0.00000000 };
Point ( 1701 ) = { 0.33333333, 53.34999847, 0.00000000 };
Point ( 1702 ) = { 0.34999999, 53.33333206, 0.00000000 };
Point ( 1703 ) = { 0.36666666, 53.31666565, 0.00000000 };
Point ( 1704 ) = { 0.36666666, 53.28333282, 0.00000000 };
Point ( 1705 ) = { 0.38333333, 53.26666641, 0.00000000 };
Point ( 1706 ) = { 0.39999999, 53.25000000, 0.00000000 };
Point ( 1707 ) = { 0.41666666, 53.23333359, 0.00000000 };
Point ( 1708 ) = { 0.43333332, 53.21666718, 0.00000000 };
Point ( 1709 ) = { 0.43333332, 53.18333435, 0.00000000 };
Point ( 1710 ) = { 0.43333332, 53.15000153, 0.00000000 };
Point ( 1711 ) = { 0.41666666, 53.13333321, 0.00000000 };
Point ( 1712 ) = { 0.39999999, 53.11666489, 0.00000000 };
Point ( 1713 ) = { 0.41666666, 53.09999847, 0.00000000 };
Point ( 1714 ) = { 0.43333332, 53.08333206, 0.00000000 };
Point ( 1715 ) = { 0.41666666, 53.06666565, 0.00000000 };
Point ( 1716 ) = { 0.39999999, 53.04999924, 0.00000000 };
Point ( 1717 ) = { 0.38333333, 53.03333282, 0.00000000 };
Point ( 1718 ) = { 0.36666666, 53.01666641, 0.00000000 };
Point ( 1719 ) = { 0.34999999, 53.00000000, 0.00000000 };
Point ( 1720 ) = { 0.31666666, 53.00000000, 0.00000000 };
Point ( 1721 ) = { 0.30000000, 52.98333359, 0.00000000 };
Point ( 1722 ) = { 0.28333333, 52.96666718, 0.00000000 };
Point ( 1723 ) = { 0.25000000, 52.96666718, 0.00000000 };
Point ( 1724 ) = { 0.23333333, 52.95000076, 0.00000000 };
Point ( 1725 ) = { 0.23333333, 52.91666794, 0.00000000 };
Point ( 1726 ) = { 0.25000000, 52.90000153, 0.00000000 };
Point ( 1727 ) = { 0.26666667, 52.91666794, 0.00000000 };
Point ( 1728 ) = { 0.28333333, 52.93333435, 0.00000000 };
Point ( 1729 ) = { 0.31666666, 52.93333435, 0.00000000 };
Point ( 1730 ) = { 0.34999999, 52.93333435, 0.00000000 };
Point ( 1731 ) = { 0.38333333, 52.93333435, 0.00000000 };
Point ( 1732 ) = { 0.39999999, 52.95000076, 0.00000000 };
Point ( 1733 ) = { 0.41666666, 52.96666718, 0.00000000 };
Point ( 1734 ) = { 0.43333332, 52.98333359, 0.00000000 };
Point ( 1735 ) = { 0.44999999, 53.00000000, 0.00000000 };
Point ( 1736 ) = { 0.46666665, 53.01666641, 0.00000000 };
Point ( 1737 ) = { 0.48333332, 53.03333282, 0.00000000 };
Point ( 1738 ) = { 0.51666665, 53.03333282, 0.00000000 };
Point ( 1739 ) = { 0.55000001, 53.03333282, 0.00000000 };
Point ( 1740 ) = { 0.58333331, 53.03333282, 0.00000000 };
Point ( 1741 ) = { 0.61666667, 53.03333282, 0.00000000 };
Point ( 1742 ) = { 0.63333333, 53.04999924, 0.00000000 };
Point ( 1743 ) = { 0.64999998, 53.06666565, 0.00000000 };
Point ( 1744 ) = { 0.68333334, 53.06666565, 0.00000000 };
Point ( 1745 ) = { 0.71666664, 53.06666565, 0.00000000 };
Point ( 1746 ) = { 0.75000000, 53.06666565, 0.00000000 };
Point ( 1747 ) = { 0.76666668, 53.04999924, 0.00000000 };
Point ( 1748 ) = { 0.78333336, 53.03333282, 0.00000000 };
Point ( 1749 ) = { 0.81666666, 53.03333282, 0.00000000 };
Point ( 1750 ) = { 0.83333334, 53.01666641, 0.00000000 };
Point ( 1751 ) = { 0.85000002, 53.00000000, 0.00000000 };
Point ( 1752 ) = { 0.88333333, 53.00000000, 0.00000000 };
Point ( 1753 ) = { 0.91666669, 53.00000000, 0.00000000 };
Point ( 1754 ) = { 0.94999999, 53.00000000, 0.00000000 };
Point ( 1755 ) = { 0.98333335, 53.00000000, 0.00000000 };
Point ( 1756 ) = { 1.01666665, 53.00000000, 0.00000000 };
Point ( 1757 ) = { 1.03333330, 52.98333359, 0.00000000 };
Point ( 1758 ) = { 1.04999995, 52.96666718, 0.00000000 };
Point ( 1759 ) = { 1.08333337, 52.96666718, 0.00000000 };
Point ( 1760 ) = { 1.11666667, 52.96666718, 0.00000000 };
Point ( 1761 ) = { 1.14999998, 52.96666718, 0.00000000 };
Point ( 1762 ) = { 1.18333328, 52.96666718, 0.00000000 };
Point ( 1763 ) = { 1.21666670, 52.96666718, 0.00000000 };
Point ( 1764 ) = { 1.25000000, 52.96666718, 0.00000000 };
Point ( 1765 ) = { 1.28333330, 52.96666718, 0.00000000 };
Point ( 1766 ) = { 1.30000001, 52.95000076, 0.00000000 };
Point ( 1767 ) = { 1.31666672, 52.93333435, 0.00000000 };
Point ( 1768 ) = { 1.35000002, 52.93333435, 0.00000000 };
Point ( 1769 ) = { 1.38333333, 52.93333435, 0.00000000 };
Point ( 1770 ) = { 1.39999998, 52.91666794, 0.00000000 };
Point ( 1771 ) = { 1.41666663, 52.90000153, 0.00000000 };
Point ( 1772 ) = { 1.45000005, 52.90000153, 0.00000000 };
Point ( 1773 ) = { 1.46666670, 52.88333511, 0.00000000 };
Point ( 1774 ) = { 1.48333335, 52.86666679, 0.00000000 };
Point ( 1775 ) = { 1.50000000, 52.84999847, 0.00000000 };
Point ( 1776 ) = { 1.51666665, 52.83333206, 0.00000000 };
Point ( 1777 ) = { 1.54999995, 52.83333206, 0.00000000 };
Point ( 1778 ) = { 1.58333337, 52.83333206, 0.00000000 };
Point ( 1779 ) = { 1.60000002, 52.81666565, 0.00000000 };
Point ( 1780 ) = { 1.61666667, 52.79999924, 0.00000000 };
Point ( 1781 ) = { 1.63333333, 52.78333282, 0.00000000 };
Point ( 1782 ) = { 1.64999998, 52.76666641, 0.00000000 };
Point ( 1783 ) = { 1.68333328, 52.76666641, 0.00000000 };
Point ( 1784 ) = { 1.69999999, 52.75000000, 0.00000000 };
Point ( 1785 ) = { 1.69999999, 52.71666718, 0.00000000 };
Point ( 1786 ) = { 1.71666670, 52.70000076, 0.00000000 };
Point ( 1787 ) = { 1.73333335, 52.68333435, 0.00000000 };
Point ( 1788 ) = { 1.73333335, 52.65000153, 0.00000000 };
Point ( 1789 ) = { 1.75000000, 52.63333321, 0.00000000 };
Point ( 1790 ) = { 1.78333330, 52.63333321, 0.00000000 };
Point ( 1791 ) = { 1.80000001, 52.61666489, 0.00000000 };
Point ( 1792 ) = { 1.78333330, 52.59999847, 0.00000000 };
Point ( 1793 ) = { 1.75000000, 52.59999847, 0.00000000 };
Point ( 1794 ) = { 1.73333335, 52.58333206, 0.00000000 };
Point ( 1795 ) = { 1.73333335, 52.54999924, 0.00000000 };
Point ( 1796 ) = { 1.75000000, 52.53333282, 0.00000000 };
Point ( 1797 ) = { 1.76666665, 52.51666641, 0.00000000 };
Point ( 1798 ) = { 1.78333330, 52.50000000, 0.00000000 };
Point ( 1799 ) = { 1.80000001, 52.48333359, 0.00000000 };
Point ( 1800 ) = { 1.78333330, 52.46666718, 0.00000000 };
Point ( 1801 ) = { 1.76666665, 52.45000076, 0.00000000 };
Point ( 1802 ) = { 1.76666665, 52.41666794, 0.00000000 };
Point ( 1803 ) = { 1.76666665, 52.38333511, 0.00000000 };
Point ( 1804 ) = { 1.75000000, 52.36666679, 0.00000000 };
Point ( 1805 ) = { 1.71666670, 52.36666679, 0.00000000 };
Point ( 1806 ) = { 1.69999999, 52.34999847, 0.00000000 };
Point ( 1807 ) = { 1.69999999, 52.31666565, 0.00000000 };
Point ( 1808 ) = { 1.68333328, 52.29999924, 0.00000000 };
Point ( 1809 ) = { 1.66666663, 52.28333282, 0.00000000 };
Point ( 1810 ) = { 1.66666663, 52.25000000, 0.00000000 };
Point ( 1811 ) = { 1.66666663, 52.21666718, 0.00000000 };
Point ( 1812 ) = { 1.64999998, 52.20000076, 0.00000000 };
Point ( 1813 ) = { 1.63333333, 52.18333435, 0.00000000 };
Point ( 1814 ) = { 1.63333333, 52.15000153, 0.00000000 };
Point ( 1815 ) = { 1.61666667, 52.13333321, 0.00000000 };
Point ( 1816 ) = { 1.60000002, 52.11666489, 0.00000000 };
Point ( 1817 ) = { 1.60000002, 52.08333206, 0.00000000 };
Point ( 1818 ) = { 1.58333337, 52.06666565, 0.00000000 };
Point ( 1819 ) = { 1.54999995, 52.06666565, 0.00000000 };
Point ( 1820 ) = { 1.53333330, 52.04999924, 0.00000000 };
Point ( 1821 ) = { 1.51666665, 52.03333282, 0.00000000 };
Point ( 1822 ) = { 1.50000000, 52.01666641, 0.00000000 };
Point ( 1823 ) = { 1.48333335, 52.00000000, 0.00000000 };
Point ( 1824 ) = { 1.45000005, 52.00000000, 0.00000000 };
Point ( 1825 ) = { 1.41666663, 52.00000000, 0.00000000 };
Point ( 1826 ) = { 1.39999998, 51.98333359, 0.00000000 };
Point ( 1827 ) = { 1.38333333, 51.96666718, 0.00000000 };
Point ( 1828 ) = { 1.35000002, 51.96666718, 0.00000000 };
Point ( 1829 ) = { 1.33333337, 51.95000076, 0.00000000 };
Point ( 1830 ) = { 1.33333337, 51.91666794, 0.00000000 };
Point ( 1831 ) = { 1.35000002, 51.90000153, 0.00000000 };
Point ( 1832 ) = { 1.36666667, 51.91666794, 0.00000000 };
Point ( 1833 ) = { 1.38333333, 51.93333435, 0.00000000 };
Point ( 1834 ) = { 1.41666663, 51.93333435, 0.00000000 };
Point ( 1835 ) = { 1.43333334, 51.91666794, 0.00000000 };
Point ( 1836 ) = { 1.43333334, 51.88333511, 0.00000000 };
Point ( 1837 ) = { 1.41666663, 51.86666679, 0.00000000 };
Point ( 1838 ) = { 1.39999998, 51.84999847, 0.00000000 };
Point ( 1839 ) = { 1.41666663, 51.83333206, 0.00000000 };
Point ( 1840 ) = { 1.43333334, 51.81666565, 0.00000000 };
Point ( 1841 ) = { 1.41666663, 51.79999924, 0.00000000 };
Point ( 1842 ) = { 1.39999998, 51.78333282, 0.00000000 };
Point ( 1843 ) = { 1.38333333, 51.76666641, 0.00000000 };
Point ( 1844 ) = { 1.35000002, 51.76666641, 0.00000000 };
Point ( 1845 ) = { 1.33333337, 51.75000000, 0.00000000 };
Point ( 1846 ) = { 1.31666672, 51.73333359, 0.00000000 };
Point ( 1847 ) = { 1.28333330, 51.73333359, 0.00000000 };
Point ( 1848 ) = { 1.25000000, 51.73333359, 0.00000000 };
Point ( 1849 ) = { 1.23333335, 51.71666718, 0.00000000 };
Point ( 1850 ) = { 1.21666670, 51.70000076, 0.00000000 };
Point ( 1851 ) = { 1.18333328, 51.70000076, 0.00000000 };
Point ( 1852 ) = { 1.14999998, 51.70000076, 0.00000000 };
Point ( 1853 ) = { 1.13333333, 51.68333435, 0.00000000 };
Point ( 1854 ) = { 1.11666667, 51.66666794, 0.00000000 };
Point ( 1855 ) = { 1.10000002, 51.65000153, 0.00000000 };
Point ( 1856 ) = { 1.10000002, 51.61666489, 0.00000000 };
Point ( 1857 ) = { 1.11666667, 51.59999847, 0.00000000 };
Point ( 1858 ) = { 1.13333333, 51.61666489, 0.00000000 };
Point ( 1859 ) = { 1.14999998, 51.63333321, 0.00000000 };
Point ( 1860 ) = { 1.16666663, 51.65000153, 0.00000000 };
Point ( 1861 ) = { 1.18333328, 51.66666794, 0.00000000 };
Point ( 1862 ) = { 1.21666670, 51.66666794, 0.00000000 };
Point ( 1863 ) = { 1.25000000, 51.66666794, 0.00000000 };
Point ( 1864 ) = { 1.28333330, 51.66666794, 0.00000000 };
Point ( 1865 ) = { 1.31666672, 51.66666794, 0.00000000 };
Point ( 1866 ) = { 1.33333337, 51.65000153, 0.00000000 };
Point ( 1867 ) = { 1.31666672, 51.63333321, 0.00000000 };
Point ( 1868 ) = { 1.30000001, 51.61666489, 0.00000000 };
Point ( 1869 ) = { 1.31666672, 51.59999847, 0.00000000 };
Point ( 1870 ) = { 1.35000002, 51.59999847, 0.00000000 };
Point ( 1871 ) = { 1.38333333, 51.59999847, 0.00000000 };
Point ( 1872 ) = { 1.39999998, 51.61666489, 0.00000000 };
Point ( 1873 ) = { 1.39999998, 51.65000153, 0.00000000 };
Point ( 1874 ) = { 1.41666663, 51.66666794, 0.00000000 };
Point ( 1875 ) = { 1.45000005, 51.66666794, 0.00000000 };
Point ( 1876 ) = { 1.46666670, 51.68333435, 0.00000000 };
Point ( 1877 ) = { 1.48333335, 51.70000076, 0.00000000 };
Point ( 1878 ) = { 1.50000000, 51.71666718, 0.00000000 };
Point ( 1879 ) = { 1.50000000, 51.75000000, 0.00000000 };
Point ( 1880 ) = { 1.51666665, 51.76666641, 0.00000000 };
Point ( 1881 ) = { 1.54999995, 51.76666641, 0.00000000 };
Point ( 1882 ) = { 1.58333337, 51.76666641, 0.00000000 };
Point ( 1883 ) = { 1.60000002, 51.75000000, 0.00000000 };
Point ( 1884 ) = { 1.58333337, 51.73333359, 0.00000000 };
Point ( 1885 ) = { 1.56666666, 51.71666718, 0.00000000 };
Point ( 1886 ) = { 1.54999995, 51.70000076, 0.00000000 };
Point ( 1887 ) = { 1.53333330, 51.68333435, 0.00000000 };
Point ( 1888 ) = { 1.51666665, 51.66666794, 0.00000000 };
Point ( 1889 ) = { 1.50000000, 51.65000153, 0.00000000 };
Point ( 1890 ) = { 1.48333335, 51.63333321, 0.00000000 };
Point ( 1891 ) = { 1.46666670, 51.61666489, 0.00000000 };
Point ( 1892 ) = { 1.45000005, 51.59999847, 0.00000000 };
Point ( 1893 ) = { 1.41666663, 51.59999847, 0.00000000 };
Point ( 1894 ) = { 1.39999998, 51.58333206, 0.00000000 };
Point ( 1895 ) = { 1.38333333, 51.56666565, 0.00000000 };
Point ( 1896 ) = { 1.36666667, 51.54999924, 0.00000000 };
Point ( 1897 ) = { 1.35000002, 51.53333282, 0.00000000 };
Point ( 1898 ) = { 1.31666672, 51.53333282, 0.00000000 };
Point ( 1899 ) = { 1.28333330, 51.53333282, 0.00000000 };
Point ( 1900 ) = { 1.26666665, 51.51666641, 0.00000000 };
Point ( 1901 ) = { 1.26666665, 51.48333359, 0.00000000 };
Point ( 1902 ) = { 1.26666665, 51.45000076, 0.00000000 };
Point ( 1903 ) = { 1.28333330, 51.43333435, 0.00000000 };
Point ( 1904 ) = { 1.31666672, 51.43333435, 0.00000000 };
Point ( 1905 ) = { 1.33333337, 51.45000076, 0.00000000 };
Point ( 1906 ) = { 1.35000002, 51.46666718, 0.00000000 };
Point ( 1907 ) = { 1.38333333, 51.46666718, 0.00000000 };
Point ( 1908 ) = { 1.39999998, 51.45000076, 0.00000000 };
Point ( 1909 ) = { 1.38333333, 51.43333435, 0.00000000 };
Point ( 1910 ) = { 1.36666667, 51.41666794, 0.00000000 };
Point ( 1911 ) = { 1.38333333, 51.40000153, 0.00000000 };
Point ( 1912 ) = { 1.41666663, 51.40000153, 0.00000000 };
Point ( 1913 ) = { 1.45000005, 51.40000153, 0.00000000 };
Point ( 1914 ) = { 1.46666670, 51.38333511, 0.00000000 };
Point ( 1915 ) = { 1.48333335, 51.36666679, 0.00000000 };
Point ( 1916 ) = { 1.50000000, 51.34999847, 0.00000000 };
Point ( 1917 ) = { 1.51666665, 51.33333206, 0.00000000 };
Point ( 1918 ) = { 1.53333330, 51.31666565, 0.00000000 };
Point ( 1919 ) = { 1.54999995, 51.29999924, 0.00000000 };
Point ( 1920 ) = { 1.56666666, 51.28333282, 0.00000000 };
Point ( 1921 ) = { 1.54999995, 51.26666641, 0.00000000 };
Point ( 1922 ) = { 1.53333330, 51.25000000, 0.00000000 };
Point ( 1923 ) = { 1.54999995, 51.23333359, 0.00000000 };
Point ( 1924 ) = { 1.56666666, 51.21666718, 0.00000000 };
Point ( 1925 ) = { 1.54999995, 51.20000076, 0.00000000 };
Point ( 1926 ) = { 1.53333330, 51.18333435, 0.00000000 };
Point ( 1927 ) = { 1.51666665, 51.16666794, 0.00000000 };
Point ( 1928 ) = { 1.50000000, 51.18333435, 0.00000000 };
Point ( 1929 ) = { 1.51666665, 51.20000076, 0.00000000 };
Point ( 1930 ) = { 1.53333330, 51.21666718, 0.00000000 };
Point ( 1931 ) = { 1.51666665, 51.23333359, 0.00000000 };
Point ( 1932 ) = { 1.50000000, 51.25000000, 0.00000000 };
Point ( 1933 ) = { 1.50000000, 51.28333282, 0.00000000 };
Point ( 1934 ) = { 1.48333335, 51.29999924, 0.00000000 };
Point ( 1935 ) = { 1.46666670, 51.28333282, 0.00000000 };
Point ( 1936 ) = { 1.45000005, 51.26666641, 0.00000000 };
Point ( 1937 ) = { 1.43333334, 51.25000000, 0.00000000 };
Point ( 1938 ) = { 1.41666663, 51.23333359, 0.00000000 };
Point ( 1939 ) = { 1.39999998, 51.21666718, 0.00000000 };
Point ( 1940 ) = { 1.39999998, 51.18333435, 0.00000000 };
Point ( 1941 ) = { 1.39999998, 51.15000153, 0.00000000 };
Point ( 1942 ) = { 1.38333333, 51.13333321, 0.00000000 };
Point ( 1943 ) = { 1.35000002, 51.13333321, 0.00000000 };
Point ( 1944 ) = { 1.33333337, 51.11666489, 0.00000000 };
Point ( 1945 ) = { 1.31666672, 51.09999847, 0.00000000 };
Point ( 1946 ) = { 1.28333330, 51.09999847, 0.00000000 };
Point ( 1947 ) = { 1.25000000, 51.09999847, 0.00000000 };
Point ( 1948 ) = { 1.21666670, 51.09999847, 0.00000000 };
Point ( 1949 ) = { 1.19999999, 51.08333206, 0.00000000 };
Point ( 1950 ) = { 1.18333328, 51.06666565, 0.00000000 };
Point ( 1951 ) = { 1.14999998, 51.06666565, 0.00000000 };
Point ( 1952 ) = { 1.11666667, 51.06666565, 0.00000000 };
Point ( 1953 ) = { 1.10000002, 51.04999924, 0.00000000 };
Point ( 1954 ) = { 1.08333337, 51.03333282, 0.00000000 };
Point ( 1955 ) = { 1.06666666, 51.01666641, 0.00000000 };
Point ( 1956 ) = { 1.04999995, 51.00000000, 0.00000000 };
Point ( 1957 ) = { 1.03333330, 50.98333359, 0.00000000 };
Point ( 1958 ) = { 1.01666665, 50.96666718, 0.00000000 };
Point ( 1959 ) = { 1.00000000, 50.95000076, 0.00000000 };
Point ( 1960 ) = { 0.98333335, 50.93333435, 0.00000000 };
Point ( 1961 ) = { 0.96666667, 50.91666794, 0.00000000 };
Point ( 1962 ) = { 0.94999999, 50.90000153, 0.00000000 };
Point ( 1963 ) = { 0.91666669, 50.90000153, 0.00000000 };
Point ( 1964 ) = { 0.90000001, 50.88333511, 0.00000000 };
Point ( 1965 ) = { 0.88333333, 50.86666679, 0.00000000 };
Point ( 1966 ) = { 0.86666667, 50.88333511, 0.00000000 };
Point ( 1967 ) = { 0.85000002, 50.90000153, 0.00000000 };
Point ( 1968 ) = { 0.81666666, 50.90000153, 0.00000000 };
Point ( 1969 ) = { 0.80000001, 50.88333511, 0.00000000 };
Point ( 1970 ) = { 0.78333336, 50.86666679, 0.00000000 };
Point ( 1971 ) = { 0.75000000, 50.86666679, 0.00000000 };
Point ( 1972 ) = { 0.71666664, 50.86666679, 0.00000000 };
Point ( 1973 ) = { 0.69999999, 50.84999847, 0.00000000 };
Point ( 1974 ) = { 0.68333334, 50.83333206, 0.00000000 };
Point ( 1975 ) = { 0.66666666, 50.81666565, 0.00000000 };
Point ( 1976 ) = { 0.64999998, 50.79999924, 0.00000000 };
Point ( 1977 ) = { 0.61666667, 50.79999924, 0.00000000 };
Point ( 1978 ) = { 0.58333331, 50.79999924, 0.00000000 };
Point ( 1979 ) = { 0.55000001, 50.79999924, 0.00000000 };
Point ( 1980 ) = { 0.51666665, 50.79999924, 0.00000000 };
Point ( 1981 ) = { 0.48333332, 50.79999924, 0.00000000 };
Point ( 1982 ) = { 0.46666665, 50.78333282, 0.00000000 };
Point ( 1983 ) = { 0.44999999, 50.76666641, 0.00000000 };
Point ( 1984 ) = { 0.43333332, 50.75000000, 0.00000000 };
Point ( 1985 ) = { 0.41666666, 50.73333359, 0.00000000 };
Point ( 1986 ) = { 0.38333333, 50.73333359, 0.00000000 };
Point ( 1987 ) = { 0.36666666, 50.75000000, 0.00000000 };
Point ( 1988 ) = { 0.34999999, 50.76666641, 0.00000000 };
Point ( 1989 ) = { 0.31666666, 50.76666641, 0.00000000 };
Point ( 1990 ) = { 0.28333333, 50.76666641, 0.00000000 };
Point ( 1991 ) = { 0.26666667, 50.75000000, 0.00000000 };
Point ( 1992 ) = { 0.25000000, 50.73333359, 0.00000000 };
Point ( 1993 ) = { 0.21666667, 50.73333359, 0.00000000 };
Point ( 1994 ) = { 0.18333334, 50.73333359, 0.00000000 };
Point ( 1995 ) = { 0.16666667, 50.75000000, 0.00000000 };
Point ( 1996 ) = { 0.15000001, 50.76666641, 0.00000000 };
Point ( 1997 ) = { 0.11666667, 50.76666641, 0.00000000 };
Point ( 1998 ) = { 0.08333334, 50.76666641, 0.00000000 };
Point ( 1999 ) = { 0.05000000, 50.76666641, 0.00000000 };
Point ( 2000 ) = { 0.03333333, 50.78333282, 0.00000000 };
Point ( 2001 ) = { 0.01666667, 50.79999924, 0.00000000 };
Point ( 2002 ) = { -0.01666667, 50.79999924, 0.00000000 };
Point ( 2003 ) = { -0.05000000, 50.79999924, 0.00000000 };
Point ( 2004 ) = { -0.08333334, 50.79999924, 0.00000000 };
Point ( 2005 ) = { -0.11666667, 50.79999924, 0.00000000 };
Point ( 2006 ) = { -0.15000001, 50.79999924, 0.00000000 };
Point ( 2007 ) = { -0.18333334, 50.79999924, 0.00000000 };
Point ( 2008 ) = { -0.21666667, 50.79999924, 0.00000000 };
Point ( 2009 ) = { -0.25000000, 50.79999924, 0.00000000 };
Point ( 2010 ) = { -0.28333333, 50.79999924, 0.00000000 };
Point ( 2011 ) = { -0.30000000, 50.81666565, 0.00000000 };
Point ( 2012 ) = { -0.31666666, 50.83333206, 0.00000000 };
Point ( 2013 ) = { -0.33333333, 50.81666565, 0.00000000 };
Point ( 2014 ) = { -0.34999999, 50.79999924, 0.00000000 };
Point ( 2015 ) = { -0.38333333, 50.79999924, 0.00000000 };
Point ( 2016 ) = { -0.41666666, 50.79999924, 0.00000000 };
Point ( 2017 ) = { -0.44999999, 50.79999924, 0.00000000 };
Point ( 2018 ) = { -0.48333332, 50.79999924, 0.00000000 };
Point ( 2019 ) = { -0.51666665, 50.79999924, 0.00000000 };
Point ( 2020 ) = { -0.55000001, 50.79999924, 0.00000000 };
Point ( 2021 ) = { -0.58333331, 50.79999924, 0.00000000 };
Point ( 2022 ) = { -0.61666667, 50.79999924, 0.00000000 };
Point ( 2023 ) = { -0.63333333, 50.78333282, 0.00000000 };
Point ( 2024 ) = { -0.64999998, 50.76666641, 0.00000000 };
Point ( 2025 ) = { -0.68333334, 50.76666641, 0.00000000 };
Point ( 2026 ) = { -0.71666664, 50.76666641, 0.00000000 };
Point ( 2027 ) = { -0.73333332, 50.75000000, 0.00000000 };
Point ( 2028 ) = { -0.73333332, 50.71666718, 0.00000000 };
Point ( 2029 ) = { -0.73333332, 50.68333435, 0.00000000 };
Point ( 2030 ) = { -0.75000000, 50.66666794, 0.00000000 };
Point ( 2031 ) = { -0.78333336, 50.66666794, 0.00000000 };
Point ( 2032 ) = { -0.81666666, 50.66666794, 0.00000000 };
Point ( 2033 ) = { -0.85000002, 50.66666794, 0.00000000 };
Point ( 2034 ) = { -0.88333333, 50.66666794, 0.00000000 };
Point ( 2035 ) = { -0.90000001, 50.68333435, 0.00000000 };
Point ( 2036 ) = { -0.91666669, 50.70000076, 0.00000000 };
Point ( 2037 ) = { -0.94999999, 50.70000076, 0.00000000 };
Point ( 2038 ) = { -0.98333335, 50.70000076, 0.00000000 };
Point ( 2039 ) = { -1.01666665, 50.70000076, 0.00000000 };
Point ( 2040 ) = { -1.04999995, 50.70000076, 0.00000000 };
Point ( 2041 ) = { -1.06666666, 50.68333435, 0.00000000 };
Point ( 2042 ) = { -1.08333337, 50.66666794, 0.00000000 };
Point ( 2043 ) = { -1.11666667, 50.66666794, 0.00000000 };
Point ( 2044 ) = { -1.14999998, 50.66666794, 0.00000000 };
Point ( 2045 ) = { -1.16666663, 50.65000153, 0.00000000 };
Point ( 2046 ) = { -1.16666663, 50.61666489, 0.00000000 };
Point ( 2047 ) = { -1.18333328, 50.59999847, 0.00000000 };
Point ( 2048 ) = { -1.21666670, 50.59999847, 0.00000000 };
Point ( 2049 ) = { -1.23333335, 50.58333206, 0.00000000 };
Point ( 2050 ) = { -1.25000000, 50.56666565, 0.00000000 };
Point ( 2051 ) = { -1.28333330, 50.56666565, 0.00000000 };
Point ( 2052 ) = { -1.31666672, 50.56666565, 0.00000000 };
Point ( 2053 ) = { -1.33333337, 50.58333206, 0.00000000 };
Point ( 2054 ) = { -1.35000002, 50.59999847, 0.00000000 };
Point ( 2055 ) = { -1.38333333, 50.59999847, 0.00000000 };
Point ( 2056 ) = { -1.41666663, 50.59999847, 0.00000000 };
Point ( 2057 ) = { -1.45000005, 50.59999847, 0.00000000 };
Point ( 2058 ) = { -1.46666670, 50.61666489, 0.00000000 };
Point ( 2059 ) = { -1.48333335, 50.63333321, 0.00000000 };
Point ( 2060 ) = { -1.50000000, 50.65000153, 0.00000000 };
Point ( 2061 ) = { -1.51666665, 50.66666794, 0.00000000 };
Point ( 2062 ) = { -1.54999995, 50.66666794, 0.00000000 };
Point ( 2063 ) = { -1.56666666, 50.68333435, 0.00000000 };
Point ( 2064 ) = { -1.58333337, 50.70000076, 0.00000000 };
Point ( 2065 ) = { -1.60000002, 50.71666718, 0.00000000 };
Point ( 2066 ) = { -1.61666667, 50.73333359, 0.00000000 };
Point ( 2067 ) = { -1.63333333, 50.71666718, 0.00000000 };
Point ( 2068 ) = { -1.64999998, 50.70000076, 0.00000000 };
Point ( 2069 ) = { -1.66666663, 50.71666718, 0.00000000 };
Point ( 2070 ) = { -1.68333328, 50.73333359, 0.00000000 };
Point ( 2071 ) = { -1.71666670, 50.73333359, 0.00000000 };
Point ( 2072 ) = { -1.75000000, 50.73333359, 0.00000000 };
Point ( 2073 ) = { -1.76666665, 50.71666718, 0.00000000 };
Point ( 2074 ) = { -1.78333330, 50.70000076, 0.00000000 };
Point ( 2075 ) = { -1.80000001, 50.71666718, 0.00000000 };
Point ( 2076 ) = { -1.81666672, 50.73333359, 0.00000000 };
Point ( 2077 ) = { -1.85000002, 50.73333359, 0.00000000 };
Point ( 2078 ) = { -1.86666667, 50.71666718, 0.00000000 };
Point ( 2079 ) = { -1.88333333, 50.70000076, 0.00000000 };
Point ( 2080 ) = { -1.91666663, 50.70000076, 0.00000000 };
Point ( 2081 ) = { -1.95000005, 50.70000076, 0.00000000 };
Point ( 2082 ) = { -1.98333335, 50.70000076, 0.00000000 };
Point ( 2083 ) = { -2.01666665, 50.70000076, 0.00000000 };
Point ( 2084 ) = { -2.03333330, 50.68333435, 0.00000000 };
Point ( 2085 ) = { -2.01666665, 50.66666794, 0.00000000 };
Point ( 2086 ) = { -1.98333335, 50.66666794, 0.00000000 };
Point ( 2087 ) = { -1.95000005, 50.66666794, 0.00000000 };
Point ( 2088 ) = { -1.93333334, 50.65000153, 0.00000000 };
Point ( 2089 ) = { -1.95000005, 50.63333321, 0.00000000 };
Point ( 2090 ) = { -1.96666670, 50.61666489, 0.00000000 };
Point ( 2091 ) = { -1.98333335, 50.59999847, 0.00000000 };
Point ( 2092 ) = { -2.01666665, 50.59999847, 0.00000000 };
Point ( 2093 ) = { -2.03333330, 50.58333206, 0.00000000 };
Point ( 2094 ) = { -2.04999995, 50.56666565, 0.00000000 };
Point ( 2095 ) = { -2.06666660, 50.58333206, 0.00000000 };
Point ( 2096 ) = { -2.08333325, 50.59999847, 0.00000000 };
Point ( 2097 ) = { -2.11666656, 50.59999847, 0.00000000 };
Point ( 2098 ) = { -2.15000010, 50.59999847, 0.00000000 };
Point ( 2099 ) = { -2.18333340, 50.59999847, 0.00000000 };
Point ( 2100 ) = { -2.21666670, 50.59999847, 0.00000000 };
Point ( 2101 ) = { -2.25000000, 50.59999847, 0.00000000 };
Point ( 2102 ) = { -2.28333330, 50.59999847, 0.00000000 };
Point ( 2103 ) = { -2.31666660, 50.59999847, 0.00000000 };
Point ( 2104 ) = { -2.34999990, 50.59999847, 0.00000000 };
Point ( 2105 ) = { -2.38333344, 50.59999847, 0.00000000 };
Point ( 2106 ) = { -2.41666675, 50.59999847, 0.00000000 };
Point ( 2107 ) = { -2.45000005, 50.59999847, 0.00000000 };
Point ( 2108 ) = { -2.46666670, 50.58333206, 0.00000000 };
Point ( 2109 ) = { -2.45000005, 50.56666565, 0.00000000 };
Point ( 2110 ) = { -2.41666675, 50.56666565, 0.00000000 };
Point ( 2111 ) = { -2.40000010, 50.54999924, 0.00000000 };
Point ( 2112 ) = { -2.38333344, 50.53333282, 0.00000000 };
Point ( 2113 ) = { -2.36666667, 50.51666641, 0.00000000 };
Point ( 2114 ) = { -2.38333344, 50.50000000, 0.00000000 };
Point ( 2115 ) = { -2.40000010, 50.51666641, 0.00000000 };
Point ( 2116 ) = { -2.41666675, 50.53333282, 0.00000000 };
Point ( 2117 ) = { -2.43333340, 50.51666641, 0.00000000 };
Point ( 2118 ) = { -2.45000005, 50.50000000, 0.00000000 };
Point ( 2119 ) = { -2.46666670, 50.51666641, 0.00000000 };
Point ( 2120 ) = { -2.46666670, 50.54999924, 0.00000000 };
Point ( 2121 ) = { -2.48333335, 50.56666565, 0.00000000 };
Point ( 2122 ) = { -2.50000000, 50.58333206, 0.00000000 };
Point ( 2123 ) = { -2.51666665, 50.59999847, 0.00000000 };
Point ( 2124 ) = { -2.54999995, 50.59999847, 0.00000000 };
Point ( 2125 ) = { -2.56666660, 50.61666489, 0.00000000 };
Point ( 2126 ) = { -2.58333325, 50.63333321, 0.00000000 };
Point ( 2127 ) = { -2.61666656, 50.63333321, 0.00000000 };
Point ( 2128 ) = { -2.65000010, 50.63333321, 0.00000000 };
Point ( 2129 ) = { -2.68333340, 50.63333321, 0.00000000 };
Point ( 2130 ) = { -2.70000005, 50.65000153, 0.00000000 };
Point ( 2131 ) = { -2.71666670, 50.66666794, 0.00000000 };
Point ( 2132 ) = { -2.75000000, 50.66666794, 0.00000000 };
Point ( 2133 ) = { -2.78333330, 50.66666794, 0.00000000 };
Point ( 2134 ) = { -2.81666660, 50.66666794, 0.00000000 };
Point ( 2135 ) = { -2.83333325, 50.68333435, 0.00000000 };
Point ( 2136 ) = { -2.84999990, 50.70000076, 0.00000000 };
Point ( 2137 ) = { -2.88333344, 50.70000076, 0.00000000 };
Point ( 2138 ) = { -2.91666675, 50.70000076, 0.00000000 };
Point ( 2139 ) = { -2.95000005, 50.70000076, 0.00000000 };
Point ( 2140 ) = { -2.98333335, 50.70000076, 0.00000000 };
Point ( 2141 ) = { -3.01666665, 50.70000076, 0.00000000 };
Point ( 2142 ) = { -3.04999995, 50.70000076, 0.00000000 };
Point ( 2143 ) = { -3.06666660, 50.68333435, 0.00000000 };
Point ( 2144 ) = { -3.08333325, 50.66666794, 0.00000000 };
Point ( 2145 ) = { -3.11666656, 50.66666794, 0.00000000 };
Point ( 2146 ) = { -3.15000010, 50.66666794, 0.00000000 };
Point ( 2147 ) = { -3.18333340, 50.66666794, 0.00000000 };
Point ( 2148 ) = { -3.21666670, 50.66666794, 0.00000000 };
Point ( 2149 ) = { -3.25000000, 50.66666794, 0.00000000 };
Point ( 2150 ) = { -3.28333330, 50.66666794, 0.00000000 };
Point ( 2151 ) = { -3.29999995, 50.65000153, 0.00000000 };
Point ( 2152 ) = { -3.31666660, 50.63333321, 0.00000000 };
Point ( 2153 ) = { -3.34999990, 50.63333321, 0.00000000 };
Point ( 2154 ) = { -3.36666667, 50.61666489, 0.00000000 };
Point ( 2155 ) = { -3.38333344, 50.59999847, 0.00000000 };
Point ( 2156 ) = { -3.41666675, 50.59999847, 0.00000000 };
Point ( 2157 ) = { -3.45000005, 50.59999847, 0.00000000 };
Point ( 2158 ) = { -3.46666670, 50.58333206, 0.00000000 };
Point ( 2159 ) = { -3.46666670, 50.54999924, 0.00000000 };
Point ( 2160 ) = { -3.48333335, 50.53333282, 0.00000000 };
Point ( 2161 ) = { -3.50000000, 50.51666641, 0.00000000 };
Point ( 2162 ) = { -3.50000000, 50.48333359, 0.00000000 };
Point ( 2163 ) = { -3.51666665, 50.46666718, 0.00000000 };
Point ( 2164 ) = { -3.53333330, 50.45000076, 0.00000000 };
Point ( 2165 ) = { -3.54999995, 50.43333435, 0.00000000 };
Point ( 2166 ) = { -3.56666660, 50.41666794, 0.00000000 };
Point ( 2167 ) = { -3.54999995, 50.40000153, 0.00000000 };
Point ( 2168 ) = { -3.51666665, 50.40000153, 0.00000000 };
Point ( 2169 ) = { -3.50000000, 50.38333511, 0.00000000 };
Point ( 2170 ) = { -3.51666665, 50.36666679, 0.00000000 };
Point ( 2171 ) = { -3.53333330, 50.34999847, 0.00000000 };
Point ( 2172 ) = { -3.54999995, 50.33333206, 0.00000000 };
Point ( 2173 ) = { -3.58333325, 50.33333206, 0.00000000 };
Point ( 2174 ) = { -3.59999990, 50.31666565, 0.00000000 };
Point ( 2175 ) = { -3.61666656, 50.29999924, 0.00000000 };
Point ( 2176 ) = { -3.63333333, 50.28333282, 0.00000000 };
Point ( 2177 ) = { -3.61666656, 50.26666641, 0.00000000 };
Point ( 2178 ) = { -3.59999990, 50.25000000, 0.00000000 };
Point ( 2179 ) = { -3.61666656, 50.23333359, 0.00000000 };
Point ( 2180 ) = { -3.65000010, 50.23333359, 0.00000000 };
Point ( 2181 ) = { -3.68333340, 50.23333359, 0.00000000 };
Point ( 2182 ) = { -3.70000005, 50.21666718, 0.00000000 };
Point ( 2183 ) = { -3.71666670, 50.20000076, 0.00000000 };
Point ( 2184 ) = { -3.75000000, 50.20000076, 0.00000000 };
Point ( 2185 ) = { -3.78333330, 50.20000076, 0.00000000 };
Point ( 2186 ) = { -3.81666660, 50.20000076, 0.00000000 };
Point ( 2187 ) = { -3.83333325, 50.21666718, 0.00000000 };
Point ( 2188 ) = { -3.84999990, 50.23333359, 0.00000000 };
Point ( 2189 ) = { -3.86666667, 50.25000000, 0.00000000 };
Point ( 2190 ) = { -3.88333344, 50.26666641, 0.00000000 };
Point ( 2191 ) = { -3.91666675, 50.26666641, 0.00000000 };
Point ( 2192 ) = { -3.95000005, 50.26666641, 0.00000000 };
Point ( 2193 ) = { -3.98333335, 50.26666641, 0.00000000 };
Point ( 2194 ) = { -4.00000012, 50.28333282, 0.00000000 };
Point ( 2195 ) = { -4.01666689, 50.29999924, 0.00000000 };
Point ( 2196 ) = { -4.05000019, 50.29999924, 0.00000000 };
Point ( 2197 ) = { -4.08333349, 50.29999924, 0.00000000 };
Point ( 2198 ) = { -4.11666679, 50.29999924, 0.00000000 };
Point ( 2199 ) = { -4.13333344, 50.31666565, 0.00000000 };
Point ( 2200 ) = { -4.15000010, 50.33333206, 0.00000000 };
Point ( 2201 ) = { -4.18333340, 50.33333206, 0.00000000 };
Point ( 2202 ) = { -4.20000005, 50.31666565, 0.00000000 };
Point ( 2203 ) = { -4.21666670, 50.29999924, 0.00000000 };
Point ( 2204 ) = { -4.23333335, 50.31666565, 0.00000000 };
Point ( 2205 ) = { -4.25000000, 50.33333206, 0.00000000 };
Point ( 2206 ) = { -4.28333330, 50.33333206, 0.00000000 };
Point ( 2207 ) = { -4.29999995, 50.34999847, 0.00000000 };
Point ( 2208 ) = { -4.31666660, 50.36666679, 0.00000000 };
Point ( 2209 ) = { -4.34999990, 50.36666679, 0.00000000 };
Point ( 2210 ) = { -4.38333321, 50.36666679, 0.00000000 };
Point ( 2211 ) = { -4.41666651, 50.36666679, 0.00000000 };
Point ( 2212 ) = { -4.44999981, 50.36666679, 0.00000000 };
Point ( 2213 ) = { -4.46666646, 50.34999847, 0.00000000 };
Point ( 2214 ) = { -4.48333311, 50.33333206, 0.00000000 };
Point ( 2215 ) = { -4.51666689, 50.33333206, 0.00000000 };
Point ( 2216 ) = { -4.55000019, 50.33333206, 0.00000000 };
Point ( 2217 ) = { -4.58333349, 50.33333206, 0.00000000 };
Point ( 2218 ) = { -4.61666679, 50.33333206, 0.00000000 };
Point ( 2219 ) = { -4.65000010, 50.33333206, 0.00000000 };
Point ( 2220 ) = { -4.66666675, 50.31666565, 0.00000000 };
Point ( 2221 ) = { -4.68333340, 50.29999924, 0.00000000 };
Point ( 2222 ) = { -4.70000005, 50.31666565, 0.00000000 };
Point ( 2223 ) = { -4.71666670, 50.33333206, 0.00000000 };
Point ( 2224 ) = { -4.75000000, 50.33333206, 0.00000000 };
Point ( 2225 ) = { -4.76666665, 50.31666565, 0.00000000 };
Point ( 2226 ) = { -4.78333330, 50.29999924, 0.00000000 };
Point ( 2227 ) = { -4.79999995, 50.28333282, 0.00000000 };
Point ( 2228 ) = { -4.78333330, 50.26666641, 0.00000000 };
Point ( 2229 ) = { -4.76666665, 50.25000000, 0.00000000 };
Point ( 2230 ) = { -4.78333330, 50.23333359, 0.00000000 };
Point ( 2231 ) = { -4.81666660, 50.23333359, 0.00000000 };
Point ( 2232 ) = { -4.84999990, 50.23333359, 0.00000000 };
Point ( 2233 ) = { -4.88333321, 50.23333359, 0.00000000 };
Point ( 2234 ) = { -4.89999986, 50.21666718, 0.00000000 };
Point ( 2235 ) = { -4.91666651, 50.20000076, 0.00000000 };
Point ( 2236 ) = { -4.94999981, 50.20000076, 0.00000000 };
Point ( 2237 ) = { -4.96666646, 50.18333435, 0.00000000 };
Point ( 2238 ) = { -4.98333311, 50.16666794, 0.00000000 };
Point ( 2239 ) = { -5.01666689, 50.16666794, 0.00000000 };
Point ( 2240 ) = { -5.03333354, 50.15000153, 0.00000000 };
Point ( 2241 ) = { -5.05000019, 50.13333321, 0.00000000 };
Point ( 2242 ) = { -5.08333349, 50.13333321, 0.00000000 };
Point ( 2243 ) = { -5.10000014, 50.11666489, 0.00000000 };
Point ( 2244 ) = { -5.08333349, 50.09999847, 0.00000000 };
Point ( 2245 ) = { -5.06666684, 50.08333206, 0.00000000 };
Point ( 2246 ) = { -5.06666684, 50.04999924, 0.00000000 };
Point ( 2247 ) = { -5.08333349, 50.03333282, 0.00000000 };
Point ( 2248 ) = { -5.10000014, 50.01666641, 0.00000000 };
Point ( 2249 ) = { -5.11666679, 50.00000000, 0.00000000 };
Point ( 2250 ) = { -5.13333344, 49.98333359, 0.00000000 };
Point ( 2251 ) = { -5.15000010, 49.96666718, 0.00000000 };
Point ( 2252 ) = { -5.18333340, 49.96666718, 0.00000000 };
Point ( 2253 ) = { -5.20000005, 49.95000076, 0.00000000 };
BSpline ( 0 ) = { 2 : 2253, 2 };
Line Loop( 0 ) = { 0 };


// == BRep component: OpenBoundary ================================
// Closing path with parallels and meridians, from (-14.00000000, 46.00000000) to  (6.00000000, 46.00000000)
// Drawing parallel index 2253 at -14.00 (to match 6.00), 46.00
Point ( 2254 ) = { -13.90000000, 46.00000000, 0.00000000 };
Point ( 2255 ) = { -13.80000000, 46.00000000, 0.00000000 };
Point ( 2256 ) = { -13.70000000, 46.00000000, 0.00000000 };
Point ( 2257 ) = { -13.60000000, 46.00000000, 0.00000000 };
Point ( 2258 ) = { -13.50000000, 46.00000000, 0.00000000 };
Point ( 2259 ) = { -13.40000000, 46.00000000, 0.00000000 };
Point ( 2260 ) = { -13.30000000, 46.00000000, 0.00000000 };
Point ( 2261 ) = { -13.20000000, 46.00000000, 0.00000000 };
Point ( 2262 ) = { -13.10000000, 46.00000000, 0.00000000 };
Point ( 2263 ) = { -13.00000000, 46.00000000, 0.00000000 };
Point ( 2264 ) = { -12.90000000, 46.00000000, 0.00000000 };
Point ( 2265 ) = { -12.80000000, 46.00000000, 0.00000000 };
Point ( 2266 ) = { -12.70000000, 46.00000000, 0.00000000 };
Point ( 2267 ) = { -12.60000000, 46.00000000, 0.00000000 };
Point ( 2268 ) = { -12.50000000, 46.00000000, 0.00000000 };
Point ( 2269 ) = { -12.40000000, 46.00000000, 0.00000000 };
Point ( 2270 ) = { -12.30000000, 46.00000000, 0.00000000 };
Point ( 2271 ) = { -12.20000000, 46.00000000, 0.00000000 };
Point ( 2272 ) = { -12.10000000, 46.00000000, 0.00000000 };
Point ( 2273 ) = { -12.00000000, 46.00000000, 0.00000000 };
Point ( 2274 ) = { -11.90000000, 46.00000000, 0.00000000 };
Point ( 2275 ) = { -11.80000000, 46.00000000, 0.00000000 };
Point ( 2276 ) = { -11.70000000, 46.00000000, 0.00000000 };
Point ( 2277 ) = { -11.60000000, 46.00000000, 0.00000000 };
Point ( 2278 ) = { -11.50000000, 46.00000000, 0.00000000 };
Point ( 2279 ) = { -11.40000000, 46.00000000, 0.00000000 };
Point ( 2280 ) = { -11.30000000, 46.00000000, 0.00000000 };
Point ( 2281 ) = { -11.20000000, 46.00000000, 0.00000000 };
Point ( 2282 ) = { -11.10000000, 46.00000000, 0.00000000 };
Point ( 2283 ) = { -11.00000000, 46.00000000, 0.00000000 };
Point ( 2284 ) = { -10.90000000, 46.00000000, 0.00000000 };
Point ( 2285 ) = { -10.80000000, 46.00000000, 0.00000000 };
Point ( 2286 ) = { -10.70000000, 46.00000000, 0.00000000 };
Point ( 2287 ) = { -10.60000000, 46.00000000, 0.00000000 };
Point ( 2288 ) = { -10.50000000, 46.00000000, 0.00000000 };
Point ( 2289 ) = { -10.40000000, 46.00000000, 0.00000000 };
Point ( 2290 ) = { -10.30000000, 46.00000000, 0.00000000 };
Point ( 2291 ) = { -10.20000000, 46.00000000, 0.00000000 };
Point ( 2292 ) = { -10.10000000, 46.00000000, 0.00000000 };
Point ( 2293 ) = { -10.00000000, 46.00000000, 0.00000000 };
Point ( 2294 ) = { -9.90000000, 46.00000000, 0.00000000 };
Point ( 2295 ) = { -9.80000000, 46.00000000, 0.00000000 };
Point ( 2296 ) = { -9.70000000, 46.00000000, 0.00000000 };
Point ( 2297 ) = { -9.60000000, 46.00000000, 0.00000000 };
Point ( 2298 ) = { -9.50000000, 46.00000000, 0.00000000 };
Point ( 2299 ) = { -9.40000000, 46.00000000, 0.00000000 };
Point ( 2300 ) = { -9.30000000, 46.00000000, 0.00000000 };
Point ( 2301 ) = { -9.20000000, 46.00000000, 0.00000000 };
Point ( 2302 ) = { -9.10000000, 46.00000000, 0.00000000 };
Point ( 2303 ) = { -9.00000000, 46.00000000, 0.00000000 };
Point ( 2304 ) = { -8.90000000, 46.00000000, 0.00000000 };
Point ( 2305 ) = { -8.80000000, 46.00000000, 0.00000000 };
Point ( 2306 ) = { -8.70000000, 46.00000000, 0.00000000 };
Point ( 2307 ) = { -8.60000000, 46.00000000, 0.00000000 };
Point ( 2308 ) = { -8.50000000, 46.00000000, 0.00000000 };
Point ( 2309 ) = { -8.40000000, 46.00000000, 0.00000000 };
Point ( 2310 ) = { -8.30000000, 46.00000000, 0.00000000 };
Point ( 2311 ) = { -8.20000000, 46.00000000, 0.00000000 };
Point ( 2312 ) = { -8.10000000, 46.00000000, 0.00000000 };
Point ( 2313 ) = { -8.00000000, 46.00000000, 0.00000000 };
Point ( 2314 ) = { -7.90000000, 46.00000000, 0.00000000 };
Point ( 2315 ) = { -7.80000000, 46.00000000, 0.00000000 };
Point ( 2316 ) = { -7.70000000, 46.00000000, 0.00000000 };
Point ( 2317 ) = { -7.60000000, 46.00000000, 0.00000000 };
Point ( 2318 ) = { -7.50000000, 46.00000000, 0.00000000 };
Point ( 2319 ) = { -7.40000000, 46.00000000, 0.00000000 };
Point ( 2320 ) = { -7.30000000, 46.00000000, 0.00000000 };
Point ( 2321 ) = { -7.20000000, 46.00000000, 0.00000000 };
Point ( 2322 ) = { -7.10000000, 46.00000000, 0.00000000 };
Point ( 2323 ) = { -7.00000000, 46.00000000, 0.00000000 };
Point ( 2324 ) = { -6.90000000, 46.00000000, 0.00000000 };
Point ( 2325 ) = { -6.80000000, 46.00000000, 0.00000000 };
Point ( 2326 ) = { -6.70000000, 46.00000000, 0.00000000 };
Point ( 2327 ) = { -6.60000000, 46.00000000, 0.00000000 };
Point ( 2328 ) = { -6.50000000, 46.00000000, 0.00000000 };
Point ( 2329 ) = { -6.40000000, 46.00000000, 0.00000000 };
Point ( 2330 ) = { -6.30000000, 46.00000000, 0.00000000 };
Point ( 2331 ) = { -6.20000000, 46.00000000, 0.00000000 };
Point ( 2332 ) = { -6.10000000, 46.00000000, 0.00000000 };
Point ( 2333 ) = { -6.00000000, 46.00000000, 0.00000000 };
Point ( 2334 ) = { -5.90000000, 46.00000000, 0.00000000 };
Point ( 2335 ) = { -5.80000000, 46.00000000, 0.00000000 };
Point ( 2336 ) = { -5.70000000, 46.00000000, 0.00000000 };
Point ( 2337 ) = { -5.60000000, 46.00000000, 0.00000000 };
Point ( 2338 ) = { -5.50000000, 46.00000000, 0.00000000 };
Point ( 2339 ) = { -5.40000000, 46.00000000, 0.00000000 };
Point ( 2340 ) = { -5.30000000, 46.00000000, 0.00000000 };
Point ( 2341 ) = { -5.20000000, 46.00000000, 0.00000000 };
Point ( 2342 ) = { -5.10000000, 46.00000000, 0.00000000 };
Point ( 2343 ) = { -5.00000000, 46.00000000, 0.00000000 };
Point ( 2344 ) = { -4.90000000, 46.00000000, 0.00000000 };
Point ( 2345 ) = { -4.80000000, 46.00000000, 0.00000000 };
Point ( 2346 ) = { -4.70000000, 46.00000000, 0.00000000 };
Point ( 2347 ) = { -4.60000000, 46.00000000, 0.00000000 };
Point ( 2348 ) = { -4.50000000, 46.00000000, 0.00000000 };
Point ( 2349 ) = { -4.40000000, 46.00000000, 0.00000000 };
Point ( 2350 ) = { -4.30000000, 46.00000000, 0.00000000 };
Point ( 2351 ) = { -4.20000000, 46.00000000, 0.00000000 };
Point ( 2352 ) = { -4.10000000, 46.00000000, 0.00000000 };
Point ( 2353 ) = { -4.00000000, 46.00000000, 0.00000000 };
Point ( 2354 ) = { -3.90000000, 46.00000000, 0.00000000 };
Point ( 2355 ) = { -3.80000000, 46.00000000, 0.00000000 };
Point ( 2356 ) = { -3.70000000, 46.00000000, 0.00000000 };
Point ( 2357 ) = { -3.60000000, 46.00000000, 0.00000000 };
Point ( 2358 ) = { -3.50000000, 46.00000000, 0.00000000 };
Point ( 2359 ) = { -3.40000000, 46.00000000, 0.00000000 };
Point ( 2360 ) = { -3.30000000, 46.00000000, 0.00000000 };
Point ( 2361 ) = { -3.20000000, 46.00000000, 0.00000000 };
Point ( 2362 ) = { -3.10000000, 46.00000000, 0.00000000 };
Point ( 2363 ) = { -3.00000000, 46.00000000, 0.00000000 };
Point ( 2364 ) = { -2.90000000, 46.00000000, 0.00000000 };
Point ( 2365 ) = { -2.80000000, 46.00000000, 0.00000000 };
Point ( 2366 ) = { -2.70000000, 46.00000000, 0.00000000 };
Point ( 2367 ) = { -2.60000000, 46.00000000, 0.00000000 };
Point ( 2368 ) = { -2.50000000, 46.00000000, 0.00000000 };
Point ( 2369 ) = { -2.40000000, 46.00000000, 0.00000000 };
Point ( 2370 ) = { -2.30000000, 46.00000000, 0.00000000 };
Point ( 2371 ) = { -2.20000000, 46.00000000, 0.00000000 };
Point ( 2372 ) = { -2.10000000, 46.00000000, 0.00000000 };
Point ( 2373 ) = { -2.00000000, 46.00000000, 0.00000000 };
Point ( 2374 ) = { -1.90000000, 46.00000000, 0.00000000 };
Point ( 2375 ) = { -1.80000000, 46.00000000, 0.00000000 };
Point ( 2376 ) = { -1.70000000, 46.00000000, 0.00000000 };
Point ( 2377 ) = { -1.60000000, 46.00000000, 0.00000000 };
Point ( 2378 ) = { -1.50000000, 46.00000000, 0.00000000 };
Point ( 2379 ) = { -1.40000000, 46.00000000, 0.00000000 };
Point ( 2380 ) = { -1.30000000, 46.00000000, 0.00000000 };
Point ( 2381 ) = { -1.20000000, 46.00000000, 0.00000000 };
Point ( 2382 ) = { -1.10000000, 46.00000000, 0.00000000 };
Point ( 2383 ) = { -1.00000000, 46.00000000, 0.00000000 };
Point ( 2384 ) = { -0.90000000, 46.00000000, 0.00000000 };
Point ( 2385 ) = { -0.80000000, 46.00000000, 0.00000000 };
Point ( 2386 ) = { -0.70000000, 46.00000000, 0.00000000 };
Point ( 2387 ) = { -0.60000000, 46.00000000, 0.00000000 };
Point ( 2388 ) = { -0.50000000, 46.00000000, 0.00000000 };
Point ( 2389 ) = { -0.40000000, 46.00000000, 0.00000000 };
Point ( 2390 ) = { -0.30000000, 46.00000000, 0.00000000 };
Point ( 2391 ) = { -0.20000000, 46.00000000, 0.00000000 };
Point ( 2392 ) = { -0.10000000, 46.00000000, 0.00000000 };
Point ( 2393 ) = { -0.00000000, 46.00000000, 0.00000000 };
Point ( 2394 ) = { 0.10000000, 46.00000000, 0.00000000 };
Point ( 2395 ) = { 0.20000000, 46.00000000, 0.00000000 };
Point ( 2396 ) = { 0.30000000, 46.00000000, 0.00000000 };
Point ( 2397 ) = { 0.40000000, 46.00000000, 0.00000000 };
Point ( 2398 ) = { 0.50000000, 46.00000000, 0.00000000 };
Point ( 2399 ) = { 0.60000000, 46.00000000, 0.00000000 };
Point ( 2400 ) = { 0.70000000, 46.00000000, 0.00000000 };
Point ( 2401 ) = { 0.80000000, 46.00000000, 0.00000000 };
Point ( 2402 ) = { 0.90000000, 46.00000000, 0.00000000 };
Point ( 2403 ) = { 1.00000000, 46.00000000, 0.00000000 };
Point ( 2404 ) = { 1.10000000, 46.00000000, 0.00000000 };
Point ( 2405 ) = { 1.20000000, 46.00000000, 0.00000000 };
Point ( 2406 ) = { 1.30000000, 46.00000000, 0.00000000 };
Point ( 2407 ) = { 1.40000000, 46.00000000, 0.00000000 };
Point ( 2408 ) = { 1.50000000, 46.00000000, 0.00000000 };
Point ( 2409 ) = { 1.60000000, 46.00000000, 0.00000000 };
Point ( 2410 ) = { 1.70000000, 46.00000000, 0.00000000 };
Point ( 2411 ) = { 1.80000000, 46.00000000, 0.00000000 };
Point ( 2412 ) = { 1.90000000, 46.00000000, 0.00000000 };
Point ( 2413 ) = { 2.00000000, 46.00000000, 0.00000000 };
Point ( 2414 ) = { 2.10000000, 46.00000000, 0.00000000 };
Point ( 2415 ) = { 2.20000000, 46.00000000, 0.00000000 };
Point ( 2416 ) = { 2.30000000, 46.00000000, 0.00000000 };
Point ( 2417 ) = { 2.40000000, 46.00000000, 0.00000000 };
Point ( 2418 ) = { 2.50000000, 46.00000000, 0.00000000 };
Point ( 2419 ) = { 2.60000000, 46.00000000, 0.00000000 };
Point ( 2420 ) = { 2.70000000, 46.00000000, 0.00000000 };
Point ( 2421 ) = { 2.80000000, 46.00000000, 0.00000000 };
Point ( 2422 ) = { 2.90000000, 46.00000000, 0.00000000 };
Point ( 2423 ) = { 3.00000000, 46.00000000, 0.00000000 };
Point ( 2424 ) = { 3.10000000, 46.00000000, 0.00000000 };
Point ( 2425 ) = { 3.20000000, 46.00000000, 0.00000000 };
Point ( 2426 ) = { 3.30000000, 46.00000000, 0.00000000 };
Point ( 2427 ) = { 3.40000000, 46.00000000, 0.00000000 };
Point ( 2428 ) = { 3.50000000, 46.00000000, 0.00000000 };
Point ( 2429 ) = { 3.60000000, 46.00000000, 0.00000000 };
Point ( 2430 ) = { 3.70000000, 46.00000000, 0.00000000 };
Point ( 2431 ) = { 3.80000000, 46.00000000, 0.00000000 };
Point ( 2432 ) = { 3.90000000, 46.00000000, 0.00000000 };
Point ( 2433 ) = { 4.00000000, 46.00000000, 0.00000000 };
Point ( 2434 ) = { 4.10000000, 46.00000000, 0.00000000 };
Point ( 2435 ) = { 4.20000000, 46.00000000, 0.00000000 };
Point ( 2436 ) = { 4.30000000, 46.00000000, 0.00000000 };
Point ( 2437 ) = { 4.40000000, 46.00000000, 0.00000000 };
Point ( 2438 ) = { 4.50000000, 46.00000000, 0.00000000 };
Point ( 2439 ) = { 4.60000000, 46.00000000, 0.00000000 };
Point ( 2440 ) = { 4.70000000, 46.00000000, 0.00000000 };
Point ( 2441 ) = { 4.80000000, 46.00000000, 0.00000000 };
Point ( 2442 ) = { 4.90000000, 46.00000000, 0.00000000 };
Point ( 2443 ) = { 5.00000000, 46.00000000, 0.00000000 };
Point ( 2444 ) = { 5.10000000, 46.00000000, 0.00000000 };
Point ( 2445 ) = { 5.20000000, 46.00000000, 0.00000000 };
Point ( 2446 ) = { 5.30000000, 46.00000000, 0.00000000 };
Point ( 2447 ) = { 5.40000000, 46.00000000, 0.00000000 };
Point ( 2448 ) = { 5.50000000, 46.00000000, 0.00000000 };
Point ( 2449 ) = { 5.60000000, 46.00000000, 0.00000000 };
Point ( 2450 ) = { 5.70000000, 46.00000000, 0.00000000 };
Point ( 2451 ) = { 5.80000000, 46.00000000, 0.00000000 };
Point ( 2452 ) = { 5.90000000, 46.00000000, 0.00000000 };
// Closing path with parallels and meridians, from (6.00000000, 46.00000000) to  (6.00000000, 64.00000000)
// Drawing meridian to latitude index 2452 at 6.00, 46.00 (to match 64.00)
Point ( 2453 ) = { 6.00000000, 46.10000000, 0.00000000 };
Point ( 2454 ) = { 6.00000000, 46.20000000, 0.00000000 };
Point ( 2455 ) = { 6.00000000, 46.30000000, 0.00000000 };
Point ( 2456 ) = { 6.00000000, 46.40000000, 0.00000000 };
Point ( 2457 ) = { 6.00000000, 46.50000000, 0.00000000 };
Point ( 2458 ) = { 6.00000000, 46.60000000, 0.00000000 };
Point ( 2459 ) = { 6.00000000, 46.70000000, 0.00000000 };
Point ( 2460 ) = { 6.00000000, 46.80000000, 0.00000000 };
Point ( 2461 ) = { 6.00000000, 46.90000000, 0.00000000 };
Point ( 2462 ) = { 6.00000000, 47.00000000, 0.00000000 };
Point ( 2463 ) = { 6.00000000, 47.10000000, 0.00000000 };
Point ( 2464 ) = { 6.00000000, 47.20000000, 0.00000000 };
Point ( 2465 ) = { 6.00000000, 47.30000000, 0.00000000 };
Point ( 2466 ) = { 6.00000000, 47.40000000, 0.00000000 };
Point ( 2467 ) = { 6.00000000, 47.50000000, 0.00000000 };
Point ( 2468 ) = { 6.00000000, 47.60000000, 0.00000000 };
Point ( 2469 ) = { 6.00000000, 47.70000000, 0.00000000 };
Point ( 2470 ) = { 6.00000000, 47.80000000, 0.00000000 };
Point ( 2471 ) = { 6.00000000, 47.90000000, 0.00000000 };
Point ( 2472 ) = { 6.00000000, 48.00000000, 0.00000000 };
Point ( 2473 ) = { 6.00000000, 48.10000000, 0.00000000 };
Point ( 2474 ) = { 6.00000000, 48.20000000, 0.00000000 };
Point ( 2475 ) = { 6.00000000, 48.30000000, 0.00000000 };
Point ( 2476 ) = { 6.00000000, 48.40000000, 0.00000000 };
Point ( 2477 ) = { 6.00000000, 48.50000000, 0.00000000 };
Point ( 2478 ) = { 6.00000000, 48.60000000, 0.00000000 };
Point ( 2479 ) = { 6.00000000, 48.70000000, 0.00000000 };
Point ( 2480 ) = { 6.00000000, 48.80000000, 0.00000000 };
Point ( 2481 ) = { 6.00000000, 48.90000000, 0.00000000 };
Point ( 2482 ) = { 6.00000000, 49.00000000, 0.00000000 };
Point ( 2483 ) = { 6.00000000, 49.10000000, 0.00000000 };
Point ( 2484 ) = { 6.00000000, 49.20000000, 0.00000000 };
Point ( 2485 ) = { 6.00000000, 49.30000000, 0.00000000 };
Point ( 2486 ) = { 6.00000000, 49.40000000, 0.00000000 };
Point ( 2487 ) = { 6.00000000, 49.50000000, 0.00000000 };
Point ( 2488 ) = { 6.00000000, 49.60000000, 0.00000000 };
Point ( 2489 ) = { 6.00000000, 49.70000000, 0.00000000 };
Point ( 2490 ) = { 6.00000000, 49.80000000, 0.00000000 };
Point ( 2491 ) = { 6.00000000, 49.90000000, 0.00000000 };
Point ( 2492 ) = { 6.00000000, 50.00000000, 0.00000000 };
Point ( 2493 ) = { 6.00000000, 50.10000000, 0.00000000 };
Point ( 2494 ) = { 6.00000000, 50.20000000, 0.00000000 };
Point ( 2495 ) = { 6.00000000, 50.30000000, 0.00000000 };
Point ( 2496 ) = { 6.00000000, 50.40000000, 0.00000000 };
Point ( 2497 ) = { 6.00000000, 50.50000000, 0.00000000 };
Point ( 2498 ) = { 6.00000000, 50.60000000, 0.00000000 };
Point ( 2499 ) = { 6.00000000, 50.70000000, 0.00000000 };
Point ( 2500 ) = { 6.00000000, 50.80000000, 0.00000000 };
Point ( 2501 ) = { 6.00000000, 50.90000000, 0.00000000 };
Point ( 2502 ) = { 6.00000000, 51.00000000, 0.00000000 };
Point ( 2503 ) = { 6.00000000, 51.10000000, 0.00000000 };
Point ( 2504 ) = { 6.00000000, 51.20000000, 0.00000000 };
Point ( 2505 ) = { 6.00000000, 51.30000000, 0.00000000 };
Point ( 2506 ) = { 6.00000000, 51.40000000, 0.00000000 };
Point ( 2507 ) = { 6.00000000, 51.50000000, 0.00000000 };
Point ( 2508 ) = { 6.00000000, 51.60000000, 0.00000000 };
Point ( 2509 ) = { 6.00000000, 51.70000000, 0.00000000 };
Point ( 2510 ) = { 6.00000000, 51.80000000, 0.00000000 };
Point ( 2511 ) = { 6.00000000, 51.90000000, 0.00000000 };
Point ( 2512 ) = { 6.00000000, 52.00000000, 0.00000000 };
Point ( 2513 ) = { 6.00000000, 52.10000000, 0.00000000 };
Point ( 2514 ) = { 6.00000000, 52.20000000, 0.00000000 };
Point ( 2515 ) = { 6.00000000, 52.30000000, 0.00000000 };
Point ( 2516 ) = { 6.00000000, 52.40000000, 0.00000000 };
Point ( 2517 ) = { 6.00000000, 52.50000000, 0.00000000 };
Point ( 2518 ) = { 6.00000000, 52.60000000, 0.00000000 };
Point ( 2519 ) = { 6.00000000, 52.70000000, 0.00000000 };
Point ( 2520 ) = { 6.00000000, 52.80000000, 0.00000000 };
Point ( 2521 ) = { 6.00000000, 52.90000000, 0.00000000 };
Point ( 2522 ) = { 6.00000000, 53.00000000, 0.00000000 };
Point ( 2523 ) = { 6.00000000, 53.10000000, 0.00000000 };
Point ( 2524 ) = { 6.00000000, 53.20000000, 0.00000000 };
Point ( 2525 ) = { 6.00000000, 53.30000000, 0.00000000 };
Point ( 2526 ) = { 6.00000000, 53.40000000, 0.00000000 };
Point ( 2527 ) = { 6.00000000, 53.50000000, 0.00000000 };
Point ( 2528 ) = { 6.00000000, 53.60000000, 0.00000000 };
Point ( 2529 ) = { 6.00000000, 53.70000000, 0.00000000 };
Point ( 2530 ) = { 6.00000000, 53.80000000, 0.00000000 };
Point ( 2531 ) = { 6.00000000, 53.90000000, 0.00000000 };
Point ( 2532 ) = { 6.00000000, 54.00000000, 0.00000000 };
Point ( 2533 ) = { 6.00000000, 54.10000000, 0.00000000 };
Point ( 2534 ) = { 6.00000000, 54.20000000, 0.00000000 };
Point ( 2535 ) = { 6.00000000, 54.30000000, 0.00000000 };
Point ( 2536 ) = { 6.00000000, 54.40000000, 0.00000000 };
Point ( 2537 ) = { 6.00000000, 54.50000000, 0.00000000 };
Point ( 2538 ) = { 6.00000000, 54.60000000, 0.00000000 };
Point ( 2539 ) = { 6.00000000, 54.70000000, 0.00000000 };
Point ( 2540 ) = { 6.00000000, 54.80000000, 0.00000000 };
Point ( 2541 ) = { 6.00000000, 54.90000000, 0.00000000 };
Point ( 2542 ) = { 6.00000000, 55.00000000, 0.00000000 };
Point ( 2543 ) = { 6.00000000, 55.10000000, 0.00000000 };
Point ( 2544 ) = { 6.00000000, 55.20000000, 0.00000000 };
Point ( 2545 ) = { 6.00000000, 55.30000000, 0.00000000 };
Point ( 2546 ) = { 6.00000000, 55.40000000, 0.00000000 };
Point ( 2547 ) = { 6.00000000, 55.50000000, 0.00000000 };
Point ( 2548 ) = { 6.00000000, 55.60000000, 0.00000000 };
Point ( 2549 ) = { 6.00000000, 55.70000000, 0.00000000 };
Point ( 2550 ) = { 6.00000000, 55.80000000, 0.00000000 };
Point ( 2551 ) = { 6.00000000, 55.90000000, 0.00000000 };
Point ( 2552 ) = { 6.00000000, 56.00000000, 0.00000000 };
Point ( 2553 ) = { 6.00000000, 56.10000000, 0.00000000 };
Point ( 2554 ) = { 6.00000000, 56.20000000, 0.00000000 };
Point ( 2555 ) = { 6.00000000, 56.30000000, 0.00000000 };
Point ( 2556 ) = { 6.00000000, 56.40000000, 0.00000000 };
Point ( 2557 ) = { 6.00000000, 56.50000000, 0.00000000 };
Point ( 2558 ) = { 6.00000000, 56.60000000, 0.00000000 };
Point ( 2559 ) = { 6.00000000, 56.70000000, 0.00000000 };
Point ( 2560 ) = { 6.00000000, 56.80000000, 0.00000000 };
Point ( 2561 ) = { 6.00000000, 56.90000000, 0.00000000 };
Point ( 2562 ) = { 6.00000000, 57.00000000, 0.00000000 };
Point ( 2563 ) = { 6.00000000, 57.10000000, 0.00000000 };
Point ( 2564 ) = { 6.00000000, 57.20000000, 0.00000000 };
Point ( 2565 ) = { 6.00000000, 57.30000000, 0.00000000 };
Point ( 2566 ) = { 6.00000000, 57.40000000, 0.00000000 };
Point ( 2567 ) = { 6.00000000, 57.50000000, 0.00000000 };
Point ( 2568 ) = { 6.00000000, 57.60000000, 0.00000000 };
Point ( 2569 ) = { 6.00000000, 57.70000000, 0.00000000 };
Point ( 2570 ) = { 6.00000000, 57.80000000, 0.00000000 };
Point ( 2571 ) = { 6.00000000, 57.90000000, 0.00000000 };
Point ( 2572 ) = { 6.00000000, 58.00000000, 0.00000000 };
Point ( 2573 ) = { 6.00000000, 58.10000000, 0.00000000 };
Point ( 2574 ) = { 6.00000000, 58.20000000, 0.00000000 };
Point ( 2575 ) = { 6.00000000, 58.30000000, 0.00000000 };
Point ( 2576 ) = { 6.00000000, 58.40000000, 0.00000000 };
Point ( 2577 ) = { 6.00000000, 58.50000000, 0.00000000 };
Point ( 2578 ) = { 6.00000000, 58.60000000, 0.00000000 };
Point ( 2579 ) = { 6.00000000, 58.70000000, 0.00000000 };
Point ( 2580 ) = { 6.00000000, 58.80000000, 0.00000000 };
Point ( 2581 ) = { 6.00000000, 58.90000000, 0.00000000 };
Point ( 2582 ) = { 6.00000000, 59.00000000, 0.00000000 };
Point ( 2583 ) = { 6.00000000, 59.10000000, 0.00000000 };
Point ( 2584 ) = { 6.00000000, 59.20000000, 0.00000000 };
Point ( 2585 ) = { 6.00000000, 59.30000000, 0.00000000 };
Point ( 2586 ) = { 6.00000000, 59.40000000, 0.00000000 };
Point ( 2587 ) = { 6.00000000, 59.50000000, 0.00000000 };
Point ( 2588 ) = { 6.00000000, 59.60000000, 0.00000000 };
Point ( 2589 ) = { 6.00000000, 59.70000000, 0.00000000 };
Point ( 2590 ) = { 6.00000000, 59.80000000, 0.00000000 };
Point ( 2591 ) = { 6.00000000, 59.90000000, 0.00000000 };
Point ( 2592 ) = { 6.00000000, 60.00000000, 0.00000000 };
Point ( 2593 ) = { 6.00000000, 60.10000000, 0.00000000 };
Point ( 2594 ) = { 6.00000000, 60.20000000, 0.00000000 };
Point ( 2595 ) = { 6.00000000, 60.30000000, 0.00000000 };
Point ( 2596 ) = { 6.00000000, 60.40000000, 0.00000000 };
Point ( 2597 ) = { 6.00000000, 60.50000000, 0.00000000 };
Point ( 2598 ) = { 6.00000000, 60.60000000, 0.00000000 };
Point ( 2599 ) = { 6.00000000, 60.70000000, 0.00000000 };
Point ( 2600 ) = { 6.00000000, 60.80000000, 0.00000000 };
Point ( 2601 ) = { 6.00000000, 60.90000000, 0.00000000 };
Point ( 2602 ) = { 6.00000000, 61.00000000, 0.00000000 };
Point ( 2603 ) = { 6.00000000, 61.10000000, 0.00000000 };
Point ( 2604 ) = { 6.00000000, 61.20000000, 0.00000000 };
Point ( 2605 ) = { 6.00000000, 61.30000000, 0.00000000 };
Point ( 2606 ) = { 6.00000000, 61.40000000, 0.00000000 };
Point ( 2607 ) = { 6.00000000, 61.50000000, 0.00000000 };
Point ( 2608 ) = { 6.00000000, 61.60000000, 0.00000000 };
Point ( 2609 ) = { 6.00000000, 61.70000000, 0.00000000 };
Point ( 2610 ) = { 6.00000000, 61.80000000, 0.00000000 };
Point ( 2611 ) = { 6.00000000, 61.90000000, 0.00000000 };
Point ( 2612 ) = { 6.00000000, 62.00000000, 0.00000000 };
Point ( 2613 ) = { 6.00000000, 62.10000000, 0.00000000 };
Point ( 2614 ) = { 6.00000000, 62.20000000, 0.00000000 };
Point ( 2615 ) = { 6.00000000, 62.30000000, 0.00000000 };
Point ( 2616 ) = { 6.00000000, 62.40000000, 0.00000000 };
Point ( 2617 ) = { 6.00000000, 62.50000000, 0.00000000 };
Point ( 2618 ) = { 6.00000000, 62.60000000, 0.00000000 };
Point ( 2619 ) = { 6.00000000, 62.70000000, 0.00000000 };
Point ( 2620 ) = { 6.00000000, 62.80000000, 0.00000000 };
Point ( 2621 ) = { 6.00000000, 62.90000000, 0.00000000 };
Point ( 2622 ) = { 6.00000000, 63.00000000, 0.00000000 };
Point ( 2623 ) = { 6.00000000, 63.10000000, 0.00000000 };
Point ( 2624 ) = { 6.00000000, 63.20000000, 0.00000000 };
Point ( 2625 ) = { 6.00000000, 63.30000000, 0.00000000 };
Point ( 2626 ) = { 6.00000000, 63.40000000, 0.00000000 };
Point ( 2627 ) = { 6.00000000, 63.50000000, 0.00000000 };
Point ( 2628 ) = { 6.00000000, 63.60000000, 0.00000000 };
Point ( 2629 ) = { 6.00000000, 63.70000000, 0.00000000 };
Point ( 2630 ) = { 6.00000000, 63.80000000, 0.00000000 };
Point ( 2631 ) = { 6.00000000, 63.90000000, 0.00000000 };
// Closing path with parallels and meridians, from (6.00000000, 64.00000000) to  (-14.00000000, 64.00000000)
// Drawing parallel index 2631 at 6.00 (to match -14.00), 64.00
Point ( 2632 ) = { 5.90000000, 64.00000000, 0.00000000 };
Point ( 2633 ) = { 5.80000000, 64.00000000, 0.00000000 };
Point ( 2634 ) = { 5.70000000, 64.00000000, 0.00000000 };
Point ( 2635 ) = { 5.60000000, 64.00000000, 0.00000000 };
Point ( 2636 ) = { 5.50000000, 64.00000000, 0.00000000 };
Point ( 2637 ) = { 5.40000000, 64.00000000, 0.00000000 };
Point ( 2638 ) = { 5.30000000, 64.00000000, 0.00000000 };
Point ( 2639 ) = { 5.20000000, 64.00000000, 0.00000000 };
Point ( 2640 ) = { 5.10000000, 64.00000000, 0.00000000 };
Point ( 2641 ) = { 5.00000000, 64.00000000, 0.00000000 };
Point ( 2642 ) = { 4.90000000, 64.00000000, 0.00000000 };
Point ( 2643 ) = { 4.80000000, 64.00000000, 0.00000000 };
Point ( 2644 ) = { 4.70000000, 64.00000000, 0.00000000 };
Point ( 2645 ) = { 4.60000000, 64.00000000, 0.00000000 };
Point ( 2646 ) = { 4.50000000, 64.00000000, 0.00000000 };
Point ( 2647 ) = { 4.40000000, 64.00000000, 0.00000000 };
Point ( 2648 ) = { 4.30000000, 64.00000000, 0.00000000 };
Point ( 2649 ) = { 4.20000000, 64.00000000, 0.00000000 };
Point ( 2650 ) = { 4.10000000, 64.00000000, 0.00000000 };
Point ( 2651 ) = { 4.00000000, 64.00000000, 0.00000000 };
Point ( 2652 ) = { 3.90000000, 64.00000000, 0.00000000 };
Point ( 2653 ) = { 3.80000000, 64.00000000, 0.00000000 };
Point ( 2654 ) = { 3.70000000, 64.00000000, 0.00000000 };
Point ( 2655 ) = { 3.60000000, 64.00000000, 0.00000000 };
Point ( 2656 ) = { 3.50000000, 64.00000000, 0.00000000 };
Point ( 2657 ) = { 3.40000000, 64.00000000, 0.00000000 };
Point ( 2658 ) = { 3.30000000, 64.00000000, 0.00000000 };
Point ( 2659 ) = { 3.20000000, 64.00000000, 0.00000000 };
Point ( 2660 ) = { 3.10000000, 64.00000000, 0.00000000 };
Point ( 2661 ) = { 3.00000000, 64.00000000, 0.00000000 };
Point ( 2662 ) = { 2.90000000, 64.00000000, 0.00000000 };
Point ( 2663 ) = { 2.80000000, 64.00000000, 0.00000000 };
Point ( 2664 ) = { 2.70000000, 64.00000000, 0.00000000 };
Point ( 2665 ) = { 2.60000000, 64.00000000, 0.00000000 };
Point ( 2666 ) = { 2.50000000, 64.00000000, 0.00000000 };
Point ( 2667 ) = { 2.40000000, 64.00000000, 0.00000000 };
Point ( 2668 ) = { 2.30000000, 64.00000000, 0.00000000 };
Point ( 2669 ) = { 2.20000000, 64.00000000, 0.00000000 };
Point ( 2670 ) = { 2.10000000, 64.00000000, 0.00000000 };
Point ( 2671 ) = { 2.00000000, 64.00000000, 0.00000000 };
Point ( 2672 ) = { 1.90000000, 64.00000000, 0.00000000 };
Point ( 2673 ) = { 1.80000000, 64.00000000, 0.00000000 };
Point ( 2674 ) = { 1.70000000, 64.00000000, 0.00000000 };
Point ( 2675 ) = { 1.60000000, 64.00000000, 0.00000000 };
Point ( 2676 ) = { 1.50000000, 64.00000000, 0.00000000 };
Point ( 2677 ) = { 1.40000000, 64.00000000, 0.00000000 };
Point ( 2678 ) = { 1.30000000, 64.00000000, 0.00000000 };
Point ( 2679 ) = { 1.20000000, 64.00000000, 0.00000000 };
Point ( 2680 ) = { 1.10000000, 64.00000000, 0.00000000 };
Point ( 2681 ) = { 1.00000000, 64.00000000, 0.00000000 };
Point ( 2682 ) = { 0.90000000, 64.00000000, 0.00000000 };
Point ( 2683 ) = { 0.80000000, 64.00000000, 0.00000000 };
Point ( 2684 ) = { 0.70000000, 64.00000000, 0.00000000 };
Point ( 2685 ) = { 0.60000000, 64.00000000, 0.00000000 };
Point ( 2686 ) = { 0.50000000, 64.00000000, 0.00000000 };
Point ( 2687 ) = { 0.40000000, 64.00000000, 0.00000000 };
Point ( 2688 ) = { 0.30000000, 64.00000000, 0.00000000 };
Point ( 2689 ) = { 0.20000000, 64.00000000, 0.00000000 };
Point ( 2690 ) = { 0.10000000, 64.00000000, 0.00000000 };
Point ( 2691 ) = { 0.00000000, 64.00000000, 0.00000000 };
Point ( 2692 ) = { -0.10000000, 64.00000000, 0.00000000 };
Point ( 2693 ) = { -0.20000000, 64.00000000, 0.00000000 };
Point ( 2694 ) = { -0.30000000, 64.00000000, 0.00000000 };
Point ( 2695 ) = { -0.40000000, 64.00000000, 0.00000000 };
Point ( 2696 ) = { -0.50000000, 64.00000000, 0.00000000 };
Point ( 2697 ) = { -0.60000000, 64.00000000, 0.00000000 };
Point ( 2698 ) = { -0.70000000, 64.00000000, 0.00000000 };
Point ( 2699 ) = { -0.80000000, 64.00000000, 0.00000000 };
Point ( 2700 ) = { -0.90000000, 64.00000000, 0.00000000 };
Point ( 2701 ) = { -1.00000000, 64.00000000, 0.00000000 };
Point ( 2702 ) = { -1.10000000, 64.00000000, 0.00000000 };
Point ( 2703 ) = { -1.20000000, 64.00000000, 0.00000000 };
Point ( 2704 ) = { -1.30000000, 64.00000000, 0.00000000 };
Point ( 2705 ) = { -1.40000000, 64.00000000, 0.00000000 };
Point ( 2706 ) = { -1.50000000, 64.00000000, 0.00000000 };
Point ( 2707 ) = { -1.60000000, 64.00000000, 0.00000000 };
Point ( 2708 ) = { -1.70000000, 64.00000000, 0.00000000 };
Point ( 2709 ) = { -1.80000000, 64.00000000, 0.00000000 };
Point ( 2710 ) = { -1.90000000, 64.00000000, 0.00000000 };
Point ( 2711 ) = { -2.00000000, 64.00000000, 0.00000000 };
Point ( 2712 ) = { -2.10000000, 64.00000000, 0.00000000 };
Point ( 2713 ) = { -2.20000000, 64.00000000, 0.00000000 };
Point ( 2714 ) = { -2.30000000, 64.00000000, 0.00000000 };
Point ( 2715 ) = { -2.40000000, 64.00000000, 0.00000000 };
Point ( 2716 ) = { -2.50000000, 64.00000000, 0.00000000 };
Point ( 2717 ) = { -2.60000000, 64.00000000, 0.00000000 };
Point ( 2718 ) = { -2.70000000, 64.00000000, 0.00000000 };
Point ( 2719 ) = { -2.80000000, 64.00000000, 0.00000000 };
Point ( 2720 ) = { -2.90000000, 64.00000000, 0.00000000 };
Point ( 2721 ) = { -3.00000000, 64.00000000, 0.00000000 };
Point ( 2722 ) = { -3.10000000, 64.00000000, 0.00000000 };
Point ( 2723 ) = { -3.20000000, 64.00000000, 0.00000000 };
Point ( 2724 ) = { -3.30000000, 64.00000000, 0.00000000 };
Point ( 2725 ) = { -3.40000000, 64.00000000, 0.00000000 };
Point ( 2726 ) = { -3.50000000, 64.00000000, 0.00000000 };
Point ( 2727 ) = { -3.60000000, 64.00000000, 0.00000000 };
Point ( 2728 ) = { -3.70000000, 64.00000000, 0.00000000 };
Point ( 2729 ) = { -3.80000000, 64.00000000, 0.00000000 };
Point ( 2730 ) = { -3.90000000, 64.00000000, 0.00000000 };
Point ( 2731 ) = { -4.00000000, 64.00000000, 0.00000000 };
Point ( 2732 ) = { -4.10000000, 64.00000000, 0.00000000 };
Point ( 2733 ) = { -4.20000000, 64.00000000, 0.00000000 };
Point ( 2734 ) = { -4.30000000, 64.00000000, 0.00000000 };
Point ( 2735 ) = { -4.40000000, 64.00000000, 0.00000000 };
Point ( 2736 ) = { -4.50000000, 64.00000000, 0.00000000 };
Point ( 2737 ) = { -4.60000000, 64.00000000, 0.00000000 };
Point ( 2738 ) = { -4.70000000, 64.00000000, 0.00000000 };
Point ( 2739 ) = { -4.80000000, 64.00000000, 0.00000000 };
Point ( 2740 ) = { -4.90000000, 64.00000000, 0.00000000 };
Point ( 2741 ) = { -5.00000000, 64.00000000, 0.00000000 };
Point ( 2742 ) = { -5.10000000, 64.00000000, 0.00000000 };
Point ( 2743 ) = { -5.20000000, 64.00000000, 0.00000000 };
Point ( 2744 ) = { -5.30000000, 64.00000000, 0.00000000 };
Point ( 2745 ) = { -5.40000000, 64.00000000, 0.00000000 };
Point ( 2746 ) = { -5.50000000, 64.00000000, 0.00000000 };
Point ( 2747 ) = { -5.60000000, 64.00000000, 0.00000000 };
Point ( 2748 ) = { -5.70000000, 64.00000000, 0.00000000 };
Point ( 2749 ) = { -5.80000000, 64.00000000, 0.00000000 };
Point ( 2750 ) = { -5.90000000, 64.00000000, 0.00000000 };
Point ( 2751 ) = { -6.00000000, 64.00000000, 0.00000000 };
Point ( 2752 ) = { -6.10000000, 64.00000000, 0.00000000 };
Point ( 2753 ) = { -6.20000000, 64.00000000, 0.00000000 };
Point ( 2754 ) = { -6.30000000, 64.00000000, 0.00000000 };
Point ( 2755 ) = { -6.40000000, 64.00000000, 0.00000000 };
Point ( 2756 ) = { -6.50000000, 64.00000000, 0.00000000 };
Point ( 2757 ) = { -6.60000000, 64.00000000, 0.00000000 };
Point ( 2758 ) = { -6.70000000, 64.00000000, 0.00000000 };
Point ( 2759 ) = { -6.80000000, 64.00000000, 0.00000000 };
Point ( 2760 ) = { -6.90000000, 64.00000000, 0.00000000 };
Point ( 2761 ) = { -7.00000000, 64.00000000, 0.00000000 };
Point ( 2762 ) = { -7.10000000, 64.00000000, 0.00000000 };
Point ( 2763 ) = { -7.20000000, 64.00000000, 0.00000000 };
Point ( 2764 ) = { -7.30000000, 64.00000000, 0.00000000 };
Point ( 2765 ) = { -7.40000000, 64.00000000, 0.00000000 };
Point ( 2766 ) = { -7.50000000, 64.00000000, 0.00000000 };
Point ( 2767 ) = { -7.60000000, 64.00000000, 0.00000000 };
Point ( 2768 ) = { -7.70000000, 64.00000000, 0.00000000 };
Point ( 2769 ) = { -7.80000000, 64.00000000, 0.00000000 };
Point ( 2770 ) = { -7.90000000, 64.00000000, 0.00000000 };
Point ( 2771 ) = { -8.00000000, 64.00000000, 0.00000000 };
Point ( 2772 ) = { -8.10000000, 64.00000000, 0.00000000 };
Point ( 2773 ) = { -8.20000000, 64.00000000, 0.00000000 };
Point ( 2774 ) = { -8.30000000, 64.00000000, 0.00000000 };
Point ( 2775 ) = { -8.40000000, 64.00000000, 0.00000000 };
Point ( 2776 ) = { -8.50000000, 64.00000000, 0.00000000 };
Point ( 2777 ) = { -8.60000000, 64.00000000, 0.00000000 };
Point ( 2778 ) = { -8.70000000, 64.00000000, 0.00000000 };
Point ( 2779 ) = { -8.80000000, 64.00000000, 0.00000000 };
Point ( 2780 ) = { -8.90000000, 64.00000000, 0.00000000 };
Point ( 2781 ) = { -9.00000000, 64.00000000, 0.00000000 };
Point ( 2782 ) = { -9.10000000, 64.00000000, 0.00000000 };
Point ( 2783 ) = { -9.20000000, 64.00000000, 0.00000000 };
Point ( 2784 ) = { -9.30000000, 64.00000000, 0.00000000 };
Point ( 2785 ) = { -9.40000000, 64.00000000, 0.00000000 };
Point ( 2786 ) = { -9.50000000, 64.00000000, 0.00000000 };
Point ( 2787 ) = { -9.60000000, 64.00000000, 0.00000000 };
Point ( 2788 ) = { -9.70000000, 64.00000000, 0.00000000 };
Point ( 2789 ) = { -9.80000000, 64.00000000, 0.00000000 };
Point ( 2790 ) = { -9.90000000, 64.00000000, 0.00000000 };
Point ( 2791 ) = { -10.00000000, 64.00000000, 0.00000000 };
Point ( 2792 ) = { -10.10000000, 64.00000000, 0.00000000 };
Point ( 2793 ) = { -10.20000000, 64.00000000, 0.00000000 };
Point ( 2794 ) = { -10.30000000, 64.00000000, 0.00000000 };
Point ( 2795 ) = { -10.40000000, 64.00000000, 0.00000000 };
Point ( 2796 ) = { -10.50000000, 64.00000000, 0.00000000 };
Point ( 2797 ) = { -10.60000000, 64.00000000, 0.00000000 };
Point ( 2798 ) = { -10.70000000, 64.00000000, 0.00000000 };
Point ( 2799 ) = { -10.80000000, 64.00000000, 0.00000000 };
Point ( 2800 ) = { -10.90000000, 64.00000000, 0.00000000 };
Point ( 2801 ) = { -11.00000000, 64.00000000, 0.00000000 };
Point ( 2802 ) = { -11.10000000, 64.00000000, 0.00000000 };
Point ( 2803 ) = { -11.20000000, 64.00000000, 0.00000000 };
Point ( 2804 ) = { -11.30000000, 64.00000000, 0.00000000 };
Point ( 2805 ) = { -11.40000000, 64.00000000, 0.00000000 };
Point ( 2806 ) = { -11.50000000, 64.00000000, 0.00000000 };
Point ( 2807 ) = { -11.60000000, 64.00000000, 0.00000000 };
Point ( 2808 ) = { -11.70000000, 64.00000000, 0.00000000 };
Point ( 2809 ) = { -11.80000000, 64.00000000, 0.00000000 };
Point ( 2810 ) = { -11.90000000, 64.00000000, 0.00000000 };
Point ( 2811 ) = { -12.00000000, 64.00000000, 0.00000000 };
Point ( 2812 ) = { -12.10000000, 64.00000000, 0.00000000 };
Point ( 2813 ) = { -12.20000000, 64.00000000, 0.00000000 };
Point ( 2814 ) = { -12.30000000, 64.00000000, 0.00000000 };
Point ( 2815 ) = { -12.40000000, 64.00000000, 0.00000000 };
Point ( 2816 ) = { -12.50000000, 64.00000000, 0.00000000 };
Point ( 2817 ) = { -12.60000000, 64.00000000, 0.00000000 };
Point ( 2818 ) = { -12.70000000, 64.00000000, 0.00000000 };
Point ( 2819 ) = { -12.80000000, 64.00000000, 0.00000000 };
Point ( 2820 ) = { -12.90000000, 64.00000000, 0.00000000 };
Point ( 2821 ) = { -13.00000000, 64.00000000, 0.00000000 };
Point ( 2822 ) = { -13.10000000, 64.00000000, 0.00000000 };
Point ( 2823 ) = { -13.20000000, 64.00000000, 0.00000000 };
Point ( 2824 ) = { -13.30000000, 64.00000000, 0.00000000 };
Point ( 2825 ) = { -13.40000000, 64.00000000, 0.00000000 };
Point ( 2826 ) = { -13.50000000, 64.00000000, 0.00000000 };
Point ( 2827 ) = { -13.60000000, 64.00000000, 0.00000000 };
Point ( 2828 ) = { -13.70000000, 64.00000000, 0.00000000 };
Point ( 2829 ) = { -13.80000000, 64.00000000, 0.00000000 };
Point ( 2830 ) = { -13.90000000, 64.00000000, 0.00000000 };
BSpline ( 1 ) = { 2254 : 2830, 2254 };
Line Loop( 1 ) = { 1 };


// == Physical entities ===========================================
// Boundary OpenOcean (ID 4): 2
Physical Line( 4 ) = { 1 };
// Boundary Coast (ID 3): 1
Physical Line( 3 ) = { 0 };
Plane Surface( 10 ) = { 0, 1 };
Physical Surface( 10 ) = { 10 };

// == End of contour definitions ==================================
// Do not extent the elements sizes from the boundary inside the domain
Mesh.CharacteristicLengthExtendFromBoundary = 1;

// input bathymetry
Field[1] = Structured;
Field[1].FileName = "metric.pos";
Field[1].TextFormat = 1;

// constant edge length to use as initial mesh in testing
Field[2] = MathEval;
Field[2].F = "0.1";

// Set background field to constant
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
General.RotationX = 0;
General.RotationY = 0;
General.RotationZ = 0;


BRepGeneration
==============

Generation of boundary representation from arbitrary geophysical fields.

For further information and updates, please contact the author Dr Adam S. Candy at adam.candy@imperial.ac.uk.

------------------------------------------------------------

A new meshing approach for realistic domains.
  
This code generates boundary representations with elemernt identifications from arbitrary geophysical fields.  It was originally used  mask to generate a boundary along the coastlines and grounding line* (which is not positioned at a constant depth).  The code is easily applied to boundaries along depth contours and to work with other NetCDF sources.
  
The new approach uses contouring routines (as opposed to the GSHHS Gmsh plugin, or a GMT approach).  It would be useful to test this new code on a wide range of regions - particularly to check the contouring routines are behaving satisfactorily.  It works very well in the Antarctic region (including the region inside ice shelf cavities). 
  
The dependencies are all Python modules (e.g. GMT is not required).

 * which involves a neat trick with modulo arithmetic to keep calculation time down significantly.
  
Supported features:
  - Define boundaries from NetCDF (currently restricted to the RTopo mask - trivial to extend) 
  - Regions defined by arbitrary functions of longitude and latitude (given on the command line)
  - Simpler definition of regions by boxes (such as 'longmin:longmax,latmin:longmax')
  - Define included paths by Gmsh ID number (useful to include or exclude  specific islands/land masses)
  - Deals with multiple open boundaries
  - Islands and boundaries split by the global boundary are treated
  - Automatically closes boundaries with parallels and meridians (with a prescribed length step)
  - Applies different boundary IDs on open and closed boundaries
  - Exclude smaller islands - restricted by a given minimum area
  - Option to extend domain in latitude on open boundaries (e.g. for sponge regions, or large open regions in the open ocean)
  - Command line used is saved in the Gmsh .geo file for reference
  - Option to generate the ACC average track line (and then to refine the mesh to this)
  

Other updates
  - Consistent use of dx_default.
  - The Antarctica main example contour can now be meshed (uses dx=10 in the parallel creation now).
  - Renamed the variables associated with the inclusion of the ice shelf ocean cavities to be more intuitive.

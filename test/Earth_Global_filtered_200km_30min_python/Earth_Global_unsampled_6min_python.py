#!/usr/bin/env python

source = '''
<?xml version='1.0' encoding='utf-8'?>
<shingle_options>
  <model_name>
    <string_value lines="1">Earth_Global_filtered_200km_30min_metric</string_value>
  </model_name>
  <domain_type>
    <string_value lines="1">oceans</string_value>
  </domain_type>
  <dataset name="RTopo105b_data_filtered_200km_30min">
    <form name="Raster">
      <source file_name="../../dataset/noshelf_30m_fg.nc" name="Local_file"/>
    </form>
  </dataset>
  <geoid_surface_representation name="GlobalCoastlines">
    <id>
      <integer_value rank="0">9</integer_value>
    </id>
    <brep_component name="GlobalCoastlines">
      <form name="Raster">
        <source name="RTopo105b_data_filtered_200km_30min"/>
        <minimum_area>
          <real_value rank="0">5000.0</real_value>
        </minimum_area>
        <contourtype name="zmask"/>
      </form>
      <identification name="Coastline"/>
      <representation_type name="BSplines"/>
      <spacing>
        <real_value rank="0">10.0</real_value>
      </spacing>
    </brep_component>
    <boundary name="Coastline">
      <identification_number>
        <integer_value rank="0">3</integer_value>
      </identification_number>
    </boundary>
  </geoid_surface_representation>
  <metric>
    <form name="Proximity">
      <boundary name="Coastline"/>
      <edge_length_minimum>
        <real_value rank="0">1.0E4</real_value>
      </edge_length_minimum>
      <edge_length_maximum>
        <real_value rank="0">1.0E6</real_value>
      </edge_length_maximum>
      <proximity_minimum>
        <real_value rank="0">4.0E4</real_value>
      </proximity_minimum>
      <proximity_maximum>
        <real_value rank="0">2.0E6</real_value>
      </proximity_maximum>
    </form>
  </metric>
</shingle_options>
'''

import os
import sys
#for path in ['~/bin/common/shingle/']: sys.path.append(os.path.expanduser(path))

shingle_path = os.path.realpath(os.path.join(os.path.realpath(os.path.dirname(os.path.realpath(__file__))), os.path.pardir, os.path.pardir))
sys.path.insert(0, shingle_path)
print shingle_path

import shingle
from shingle import Prime

from shingle.Scenario import specification

specification.set_option('/model_name', 'Earth_Global_filtered_200km_30min_python')

specification.set_option('/dataset[0]', 'RTopo105b_data_filtered_200km_30min')
specification.set_option('/dataset::RTopo105b_data_filtered_200km_30min/form[0]', 'Raster')

specification.set_option('/dataset::RTopo105b_data_filtered_200km_30min/form::Raster/source', 'Local_file')
specification.set_option('/dataset::RTopo105b_data_filtered_200km_30min/form::Raster/source/file_name', '../../dataset/noshelf_30m_fg.nc')


specification.set_option('/geoid_surface_representation', 'GlobalCoastlines')
specification.set_option('/geoid_surface_representation/id', 9)



specification.print_options()


# Also do:

# s = Scenario()
# d = Dataset(...)
# s.AddDataset(d)


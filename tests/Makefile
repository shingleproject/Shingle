##########################################################################
#  
#  Generation of boundary representation from arbitrary geophysical
#  fields and initialisation for anisotropic, unstructured meshing.
#  
#  Copyright (C) 2011-2013 Dr Adam S. Candy, adam.candy@imperial.ac.uk
#  
#  This program is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 3 of the License, or
#  (at your option) any later version.
#  
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#  
#  You should have received a copy of the GNU General Public License
#  along with this program.  If not, see <http://www.gnu.org/licenses/>.
#  
##########################################################################

DATASET=../RTopo105b_50S.nc

SCRIPT=../shingle.py

EXAMPLES=antarctica_main_landmass filchner-ronne antarctica_all filchner-ronne_iceshelf amundsen_sea antarctica_main_landmass_30s

green=\033[0;32m
red=\033[0;31m
blue=\033[0;34m
end=\033[0m

#green=
#red=
#blue=
#end=

#ECHO=echo -e
ECHO=echo

#### main

default:	test

test: 
	@echo "  TEST ALL"
	@make -s clean
	@make -s allcases
	$(ECHO) "  SUMMARY:"
	@make -s testcases
	$(ECHO) "  ALL TESTS: $(green)PASS$(end)"

build:
	@echo "  BUILD ALL (no testing)"
	@make -s clean
	@make -s buildcases

clean: datacheck
	@echo "  CLEAN ALL"
	@$(foreach var,$(EXAMPLES), $(MAKE) -s clean$(var);)

datacheck:
	@test -s $(DATASET) || { \
		echo ""; \
	  echo "Dataset '$(DATASET)' not present."; \
		echo "Please download from"; \
		echo "  http://store.pangaea.de/Publications/TimmermannR_et_al_2010/RTopo105b_50S.nc"; \
		echo "and place in the root folder."; \
		echo ""; \
		echo "Alternatively, download using the make directive 'data', i.e."; \
		echo "  make data"; \
		echo ""; \
		echo "Also, the directive 'datalink' is setup to create a symbolic link to the dataset at ~/dataset/rtopo/RTopo105b_50S.nc using"; \
		echo "  make datalink"; \
		echo ""; \
		false; }

datalink:
	@echo 'Creating a link to the RTopo dataset at ~/dataset/rtopo/RTopo105b_50S.nc'
	@ln -s ~/tmp/dataset/rtopo/RTopo105b_50S.nc $(DATASET)

data:
	@echo 'Downloading the RTopo dataset for the tests (note 743MB).'
	@curl 'http://store.pangaea.de/Publications/TimmermannR_et_al_2010/RTopo105b_50S.nc' -o $(DATASET)

datatimeout:
	@echo 'Downloading the RTopo dataset for the tests (note 743MB).'
	@curl -m 240 'http://store.pangaea.de/Publications/TimmermannR_et_al_2010/RTopo105b_50S.nc' -o $(DATASET)

testwithdatadownload:
	@make datatimeout
	@make test

.PHONY: data datalink testwithdatadownload datacheck

allcases:
	@$(foreach var, $(EXAMPLES), $(MAKE) -s all$(var);)

buildcases:
	@$(MAKE) -s $(foreach var, $(EXAMPLES), build$(var))

updatevalid:
	@$(foreach var,$(EXAMPLES), cat $(var)/shorelines.geo > valid/$(var)/shorelines.geo;)

testcases:
	@$(MAKE) -s $(foreach var, $(EXAMPLES), test$(var))

.PHONY: allcases buildcases testcases

default: test

#### individual

test%: %
	@$(ECHO) "    TEST $(blue)$*$(end)"
	@if ./diff_exclude_header valid/$</shorelines.geo $</shorelines.geo; then \
		$(ECHO) "    $(green)PASS$(end)"; \
	else \
		$(ECHO) "    $(red)FAIL$(end)"; \
		echo "Examine valid/$</shorelines.geo $</shorelines.geo"; \
		exit 1; \
	fi

clean%:
	@$(ECHO) "    CLEAN $(blue)$*$(end)"
	@rm -fr "$*"

mkdir%:
	@$(ECHO) "    MKDIR $(blue)$*$(end)"
	@mkdir "$*"
	
build%:
	@echo "  CASE $*"
	@make -s clean$*
	@make -s mkdir$*
	@$(ECHO) "    CONTOUR $(blue)$*$(end)"
	@make -s $*/shorelines.geo

all%:
	@make -s build$*
	@make -s test$*

#### test cases

# Include only the main Antarctic mass (path 1), and only parts which lie below 60S
antarctica_main_landmass/shorelines.geo: 
	@$(SCRIPT) -f $@ -n $(DATASET) -r 'latitude <= -60.0' -p 1 -dx 10 -exclude_ice_shelves -bl -60 > $(dir $@)/mesh.log

# Include only the main Antarctic mass (path 1), and only parts which lie below 60S, domain up to -30S
antarctica_main_landmass_30s/shorelines.geo: 
	@$(SCRIPT) -f $@ -n $(DATASET) -r 'latitude <= -60.0' -p 1 -dx 10 -exclude_ice_shelves -bl -30 > $(dir $@)/mesh.log

# Filchner-Ronne extended out to the 65S parallel
filchner-ronne/shorelines.geo:
	@$(SCRIPT) -f $@ -n $(DATASET) -no -b -85.0:-20.0,-89.0:-75.0 -64.0:-30.0,-89.0:-70.0 -30.0:-20.0,-89.0:-75.0 -lat '-65.0' > $(dir $@)/mesh.log

# Antarctica, everything below the 60S parallel, coarse approximation to open boundary
antarctica_all/shorelines.geo:
	@$(SCRIPT) -f $@ -n $(DATASET) -dx 2 -r 'latitude <= -60' > $(dir $@)/mesh.log

# Small region close to the Filcher-Ronne ice shelf
filchner-ronne_iceshelf/shorelines.geo:
	@$(SCRIPT) -f $@ -n $(DATASET) -no -b -85.0:-20.0,-89.0:-75.0 -64.0:-30.0,-89.0:-70.0 -30.0:-20.0,-89.0:-75.0 -p 1 -r 'latitude <= -83' > $(dir $@)/mesh.log

# Amundsen Sea
amundsen_sea/shorelines.geo:
	@$(SCRIPT) -f $@ -n $(DATASET) -no -b -130.0:-85.0,-85.0:-60.0 -lat -64.0 > $(dir $@)/mesh.log




#clean:
#	@rm -r $(EXAMPLES)

#  -n filename                 | Input netCDF file
#  -f filename                 | Output Gmsh file
#  -p path1 (path2)..          | Specify paths to include
#  -r function                 | Function specifying region of interest
#  -b box1 (box2)..            | Boxes with regions of interest
#  -a minarea                  | Minimum area of islands
#  -dx dist                    | Distance of steps when drawing parallels and meridians (currently in degrees - need to project)
#  -bounding_latitude latitude | Latitude of boundary to close the domain
#  -bl latitude                | Short form of -bounding_latitude
#  -exclude_ice_shelves        | Excludes under ice shelf region from mesh (default behaviour includes region)
#  -smooth_data degree         | Smoothes boundaries
#  -no                         | Do not include open boundaries
#  -lat latitude               | Latitude to extent open domain to
#  -s scenario                 | Select scenario (in development)
#  -v                          | Verbose
#  -vv                         | Very verbose (debugging)
#  -q                          | Quiet
#  -h                          | Help
# ------------------------------------------------------------
# Example usage:
# Filchner-Ronne extended out to the 65S parallel
#   rtopo_mask_to_stereographic.py -no -b -85.0:-20.0,-89.0:-75.0 -64.0:-30.0,-89.0:-70.0 -30.0:-20.0,-89.0:-75.0 -lat '-65.0'
# Antarctica, everything below the 60S parallel, coarse approximation to open boundary
#   rtopo_mask_to_stereographic.py -dx 2 -r 'latitude <= -60'
# Small region close to the Filcher-Ronne ice shelf
#   rtopo_mask_to_stereographic.py -no -b -85.0:-20.0,-89.0:-75.0 -64.0:-30.0,-89.0:-70.0 -30.0:-20.0,-89.0:-75.0 -p 1 -r 'latitude <= -83'
# Amundsen Sea
#   rtopo_mask_to_stereographic.py -no -b -130.0:-85.0,-85.0:-60.0 -lat -64.0
# 
# Small islands, single out, or group with -p
#   312, 314
#   79 - an island on 90W 68S


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

ECHO=echo

default: bin/shingle

bin/shingle: src/shingle lib/libspud.so
	@mkdir -p bin
	@cp src/shingle bin/shingle

clean:
	@echo 'CLEAN test legacy'
	@make -s -C test/legacy clean
	@echo 'CLEAN test'
	@rm -f test/*/*.log test/*/*.geo
	@echo 'CLEAN shingle'
	@rm -f shingle/*.pyc
	@echo 'CLEAN tool'
	@rm -f tool/spud-preprocess
	@echo 'CLEAN lib'
	@rm -rf lib
	@echo 'CLEAN spud'
	@make -s -C spud clean
	@echo 'CLEAN bin'
	@rm -rf bin

# ------------------------------------------------------------------------

test: bin/shingle
	@./bin/shingle -t test

testlegacy:
	@echo "Legacy test engine:"
	@make -s -C test/legacy

testall:
	@make test
	@make testlegacy

data:
	@make -s -C test/legacy data

datalink:
	@make -s -C test/legacy datalink

testwithdatadownload:
	@make -s -C test/legacy testwithdatadownload
	
.PHONY: test testlegacy data datalink testwithdatadownload schema

# ------------------------------------------------------------------------

spud: lib/libspud.so tool/spud-preprocess
libspud: lib/libspud.so

lib/libspud.so:
	@mkdir -p lib
	@make -C spud install-pyspud
	@cp lib/python*/site-packages/libspud.so lib/

# ------------------------------------------------------------------------

schema: schema/shingle_options.rng .FORCE

schema/shingle_options.rng: tool/spud-preprocess .FORCE
	@echo "Rebuilding schema shingle_options.rng"
	@./tool/spud-preprocess schema/shingle_options.rnc

tool/spud-preprocess: lib/libspud.so
	@mkdir -p ./tool
	@cp spud/bin/spud-preprocess tool/
	@chmod a+x ./tool/spud-preprocess
	@sed -i 's/\.\.\/share\/spud/schema/' ./tool/spud-preprocess

.FORCE: 

# ------------------------------------------------------------------------

spudpatch:
	@patch -p0 < spud.patch


# ./spud/diamond/bin/diamond -s schema/shingle_options.rng test/test.shml


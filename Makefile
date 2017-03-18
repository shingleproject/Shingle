##########################################################################
#  
#  Copyright (C) 2011-2016 Dr Adam S. Candy
# 
#  Shingle:  An approach and software library for the generation of
#            boundary representation from arbitrary geophysical fields
#            and initialisation for anisotropic, unstructured meshing.
# 
#            Web: https://www.shingleproject.org
#
#            Contact: Dr Adam S. Candy, contact@shingleproject.org
#
#  This file is part of the Shingle project.
#  
#  Shingle is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 3 of the License, or
#  (at your option) any later version.
#  
#  Shingle is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#  
#  You should have received a copy of the GNU General Public License
#  along with Shingle.  If not, see <http://www.gnu.org/licenses/>.
#
##########################################################################

ECHO = echo
MAKE = make
PYPI = pypi

default: bin/shingle

bin/shingle: src/shingle lib/libspud.so
	@mkdir -p bin
	@cp src/shingle bin/shingle

install: bin/shingle
	@$(ECHO) 'INSTALL shingle Python library'
	@pip install .

clean:
	@echo 'CLEAN test legacy'
	@$(MAKE) -s -C test/legacy clean
	@echo 'CLEAN test'
	@rm -f test/*/*.log test/*/*.geo
	@echo 'CLEAN shingle'
	@rm -f shingle/*.pyc
	@echo 'CLEAN tool'
	@rm -f tool/spud-preprocess
	@echo 'CLEAN lib'
	@rm -rf lib
	@echo 'CLEAN doc'
	@$(MAKE) -s -C doc clean
	@echo 'CLEAN spud'
	@$(MAKE) -s -C spud clean
	@echo 'CLEAN bin'
	@rm -rf bin
	@rm -rf spud.egg-info libspud.egg-info shingle.egg-info build dist

manual: 
	@$(MAKE) -s -C doc shingle_manual.pdf

package:
	@$(ECHO) 'PACKAGE shingle'
	@python setup.py sdist bdist_wheel
	@$(ECHO) 'PACKAGE dxdiff'
	@cd spud/dxdiff; python setup.py sdist; cp -rp dist/* ../../dist/; cd ../..
	@$(ECHO) 'PACKAGE diamond'
	@cd spud/diamond; python setup.py sdist; cp -rp dist/* ../../dist/; cd ../..

packageupload:
	@$(ECHO) 'PACKAGE UPLOAD shingle'
	@python setup.py register -r $(PYPI)
	@python setup.py sdist bdist_wheel upload -r $(PYPI)
	@$(ECHO) 'PACKAGE UPLOAD dxdiff'
	@cd spud/dxdiff; python setup.py register -r $(PYPI); python setup.py sdist upload -r $(PYPI); cp -rp dist/* ../../dist/; cd ../..
	@$(ECHO) 'PACKAGE UPLOAD diamond'
	@cd spud/diamond; python setup.py register -r $(PYPI); python setup.py sdist upload -r $(PYPI); cp -rp dist/* ../../dist/; cd ../..

installpackage: package
	@$(ECHO) 'INSTALL shingle Python library'
	@pip install ./dist/shingle-*.tar.gz
	@$(ECHO) 'INSTALL diamond'
	@pip install ./dist/spud-diamond-*.tar.gz
	@$(ECHO) 'INSTALL dxdiff'
	@pip install ./dist/dxdiff-*.tar.gz

test: bin/shingle datalocal
	@./bin/shingle -t test

testimage:
	@./bin/shingle -t test -image
	@convert ./test/*/*.png ./test/ShingleVerificationOverviewImages.pdf

testimagelabel:
	@label -tf -nd -d test/images test/*/*.png
	@convert test/images/*.png test/ShingleVerificationOverviewImages.pdf 
	@rm -r test/images

unittest:
	@cd shingle; pytest; cd ..

# ------------------------------------------------------------------------

testlegacy:
	@echo "Legacy test engine:"
	@$(MAKE) -s -C test/legacy

testall:
	@$(MAKE) test
	@$(MAKE) testlegacy

data:
	@$(MAKE) -s -C test/legacy data

datalink:
	@$(MAKE) -s -C test/legacy datalink

testwithdatadownload:
	@$(MAKE) -s -C test/legacy testwithdatadownload

.PHONY: test testlegacy data datalink testwithdatadownload schema doc datalocal package

# ------------------------------------------------------------------------

spud: lib/libspud.so tool/spud-preprocess
libspud: lib/libspud.so

lib/libspud.so:
	@mkdir -p lib
	@$(MAKE) -C spud install-pyspud
	@pwd
	@tree
	@cp spud/python/build/lib.linux-x86_64-2.7/libspud.so lib/
	@cd lib; ln -sf libspud.so libspud.so.0; cd ..
	@cd shingle; ln -sf libspud.so libspud.so.0; cd ..

#@cp lib/python*/site-packages/libspud.so lib/
#@cp lib/python*/site-packages/libspud.so shingle/
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

# ------------------------------------------------------------------------

datalocal: dataset/Caribbean.nc dataset/ChilePacificWide.nc dataset/Coquimbo.nc dataset/SouthernOcean_noshelf_30m_fg.nc dataset/RTopo105b_50S.nc

dataset/Caribbean.nc:
	@echo Downloading $@
	@mkdir -p dataset
	@curl -s 'https://zenodo.org/record/399213/files/Caribbean.nc' -o ./dataset/Caribbean.nc

dataset/ChilePacificWide.nc:
	@echo Downloading $@
	@mkdir -p dataset
	@curl -s 'https://zenodo.org/record/399213/files/ChilePacificWide.nc' -o ./dataset/ChilePacificWide.nc

dataset/Coquimbo.nc:
	@echo Downloading $@
	@mkdir -p dataset
	@curl -s 'https://zenodo.org/record/399213/files/Coquimbo.nc' -o ./dataset/Coquimbo.nc

dataset/SouthernOcean_noshelf_30m_fg.nc:
	@echo Downloading $@
	@mkdir -p dataset
	@curl -s 'https://zenodo.org/record/399213/files/SouthernOcean_noshelf_30m_fg.nc' -o ./dataset/SouthernOcean_noshelf_30m_fg.nc

dataset/RTopo105b_50S.nc:
	@echo Downloading $@
	@mkdir -p dataset
	@curl -s 'http://store.pangaea.de/Publications/TimmermannR_et_al_2010/RTopo105b_50S.nc' -o ./dataset/RTopo105b_50S.nc







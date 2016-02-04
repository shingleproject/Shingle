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

default: test

test:
	@make -s -C tests

data:
	@make -s -C tests data

datalink:
	@make -s -C tests datalink

testwithdatadownload:
	@make -s -C tests testwithdatadownload
	
.PHONY: test data datalink testwithdatadownload


clean:
	@echo 'CLEAN tests'
	@make -s -C tests clean
	@echo 'CLEAN libs'
	@rm -f ./libspud.so
	@echo 'CLEAN spud'
	@make -s -C spud clean


spudpatch:
	@patch -p0 < spud.patch

libspud.so:
	@cd spud; ./configure; cd ..
	@DESTDIR=. make -C spud install-pyspud
	@cp spud/python/usr/local/lib/python*/site-packages/libspud.so .





lib/libspud.a:
	@echo '    MKDIR lib'; mkdir -p lib
	@echo '    MAKE libspud'; $(MAKE) -C libspud




##############################################################################
#
#  Copyright (C) 2011-2018 Dr Adam S. Candy and others.
#  
#  Shingle:  An approach and software library for the generation of
#            boundary representation from arbitrary geophysical fields
#            and initialisation for anisotropic, unstructured meshing.
#  
#            Web: http://www.shingleproject.org
#  
#            Contact: Dr Adam S. Candy, contact@shingleproject.org
#  
#  This file is part of the Shingle project.
#  
#  Please see the AUTHORS file in the main source directory for a full list
#  of contributors.
#  
#  Shingle is free software: you can redistribute it and/or modify
#  it under the terms of the GNU Lesser General Public License as published by
#  the Free Software Foundation, either version 3 of the License, or
#  (at your option) any later version.
#  
#  Shingle is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU Lesser General Public License for more details.
#  
#  You should have received a copy of the GNU Lesser General Public License
#  along with Shingle. If not, see <http://www.gnu.org/licenses/>.
#
##############################################################################

MAKE = make
ECHO = echo

default: ShingleManual

ShingleManual: verification_figures.tex
	@echo BUILD ShingleManual
	@$(MAKE) -s ShingleManual.pdf

verification_figures.tex:
	@echo BUILD verification_figures
	@./compile_verification_test_images.py

%.pdf: %.tex
	pdflatex -shell-escape $^
	if fgrep "Rerun to" $*.log; then $(MAKE) --assume-new $^ $@;fi
ifndef NOBIBTEX
	if fgrep "There were undefined"  $*.log;\
	then bibtex $*; \
	$(MAKE) NOBIBTEX=true --assume-new $^ $@;fi
endif

clean:
	@rm -f *.{aux,log,bbl,blg,out,toc,pyg,thm}
	@rm -f verification_figures.tex
	@rm -rf _minted-ShingleManual

.PHONY: verification_figures ShingleManual


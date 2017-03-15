
MAKE = make
ECHO = echo

default: shingle_manual


shingle_manual: verification_figures.tex
	@echo BUILD shingle_manual
	@$(MAKE) -s shingle_manual.pdf

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
	@rm -f verification_figures.tex shingle_manual.pdf
	@rm -rf _minted-shingle_manual

.PHONY: verification_figures shingle_manual


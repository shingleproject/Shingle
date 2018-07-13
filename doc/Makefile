
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
	@rm -f verification_figures.tex ShingleManual.pdf
	@rm -rf _minted-ShingleManual

.PHONY: verification_figures ShingleManual


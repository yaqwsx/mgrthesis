svgfigures = $(wildcard figures/*.svg)
pdffigures = $(svgfigures:.svg=.pdf)
src = $(wildcard *.tex)

all: thesis

thesis: $(src) $(pdffigures)
	texfot latexmk -halt-on-error -pdf --shell-escape thesis.tex 2>&1

.PHONY: clean
clean:
	latexmk -c
	rm $(pdffigures)

%.pdf: %.svg
	inkscape $< --export-pdf=$@
svgfigures = $(wildcard figures/*.svg)
pdffigures = $(svgfigures:.svg=.pdf)
src = $(wildcard *.tex)

all: thesis

thesis: $(src) $(pdffigures)
	latexmk -pdf --shell-escape thesis.tex

.PHONY: clean
clean:
	latexmk -c

%.pdf: %.svg
	inkscape $< --export-pdf=$@
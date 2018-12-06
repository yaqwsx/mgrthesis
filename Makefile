svgfigures = $(wildcard figures/*.svg)
xcffigures = $(wildcard figures/*.xcf)
pdffigures = $(svgfigures:.svg=.pdf)
jpgfigures = $(xcffigures:.xcf=.jpg)
src = $(wildcard *.tex)

all: thesis

thesis: $(src) $(pdffigures) $(jpgfigures)
	texfot latexmk -halt-on-error -pdf --shell-escape thesis.tex 2>&1

.PHONY: clean
clean:
	latexmk -c
	rm $(pdffigures)
	rm $(jpgfigures)

%.pdf: %.svg
	inkscape $< --export-pdf=$@

%.jpg: %.xcf
	util/xcfToJpg.sh $< $@
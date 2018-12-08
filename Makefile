svgfigures = $(wildcard figures/*.svg)
xcffigures = $(wildcard figures/*.xcf)
pdffigures = $(svgfigures:.svg=.pdf)
jpgfigures = $(xcffigures:.xcf=.jpg)
src = $(wildcard *.tex)

all: thesis

thesis: $(src) $(pdffigures) $(jpgfigures)
	texfot latexmk -halt-on-error -pdf --shell-escape thesis.tex 2>&1

thesis-print: thesis-print.tex $(src) $(pdffigures) $(jpgfigures)
	texfot latexmk -halt-on-error -pdf --shell-escape thesis-print.tex 2>&1

thesis-print.tex: thesis.tex
	sed -e 's/linkcolor={.*}/linkcolor={black}/' \
		-e 's/citecolor={.*}/citecolor={black}/' \
		-e 's/urlcolor={.*}/urlcolor={black}/' \
		-e 's/\\iffalse.*%@ifprint/\\iftrue/' \
		$< > $@

.PHONY: clean

clean-thesis:
	latexmk -c

clean-figures:
	rm $(pdffigures)
	rm $(jpgfigures)

clean: clean-thesis clean-figures

%.pdf: %.svg
	inkscape $< --export-pdf=$@

%.jpg: %.xcf
	util/xcfToJpg.sh $< $@
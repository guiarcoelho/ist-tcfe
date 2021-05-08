# ------------------------------------------------------------
# type "make" command in the Linux terminal create report.pdf
#
# type "make clean" to delete all generated files
# ------------------------------------------------------------

all: | ../doc/octave.log convert

../doc/octave.log: acdc_thunderstruck.m
	octave $< > $@
	
convert: 
	ls *.eps | awk '{system("epstopdf "$$0 )}'

clean:
	@rm -f *.tex
	@rm -f *.txt
	@rm -f *.cir
	@rm -f *.eps
	@rm -f *.pdf
	
.PHONY: clean


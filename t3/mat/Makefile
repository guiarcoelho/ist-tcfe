all: octave.log
	mv all_vout.eps ../doc
	mv deviation.eps ../doc
	mv envelope.eps ../doc
	mv regulator.eps ../doc

octave.log: acdc_converter.m
	octave $< > $@

clean:
	@rm -f octave.log octave-workspace *.eps *~
	@rm -f data*
	@rm -f *_tab.tex result_octave.txt
	
.PHONY: clean

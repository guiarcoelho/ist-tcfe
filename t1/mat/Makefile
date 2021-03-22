all:  octaveKnots.log octaveMesh.log


PreOctaveMesh.log: Mesh.m
	octave $< > $@

octaveMesh.log: PreOctaveMesh.log
	$(eval OCTTABS=$(shell grep -R _TAB $< | sed 's/_TAB//g' | sed ':a;N;$!ba;s/\n/ /g'))
	$(foreach i, $(OCTTABS), sed -n '/^$i_TAB/,/^$i_END/{p;/^$i_END/q}' $< | grep -v $i_TAB | grep -v $i_END | grep -v '#' | sed 's/\=/\&/g' | sed 's/$$/\\\\ \\hline/g' > $i_tab.tex;)
	 mv PreOctaveMesh.log octaveMesh.log


PreOctaveKnots.log: Knots.m
	octave $< > $@

octaveKnots.log: PreOctaveKnots.log
	$(eval OCTTABS=$(shell grep -R _TAB $< | sed 's/_TAB//g' | sed ':a;N;$!ba;s/\n/ /g'))
	$(foreach i, $(OCTTABS), sed -n '/^$i_TAB/,/^$i_END/{p;/^$i_END/q}' $< | grep -v $i_TAB | grep -v $i_END | grep -v '#' | sed 's/\=/\&/g' | sed 's/$$/\\\\ \\hline/g' > $i_tab.tex;)	
	mv PreOctaveKnots.log octaveKnots.log
	

clean:
	@rm -f octave-workspace *.log *.tex

.PHONY: clean

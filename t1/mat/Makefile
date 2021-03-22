all:  octaveNos.log octaveMalhas.log


PreOctaveMalhas.log: Malhas.m
	octave $< > $@

octaveMalhas.log: PreOctaveMalhas.log
	$(eval OCTTABS=$(shell grep -R _TAB $< | sed 's/_TAB//g' | sed ':a;N;$!ba;s/\n/ /g'))
	$(foreach i, $(OCTTABS), sed -n '/^$i_TAB/,/^$i_END/{p;/^$i_END/q}' $< | grep -v $i_TAB | grep -v $i_END | grep -v '#' | sed 's/\=/\&/g' | sed 's/$$/\\\\ \\hline/g' > $i_tab.tex;)
	 mv PreOctaveMalhas.log octaveMalhas.log


PreOctaveNos.log: Nos.m
	octave $< > $@

octaveNos.log: PreOctaveNos.log
	$(eval OCTTABS=$(shell grep -R _TAB $< | sed 's/_TAB//g' | sed ':a;N;$!ba;s/\n/ /g'))
	$(foreach i, $(OCTTABS), sed -n '/^$i_TAB/,/^$i_END/{p;/^$i_END/q}' $< | grep -v $i_TAB | grep -v $i_END | grep -v '#' | sed 's/\=/\&/g' | sed 's/$$/\\\\ \\hline/g' > $i_tab.tex;)	
	mv PreOctaveNos.log octaveNos.log
	

clean:
	@rm -f octave-workspace *.log *.tex

.PHONY: clean

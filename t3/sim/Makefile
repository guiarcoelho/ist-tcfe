all: ngspice_auto.log
	$(eval NGSFIGS=$(shell grep _FIG $< | sed 's/_FIG//g' | sed ':a;N;$!ba;s/\n/ /g'))
	$(eval NGSFIGPS=$(addsuffix .ps, $(NGSFIGS)))
	$(foreach i, $(NGSFIGPS), ps2pdf $i;)
	$(eval NGSTABS=$(shell grep _TAB $< | sed 's/_TAB//g' | sed ':a;N;$!ba;s/\n/ /g'))
	$(foreach i, $(NGSTABS), sed -n '/^$i_TAB/,/^$i_END/{p;/^$i_END/q}' $< | grep -v $i_TAB | grep -v $i_END | grep -v '#' | sed 's/\=/\&/g' | sed 's/$$/\\\\ \\hline/g' > $i_tab.tex;)
	
	
	mv vo_menos_12.pdf ../doc
	mv vout.pdf ../doc
	mv vs_vout_venv.pdf ../doc
	mv vrect.pdf ../doc

	
ngspice.log: ../sim/t3.net 
	ngspice -b $< -o $@
	
ngspice_auto.log: ../sim/t3_pontuacao.net
	ngspice -b $< -o $@
	
	
clean:
	@rm -f *.log *.tex *.pdf *.ps *~
	@rm -f *.txt
.PHONY: all clean

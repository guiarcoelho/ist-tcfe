# ------------------------------------------------------------
# type "make" command in the Linux terminal to generate report.pdf
#
# type "make clean" to delete all generated files
# ------------------------------------------------------------


all: ngspice.log ngspiceeq.log ngspice3.log ngspice4.log ngspice5.log
	$(eval NGSFIGS=$(shell grep _FIG $< | sed 's/_FIG//g' | sed ':a;N;$!ba;s/\n/ /g'))
	$(eval NGSFIGPS=$(addsuffix .ps, $(NGSFIGS)))
	$(foreach i, $(NGSFIGPS), ps2pdf $i;)
	$(eval NGSTABS=$(shell grep _TAB $< | sed 's/_TAB//g' | sed ':a;N;$!ba;s/\n/ /g'))
	$(foreach i, $(NGSTABS), sed -n '/^$i_TAB/,/^$i_END/{p;/^$i_END/q}' $< | grep -v $i_TAB | grep -v $i_END | grep -v '#' | sed 's/\=/\&/g' | sed 's/$$/\\\\ \\hline/g' > $i_tab.tex;)
	$(eval NGSFIGS=$(shell grep _FIG $(word 2,$^) | sed 's/_FIG//g' | sed ':a;N;$!ba;s/\n/ /g'))
	$(eval NGSFIGPS=$(addsuffix .ps, $(NGSFIGS)))
	$(foreach i, $(NGSFIGPS), ps2pdf $i;)
	$(eval NGSTABS=$(shell grep _TAB $(word 2,$^) | sed 's/_TAB//g' | sed ':a;N;$!ba;s/\n/ /g'))
	$(foreach i, $(NGSTABS), sed -n '/^$i_TAB/,/^$i_END/{p;/^$i_END/q}' $(word 2,$^) | grep -v $i_TAB | grep -v $i_END | sed 's/vx#branch/Ix/g'| grep -v '#' | sed 's/v(6)-v(8)/Vx/g' | sed 's/(Vx)\/Ix/Req/g' | sed 's/\=/\&/g' | sed 's/$$/\\\\ \\hline/g' > $i_tab.tex;)
	$(eval NGSFIGS=$(shell grep _FIG $(word 3,$^) | sed 's/_FIG//g' | sed ':a;N;$!ba;s/\n/ /g'))
	$(eval NGSFIGPS=$(addsuffix .ps, $(NGSFIGS)))
	$(foreach i, $(NGSFIGPS), ps2pdf $i;)
	$(eval NGSFIGS=$(shell grep _FIG $(word 4,$^) | sed 's/_FIG//g' | sed ':a;N;$!ba;s/\n/ /g'))
	$(eval NGSFIGPS=$(addsuffix .ps, $(NGSFIGS)))
	$(foreach i, $(NGSFIGPS), ps2pdf $i;)
	$(eval NGSFIGS=$(shell grep _FIG $(word 5,$^) | sed 's/_FIG//g' | sed ':a;N;$!ba;s/\n/ /g'))
	$(eval NGSFIGPS=$(addsuffix .ps, $(NGSFIGS)))
	$(foreach i, $(NGSFIGPS), ps2pdf $i;)
	mv acm.pdf ../doc
	mv trans.pdf ../doc
	mv transv5vs.pdf ../doc
	mv phase.pdf ../doc

	
ngspice.log: circuito.cir
	ngspice -b $< -o $@
	sed -i 's/v(6)-v(8) =/Vx 6 8 DC/g' datav6v8.txt
	sed -i 's/v(6)-v(8) = /\.ic v(6)=/g' dataic.txt
	sed -i 's/$$/ v(8)=0/g' dataic.txt


ngspiceeq.log: circuito_t_0.cir
	ngspice -b $< -o $@
	
ngspice3.log: natural_solution.cir
	ngspice -b $< -o $@
	
ngspice4.log: transient_analysis.cir
	ngspice -b $< -o $@
	
ngspice5.log: frequency_response.cir
	ngspice -b $< -o $@
	

clean:
	@rm -f *.log *.tex *.pdf *.ps *~
	@rm -f data_sim.txt
	@rm -f data_simeq.txt
	@rm -f datav6v8.txt
	@rm -f data_sim3.txt
	@rm -f data_sim4.txt
	@rm -f data_sim5.txt
	@rm -f dataic.txt
.PHONY: all clean

# ------------------------------------------------------------
# type "make" command in the Linux terminal create report.pdf
#
# type "make clean" to delete all generated files
# ------------------------------------------------------------

all: | octave.log convert

octave.log: nos_rc.m
	sed -i 's/C =/Ca = /g' data.txt
	octave $< > $@
	mv data_sim.txt ../sim
	mv data_simeq.txt ../sim
	mv data_sim3.txt ../sim
	mv data_sim4.txt ../sim
	mv data_sim5.txt ../sim
	
	sed -i 's/\=/\&/g' nodal_tab.tex
	sed -i 's/$$/\\\\ \\hline/g' nodal_tab.tex
	sed -i 's/\I_/\@/g' nodal_tab.tex
	mv nodal_tab.tex ../doc
	
	sed -i 's/\=/\&/g' phasor_tab.tex
	sed -i 's/p//g' phasor_tab.tex
	sed -i 's/$$/\\\\ \\hline/g' phasor_tab.tex
	mv phasor_tab.tex ../doc
	
	sed -i 's/\=/\&/g' req_tab.tex
	sed -i 's/$$/\\\\ \\hline/g' req_tab.tex
	sed -i 's/eq//g' req_tab.tex
	sed -i 's/R/Req/g' req_tab.tex
	sed -i 's/\I_/\@/g' req_tab.tex
	sed -i 's/tau/\\tau/g' req_tab.tex
	mv req_tab.tex ../doc

convert: 
	 ls *.eps | awk '{system("epstopdf "$$0 )}'
	 mv vs_v6_f_tab.pdf ../doc
	 mv theo5_tab.pdf ../doc
	 mv capacitor_voltage_tab.pdf ../doc
	 mv freq_resp_tab.pdf ../doc
	 mv angle_tab.pdf ../doc
	 mv natural_tab.pdf ../doc
 


clean:
	@rm -f octave.log octave-workspace *.eps *~
	@rm -f data*
	@rm -f *_tab.tex
	
.PHONY: clean


# ------------------------------------------------------------
# type "make" command in the Linux terminal create report.pdf
#
# type "make clean" to delete all generated files
# ------------------------------------------------------------



all:
	echo 95794 | python2.7 t2_datagen.py > data.txt
	sed -i -e '1,8d;20,22d' data.txt
	sed -i 's/Values:  //g' data.txt
	cp data.txt mat
	make -C mat
	make -C sim
	mv sim/op_tab.tex doc
	mv sim/opeq_tab.tex doc
	make -C doc
	cp doc/report.pdf .

clean:
	@rm -f data.txt
	make -C mat clean
	make -C sim clean
	make -C doc clean

.PHONY: all clean


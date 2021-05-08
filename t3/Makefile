# ------------------------------------------------------------
# type "make" command in the Linux terminal create report.pdf
#
# type "make clean" to delete all generated files
# ------------------------------------------------------------	

all: open

open:
	make -C mat
	make -C sim
	make -C doc
	cp doc/report.pdf .
	
clean:
	@rm -f *.txt
	make -C doc clean
	make -C mat clean
	make -C sim clean

.PHONY: all clean

close all
clear all

%variables for acdc_conveter-----------------------------------------

diary data_octave.txt
diary on
Renv = 600e3
C = 600e-6
Rreg = 803.84e3
n = 3 %amplitude(Vs) = 230/n
n_diodes = 21
diary off

%variables for ngspice-----------------------------------------

diary data_t3.txt
diary on

printf("Vs 1 3 0 sin(0 %f 50 0 0 90)\n", 230/n)
printf("Dtl 1 2 Default\n")
printf("Dtr 3 2 Default\n")
printf("Dbl 0 3 Default\n")
printf("Dbr 0 1 Default\n")
printf("R1 2 0 %d\n", Renv)
printf("C 2 0 %d\n",C)
printf("R2 2 5 %d\n",Rreg)
printf("Dr1 5 0 Default_n\n")
printf("Dr2 5 0 Default_n\n")
printf(".model Default D\n")
printf(".model Default_n D (n=%d)\n", n_diodes)

diary off






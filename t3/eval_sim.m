close all
clear all

datao = fopen('data_octave.txt','r');
DATAO = fscanf(datao,'%*s = %f');
fclose(datao);

Renv = DATAO(1);
C = DATAO(2);
Rreg = DATAO(3);
n = DATAO(4);
n_diodes = DATAO(5);

dataf = fopen('./sim/result_sim.txt','r');
DATA = fscanf(dataf,'%*s = %f');
fclose(dataf);


cost = Renv/1000 + C*1e6 + Rreg/1000 + n_diodes*2*0.1+4*0.1;
average = DATA(1);
ripple = DATA(4);
MERIT = 1/cost/(ripple+abs(average-12)+1e-6);


datar = fopen('./mat/result_octave.txt','r');
DATAR = fscanf(datar,'%*s = %f');
fclose(datar);


average_oct = DATAR(1);
ripple_oct = DATAR(4);
MERIT_oct = 1/cost/(ripple_oct+abs(average_oct-12)+1e-6);


diary merit.tex
diary on
printf('$R_{env}$ & %d & %d & kohm\n',Renv/1000,Renv/1000);
printf('$C_{env}$ & %d & %d & uF\n', C*1e6, C*1e6);
printf('$R_{reg}$ & %d & %d & kohm\n', Rreg/1000, Rreg/1000);
printf('$n_{transformer}$ & %.2f & %.2f & \n', n, n);
printf('$n_{diodes}$ & %d & %d & diodes\n', n_diodes, n_diodes);
printf('Cost & %d & %d & MU\n', cost, cost);
printf('Average & %.3f & %.3f & V\n', average, average_oct);
printf('Ripple & %.6f & %.6f & V\n', ripple, ripple_oct);
printf('MERIT & %.4f & %.4f & gold medals\n', MERIT, MERIT_oct);
diary off







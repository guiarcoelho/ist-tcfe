close all
clear all

pkg load symbolic;

format long;

%data_gen

datafile=fopen('data.txt','r');
data=fscanf(datafile, '%s = %f', [3 inf]);
data = data';
fclose(datafile);

simf=fopen('data_sim.txt','w');
fprintf(simf, 'R1 1 2 %fk\n', data(1,3));
fprintf(simf, 'R2 2 3 %fk\n', data(2,3));
fprintf(simf, 'R3 2 5 %fk\n', data(3,3));
fprintf(simf, 'R4 0 5 %fk\n', data(4,3));
fprintf(simf, 'R5 5 6 %fk\n', data(5,3));
fprintf(simf, 'R6 0 4 %fk\n', data(6,3));
fprintf(simf, 'R7 7 8 %fk\n', data(7,3));
fprintf(simf, 'Vs 1 0 DC %f\n', data(8,3));
fprintf(simf, 'Vf 4 7 DC 0\n');
fprintf(simf, 'C 6 8 %f\n' ,data(9,3));
fprintf(simf, 'Gb 6 3 2 5 %fm\n', data(10,3));
fprintf(simf, 'Hd 5 8 Vf %fk\n', data(11,3));

fclose(simf);


R1 = sym(sprintf('%.11f', data(1,3)*1000));
R2 = sym(sprintf('%.11f', data(2,3)*1000));
R3 = sym(sprintf('%.11f', data(3,3)*1000));
R4 = sym(sprintf('%.11f', data(4,3)*1000));
R5 = sym(sprintf('%.11f', data(5,3)*1000));
R6 = sym(sprintf('%.11f', data(6,3)*1000));
R7 = sym(sprintf('%.11f', data(7,3)*1000));
Vs = sym(sprintf('%.11f', data(8,3)));
Vf = sym('0');
C = sym(sprintf('%.11f', data(9,3)*10^-6));
Kb = sym(sprintf('%.11f', data(10,3)/1000));
Kd = sym(sprintf('%.11f', data(11,3)*1000));

%%NODAL THEO 1
syms V0 V1 V2 V3 V4 V5 V6 V7 V8

Eq_0 = V0 == 0;
Eq_f = V4 == V7;
Eq_d = V5-V8 == Kd*(V0-V4)/R6;
Eq_s = V1-V0 == Vs;
Eq_2 = (V2-V1)/R1 + (V2-V5)/R3 + (V2-V3)/R2 == 0;
Eq_3 = (V3-V2)/R2 - Kb*(V2-V5) == 0;
Eq_5 = (V5-V2)/R3 + (V5-V0)/R4 + (V5-V6)/R5 + (V8-V7)/R7 == 0;
Eq_6 = Kb*(V2-V5) + (V6-V5)/R5 == 0;
Eq_7 = (V4-V0)/R6 + (V7-V8)/R7 == 0;

sn = solve(Eq_0,Eq_f,Eq_d,Eq_s,Eq_2,Eq_3,Eq_5,Eq_6,Eq_7);

diary "nodal_tab.tex"
diary on

% Table

fid=fopen('../doc/data.tex', 'w');
fprintf(fid, "$R_1$ & %.11f \\\\ \\hline \n", data(1,3)*1000);
fprintf(fid, "$R_2$ & %.11f \\\\ \\hline \n", data(2,3)*1000);
fprintf(fid, "$R_3$ & %.11f \\\\ \\hline \n",data(3,3)*1000);
fprintf(fid, "$R_4$ & %.11f \\\\ \\hline \n", data(4,3)*1000);
fprintf(fid, "$R_5$ & %.11f \\\\ \\hline \n", data(5,3)*1000);
fprintf(fid, "$R_6$ & %.11f \\\\ \\hline \n", data(6,3)*1000);
fprintf(fid, "$R_7$ & %.11f \\\\ \\hline \n", data(7,3)*1000);
fprintf(fid, "$V_s$ & %.11f \\\\ \\hline \n", data(8,3));
fprintf(fid, "$C$ & %.11f \\\\ \\hline \n", data(9,3)*10^-6);
fprintf(fid, "$K_b$ & %.11f \\\\ \\hline \n", data(10,3)/1000);
fprintf(fid, "$K_d$ & %.11f \\\\ \\hline \n", data(11,3)*1000);
fclose(fid);

V0 = double(sn.V0);
V1 = double(sn.V1);
V2 = double(sn.V2);
V3 = double(sn.V3);
V4 = double(sn.V4);
V5 = double(sn.V5);
V6 = double(sn.V6);
V7 = double(sn.V7);
V8 = double(sn.V8);

printf('@c = 0\n');
Gb = -(V6 -V5)/double(R5);
printf('@Gb = %e\n', Gb);
I_r1 = -(V2 -V1)/double(R1)
I_r2 = -(V3 -V2)/double(R2)
I_r3 = -(V5 -V2)/double(R3)
I_r4 = -(V5 -V0)/double(R4)
I_r5 = -(V6 -V5)/double(R5)
I_r6 = -(V4 -V0)/double(R6)
I_r7 = -(V8 -V7)/double(R7)

printf('v(1) = %.11f\n', V1);
printf('v(2) = %.11f\n', V2);
printf('v(3) = %.11f\n', V3);
printf('v(4) = %.11f\n', V4);
printf('v(5) = %.11f\n', V5);
printf('v(6) = %.11f\n', V6);
printf('v(7) = %.11f\n', V7);
printf('v(8) = %.11f\n', V8);


Hd = double(Kd)*(V0-V4)/double(R6);

diary off


%PRINT FILE FOR NGSPICE ANALYSIS 2
simf=fopen('data_simeq.txt','w');
fprintf(simf, 'R1 1 2 %fk\n', data(1,3));
fprintf(simf, 'R2 2 3 %fk\n', data(2,3));
fprintf(simf, 'R3 2 5 %fk\n', data(3,3));
fprintf(simf, 'R4 0 5 %fk\n', data(4,3));
fprintf(simf, 'R5 5 6 %fk\n', data(5,3));
fprintf(simf, 'R6 0 4 %fk\n', data(6,3));
fprintf(simf, 'R7 7 8 %fk\n', data(7,3));
fprintf(simf, 'Vs 1 0 DC 0\n');
fprintf(simf, 'Vf 4 7 DC 0\n');
fprintf(simf, 'Gb 6 3 2 5 %fm\n', data(10,3));
fprintf(simf, 'Hd 5 8 Vf %fk\n', data(11,3));

fclose(simf);




%NODAL THEO 2
Vs = sym('0');
Vx = sym(sprintf('%.11f', double(V6-V8)));

syms V0eq V1eq V2eq V3eq V4eq V5eq V6eq V7eq V8eq Ix

Eq2_v0 = V0eq == 0;
Eq2_f = V4eq == V7eq;
Eq2_d = V5eq-V8eq == Kd*(V0eq-V4eq)/R6;
Eq2_s = V1eq-V0eq == Vs;
Eq2_2 = (V2eq-V1eq)/R1 + (V2eq-V5eq)/R3 + (V2eq-V3eq)/R2 == 0;
Eq2_3 = (V3eq-V2eq)/R2 - Kb*(V2eq-V5eq) == 0;
Eq2_0 = (V1eq-V2eq)/R1 + (V0eq-V4eq)/R6 + (V0eq-V5eq)/R4 == 0;
Eq2_6 = Kb*(V2eq-V5eq) + (V6eq-V5eq)/R5 + Ix == 0;
Eq2_7 = (V4eq-V0eq)/R6 + (V7eq-V8eq)/R7 == 0;
Eq2_x = Vx == V6eq-V8eq;

sn_eq = solve(Eq2_v0,Eq2_f,Eq2_d,Eq2_s,Eq2_2,Eq2_3,Eq2_0,Eq2_6,Eq2_7,Eq2_x);

diary "req_tab.tex"
diary on

V0eq = double(sn_eq.V0eq);
V1eq = double(sn_eq.V1eq);
V2eq = double(sn_eq.V2eq);
V3eq = double(sn_eq.V3eq);
V4eq = double(sn_eq.V4eq);
V5eq = double(sn_eq.V5eq);
V6eq = double(sn_eq.V6eq);
V7eq = double(sn_eq.V7eq);
V8eq = double(sn_eq.V8eq);

Gbeq = (V3eq -V2eq)/double(R2);
printf('@Gb = %.11f\n', Gbeq);
I_r1eq = (V2eq -V1eq)/double(R1)
I_r2eq = (V3eq -V2eq)/double(R2)
I_r3eq = (V5eq -V2eq)/double(R3)
I_r4eq = (V5eq -V0eq)/double(R4)
I_r5eq = -(V6eq -V5eq)/double(R5)
I_r6eq = (V4eq -V0eq)/double(R6)
I_r7eq = (V8eq -V7eq)/double(R7)

printf('v(1) = %.11f\n', V1eq);
printf('v(2) = %.11f\n', V2eq);
printf('v(3) = %.11f\n', V3eq);
printf('v(4) = %.11f\n', V4eq);
printf('v(5) = %.11f\n', V5eq);
printf('v(6) = %.11f\n', V6eq);
printf('v(7) = %.11f\n', V7eq);
printf('v(8) = %.11f\n', V8eq);

printf('Ix = %.11f\n',double(sn_eq.Ix));
printf('Vx = %.11f\n',double(Vx));

Req = double(Vx)/double(sn_eq.Ix);
printf('$R_{eq}$ = %e\n', Req)
tau = Req*double(C);
printf('$tau$ = %e', tau)
diary off


%NATUAL SOLUTION ANALYSIS

syms t
syms R
syms C
syms vc_n(t) %natural solution
syms i_n(t)

sim3f=fopen('data_sim3.txt','w');
fprintf(sim3f, 'R1 1 2 %fk\n', data(1,3));
fprintf(sim3f, 'R2 2 3 %fk\n', data(2,3));
fprintf(sim3f, 'R3 2 5 %fk\n', data(3,3));
fprintf(sim3f, 'R4 0 5 %fk\n', data(4,3));
fprintf(sim3f, 'R5 5 6 %fk\n', data(5,3));
fprintf(sim3f, 'R6 0 4 %fk\n', data(6,3));
fprintf(sim3f, 'R7 7 8 %fk\n', data(7,3));
fprintf(sim3f, 'Vs 1 0 DC %f\n', 0);
fprintf(sim3f, 'Vf 4 7 DC 0\n');
fprintf(sim3f, 'C 6 8 %fu\n', data(9,3));
fprintf(sim3f, 'Gb 6 3 2 5 %fm\n', data(10,3));
fprintf(sim3f, 'Hd 5 8 Vf %fk\n', data(11,3));

fclose(sim3f);
C = sym(sprintf('%.11f', data(9,3)));
R = sym(sprintf('%.11f', abs(Req)));

syms A
syms wn
vc_n(t) == A*exp(wn*t)

wn = -1/abs(tau)
A = double(Vx)

printf("\n\nNatural solution:\n");

t=0:1e-6:20e-3;
v6_n = A*exp(wn*t);

hf=figure(1)

plot(t*1000, v6_n, "g")

xlabel ("t[ms]");
ylabel ("Potencial in node 6 in Volts");
legend('v6_n(t)', 'Location', 'Northeast');
print (hf, "natural_tab.eps", "-depsc");


%NODAL THEO 4 forced solution
f=1000
w=sym(sprintf('2*pi*%.11f', f))
C = sym(sprintf('%.11f', data(9,3)*10^-6))
Vsp = sym (0-j)
Z = sym (0-1/(w*C)*j)

syms V0p V1p V2p V3p V4p V5p V6p V7p V8p Vxp

Eq3_v0 = V0p == 0;
Eq3_f = V4p == V7p;
Eq3_d = V5p-V8p == Kd*(V0p-V4p)/R6;
Eq3_s = V1p-V0p == Vsp;
Eq3_2 = (V2p-V1p)/R1 + (V2p-V5p)/R3 + (V2p-V3p)/R2 == 0;
Eq3_3 = (V3p-V2p)/R2 - Kb*(V2p-V5p) == 0;
Eq3_0 = (V1p-V2p)/R1 + (V0p-V4p)/R6 + (V0p-V5p)/R4 == 0;
Eq3_6 = Kb*(V2p-V5p) + (V6p-V5p)/R5 + (V6p-V8p)/Z == 0;
Eq3_7 = (V4p-V0p)/R6 + (V7p-V8p)/R7 == 0;
Eq3_x = Vxp == V6p-V8p;

sn_p = solve(Eq3_v0,Eq3_f,Eq3_d,Eq3_s,Eq3_2,Eq3_3,Eq3_0,Eq3_6,Eq3_7,Eq3_x);

diary "phasor_tab.tex"
diary on

V0p = double(abs(sn_p.V0p))
V1p = double(abs(sn_p.V1p))
V2p = double(abs(sn_p.V2p))
V3p = double(abs(sn_p.V3p))
V4p = double(abs(sn_p.V4p))
V5p = double(abs(sn_p.V5p))
V6p = double(abs(sn_p.V6p))
V7p = double(abs(sn_p.V7p))
V8p = double(abs(sn_p.V8p))

diary off

sim4f=fopen('data_sim4.txt','w');
fprintf(sim4f, 'R1 1 2 %fk\n', data(1,3));
fprintf(sim4f, 'R2 2 3 %fk\n', data(2,3));
fprintf(sim4f, 'R3 2 5 %fk\n', data(3,3));
fprintf(sim4f, 'R4 0 5 %fk\n', data(4,3));
fprintf(sim4f, 'R5 5 6 %fk\n', data(5,3));
fprintf(sim4f, 'R6 0 4 %fk\n', data(6,3));
fprintf(sim4f, 'R7 7 8 %fk\n', data(7,3));
fprintf(sim4f, 'Vs 1 0 sin(0 1 1k)\n');
fprintf(sim4f, 'Vf 4 7 DC 0\n');
fprintf(sim4f, 'C 6 8 %fu\n', data(9,3));
fprintf(sim4f, 'Gb 6 3 2 5 %fm\n', data(10,3));
fprintf(sim4f, 'Hd 5 8 Vf %fk\n', data(11,3));

fclose(sim4f);

M_V6p = double(abs(sn_p.V6p))
A_V6p = double(angle(sn_p.V6p))
M_V8p = double(abs(sn_p.V8p))
A_V8p = double(angle(sn_p.V8p))

t=0:1e-6:20e-3;
v6_f = M_V6p*cos(double(w)*t+A_V6p);
v8_f = M_V8p*cos(double(w)*t+A_V8p);
vs_p = sin(double(w)*t);

hf = figure (2);
title('graph of forced from 0 to 20 ms')
plot (t*1000, v6_f, ";v6_f(t);");

xlabel ("t [ms]");
ylabel ("v [V]");
legend('Location','northeast');
print (hf, "vs_v6_f_tab.eps", "-depsc");


%NODAL THEO 4 total solution


v6_t = v6_n + v6_f;
v8_t = v8_f;
ti=-5e-3:1e-6:0;
tt=cat(2,ti,t);

v6i=V6*ones(1,size(ti,2));
v6t_t=cat(2,v6i,v6_t);

v8i=V8*ones(1,size(ti,2));
v8t_t=cat(2,v8i,v8_t);

vsi=data(8,3)*ones(1,size(ti,2));
vst=cat(2,vsi,vs_p);

hft = figure (3);
title('point 5 - graph from -5 to 20 ms')
plot (tt*1000, vst,";vs(t);", tt*1000, v6t_t, ";v6(t);");
xlabel ("t [ms]");
ylabel ("v [V]");
legend('Location','northeast');
print (hft, "theo5_tab.eps", "-depsc");


hfc = figure (4);
title('capacitor voltage from -5 to 20 ms')
plot (tt*1000, v6t_t-v8t_t, ";vc(t);");
xlabel ("t [ms]");
ylabel ("v [V]");
legend('Location','northeast');
print (hfc, "capacitor_voltage_tab.eps", "-depsc");

%FREQUENCY RESPONSE

sim5f=fopen('data_sim5.txt','w');
fprintf(sim5f, 'R1 1 2 %fk\n', data(1,3));
fprintf(sim5f, 'R2 2 3 %fk\n', data(2,3));
fprintf(sim5f, 'R3 2 5 %fk\n', data(3,3));
fprintf(sim5f, 'R4 0 5 %fk\n', data(4,3));
fprintf(sim5f, 'R5 5 6 %fk\n', data(5,3));
fprintf(sim5f, 'R6 0 4 %fk\n', data(6,3));
fprintf(sim5f, 'R7 7 8 %fk\n', data(7,3));
fprintf(sim5f, 'Vs 1 0 0 ac 1 -90\n');
fprintf(sim5f, 'Vf 4 7 DC 0\n');
fprintf(sim5f, 'C 6 8 %fu\n', data(9,3));
fprintf(sim5f, 'Gb 6 3 2 5 %fm\n', data(10,3));
fprintf(sim5f, 'Hd 5 8 Vf %fk\n', data(11,3));

fclose(sim5f);

syms f

Z = sym (0-1/(2*sym(pi)*f*C)*j)

syms V0p V1p V2p V3p V4p V5p V6p V7p V8p Vxp

Eq3_v0 = V0p == 0;
Eq3_f = V4p == V7p;
Eq3_d = V5p-V8p == Kd*(V0p-V4p)/R6;
Eq3_s = V1p-V0p == Vsp;
Eq3_2 = (V2p-V1p)/R1 + (V2p-V5p)/R3 + (V2p-V3p)/R2 == 0;
Eq3_3 = (V3p-V2p)/R2 - Kb*(V2p-V5p) == 0;
Eq3_0 = (V1p-V2p)/R1 + (V0p-V4p)/R6 + (V0p-V5p)/R4 == 0;
Eq3_6 = Kb*(V2p-V5p) + (V6p-V5p)/R5 + (V6p-V8p)/Z == 0;
Eq3_7 = (V4p-V0p)/R6 + (V7p-V8p)/R7 == 0;
Eq3_x = Vxp == V6p-V8p;

sn_p = solve(Eq3_v0,Eq3_f,Eq3_d,Eq3_s,Eq3_2,Eq3_3,Eq3_0,Eq3_6,Eq3_7,Eq3_x);

printf("\n\nfrequency response\n");
sn_p.Vxp
sn_p.V8p
Vsp

freq=logspace(-1,6,200)

fhx = function_handle(sn_p.Vxp);
ax = fhx(freq);

fh6 = function_handle(sn_p.V6p);
a6 = fh6(freq);

fhs = function_handle(Vsp);
as = fhs(freq);

aux1= double(abs(Vsp));
aux2= double(angle(Vsp))*180/pi;
vsf = aux1*ones(1,size(freq,2));
vsfa = aux2*ones(1,size(freq,2));

hfr = figure(5);
semilogx(freq, 20*log10(abs(ax)),";vc(f);", freq, 20*log10(abs(a6)),";v6(f);");
xlabel("frequency in Hz (logarithmic scale)")
ylabel("copmlex amplitude (dB)")
hold on
semilogx(freq, 20*log10(vsf),";vs(f);")
hold off

print (hfr, "freq_resp_tab.eps", "-depsc");


hfa = figure (6);
semilogx(freq,180/pi*angle(a6), "r",freq,vsfa,"g",freq,180/pi*angle(ax), "b");
xlabel ("f [Hz]");
ylabel ("phase [degrees]");
legend('phase.v6(f)','phase.vs(f)','phase.vc(f)','Location','northwest');
print (hfa, "angle_tab.eps", "-depsc");

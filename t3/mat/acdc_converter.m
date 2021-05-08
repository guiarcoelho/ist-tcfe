close all
clear all

pkg load symbolic;

%graphics_toolkit("gnuplot")

format long;

%option = 1 %half wave rectifier
option = 2 %full wave rectifier


%reads data file ----------------------------------
dataf = fopen('../data_octave.txt','r');
DATA = fscanf(dataf,'%*s = %f');
fclose(dataf);

%variables -----------------------------------------
Renv = DATA(1)
C = DATA(2)
f=50;
vini = 230;
Rreg = DATA(3)

%transformer -----------------------------------------
n = DATA(4)
A = vini/n;

%envelope detector -----------------------------------------

t=linspace(0, 10/f, 50000);
w=2*pi*f;
vSenv = A * cos(w*t);
vOhr = zeros(1, length(t));
vOenv = zeros(1, length(t));

tOFF = 1/w * atan(1/w/Renv/C);

vOnexp = A*cos(w*tOFF)*exp(-(t-tOFF)/Renv/C);


if option == 1
	for i=1:length(t)
	  if (vSenv(i) > 0)
	    vOhr(i) = vSenv(i);
	  else
	    vOhr(i) = 0;
	  endif
	endfor
endif

if option == 2
	for i=1:length(t)
	  vOhr(i) = abs(vSenv(i));
	endfor
endif

for i=1:length(t)
  if t(i) < tOFF
    vOenv(i) = vOhr(i);
  elseif vOnexp(i) > vOhr(i)
    vOenv(i) = vOnexp(i);
  else
    tOFF = tOFF + 1/f/option;
    vOnexp = A*abs(cos(w*tOFF))*exp(-(t-tOFF)/Renv/C);
    vOenv(i) = vOhr(i);
  endif
endfor

average_env = mean(vOenv)
ripple_env = max(vOenv) - min(vOenv)

%average_env = min(vOenv)+ripple_env/2


%voltage regulator -----------------------------------------
n_diodes = DATA(5)
von = 12/n_diodes;

vOreg = zeros(1, length(t));
vOreg_dc = 0;
vOreg_ac = zeros(1, length(t));

%dc component regulator ----------------
if average_env >= von*n_diodes
  vOreg_dc = von*n_diodes;
else
  vOreg_dc = average_env;
endif

%ac component regulator -----------------
vt = 0.026;
Is = 1e-14;
new = 1;

rd = new*vt/(Is*exp(von/(new*vt)))

%if average_env >= von*n_diodes
%  vOreg_ac = n_diodes*rd/(n_diodes*rd+Rreg) * (vOenv-average_env);
%else
%  vOreg_ac = vOenv-average_env;
%endif 



% ac regulator
for i = 1:length(t)
  if vOenv(i) >= n_diodes*von
    vOreg_ac(i) = n_diodes*rd/2/(n_diodes*rd/2+Rreg) * (vOenv(i)-average_env);
  else
    vOreg_ac(i) = vOenv(i)-average_env;
  endif
endfor

vOreg = vOreg_dc + vOreg_ac;


%plots ----------------------------------------------

%output voltages at rectifier, envelope detector and regulator
hfa = figure(1);
title('Regulator and envelope output voltage v_o(t)')
plot (t*1000, vSenv, ";vs_{transformer}(t);", t*1000,vOenv, ";vo_{envelope}(t);", t*1000,vOreg, ";vo_{regulator}(t);");
xlabel ("t[ms]")
ylabel ("v_O [Volts]")
legend('Location','northeast');
print (hfa, "all_vout.eps", "-depsc");

%Deviations (vO - 12) 
hfb = figure(2);
title('Deviations from desired DC voltage')
plot (t*1000,vOreg-12, ";vo-12 (t);");
xlabel ("t[ms]")
ylabel ("v_O [Volts]")
legend('Location','northeast');
print (hfb, "deviation.eps", "-depsc");

%output ENVELOPE DETECTOR
hfc = figure(3);
title('Envelope detector output')
plot (t*1000,vOenv, ";vo_{envelope}(t);");
xlabel ("t[ms]")
ylabel ("v_O [Volts]")
legend('Location','northeast');
print (hfc, "envelope.eps", "-depsc");

%output REGULATOR
hfd = figure(4);
title('Regulator output')
plot (t*1000,vOreg-12, ";vo_{regulator}(t);");


yticks=get(gca, "ytick");
ylabels=arrayfun(@(x) sprintf ("%.8f", x+12),yticks,"uniformoutput", false);
set(gca, "yticklabel", ylabels) 

xlabel ("t[ms]")
ylabel ("v_O [Volts]")
legend('Location','northeast');
print (hfd, "regulator.eps", "-depsc");


diary result_octave.txt
diary on
average_reg = mean(vOreg)
max(vOreg)
min(vOreg)
ripple_reg = max(vOreg)-min(vOreg) 
diary off

cost = Renv/1000 + Rreg/1000 + C*1e6 + n_diodes*0.1*2; %o 0.1 e do diodo do envelope detector 

if option == 1
  cost = cost + 0.1
elseif option == 2
  cost = cost + 0.4
endif

MERIT = 1/(cost*(ripple_reg + abs(average_reg - 12) + 1e-6))


clear all
close all

%see notes on Ngspice explaining the configuration (and the values). No rules broken

R1 = 1000;
R2 = 1000;
R3 = 100000;
R4 = 1000;
C1 = 220e-9;
C2 = 110e-9;

f = logspace(1,8,70);
T = (R1*C1*2*pi*f*j)./(1+R1*C1*2*pi*f*j).*(1+R3/R4).*(1./(1+R2*C2*2*pi*f*j));
fig1 = figure();
semilogx(f,180*arg(T)/pi);
xlabel("Frequency [Hz]");
ylabel("Phase [Deg]");
title("Phase Frequency Response");
print(fig1, "theo_phase_f_response.eps", "-depsc");


fig2 = figure();
semilogx(f,20*log10(abs(T)));
xlabel("Frequency [Hz]");
ylabel("Gain [dB]");
title("Gain Frequency Response");
print(fig2, "theo_gain_f_response.eps", "-depsc");

wL = 1/(R1*C1);
wH = 1/(R2*C2);
wO = sqrt(wL*wH);

fich= fopen("freq_theo_del.tex","w");
string=strcat("$f_L$","\t&\t",num2str(wL/(2*pi),'%.6f'),'\\','\\','\\',"hline\n");
fprintf(fich,string);
string=strcat("$f_H$","\t&\t",num2str(wH/(2*pi),'%.6f'),'\\','\\','\\',"hline\n");
fprintf(fich,string);
string=strcat("$f_O$","\t&\t",num2str(wO/(2*pi),'%.6f'),'\\','\\','\\',"hline\n");
fprintf(fich,string);
fclose(fich);

AV_HP = (R1*C1*j*1000*2*pi)/(1+R1*C1*j*1000*2*pi);
AV_HP = 20*log10(abs(AV_HP));
AV_Amp = (1+R3/R4);
AV_Amp = 20*log10(abs(AV_Amp));
AV_LP = 1/(1+R2*C2*j*1000*2*pi);
AV_LP = 20*log10(abs(AV_LP));
AV= AV_HP + AV_Amp + AV_LP;

fich= fopen("gain_theo_del.tex","w");
string=strcat("$AV_{HP}$","\t&\t",num2str(AV_HP,'%.6f'),'\\','\\','\\',"hline\n");
fprintf(fich,string);
string=strcat("$AV_{Amp}$","\t&\t",num2str(AV_Amp,'%.6f'),'\\','\\','\\',"hline\n");
fprintf(fich,string);
string=strcat("$AV_{LP}$","\t&\t",num2str(AV_LP,'%.6f'),'\\','\\','\\',"hline\n");
fprintf(fich,string);
string=strcat("$AV$","\t&\t",num2str(AV,'%.6f'),'\\','\\','\\',"hline\n");
fprintf(fich,string);
fclose(fich);

z_in = R1 + 1/(j*1000*2*pi*C1);
z_out = R2/(j*1000*2*pi*C2)/(R2+1/(j*1000*2*pi*C2));

fich= fopen("imp_theo_del.tex","w");
string=strcat("$Z_{in}$","\t&\t",num2str(z_in,'%.6f'),'\\','\\','\\',"hline\n");
fprintf(fich,string);
string=strcat("$Z_{out}$","\t&\t",num2str(z_out,'%.6f'),'\\','\\','\\',"hline\n");
fprintf(fich,string);
fclose(fich);


clear all

%gain stage

VT=25e-3
BFN=178.7
VAFN=69.7
RE1_valor=200
RC1=3800
RB1=33700
RB2=3600
VBEON=0.7
VCC=12
RS=100
Ci=800e-6
Ce=800e-6
Co=600e-6
RL=8

RE1=RE1_valor
RB=1/(1/RB1+1/RB2)
VEQ=RB2/(RB1+RB2)*VCC
IB1=(VEQ-VBEON)/(RB+(1+BFN)*RE1)
IC1=BFN*IB1
IE1=(1+BFN)*IB1
VE1=RE1*IE1
VO1=VCC-RC1*IC1
VCE=VO1-VE1


gm1=IC1/VT
rpi1=BFN/gm1
ro1=VAFN/IC1

RSB=RB*RS/(RB+RS)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% VERIFICAR QUAL A MELHOR APROXIMACAO, RE1=0 OU RE1=RE1_VALOR
% O VALOR CERTO DEVE FICAR NO MEIO DOS DOIS, ENTRE OC E SC!!!

AV1 = RSB/RS * RC1*(RE1-gm1*rpi1*ro1)/((ro1+RC1+RE1)*(RSB+rpi1+RE1)+gm1*RE1*ro1*rpi1 - RE1^2)
AV1_aux = AV1;
AVI_DB = 20*log10(abs(AV1))
AV1simple = RB/(RB+RS) * gm1*RC1/(1+gm1*RE1)
AVIsimple_DB = 20*log10(abs(AV1simple))


RE1=0
AV1 = RSB/RS * RC1*(RE1-gm1*rpi1*ro1)/((ro1+RC1+RE1)*(RSB+rpi1+RE1)+gm1*RE1*ro1*rpi1 - RE1^2)
AVI_DB = 20*log10(abs(AV1))
AV1simple =  - RSB/RS * gm1*RC1/(1+gm1*RE1)
AVIsimple_DB = 20*log10(abs(AV1simple))
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

RE1=RE1_valor
ZI1 = 1/(1/RB+1/(((ro1+RC1+RE1)*(rpi1+RE1)+gm1*RE1*ro1*rpi1 - RE1^2)/(ro1+RC1+RE1)))
ZX = ro1*((RSB+rpi1)*RE1/(RSB+rpi1+RE1))/(1/(1/ro1+1/(rpi1+RSB)+1/RE1+gm1*rpi1/(rpi1+RSB)))
ZX = ro1*(   1/RE1+1/(rpi1+RSB)+1/ro1+gm1*rpi1/(rpi1+RSB)  )/(   1/RE1+1/(rpi1+RSB) ) 
ZO1_aux = 1/(1/ZX+1/RC1)
RE1=0
ZI1 = 1/(1/RB+1/(((ro1+RC1+RE1)*(rpi1+RE1)+gm1*RE1*ro1*rpi1 - RE1^2)/(ro1+RC1+RE1)))
ZO1 = 1/(1/ro1+1/RC1)

%ouput stage
BFP = 227.3
VAFP = 37.2
RE2 = 400
VEBON = 0.7
VI2 = VO1
IE2 = (VCC-VEBON-VI2)/RE2
IC2 = BFP/(BFP+1)*IE2
VO2 = VCC - RE2*IE2

gm2 = IC2/VT
go2 = IC2/VAFP
gpi2 = gm2/BFP
ge2 = 1/RE2

AV2 = gm2/(gm2+gpi2+go2+ge2)
ZI2 = (gm2+gpi2+go2+ge2)/gpi2/(gpi2+go2+ge2)
ZO2 = 1/(gm2+gpi2+go2+ge2)


%total
gB = 1/(1/gpi2+ZO1)
AV = (gB+gm2/gpi2*gB)/(gB+ge2+go2+gm2/gpi2*gB)*AV1
AV_aux = AV*AV1_aux/AV1;
AV_DB = 20*log10(abs(AV))
AV_DB_aux = 20*log10(abs(AV_aux))
ZI=ZI1
ZO=1/(go2+gm2/gpi2*gB+ge2+gB)

fich= fopen("theo_imp_del.tex","w");
string=strcat("$Z_{I1}$","\t&\t",num2str(ZI1,'%.6f'),'\\','\\','\\',"hline\n");
fprintf(fich,string);
string=strcat("$Z_{O1}$","\t&\t",num2str(ZO1,'%.6f'),'\\','\\','\\',"hline\n");
fprintf(fich,string);
string=strcat("$Z_{I2}$","\t&\t",num2str(ZI2,'%.6f'),'\\','\\','\\',"hline\n");
fprintf(fich,string);
string=strcat("$Z_{O2}$","\t&\t",num2str(ZO2,'%.6f'),'\\','\\','\\',"hline\n");
fprintf(fich,string);
string=strcat("$Z_{OT}$","\t&\t",num2str(ZO,'%.6f'),'\\','\\','\\',"hline\n");
fprintf(fich,string);
fclose(fich);

fich = fopen("theo_gain_high_del.tex","w");
string=strcat("$G_1$","\t&\t",num2str(AV1,'%.6f'),'\\','\\','\\',"hline\n");
fprintf(fich,string);
string=strcat("$G_2$","\t&\t",num2str(AV2,'%.6f'),'\\','\\','\\',"hline\n");
fprintf(fich,string);
string=strcat("$G_T$","\t&\t",num2str(AV,'%.6f'),'\\','\\','\\',"hline\n");
fprintf(fich,string);
string=strcat("$G_{T_{dB}}$","\t&\t",num2str(AV_DB,'%.6f'),'\\','\\','\\',"hline\n");
fprintf(fich,string);
fclose(fich);

fich = fopen("theo_gain_low_del.tex","w");
string=strcat("$G_1$","\t&\t",num2str(AV1_aux,'%.6f'),'\\','\\','\\',"hline\n");
fprintf(fich,string);
string=strcat("$G_2$","\t&\t",num2str(AV2,'%.6f'),'\\','\\','\\',"hline\n");
fprintf(fich,string);
string=strcat("$G_T$","\t&\t",num2str(AV_aux,'%.6f'),'\\','\\','\\',"hline\n");
fprintf(fich,string);
string=strcat("$G_{T_{dB}}$","\t&\t",num2str(AV_DB_aux,'%.6f'),'\\','\\','\\',"hline\n");
fprintf(fich,string);
fclose(fich);

%lower CO-freq

RE1=RE1_valor;


Aux =(rpi1+RSB)/(rpi1*gm1);
Aux = Aux*RE1/(Aux+RE1);

%RE1//aux

w_L= 1/(Ce*Aux)+ 1/((ZO+RL)*Co) +1/((ZI+RS)*Ci);
f_L=w_L/(2*pi);


fich = fopen("theo_CO_freq_band_del.tex","w");
string=strcat("Lower CO freq","\t&\t",num2str(f_L,'%.6f'),'\\','\\','\\',"hline\n");
fprintf(fich,string);
fclose(fich);

fig1=figure;
b = (10^(AV_DB/20))/f_L;
x = logspace(1,6,50);

c = (10^(AV_DB_aux/20))/f_L;
d = (10^((AV_DB_aux+AV_DB)/40))/f_L;

gain_func_h = @(f) 20*log10(f*b).*(f<f_L & f>0)+AV_DB*(f>=f_L & f>0);
gain_func_l = @(f) 20*log10(f*c).*(f<f_L & f>0)+AV_DB_aux*(f>=f_L & f>0);
gain_func_m = @(f) 20*log10(f*d).*(f<f_L & f>0)+0.5*(AV_DB_aux+AV_DB)*(f>=f_L & f>0);

semilogx(x, gain_func_h(x), x , gain_func_l(x), x, gain_func_m(x), "--");

xlabel("Frequency [Hz]");
ylabel("Gain [dB]");
ylim([-10 50]);
title("Theoretical results");
legend({"Upper Gain Bound", "Lower Gain Bound", "Gain approximation"}, 'Location', 'southeast');
print (fig1, "theo_results.eps", "-depsc");




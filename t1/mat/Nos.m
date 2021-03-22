close all
clear all

%%EXAMPLE SYMBOLIC COMPUTATIONS

pkg load symbolic

format long;

syms R1
syms R2
syms R3
syms R4
syms R5
syms R6
syms R7

syms Kb
syms Kc

syms Va
syms Vb
syms Vc
syms Ib
syms Ic
syms Id

syms v1
syms v2
syms v3
syms v4
syms v5
syms v6
syms v7
syms v0

%%  Lei dos Nós


printf("\n\KCL Equasions for the knots not connected to tension sorces:\n");
Ic+(v7-v6)/R7 == 0
(v4-v5)/R5-Ib+Id == 0
Ib+(v2-v3)/R2 == 0
(v2-v3)/R2+Vb/R3+(v2-v1)/R1 == 0
printf("\n\Equasion for the knots (0) and (1) considering cosntant current in the tension sourse:\n");
(v1-v2)/R1+(v4-v0)/R4-Ic==0
printf("\n\Circuit Given Data and Direct Analysis\n");

v0 == 0

v1-v0 == Va
v4-v7 == Vc
v4-v2 == Vb
Ic = (v0-v6)/R6
Vc = Kc*Ic
Ib = Kb*Vb


%%  Atribuição de Valores
printf("\nLab Data for our Group:\n\n");

R1 = 1.00630884619e3
R2 = 2.04459046985e3 
R3 = 3.06334496076e3 
R4 = 4.14716400981e3 
R5 = 3.04909455334e3 
R6 = 2.00303133774e3 
R7 = 1.02434741967e3 

Va = 5.21115954318
Id = 1.01060327002e-3 

Kb = 7.13035015936e-3 
Kc = 8.36091910927e3

A = [ 0     , -(1/R1)         , (1/R1)+(1/R2)     , -1/R2     , 0         , 0     , 0 , 0  , 1/R3     , 0 , 0 , 0   ;...
      0     , 0         , 1/R2     , -1/R2     , 0      , 0 , 0     , 0     , 0     , 0 , 1, 0   ;...
      0     , 0      , 0 , 0     , 1/R5         , -1/R5     , 0     , 0     , 0     , 0 , -1 , 0   ;...
      0  , 0, 0  , 0     , 0         , 0     , -1/R7     , 1/R7     , 0 , 0 , 0 , 1   ;...
      -1/R6 , 0      , 0     , 0 , 0      , 0     , 1/R6     , 0     , 0     , 0 , 0 , 1  ;...
      -1     , 1         , 0     , 0     , 0         , 0     , 0     , 0     , 0     , 0 , 0 , 0   ;...
      0     , 0         , 0     , 0    , 1         , 0     , 0     , -1     , 0     , -1 , 0 , 0   ;...
      0     , 0         , 0     , 0     , 0         , 0     , 0     , 0    , 0     , 1, 0 , -Kc   ;...
      0     , 0         , 0     , 0     , 0        , 0     , 0     , 0     , -Kb    , 0 , 1 , 0   ;...
      0     , 0         , -1     , 0  , 1         , 0     , 0 , 0     , 1     , 0 , 0 , 0  ;...
      -1/R4     , -1/R1         , 1/R1     , 0     , 1/R4         , 0     , 0     , 0     , 0     , 0 , 0 , -1 ;...
      1     , 0         , 0     , 0     , 0         , 0     , 0     , 0     , 0   , 0 , 0 , 0   ];

B = [ 0; 0; -Id; 0; 0; Va; 0; 0; 0; 0; 0; 0];

x = inv(A)*B
v0=x(1)
v1=x(2)
v2=x(3)
v3=x(4)
v4=x(5)
v5=x(6)
v6=x(7)
v7=x(8)
Vb=x(9)
Vc=x(10)
Ib=x(11)
Ic=x(12)

%	Impressão da Tabela
printf("Nos_TAB \n")
printf("$v_{0}$ = %e \n", v0);
printf("$v_{1}$ = %e \n", v1);
printf("$v_{2}$ = %e \n", v2);
printf("$v_{3}$ = %e \n", v3);
printf("$v_{4}$ = %e \n", v4);
printf("$v_{5}$ = %e \n", v5);
printf("$v_{6}$ = %e \n", v6);
printf("$v_{7}$ = %e \n", v7);

printf("$V_{b}$ = %e \n", Vb);
printf("$V_{c}$ = %e \n", Vc);
printf("@$I_{b}$ = %e \n", Ib);
printf("@$I_{c}$ = %e \n", Ic);
printf("Nos_END \n")

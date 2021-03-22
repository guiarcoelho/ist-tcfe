close all
clear all

%%EXAMPLE SYMBOLIC COMPUTATIONS

pkg load symbolic

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
syms v8

%%  Lei dos Nós

printf("\n\nKNL equações:\n");

printf("\n\Knots equações:\n");
Ic+(v8-v7)/R7 == 0
(v5-v6)/R5-Ib+Id == 0
Ib+(v2-v3)/R2 == 0
(v3-v2)/R2-Vb/R3+(v1-v2)/R1 == 0
printf("\n\SuperKnots equações:\n");
(v7-v8)/R7-Id+(v4-v5)/R4+Vb/R3+(v6-v5)/R5 == 0
-Ic+(v5-v4)/R4+(v2-v1)/R1 == 0
printf("\n\Por observação do circuito\n");

v4 == 0

v1-v4 == Va
v5-v8 == Vc
v2-v5 == Vb
Ic = (v4-v7)/R6
Vc = Kc*Ic
Ib = Kb*Vb
printf("\n\Como uma das equações do SuperKnots não é necessária, retiramos a maior:\n\n");
(v7-v8)/R7-Id+(v4-v5)/R4+Vb/R3+(v6-v5)/R5 == 0

%%  Atribuição de Valores
printf("\nAtribuição dos valores para o laboratório:\n\n");

R1 = 1.03258022265e3
R2 = 2.05854281116e3 
R3 = 3.05658918951e3 
R4 = 4.12083818633e3 
R5 = 3.10223748153e3 
R6 = 2.09909352125e3 
R7 = 1.01569886691e3 

Va = 5.19832384287 
Id = 1.04739543259e-3 

Kb = 7.07448059081e-3 
Kc = 8.22345657857e3 

A = [ 0     , 0         , 0     , 0     , 0         , 0     , -1/R7 , 1/R7  , 0     , 0 , 0 , 1   ;...
      0     , 0         , 0     , 0     , 1/R5      , -1/R5 , 0     , 0     , 0     , 0 , -1, 0   ;...
      0     , 1/R2      , -1/R2 , 0     , 0         , 0     , 0     , 0     , 0     , 0 , 1 , 0   ;...
      1/R1  , -1/R2-1/R1, 1/R2  , 0     , 0         , 0     , 0     , 0     , -1/R3 , 0 , 0 , 0   ;...
      -1/R1 , 1/R1      , 0     , -1/R4 , 1/R4      , 0     , 0     , 0     , 0     , 0 , 0 , -1  ;...
      0     , 0         , 0     , 1     , 0         , 0     , 0     , 0     , 0     , 0 , 0 , 0   ;...
      1     , 0         , 0     , -1    , 0         , 0     , 0     , 0     , 0     , 0 , 0 , 0   ;...
      0     , 0         , 0     , 0     , 1         , 0     , 0     , -1    , 0     , -1, 0 , 0   ;...
      0     , 1         , 0     , 0     , -1        , 0     , 0     , 0     , -1    , 0 , 0 , 0   ;...
      0     , 0         , 0     , 1/R6  , 0         , 0     , -1/R6 , 0     , 0     , 0 , 0 , -1  ;...
      0     , 0         , 0     , 0     , 0         , 0     , 0     , 0     , 0     , 1 , 0 , -Kc ;...
      0     , 0         , 0     , 0     , 0         , 0     , 0     , 0     , -Kb   , 0 , 1 , 0   ];

B = [ 0; -Id; 0; 0; 0; 0; Va; 0; 0; 0; 0; 0];

x = A\B
v1=x(1)
v2=x(2)
v3=x(3)
v4=x(4)
v5=x(5)
v6=x(6)
v7=x(7)
v8=x(8)
Vb=x(9)
Vc=x(10)
Ib=x(11)
Ic=x(12)

%	Impressão da Tabela
printf("Nos_TAB \n")
printf("$v_{1}$ = %e \n", v1);
printf("$v_{2}$ = %e \n", v2);
printf("$v_{3}$ = %e \n", v3);
printf("$v_{4}$ = %e \n", v4);
printf("$v_{5}$ = %e \n", v5);
printf("$v_{6}$ = %e \n", v6);
printf("$v_{7}$ = %e \n", v7);
printf("$v_{8}$ = %e \n", v8);

printf("$V_{b}$ = %e \n", Vb);
printf("$V_{c}$ = %e \n", Vc);
printf("@$I_{b}$ = %e \n", Ib);
printf("@$I_{c}$ = %e \n", Ic);
printf("Nos_END \n")
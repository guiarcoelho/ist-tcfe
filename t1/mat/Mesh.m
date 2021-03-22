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

%%  Método das Malhas

syms Ialfa
syms Ibeta
syms Igama
syms Idelta

printf("\n\nKVL equation:\n");

-Va+Ialfa*R1+Vb+R4*(Ialfa-Idelta) == 0
Ibeta = -Ib
Igama = -Id
R6*Idelta+R4*(Idelta-Ialfa)+Vc+R7*Idelta == 0

printf("\n\Por observação do circuito\n");

Vc = Kc*Ic
Ib = Kb*Vb
Ic = -Idelta
Vb = R3*(Ialfa-Ibeta)

printf("\nAtribuição dos valores para o laboratório:\n\n");

%%EXAMPLE NUMERIC COMPUTATIONS

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

A = [ R1+R4 , 0 , 0, -R4      , 1   , 0, 0, 0   ;...
      0     , 1 , 0, 0        , 0   , 0, 1, 0   ;...
      0     , 0 , 1, 0        , 0   , 0, 0, 0   ;...
      -R4   , 0 , 0, R4+R6+R7 , 0   , 1, 0, 0   ;...
      0     , 0 , 0, 0        , 0   , 1, 0, -Kc ;...
      0     , 0 , 0, 0        , -Kb , 0, 1, 0   ;...
      0     , 0 , 0, 1        , 0   , 0, 0, 1   ;...
      -R3   , R3, 0, 0        , 1   , 0, 0, 0   ]

B = [ Va; 0; -Id; 0; 0; 0; 0; 0]

x = A\B;

Ialfa = x(1)
Ibeta = x(2)
Igama = x(3)
Idelta= x(4)
Vb    = x(5)
Vc    = x(6)
Ib    = x(7)
Ic    = x(8)

printf("Mesh_TAB \n")
printf("@$I_{\\alpha}$ = %e \n", Ialfa);
printf("@$I_{\\beta}$ = %e \n",  Ibeta);
printf("@$I_{\\gamma}$ = %e \n", Igama);
printf("@$I_{\\delta}$ = %e \n", Idelta);

printf("$V_{b}$ = %e \n", Vb);
printf("$V_{c}$ = %e \n", Vc);
printf("@$I_{b}$ = %e \n", Ib);
printf("@$I_{c}$ = %e \n", Ic);
printf("Mesh_END \n")

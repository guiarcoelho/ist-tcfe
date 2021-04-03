close all
clear all

%%EXAMPLE SYMBOLIC COMPUTATIONS

format long;
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

%%  Mesh Method

syms Itl 
syms Itr
syms Ibl
syms Ibr

printf("\n\nKVL Elementary Meshes Equations:\n");

Itl*R1+Vb+R4*(Itl-Ibl) == Va
Itr = -Ib
Ibr = -Id
R6*Ibl+R4*(Ibl-Itl)+Vc+R7*Ibl == 0

printf("\n\Circuit Given Data and Direct Analysis:\n");

Vc = Kc*Ic
Ib = Kb*Vb
Ibl = -Ic
Vb = R3*(Itl-Itr)

printf("\nLab Data for our Group:\n\n");

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

R = inv(A)*B;

Itl = R(1)
Itr = R(2)
Ibl = R(3)
Ibr = R(4)
Vb  = R(5)
Vc  = R(6)
Ib  = R(7)
Ic  = R(8)

printf("Malhas_TAB \n")
printf("@$I_{tl}$ = %e \n", Itl);
printf("@$I_{tr}$ = %e \n",  Itr);
printf("@$I_{bl}$ = %e \n", Ibl);
printf("@$I_{br}$ = %e \n", Ibr);

printf("$V_{b}$ = %e \n", Vb);
printf("$V_{c}$ = %e \n", Vc);
printf("@$I_{b}$ = %e \n", Ib);
printf("@$I_{c}$ = %e \n", Ic);
printf("Malhas_END \n")

tic

gamma = 0.5;
rho1 = 1.2;
rho2 = -0.4;
beta = 0.95;
%-----------------------------------
den = [beta -(1+rho1*beta) rho1-rho2*beta rho2];
num = [beta*(1+gamma*beta) -1 -gamma 0];
%-----------------------------------
bigshow(num,den)

toc
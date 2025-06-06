tic
%-----------------------------------
rho1 = 1.2;
rho2 = -0.3;
b = 30;
beta = 0.95;
gamma = 1;
%-----------------------------------
r = 1/beta-1;
A = [1 0 0 0;0 rho1 rho2 0;0 1 0 0;0 0 0 1];
B = [1;0;0;0];
R = [gamma^2 gamma 0 -gamma*b;gamma 1 0 -b;zeros(1,4);-gamma*b -b 0 b^2];
Q = 1+gamma;
H = [-gamma -1 0 b];
%-----------------------------------
[F,P] = olrp1(beta,A,B,R,Q,H)

toc
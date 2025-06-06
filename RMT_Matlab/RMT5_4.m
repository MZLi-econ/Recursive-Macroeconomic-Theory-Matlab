tic
%-----------------------------------
rho1 = 1.2;
rho2 = -0.3;
b = 30;
beta = 0.95;
gamma = 1;
lambda = 1;
theta = 1;
pi = 0.05;
delta = 0.95;

%-----------------------------------
r = 1/beta-1;
A = [1 0 0 0 0;0 rho1 rho2 0 0;0 1 0 0 0;
    theta*gamma theta 0 delta 0;0 0 0 0 1];
B = [1;0;0;-theta;0];
R = [gamma^2*pi^2 gamma*pi^2 0 pi*gamma*lambda -gamma*b*pi;pi^2*gamma pi^2 0 lambda*pi^2 -b*pi;
    zeros(1,5);pi*gamma*lambda lambda*pi^2 0 lambda^2 -b*lambda;-pi*gamma*b -b*pi 0 -b*lambda b^2];
Q = pi^2+gamma;
H = pi*[-pi*gamma -pi 0 -lambda b];
%-----------------------------------
[F,P] = olrp1(beta,A,B,R,Q,H)

toc
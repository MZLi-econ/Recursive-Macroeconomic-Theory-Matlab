% bewley 99.m

% revised from bewley.m in task4

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%				Aiyagari's model( with related Bewley models )
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear
global beta mu A delta alpha s N prob b fixw indi kk kap probst

tic

%diary bewley.out; 
disp('family of Bewley models');
disp('');
%
%  set parameter values
%
mu     = 3;               % risk aversion              
beta   = 0.96;            % subjective discount factor 
delta  = 0.08;            % depreciation
A      = 1;            % production technology
alpha  = 0.36;            % capital's share of income

% approximate labor endowment shocks with seven states Markov chain
% log(s_t) = rho*log(s_t-1)+sigmaint*sqrt(1-rho^2)*error_t

N        = 7;             % number of discretized states
rho      = 0.2;           % first-order autoregressive coefficient
sigmaint = 0.4;           % intermediate value to calculate sigma
sigma    = sigmaint*sqrt(1-rho^2); % standard deviation of error_t

% prob is transition matrix of the Markov chain
% logs is the discretized states of log labor earnings
% invdist is the invariant distribution of Markov chain
% alambda and asigma are respectively the theoretical 
% rho and standard deviation of log labor income in Markov chain

[prob,logs,invdist,alambda,asigma]=markovappr(rho,sigma,3,N);

s = exp(logs);
labor = s*invdist;

fixw = 0;          % if fixw=0, compute bewley model with production
indi = 0;          % if indi=1, draw asset choice and consumption graph 

figure
%subplot(2,1,1)
b =3;
minrate = -0.04;
maxrate = (1-beta)/beta;
rate = minrate:(maxrate-minrate)/19:maxrate;
for q = 1:length(rate)
   k1(q) = aiyagari2(rate(q));
end

plot(k1,rate,'b--')
title('Bewley model with production')
xlabel('supply of assets, -- b=3, - b=6')
ylabel('interest rate')

hold on
plot(k1,rate,'b*')
b=6;
for q = 1:length(rate)
   k2(q) = aiyagari2(rate(q));
end

plot(k2,rate,'r-')
plot(k2,rate,'ro')

i = 0:0.005:0.05;
capital = labor*(alpha*A./(i+delta)).^(1/(1-alpha));   
plot(capital,i)
line([0,0],[-0.04,0.05])
line([-5,10],[0 0])
axis([-inf inf -0.04 0.05])

hold off


figure
indi = 1;
fixw = 0;
y = aiyagari2(-0.02);

%diary off

toc
% bewley99v2.m

% revised from bewley99.m in task4, incorporate iid labor income shock

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
A      = 1.00;            % production technology
alpha  = 0.36;            % capital's share of income

% approximate labor endowment shocks with seven states Markov chain
% log(s_t) = rho*log(s_t-1)+sigmaint*sqrt(1-rho^2)*error_t

N        = 7;             % number of discretized states
%rho      = 0.2;           % first-order autoregressive coefficient
%sigmaint = 0.6;           % intermediate value to calculate sigma
%sigma    = sigmaint*sqrt(1-rho^2); % standard deviation of error_t

% prob is transition matrix of the Markov chain
% logs is the discretized states of log labor earnings
% invdist is the invariant distribution of Markov chain
% alambda and asigma are respectively the theoretical 
% rho and standard deviation of log labor income in Markov chain

%[prob,logs,invdist,alambda,asigma]=markovappr(rho,sigma,3,N);

% s1 and s2 are respectively the states for two discrete distribution,
% they share the same cdf, the same mean, var(s1)<var(s2). s1 is the 
% exp(logs) produced from markovappr given sigmaint =0.4; s2 is the
% exp(logs) produced from markoappr given sigmaint = 0.6, then subtract
% a constant from it to get the same mean as s1.


s1 = [0.3012,0.4493,0.6703,1.0000,1.4918,2.2255,3.3201];
s2 = [0.0410,0.1769,0.4245,0.8757,1.6978,3.1958,5.9253];
invdist = [0.0063,0.0608,0.2417,0.3823,0.2417,0.0608,0.0063]';
prob = meshgrid(invdist,ones(N,1));

labor1 = s1*invdist;
labor2 = s2*invdist;

if abs(labor1 - labor2) < 0.001
   labor = labor1;  % check for the closeness of two means
end

fixw = 0;
indi = 0;

figure

b = 0;

s = s1;
rate = -0.04:(1-beta)/(beta*19):(1-beta)/beta;
for q = 1:length(rate)
   k1(q) = aiyagari2(rate(q));
end

plot(k1,rate,'b--')
title('Bewley model with production')
xlabel('supply of assets, -- b=3, - b=6')
ylabel('interest rate')

hold on
plot(k1,rate,'b*')

s = s2;

for q = 1:length(rate)
   k2(q) = aiyagari2(rate(q));
end

plot(k2,rate,'r-')
plot(k2,rate,'ro')

i = 0.01:0.005:0.05;
capital = labor*(alpha*A./(i+delta)).^(1/(1-alpha));   
plot(capital,i)
line([0,0],[-0.04,0.05])

hold off




toc
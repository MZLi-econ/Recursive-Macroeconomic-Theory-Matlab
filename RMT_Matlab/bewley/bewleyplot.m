% bewleyplot.m plot the result of bewley99.m

% revised from bewley.m in task4

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%				Aiyagari's model( with related Bewley models )
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear

global beta mu delta A alpha s N prob b fixw indi probst kk kap

load bewleydata % result from bewley99.m with A = 1

disp('family of Bewley models');
disp('');
%
%  set parameter values
%
mu     = 3;               % risk aversion              
beta   = 0.96;            % subjective discount factor 
delta  = 0.08;            % depreciation
A      = 1;               % productivity
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


figure

% b is the maximum amount allowed to borrow

b =3;

% rate is a column vector of interest rates from -0.04 to 0.04
% k1 is the mean asset supply level computed from aiyagari2.m

plot(k1,rate,'b--')  
ylabel('interest rate')

hold on
plot(k1,rate,'b*')

b=6;

plot(k2,rate,'r-')  % k2 is the mean asset supply given b = 6
plot(k2,rate,'ro')


i = 0:0.005:0.05;
capital = labor*(alpha*A./(i+delta)).^(1/(1-alpha));   
plot(capital,i)
line([0,0],[-0.04,0.05])
line([-5,12],[0 0])
axis([-inf 12 -0.04 0.05])

% mark text at corrdinate (capital(6),i(6))

text(capital(6)+0.3,i(6),'L(\alphaA/(r+\delta))^{1/(1-\alpha)}')

hold off

% eyeball the equilibrium interest rate at 0.0399

fixw = 0;          % if fixw=0, compute bewley model with production
indi = 0;          % if indi=1, draw asset choice and consumption graph 

b = 3;

y = aiyagari2(0.0399);
figure
pp = reshape(probst,[length(probst)/7 7]);
pr = sum(pp,2)';
plot(kap,pr);

%diary off


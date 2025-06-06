% bewleyplot2.m

% revised from bewleyplot.m, now plot the case with iid labor income
% shocks

% bewleyplot.m plot the result of bewley99.m

% revised from bewley.m in task4

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%				Aiyagari's model( with related Bewley models )
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear

load bewley99v2 % result from bewley99.m with A = 1

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


N        = 7;             % number of discretized states

% s1 and s2 are respectively the states for two discrete distribution,
% they share the same cdf, the same mean, var(s1)<var(s2). s1 is the 
% exp(logs) produced from markovappr given sigmaint =0.4; s2 is the
% exp(logs) produced from markoappr given sigmaint = 0.6, then subtract
% a constant from it to get the same mean as s1.

s1 = [0.3012,0.4493,0.6703,1.0000,1.4918,2.2255,3.3201];
s2 = [0.0410,0.1769,0.4245,0.8757,1.6978,3.1958,5.9253];
invdist = [0.0063,0.0608,0.2417,0.3823,0.2417,0.0608,0.0063]';
prob = meshgrid(invdist,ones(N,1));

labor1 = s1*invdist;  %=1.0903
labor2 = s2*invdist;  %=1.0904 

sigs1 = ((s1-labor1).^2)*invdist; % =0.2233
sigs2 = ((s2-labor2).^2)*invdist; % =0.6884

if abs(labor1 - labor2) < 0.001
   labor = labor1;  % check for the closeness of two means
end

figure

% b is the maximum amount allowed to borrow

b =0;

s = s1; % lower variance, same mean as s2

% rate is a column vector of interest rates from -0.04 to 0.04
% k1 is the mean asset supply level computed from aiyagari2.m

plot(k1,rate,'b--') % k1 is the mean asset supply curve given s1
ylabel('interest rate')

hold on
plot(k1,rate,'b*')

s = s2; % higher variance

plot(k2,rate,'r-')  % k2 is the mean asset supply given process s2
plot(k2,rate,'ro')

%A = 0.6;

i = 0:0.005:0.05;
capital = labor*(alpha*A./(i+delta)).^(1/(1-alpha));   
plot(capital,i)
line([0,0],[-0.04,0.05])
line([0,10],[0 0])
axis([-inf 10 -0.04 0.05])

% mark text at corrdinate (capital(6)+0.3,i(2))

text(capital(6)+0.3,i(6),'L(\alphaA/(r+\delta))^{1/(1-\alpha)}')


hold off



%diary off


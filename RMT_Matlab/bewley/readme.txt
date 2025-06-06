% readme.txt

%----------------
Common parameters:
%----------------

mu     = 3;               % risk aversion              
beta   = 0.96;            % subjective discount factor 
delta  = 0.08;            % depreciation
A      = 1;               % productivity
alpha  = 0.36;            % capital's share of income

maxkap = 16;                     % maximum value of capital grid  
inckap = 0.2;                    % size of capital grid increments
kap    = minkap:inckap:maxkap;   % state of assets 
nkap   = length(kap);            % number of grid points

%-----------------------------------
Parameters for Markov endowment process
%-----------------------------------

% approximate labor endowment shocks with seven states Markov chain
% log(s_t) = rho*log(s_t-1)+sigmaint*sqrt(1-rho^2)*error_t

N        = 7;             % number of discretized states
rho      = 0.2;           % first-order autoregressive coefficient
sigmaint = 0.4;           % intermediate value to calculate sigma
sigma    = sigmaint*sqrt(1-rho^2); % standard deviation of error_t

%-----------------------------------
Parameters for iid endowment process
%-----------------------------------

labor = 1.0903;  % mean of labor
sigs1 = 0.2233;  % variance for s1
sigs2 = 0.6884;  % variance for s2
 

The directory has several files:

bewleyplot.m: produce two figures: 
              1. the figure of bewley model with production,
              2. invariate distribution of capital for b = 3 case.
              Markov chain labor income shocks;
              b = 3; b = 6.
bewleyplot2.m: produce the figure of bewley model with production,
               i i d labor income shocks for two mean preserving 
                     processes with the same mean
               b = 0.
Note: The above two files take data saved in two *.mat files as input
      without computations.

The two *.mat files are:

bewleydata.mat: the workspace saved after running bewley99.m(Markov chain 
                labor income shocks, b=3,b=6.
bewley99v2.mat: the workspace saved after running bewley99v2.m(iid labor
                income shocks for two processes, b = 0)

Three *.m files are used:

bewley99.m,bewley99v2.m: script file
aiyagari2.m: function file

Bewley*.m are slight revisions of bewley.m in task4. Readbewly.txt in
task4 has detailed comments. 

       



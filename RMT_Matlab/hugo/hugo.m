% designing optimal unemployment insurance 
% by Hopenhayn, Hugo and Nicolini, JPE 1996, vol 105

% Function file valhugo.m is called.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% calculate value function of employment and unemployment in
% autarky case
clear
diary hugo.out

global beta sigma r vmax vmin n ve
% set parameter values

beta = 0.999;              % discount rate
sigma = 0.5;               % relative risk aversion
w = 100;                   % wage after being employed  

ve = (w^(1-sigma))/((1-sigma)*(1-beta)); % utility of employed

vuaut = 1.676e+004;  % initialize value of unemployment
test =10;

% write a function file for first order condition
% of hugo's autarky case

fid = fopen ('hugofoc1.m', 'w');
fprintf(fid, 'function [f] = hugofoc1(x,vu);\n');
fprintf(fid, 'global beta ve;                  \n');
fprintf(fid, 'f = 0.9*beta*x*(ve-vu)-1;        \n' );
fclose (fid);                                    

% iterate to get vuaut
% we already know that P(a)=1-exp(-r*aaut)=0.1;
% so we can make use of this relation and express aaut
% as a function of r
% now first order condition is just a function of r

while abs(test) > 0.1e-03

r0=fsolve('hugofoc1',3e-004,[],[],vuaut); 

a0 = -log(0.9)/r0;
vu1 = 0-a0+beta*(0.1*ve+0.9*vuaut);

test = vu1-vuaut;
vuaut = vu1;

end
aaut = a0;           % effort exerted in autarky
r=r0;                % interest rate calibrated so that p(aaut)=0.1 
%----------------------------------------------------------------------------
% imperfect information case

% The value function is approximated by using orthogonal polynomials,
% more precisely, by using Chebyshev polynomials.
                                                      
% control variable is next period promised value vu if unemployed
% effort a and consumption will be written as a function of vu

% Set parameter values

%-----------------------------------------------------------------------------
% WEALTH
%-----------------------------------------------------------------------------
vmax = ve-1/(beta*r); 

% upper bound on continuation values(state variable)
% Note that vmax~=ve to guarantee convergence of coefficients

vmin= vuaut;		% Lower bound on state space
	             	% these bounds are not binding, approximations
                  % using polynomials are actually global    

%-----------------------------------------------------------------------------

n=5;		% order of approx (i=0,1,...5)
m=15;		% number of Chebyshev zeros (Note: you need m=>n)



% find the Chebyshev zeros and polynomials for continuous approx.  
% Chebyshev zeroes (ZR from [-1,1}) and adjusted zeroes (ZK from
% [vmin,vmax]) 

ZK=zeros(1,m); 
ZR=zeros(1,m);

% The polynomials T
	   
   i=[1:1:m]';
   
	ZR = -cos(pi*(i-0.5)./m);
	ZK = (ZR + 1).*(vmax-vmin)/2 + vmin;
	

% construct the Chebyshev polynomials; columns are zeros and rows are polys.
% T is (n+1)by m matrix

	for k=1:m
		T(1,k)=1;
		T(2,k)=ZR(k);
			
		for s=3:n+1
			T(s,k)=2*ZR(k)*T(s-1,k)-T(s-2,k);
		end;
	end;
 
 
% Set initial Chebyshev coefficients 

coeff = ones(n+1,1);
flag=1;
iter=1;

%--------------------------------------------------------------------------
% Main Loop
%--------------------------------------------------------------------------

	while (flag >10^(-5)) 

% vuprime is the policy function. Given an approximation for the value
% function,
% (i.e the coefficients and the chebyshev zeros), find vuprime ( next
% period's continuation value that maximizes the value function.)
% for each leve of today's promised value ( the Chebyshev zeros) 

% vuaut<vuprime<ve-1/(beta*r); lower bound is incentive constraint
% Upper bound guarantees a>=0, where a is effort

for t=1:m
vuprime(t,1)=fmin('valhugo',vuaut,ve-1/(beta*r),[],ZK(t),coeff);
Cv(t,1)=feval('valhugo',vuprime(t,1),ZK(t),coeff);

end;

% Find the new set of Coefficients. Note that this is least squares.

coeff1 = inv(T*T')*T*Cv;

% Check for convergence

	flag = max(abs(coeff1-coeff));
   
   iter=iter+1;
   
	coeff = coeff1;
   
end

%______________________________________________________________________________

% now calculate replacement ratio for three initial promised values vini

vini = [16900 16942 17000];

for i=1:3             % i: ith initial promise value
for t=1:25            % t: tth period

vuprime(i)=fmin('valhugo',vmin,ve-1/(beta*r),[],vini(i),coeff);

%Cv(t,1)=feval('valhugo',vuprime(t,1),ZK(t),coeff);
cinv = max(0,(vini(i)+log(beta*r*(ve-vuprime(i)))/r...
   -beta*(ve-1/(beta*r))));

cons(i,t)=((1-sigma)* cinv)^(1/(1-sigma));
rep(i,t)=cons(i,t)/w;

vini(i) = vuprime(i);                                               

end;
end;

disp('PARAMETER VALUES');
disp('');
disp('    sigma      beta        w       r'); 
disp([ sigma beta w r]);
disp(''); 
disp('the fixed point of coefficients')
disp([coeff]);
disp('    ve         vuaut');
disp('')
disp('')
disp([ ve vuaut] );

disp('replacement ratio for different initial values')
disp('    period   v=16900   v=16942   v=17000')
disp('----------------------------------------------')
period = [1:1:25];
disp([period',rep']);
                         
diary off




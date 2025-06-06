%	Jovanovic's matching model (1979b)
%  a revised version of jovanovic's model 
%  Given current human capital level, the worker decides how to devide time
%  between investment in human capital and search for other jobs. The 
%  probabilty of getting another offer depends on search effort. The worker
%  can always stay in his current job if he wants to. The distribution of new 
%  job offers is uniform in the program.

clear
diary jova.out
disp('Jovanovic model');
disp('');
%  set parameter values

A = 0.2;                       % production technology of human capital
fprob = 0.1*ones(10,1);        % uniform distribution of new job offers 
alpha = 60/100;                % production parameter
delta = 0.2;                   % depreciation rate in usual sense 
beta = 0.95;                   % discount rate 

%  form grid for human capital
maxcap = 1;                    % maximum value of human capital   
mincap = 0.1;                  % minimum value of human capital
incap = 0.1;                   % size of grid increments
ncap = round(1/0.1);           % number of grid points
cap = [0.1:0.1:1]';            % capital grids

%  form grid for search effort)
maxs = 1;                    % maximum value of search effort   
mins = 0;                    % minimum value of search effort
ins = 0.1;                   % size of grid increments
ns = round(maxs/ins)+1;      % number of grid points
s = [0:0.1:1]';              % search effort grids

% the state variable is current human capital level
% the control variable is next period human capital level and search effort
   %  initialize some variables
   v       = zeros(ncap,1);
   decis   = zeros(1,ncap);
   test1    = 10;
   test2    = 10;
   %  iterate on Bellman's equation and get the decision 
   %  rules and the value function at the optimum         
   while (test1 ~= 0) | (test2 > 0.1);
   %  tabulate the value function such that for phi + s > 1 or 
   %  phi > 1, value of the problem remains a large negative number 
   %  so that such values will never be chosen as value maximizing      
   w = repmat(-1,[10 11 10]);
   %  the ith row of w denotes the next period capital level, the
   %  jth colume denots search effort, and the kth page denotes
   %  current human capital level. W is the value given above choices

   for k=1:ncap
         for i=1:ncap  
              for j=1:ns
                 phi(i,k) = 1/cap(k)*((cap(i)-(1-delta)*cap(k))/A)^(1/alpha);% investment effort
                 Q(i) = max(v',v(i))*fprob;  % optimal value when having another offer
             if  0 <= phi(i,k) <= 1 & phi(i,k)+ s(j) <= 1 &...
                   cap(i)-(1-delta)*cap(k) > 0  
                % the last condition rules out the case of complex phi
                   w(i,j,k) = cap(k)*(1-phi(i,k)-s(j))+beta*(1-s(j)^0.5)...
                     *v(i)+beta*s(j)^0.5*Q(i);
                end;
              end;
         end;
   end;
      vstack = reshape(w,[ncap*ns ncap]);
      [tvstack,tdecis] = max(vstack);
      tv = tvstack';    
      test1=max(any(tdecis-decis));
      test2=max(max(abs(tv - v))');
      v=tv;
      decis=tdecis;
   end;
   % note that the following recovering formula is specific for the case
   % ncap = 10, approximate changes should be made when otherwise
   sdecis = fix((decis-1)./10).*0.1;  % recover search effort form decis
   capdecis = (decis - fix((decis-1)/10)*10).*0.1; % recover future capital
   phidecis = ((capdecis' - (1-delta)*cap)./A).^(1/alpha)./cap; % recover optimal phi
   disp('value function and optimal decision rule')
   disp(' ')
   disp('     value     x_t+1      phi       s')
   disp('------------------------------------------')
   disp([v,capdecis',phidecis,sdecis'])    % ith row corresponds to current state
plot(cap,v,'r*',cap,capdecis','mo',cap,sdecis','bx',cap,phidecis,'r+')   
title('Graph of Jovanovic model, alpha = 60/100')
xlabel('current human capital')
ylabel('optimal phi +,optimal future capital o,optimal search effort x,value *')
grid on
diary off   


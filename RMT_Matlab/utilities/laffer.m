%  laffer.m
%  computes the laffer curve equilibrium using
%  schurg.m
% 
%  We study the system
%
%   M_t = gam1 p_t - gam2 p_{t+1}
%   M_t - M_{t-1} = p_t g
%  
%  Work with example where gam1 = 100, gam2=50, g = .05
% 
%  Write the system as 
%
%  L [M_t p_{t+1}]' = N [M_{t-1} p_t]'
% 
%  where L=[1 gam2 ; 1 0]; [0 gam1; 0 g]
%  
%  solve the system by calling schurg (by Evan Anderson)
%  and get the stabilizing solution (the lowest inflation rate initial
%  p_0 as p_0 = P M_{-1}  
%
%
%    


  
gam1=100;
gam2=50; 
g=.05;


L=[1 gam2; 1 0];

N = [0 gam1 ; 1 g];



[V,Lbar,Nbar,alpha,beta,info]=schurg(L,N,0,0,1e-15)



% eigenvalues

lambda=alpha./beta  %  the lambda's are the two gross inflation rates

P=V(2,1)/V(1,1)       % the P matrix

%  Try this out

AT=L\N;

for t=1:2
   
  (AT^t)*[1 P*1]'
end



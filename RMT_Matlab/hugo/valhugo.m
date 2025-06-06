function [f]=valhugo(vuprime,v,coeff)
% value fuction for hugo.m
% vuprime is control variable: promised value for next period
% v is last period promised value

global beta ve r sigma n vmax vmin

% Chebyshev polnomials given v

tv=(2*(vuprime-vmin)/(vmax-vmin))-1;

		Tret(1,1)=1;
      Tret(2,1)=tv;
      
      for i=3:n+1 
         
		Tret(i,1)=2*tv*Tret(i-1,1)-Tret(i-2,1);
		
      end;
      
      % cinv is the promise keeping utility
      
      cinv = max(0,(v + log(beta*r*(ve-vuprime))/r -beta...
         *(ve-1/(beta*r))));
      
      c = ((1-sigma)*cinv)^(1/(1-sigma)); % consumption
               
      f = c + coeff'*Tret/(r*(ve-vuprime)); % value function
      
     	



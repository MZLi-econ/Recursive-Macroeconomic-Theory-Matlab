
function [meank] = aiyagari2(r)
% aiyagari2.m is a function file which computes aggregate savings 
% given aggregate interest rate in Aiyagari's QJE 1994 paper

% r is interest rate

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global beta mu delta A alpha s N prob b fixw indi probst kk kap
%  
%   write wage as a function of interest rate using Cobb-Douglas
%   production function
if fixw == 0
wage = (1-alpha)*(A*(alpha/(r+delta))^alpha)^(1/(1-alpha));
else
   wage = 0.2;
end

if r<=0
   phi = b;
   else
      phi  = min(b, wage*s(1)/r);           
end

% -phi is borrowing limit, b is adhoc
% the second term is natural limit

%--------------------------------------------------------------------                               
                                
                              
%   form capital grid

%   
   
maxkap = 16;                     % maximum value of capital grid  
minkap = -phi;                   % borrowing constraint
inckap = 0.2;                    % size of capital grid increments
kap    = minkap:inckap:maxkap;   % state of assets 
nkap   = length(kap);            % number of grid points

   %  initialize some variables
   %
   v       = zeros(nkap,N);
   decis   = zeros(nkap,N);
   
   test    = 10;
   
   %  iterate on Bellman's equation and get the decision 
   %  rules and the value function at the optimum         
   %
   cons = zeros(nkap,nkap,N);
   util = zeros(nkap,nkap,N);
   vint = zeros(nkap,nkap,N);
   tv   = zeros(N,nkap);
   tdecis = zeros(N,nkap);
   
   while test ~= 0;
      
  
   %  tabulate the utility function such that for zero or negative
   %  consumption utility remains a large negative number so that
   %  such values will never be chosen as utility maximizing      
   for j=1:N
      
      
      cons(:,:,j) = s(j)*wage + (1+r)*ones(nkap,1)*kap -...
         kap'*ones(1,nkap);
            
            
      util(:,:,j) = (cons(:,:,j).^(1-mu)-1)/(1-mu);
      utilj = util(:,:,j);
      
      Aj = cons(:,:,j);                % give negative value to 
      i = find( Aj <= 0);              % infeasible consumption choice
      utilj(i) = -10000;
      util(:,:,j) = utilj;

      futval = sum((ones(nkap,1)*prob(j,:)).*v,2); % nkap by 1 vector of
                                                   % future value function
                                                   
                                             
      vint(:,:,j) = util(:,:,j) + beta*futval*ones(1,nkap);
      [t1,t2] = max(vint(:,:,j));
      
      tv(j,:) =t1;
      tdecis(j,:)=t2;
   end
   
   
       tv1     = tv';
       tdecis1 = tdecis';
       test=max(any(tdecis1-decis));
       v=tv1;
       decis=tdecis1;

   end;
   
   decis = -phi + (decis-1)*inckap
   [xs,ykap] = meshgrid(s,kap);
   condecis = wage*xs+(1+r)*ykap-decis;
   
   if indi == 1
      
      subplot(1,2,1)
      plot(kap,decis(:,1),kap,decis(:,7))
      title('evolution of assets,shock Smin and Smax')
      xlabel('asset of current period')
      ylabel('asset of next period')
      legend('b=0','r= -0.02',2)
      
      hold on
      plot(kap,kap,'r-')
      axis([-b,maxkap,-b,maxkap])
      plot(kap,decis(:,1),'ro',kap,decis(:,7),'b*')

      hold off
      
      subplot(1,2,2)
      plot(kap,condecis(:,1),kap,condecis(:,6))
      title('consumption as function of asset')
      xlabel('current asset')
      ylabel('consumption w/r Smin and second highest shock')
      axis([-b,maxkap,-b,6])
      legend('b=0','r= -0.02')
      
      hold on
      plot(kap,condecis(:,1),'ro',kap,condecis(:,6),'b*')
      hold off
      
   end
%-----------------------------------------------------------------------
   %   form transition matrix
   %   trans is the transition matrix from state at t (row)
   %   to the state at t+1 (column) 
   %   The eigenvector associated with the unit eigenvalue
   %   of trans' is  the stationary distribution. 
   % 
   gmat=zeros(nkap,nkap,N);
   
   for j = 1:N
      
      for k = 1:nkap
         
         gmat(k,tdecis1(k,j),j) = 1;
         
      end
      
      trans((j-1)*nkap+1:j*nkap,:) = kron(prob(j,:),gmat(:,:,j));
         
   end
   
   trans=trans';
   
   probst = (1/(N*nkap))*ones(N*nkap,1);
   test=1;
   while test > 10^(-5);
      probst1 = trans*probst;
      test = max(abs(probst1-probst));
      probst = probst1;
   end;
   %
   %   vectorize the decision rule to be conformable with probst
   %   calculate new aggregate capital stock  meanK
   %
   
   kk=decis(:);
   meank=probst'*kk
   r
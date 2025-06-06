function [f,p] = policyi(A,B,R,Q,S)
%function [f,p] = policyi(A,B,R,Q,S)
%  Policy iteration algorithm of Howard applied to linear regulator
%  Also known as Newton's method      
%
%     POLICYI calculates f of the feedback law:
%               
%		u = -fx
%  
%  that maximizes the function:
%
%          sum [x'Rx + u'Qu +2u'Sx] 
%  
%  subject to 
%		x[t+1] = Ax[t] + Bu[t] 
%
%  where x is the nx1 vector of states, u is the kx1 vector of controls,
%  A is nxn, B is nxk, R is nxn, Q is kxk, S is k \times n.
%                
%  The optimal policy is u = -f x.
%  The program also returns p, the steady-state solution to the associated 
%  discrete matrix Riccati equation; the optimal value function is x'px.
%  Revised April 18, 2000.
[n1,n2]=size(A);
[m1,m2]=size(B);
K1=zeros(m2,n1);
tol=.000000001;



  dd=1;
  it=1;
  maxit=10000;
  % check tolerance; for greater accuracy set it to 1e-10
  while (dd>1e-10 & it<=maxit);
    K=K1;
    C=R+K'*S+S'*K+K'*Q*K;
    G=A+B*K;
    X=dlyap(G',C);              
    K1=-(Q+B'*X*B)\(S+B'*X*A);  
    dd=max(max(abs(K1-K)));
    it=it+1;

  end;
f=-K1;p=X;
return


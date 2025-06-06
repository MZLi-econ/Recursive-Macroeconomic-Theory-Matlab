function [F,P] = olrp1(beta,A,B,R,Q,H)
% The optimal linear regulator problem;
% max{-sum{x'Rx+u'Qu+2u'Hx}} s.t. x_{t+1} = Ax+Bu;
% u = -Fx，求控制函数F的不动点;
echo on
tic
ha = max(size(A));
[~,hb] = size(B);
if nargin == 5
    H = zeros(hb,ha);
end
if min(abs(eig(Q))) > 1e-8
    A = sqrt(beta)*(A-B*(Q\H));
    B = sqrt(beta)*B;
    R = R-H'*(Q\H);
    [k,s] = doubleo(A',B',R,Q);
    F = k'+(Q\H);
    P = s;
    %----------------------------------
    % value function iteration
else 
    p0 = 0;
    dif = 1;
    iter = 0;
    f0 = (Q+beta*B'*p0*B)\(beta*B'*p0*A+H);
  while (dif > 1e-8 && iter < 1000)
    p1 = beta*A'*p0*A + R -(beta*A'*p0*B+H')*f0;
    f1 = (Q+beta*B'*p1*B)\(beta*B'*p1*A+H);
    dif = max(max(abs(f1-f0)));
    f0 = f1;
    p0 = p1;
    iter = iter+1;
  end
  %-------------------------------------
  if iter >= 1000
      disp('WARNING: Iteration limit of 1000'); 
  end
  F = f0;
  P = p0;
end
toc
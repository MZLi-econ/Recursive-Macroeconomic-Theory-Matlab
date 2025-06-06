echo on
cla
%This program computes the limit of a Nash linear quadratic
%dynamic game
% Player i maximizes
%  Sum {x'*ri*x + 2 x'*wi*ui +ui'*qi*ui + uj'*si*uj + 2 uj'*mi*ui}
%  s.t. the law of motion
%   x(t+1) = a*x(t) +b1*u1(t)+b2*u2(t)
% and a perceived control law uj(t)= -fj*x(t) for the other player
%a is nxn;
% b1 is nxk1;
% b2 is nxk2;
%r1 is nxn;
% r2 is nxn;
%q1 is k1xk1; q2 is k2xk2;
%s1 is k2xk2; s2 is k1xk1;
%w1 is n x k1
%w2 is n x k2
%m1 is k2 x k1; m2 is k1 x k2;

pause    %Press a key to compute the equilibrium
n = length(a);
[~,k1]=size(b1);
[~,k2]=size(b2);
v1 = eye(k1);
v2 = eye(k2);
p1 = zeros(n);
p2 = zeros(n);
f1 = rand(k1,n);
f2 = rand(k2,n);
dif = 1;
t1 = datetime("now");
jj = 0;
while dif > 1e-10
    f10=f1;f20=f2;
    g2=(b2'*p2*b2+q2)\v2;
    g1=(b1'*p1*b1+q1)\v1;
    h2=g2*b2'*p2;
    h1=g1*b1'*p1;
    f1=(v1-(h1*b2+g1*m1')*(h2*b1+g2*m2'))\((h1*a+g1*w1')- ...
        (h1*b2+g1*m1')*(h2*a+g2*w2'));
    f2=(h2*a+g2*w2')-(h2*b1+g2*m2')*f1;
    a2=a-b2*f2;
    a1=a-b1*f1;
    p1=a2'*p1*a2+r1+f2'*s1*f2-(a2'*p1*b1+w1-f2'*m1)*f1;
    p2=a1'*p2*a1+r2+f1'*s2*f1-(a1'*p2*b2+w2-f1'*m2)*f2;
    jj=jj+1;
    dif=max(abs(f10-f1))+max(abs(f20-f2));
end
t2 = datetime("now");
et = t2-t1;
pause   %Press a key to see time it took to compute equilibrium
et;
f1;
f2;
pause    %Press a key to see number of iterations on Ricatti needed
jj
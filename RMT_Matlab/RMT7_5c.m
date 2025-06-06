A0 = 100;
A1 = 0.05;
d = 10;
a = eye(3);
b1 = [1;0;0];
b2 = [0;1;0];
r1 = [-A1 -A1/2 A0/2;-A1/2 0 0;A0/2 0 0];
r2 = [0 -A1/2 0;-A1/2 -A1 A0/2;0 A0/2 0];
q1 = -0.5*d;
q2 = -0.5*d;
s1 = 0;
s2 = 0;
w1 = 0;
w2 = 0;
m1 = 0;
m2 = 0;
echo on
tic
n = length(a);
[~,k1] = size(b1);
[~,k2] = size(b2);
v1 = eye(k1);
v2 = eye(k2);
P1 = zeros(n);
P2 = zeros(n);
F1 = rand(k1,n);
F2 = rand(k2,n);
dif = 1;
iter = 0;
while dif > 1e-10
    f10 = F1;
    f20 = F2;
    g2 = (b2'*P2*b2+q2)\v2;
    g1 = (b1'*P1*b1+q1)\v1;
    h2 = g2*b2'*P2;
    h1 = g1*b1'*P1;
    F1 = (v1-(h1*b2+g1*m1')*(h2*b1+g2*m2'))\((h1*a+g1*w1')- ...
        (h1*b2+g1*m1')*(h2*a+g2*w2'));
    F2 = (h2*a+g2*w2')-(h2*b1+g2*m2')*F1;
    a2 = a-b2*F2;
    a1 = a-b1*F1;
    P1 = a2'*P1*a2+r1+F2'*s1*F2-(a2'*P1*b1+w1-F2'*m1)*F1;
    P2 = a1'*P2*a1+r2+F1'*s2*F1-(a1'*P2*b2+w2-F1'*m2)*F2;
    iter = iter+1;
    dif = max(abs(f10-F1))+max(abs(f20-F2));
end
toc
iter
F1
F2
A = [0 -2;0 0];
C = [1;1];
G = [1 0];
D = 0;

[K,S] = kfilter(A,G,C*C',D*D')

tic %启动计时器

%--------输入----------------------------
rho = [0.8 -0.3];
delta = [0.2 0];
alpha = 1;
gamma = [0 0];
phi = [0.7 -0.2];
psi1 = 1;
psi2 = 1;
beta = 0.95;
a11 = -0.5;
a15 = -30;
a55 = -1800;

%--------中间变量-------------------------
A = [rho delta alpha;1 0 0 0 0;gamma phi 0;0 0 1 0 0;0 0 0 0 1];
C = [psi1 0;0 0;0 psi2;0 0;0 0];
B = C * C';
a51 = a15;
Y = [a11 0 0 0 a15;zeros(3,5);a51 0 0 0 a55];


%--------输出----------------------------
sigma = doublej(A,B)
mu = 3 * null((eye(5) - A)) % *3使mu向量的alpha=1

%--------中间变量-------------------------
A4 = A^4 * sigma;
A2 = A^2 * sigma;
A6 = A^6 * sigma;
EXX = [1 mu(3,1) mu(3,1);mu(3,1) sigma(3,3) A4(3,3);
    mu(3,1) A4(3,3) sigma(3,3)]
EXY = [mu(1,1);A2(1,3);A6(1,3)]

%--------输出----------------------------
beta1 = EXX \ EXY

%---------------------------------------
t = toc %读取计时器
tic
%--------输入1----------------------------------------
bx1_t = 100;
bx2_t = 100;
y1_t = bx1_t;
y2_t = bx2_t;
sigma_t = [100 0;0 100];
A = [1 0;0 1];
G1 = [0.9 0.1];
G2 = [0.01 0.99];
Q = 0;
R = [50 0;0 50];
%--------中间变量1-------------------------------------
iter = 0;
G = [G1;G2];
bx_t = [bx1_t;bx2_t];
while iter < 50   
    if mod(iter,2) == 0
        X1 = normrnd(100,10,10,1);
        y1_t = mean(X1);
    else
        X2 = normrnd(100,10,10,1);
        y2_t = mean(X2);
    end 
    K_t = A*sigma_t*G'/(G*sigma_t*G'+R);
    sigma_t1 = A*sigma_t*A' +Q- A*sigma_t*G'/(G*sigma_t *G'+R)*G*sigma_t*A';
    y_t = [y1_t;y2_t];
    a_t = y_t - G*bx_t;
    bx_t1 = A*bx_t + K_t*a_t;
    bx_t = bx_t1;
    sigma_t = sigma_t1;
    iter = iter +1;
end
y_t = G*bx_t + a_t;
%--------输出1----------------------------------------
K_t
sigma_t
y_t
bx_t
a_t
iter
%----------------------------------------------------
t=toc
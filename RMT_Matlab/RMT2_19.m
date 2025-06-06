tic
%--------输入1----------------------------------------
bx_t = 100;
sigma_t = 100;
Q = 0;
R = 100;
iter = 1;
%--------中间变量1-------------------------------------
while iter < 50
    X = normrnd(100,10,10,1);
    y_t = mean(X);
    K_t = sigma_t / (sigma_t+R);
    sigma_t1 = sigma_t + Q - sigma_t^2 / (sigma_t+R);
    
    a_t = y_t - bx_t;
    bx_t1 = bx_t + K_t * a_t;
    bx_t = bx_t1;
    sigma_t = sigma_t1;
    iter = iter +1;
end
y_t = bx_t +a_t;
%--------输出1----------------------------------------
K_t
sigma_t
y_t
bx_t
a_t
iter;
%----------------------------------------------------
t=toc
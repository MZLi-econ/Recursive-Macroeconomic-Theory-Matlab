function[P]=nsm(P);

%求矩阵n次方
dif =1;
iter =0;
while dif > 1e-8
    P1 = P^2;
    dif =max(max(abs(P1-P)));
    P = P1;
    iter = iter+1;
    if iter > 1000
        disp('WARNING: Iteration limit of 1000 reached in doubleo.m');
    end
end


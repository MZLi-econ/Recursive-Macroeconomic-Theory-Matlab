%hanjagbnd.m
%  computes two HJ bounds for Kydland-Prescott data
%
% then it plots them
% also inputs the Kydland-Prescott data and plots the
% std(y) and E(y) for various gamma's

global covx mu pricerisk


mu=[1.070 1.010]';
covx=[.0274 .00104; .00104 .00308];

% form statistics for excess return

a=[1 -1]';
muz=a'*mu;
covz=a'*covx*a;   

pricerisk=muz/(sqrt(covz));


mu
covx
muz
covz
pricerisk

%%%% bound for raw returns
%

q1=[1 1]';

ey=.99;

b=covx\(q1 - ey*mu) ; 
sigy=sqrt(b'*covx*b);
lims=[.85 1.02 0 1.8];
figure(1)
fplot('hjbnd',lims)
hold on
%figure
fplot('hjbnd2',lims,'g--'),xlabel('E(y)'),ylabel('\sigma(y)')
hold off

figure(2)

epdata  ;  % load the equity consumption etc. data
congr=epdata(:,4);
tt=ptime(1890,90,1);
plot(tt,congr)
print -deps hanjag2.eps

%  compute several mean and sd of stochastic discount factors
epdata;   % load the equity and consumption data
beta=.99;
congr=epdata(:,4);

n=6;  mm=zeros(n,1);sm=mm;gamma=mm;
for i=1:n+1;
   gamma(i)=(i-1)*7.5;

x=beta*congr.^(-gamma(i));
mm(i)=mean(x);
sm(i)=std(x);

end

figure(1)
hold on
plot(mm(1),sm(1),'s')
plot(mm(2),sm(2),'o')
plot(mm(3),sm(3),'d')
plot(mm(4),sm(4),'v')
plot(mm(5),sm(5),'h')
plot(mm(6),sm(6),'p')
print -deps hanjag1.eps

figure(3)
scatter(epdata(:,3),epdata(:,2),'.')
hold on
meanbill=mean(epdata(:,3))
meanstock=mean(epdata(:,2))
plot(meanbill,meanstock,'o');
print -deps hanjag3.eps
hold off



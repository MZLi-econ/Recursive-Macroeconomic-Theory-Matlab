clear;

beta = 0.98;
mu   = 0.02;

b = 0.2;
z = 0.3;

EPSILON2 =0.0001;  % tolerance for convergence of value functions
simlength = 200;

w = 0:.01:1;
w = w';
w_size = length(w);

f = (1/w_size).*ones(1,w_size);

beta2 = beta*(1-mu);


  %%%%%%%%%%%%%%%%%% initialization of the variables %%%%%%%%%%%%%%%%%%%%
% initialize the variables for the value function iteration 

 v = zeros(w_size,2);         % the value function, 
 w_res = [0 0];       
  
    %%%%%%%%%%%% Iteration on the value functions %%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    t2 = clock;
    % Iterate Bellman Equations to convergence of reservation wages
    test = 0;
    test4 = 0;
    EPSILON22 = EPSILON2
    check_iter2 = 0;    
    while (test == 0)
      check_iter2 = check_iter2 + 1;
    

   reject  = b + beta2*( (1/2).* f*v(:,1) + (1/2).* f*v(:,2) );
   acceptR = w + beta2*( (1/2).* v(:,1)   + (1/2).* v(:,2)   );
   acceptB = acceptR + z;

   tempR = min(find(acceptR-reject >= 0));
   tempB = min(find(acceptB-reject >= 0));

   w_res_index = [w_size w_size];

   if(~isempty(tempR));
       w_res_index(1) = tempR;
    end; % for if

   if(~isempty(tempB));
       w_res_index(2) = tempB;
   end; % for if

   tw_res = [w(w_res_index(1)) w(w_res_index(2))];
   tv(:,1)= max(acceptR, reject);
   tv(:,2)= max(acceptB, reject);


      % Test if reservation wages have converged
      if ((tw_res(1) == w_res(1)) & (tw_res(2) == w_res(2)))
         test1 = 1;
         test4 = test4 + 1;
        else
         test1 = 0;
         test4 = 0;
      end; % for if

      if (max(max(abs([v(:,1)-tv(:,1);v(:,2)-tv(:,2)])))<EPSILON22)
         test3 = 1;
        else
         test3 = 0;
      end;

      epsdiff = max(max(abs(v-tv)));
      epslevel = min(min(abs(v)));

      EPSILON22 = EPSILON2 * min(epslevel); 



      [check_iter2/1000 epsdiff
       test4            epslevel]

      test = test1 & test3;
      w_res = tw_res;
      v = tv;

    [test1 test3]
    end;    % while reservation wages have not converged

%%Simulation of unemployment rate

pop = zeros(3,simlength);

pop(1,1) = 1-mu;
pop(2,1) = 0;
pop(3,1) = mu;
simuliter = 0;

shocks = rand(simlength,1);
booms  = ones(simlength,1);

while simuliter<simlength;
simuliter = simuliter+1;

F = w_res_index./100;

if (shocks(simuliter)>0.5)
    booms(simuliter)=0;
    AA = [(1-mu) (1-mu)*(1-F(1))  (1-mu)*(1-F(1))
           0     0                          0
           0     (1-mu)*F(1)      (1-mu)*F(1)    ];
  else;
    AA = [(1-mu) 0                          (1-mu)*(1-F(2))
           0     (1-mu)                     0
           0     0                          (1-mu)*F(2)    ];
end;

BB = [0
      0
      mu];

pop(:,simuliter+1) = BB + AA*pop(:,simuliter);

end;

times = 1:1:50;
plot(times(1:49),pop(3,151:199),'-', times(1:49),booms(151:199),'*')
axis([0 50 0 0.10]);

 print -dps pic1b.ps;
pause;

 plot(times(1:49),pop(3,151:199),'-')
 xlabel('Time','FontSize',20);
ylabel('Unemployment rate','FontSize',20);

   set(gca,'Fontsize',16);

 print -dps pic1.ps;

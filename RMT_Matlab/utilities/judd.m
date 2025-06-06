echo on
cla
%      This program computes the Nash feedback equilibrium
%      of a linear quadratic dynamic game.   Each of two players
%      solves a linear quadratic optimization problem, taking as
%      given and known the sequence of linear feedback rules used
%      by his opponent.  
%
%      The particular game analyzed is a price-quantity setting
%      game suggested by Ken Judd.
%
pause   %Press a key to continue
cla
%      There are two firms.  There is no uncertainty.  Relevant
%      variables are defined as follows:
%
%       Ii(t) = inventories of firm i at beginning of t.
%       qi(t) = production of firm i during period t.
%       pi(t) = price charged by firm i during period t.
%       Si(t) = sales made by firm i during period t.
%       Ei(t) = costs of production of firm i during period t.
%       Ci(t) = costs of carrying inventories for firm i during t.
%
%      It is assumed that costs obey
%
%       Ci(t) = ci(1) + ci(2)*Ii(t) + .5* ci(3)*Ii(t)^2
%       Ei(t) = ei(1) + ei(2)*qi(t) + .5* ei(3)*qi(t)^2
%
%      where ei(j) and ci(j) are constants.
%
%      It is assumed that inventories obey the laws of motion
%
%       Ii(t+1) = (1 - del) * Ii(t) + qi(t) - Si(t)
%
pause   %Press a key to continue
cla
%      It is assumed that demand is governed by the linear schedule
%
%
%       S(t) = d * p(t) + B
%
%      where S(t) = [S1(t),S2(t)]', d is a (2x2) negative definite
%      matrix, and B is a vector of constants.
%      Firm i is assumed to maximize the undiscounted sum
%
%       SUM { pi(t)*Si(t) - Ei(t) - Ci(t) }
%
%      by choosing a control law of the form
%
%       ui(t) = -Fi * x(t)
%
%      where ui(t) = [pi(t),qi(t)]', and the state x(t)
%      is given by x(t)=[I1(t),I2(t),1].  
%
pause   %Press a key to continue
cla
%      Firm i is assumed to solve its control problem taking
%      the (sequence of) control laws uj(t) = -Fj(t)*x(t) as
%      known and given.  
%
%      The program computes the limiting values of the control
%      laws (F1(t),F2(t)) as the horizon is extended to infinity.
pause    %Now the program will set some parameters. Press a key.
cla
del=.02;
d=[-1 .5; .5 -1]
B=[25 25]'
pause   %Press a key to set more parameter
cla
c1=[1 -2 1]
c2=[1 -2 1]
e1= [10 10 3]
e2= [10 10 3]
del1=1-del
pause   %Press a key to continue
cla
%      Now we'll create the matrices needed to compute the
%      Nash feedback equilibrium.  We will proceed by iterating
%      on pairs of "Ricatti" equations.  Player 1 has a regulator
%      problem with matrices r1,w1,q1,s1,m1 in the objective function
%      (see the explanation of these quantities when nnash is
%      called shortly) and matrices a,b1,and b2 in the law of motion
%      (again, see the explanation when nnash is called).
a=[del1 0 -del1*B(1);0 del1 -del1*B(2);0 0 1]
b1=del1*[1 -d(1,1); 0 -d(2,1); 0 0]
pause    %Press a key to continue
b2=del1*[0 -d(1,2); 1 -d(2,2);0 0]
r1=[.5*c1(3) 0 .5*c1(2); 0 0 0;.5*c1(2) 0 c1(1)]
r2=[0 0 0;0 .5*c2(3) .5*c2(2);0 .5*c2(2) c2(1)]
pause   %Press a key to continue
r1=-r1;r2=-r2;
q1=[-.5*e1(3) 0; 0 d(1,1)]
q2=[-.5*e2(3) 0; 0 d(2,2)]
pause    %Press a key to continue
m1=[0 0; 0 d(1,2)/2]
m2=m1
s1=zeros(2);s2=s1;
pause   %Press a key to continue
w1=[0 0;0 0;-.5*e1(2) B(1)/2]
w2=[0 0;0 0;-.5*e2(2) B(2)/2]
pause   %Press a key to call nnash to compute equilibrium
nnash
pause   %Press a key to see Firm 1's feedback rule
f1
%     Firm 2's feedback rule is 
f2
pause     %Press a key to compute closed loop control law
aaa=a-b1*f1-b2*f2
%     Recall that the state is x(t)=[I1(t),I2(t),1]'
%     So the equilibrium law of motion is
%
%       x(t+1) = aaa * x(t)
%            or
%       x(t+1) = (a - b1*F1 - b2*F2) * x(t)
pause    %Press a key to continue
cla
pause     %Press a key to calculate the optimal stationary values
%          of the inventory levels [I1(t),I2(t)]'.
aa=aaa(1:2,1:2);
tf=eye(2)-aa;
tfi=inv(tf);
xbar=tfi*aaa(1:2,3)
pause    %press a key to return to menu

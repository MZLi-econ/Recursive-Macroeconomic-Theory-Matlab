% This is an example script file which shows how to use 
% the function armairspect.  Does a business cycle process.

a = [1 -1.3 .6]
b = [1 0]

armairspect (a,b)

pause

% Now do with a simulation of 150 periods and the impulse 
% response out to 7 periods.

armairspect (a,b,150,7)

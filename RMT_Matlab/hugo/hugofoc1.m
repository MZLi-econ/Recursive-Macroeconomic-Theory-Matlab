function [f] = hugofoc1(x,vu);
global beta ve;                  
f = 0.9*beta*x*(ve-vu)-1;        

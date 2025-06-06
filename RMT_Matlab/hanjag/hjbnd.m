function[sigy]=hjbnd(ey)
%function[sigy]=hjbnd(ey)
%
%  computes the basic HJ bound for returns

global covx mu 
q1=[1 1]';



b=covx\(q1 - ey*mu) ; 
sigy=sqrt(b'*covx*b);

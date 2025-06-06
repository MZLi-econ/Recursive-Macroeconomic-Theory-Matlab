function[sigy]=hjbnd2(ey)
%function[sigy]=hjbnd2(ey)
%
%  computes the basic HJ bound for a scalar excess return
%  the price of risk must be input as global

global covx mu pricerisk
q1=[1 1]';



sigy=pricerisk*ey;

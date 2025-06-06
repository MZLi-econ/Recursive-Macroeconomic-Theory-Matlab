function [V, LBAR, NBAR,alpha,beta,info]  = schurg(L,N,order,balance,eps)
%
% SCHURG  Ordered real generalized schur decomposition
%
%  [V, LBAR, NBAR,alpha,beta,info]  = schurg(L,N,order,balance,eps)
%  computes the ordered generalized real
%  Schur decomposition of the matrix pencil  
%                     lambda L  - N
%  such that LBAR is upper triangular, NBAR is upper block
%  triangular, V is the matrix of right Shur vectors such that
%  for some orthogonal matrix W
%          W L V = LBAR
%          W N V = NBAR,
%   and the generalized eigenvalues of the pencil are given
%   by  (alpha ./ beta).  If order =1 then the unstable eigenvalues
%   appear first in the pencil
%                   lambda LBAR - NBAR 
%   If order =0 then the stable eigenvalues
%   appear first.  (The order of the eigenvalues in (alpha ./ beta)
%   is not related to the order of the eigenvalues in the pencil.)   
%
%   If balance ~=0, then the problem
%   is balanced before the computation of the real schur form.
%   eps is a real number reflecting when an element of a matrix should
%   be considered zero.   
%
%   info is a two-dimensional giving information
%   on failure. If info(1) ~=0 then the algorithm failed to compute
%   the ordered generalized real schur decomposition. If info(1)=1 this
%   is because the FORTRAN function QZITW failed. If info(1) =2 
%   this is because the FORTRAN function ORDER failed. Currently,
%   info(2) does not contain useful information.
%  
%  NOTES: (1) It is recommended that balancing be turned off
%         (2) eps should normally be set near  machine precision
%         (3) L and N must be real matrices.  If they are
%             complex, the complex portion will be
%             truncated without warning.
%
%  EXAMPLE : To obtain a generalized real schur decomposition
%     of the pencil lambda L  - N in which the stable
%     eigenvalues appear first, use the following code:
%            [V,LBAR,NBAR,alpha,beta,info] = schurg(L,N,0,0,1e-15)
%     If the half of the eigenvalues of the pencil are stable and
%     if the algorithm didn't fail, the stabilizing solution to the
%     corresponding  Riccati like equation is
%          P = V21/V11
%     where V21 is the lower left block of V and V11 is the upper left
%     block of V.
%
%  ALGORITHM:  QZHESW, QZITW, QZVAL, and ORDER from  RICPACK 
%  REFERENCES: Anderson, Hansen, McGrattan and Sargent (1995) 
%             Arnold and Laub 
%             Pappas, Laub and Sandel (1980)
%             Ward
%  MATLAB INTERFACE WRITTEN BY:  Evan W. Anderson January 1,1995


%  This file contains the documentation for the mex file SCHURG. This
%  file is not a MATLAB function.  If the following line of code
%  is executed then you have not properly installed the MEX files.


error('MEX file shurg.* is not available');







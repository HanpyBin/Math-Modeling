function [EOFsR,XR]=r_eof(EOFs,method,options)
% [EOFsR,XR]=r_eof(EOFs,method,options)
% 
% This function rotates Empirical Orthogonal Functions such that
% a particular criterium is maximised or minimised.
% At present only orthogonal rotations are implemented
%
% *** input variables ***
% EOFs   : the variable with the EOFs in the columns
% method : contains the criterium for which the rotation is evaluated
%          presently only the raw varimax approach is implemented (see below)
% options: solver options which can be passed on to the optimisation algorithm
%
% *** output variables ***
% EOFsR	: The Rotated EOFs
% XR		: matrix which transforms the original EOF matrix to rotated space
%
% R_VARIMAX A function used for rotating EOFs
%  	R_VARIMAX determines the raw varimax measure of a 
%		set of EOFs. The purpose is to rotate the EOFs in 
% 		such a fashion that this criterion is minimised.
%
%		See "Analysis of Climate Variability",  H. von Storch, A. Navarra (Eds.)
%		page 234-235, 1995.
%		and "Rotation of Principal Components", Michael B. Richman,
%		J. of Climatology, VOl 6. pg 293-335., 1986
%
%		Also see N_VARIMAX (normalised varimax measure) and
%		OBLIMIN which determines oblique rotation of the eofs.

if nargin<2
   method='r_varimax';
end
if nargin<3
   options=[];
end

[m,n]=size(EOFs);

x0=ones(n,1);
%options(14)=3000;

x1=fmins('Rotate1',x0,options,[],EOFs,method);
XR(:,1)=x1./norm(x1);

for i=2:n
   x1=constr('Rotate2',x0,[],[],[],[],EOFs,XR,method);
   XR(:,i)=x1./(norm(x1));
end;

 EOFsR=EOFs*XR;
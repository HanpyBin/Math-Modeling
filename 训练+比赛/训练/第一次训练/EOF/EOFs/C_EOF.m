function [V,EOFs,EC,error]=c_eof(D,NOE,options)
% function [V,EOFs,EC,error]=c_eof(D,NOE,options)
%
% This function determines the complex empirical orthogonal functions of a
% data set contained in matrix D.
%
% ******* INPUT PARAMETERS *************
% D =  each row is assumed to be a sample. Each column a variable.
%     Thus a column represents a time series of one variable
% NOE= required number of eigenvalues. (optional parameter)
%     (If no input is given, then all eigenvalues are computed)
%     If NOE is 'all' then all eigenvalues are computed.
% options : defined as in matlab function: eigs
% 
% ******* OUTPUT PARAMETERS ************
% V = vector of (real) eigenvalues (they are real because the 
%     covariance matrix is Hermitian)
% EOFs = matrix with complex values. Each columns represents and EOF
% EC = EOF Coefficients, also called Principal Component Coefficients
%      Basically the original data transformed to EOF space
% error = compute L2-norm reconstruction error for each spatial point
%
% For the method use in this file see T.P. Barnett, "Interaction of the 
% Monsoon and Pacific Trade Wind System at Interannual Time Scales, 
% Part I: The Equatorial Zone", Montly Weather Review, 
% VOL. 111, page 756-773, (C) 1983 American Meteorological Society.
%
% Also see: J.D. Horel "Complex Principal Component Analysis: Theory and Examples"
% Journal of Climate and Applied Meteorology, V 23, page 1660-1673, 1984
%
% written by Martijn Hooimeijer, 1999 (http://hydr.ct.tudelft.nl/wbk/public/hooimeijer/)

[n,m]=size(D);  % n is number of time steps, m is number of spatial points
q=min(n,m);

% Hilbert Transform of Data with fft. (Note: this may not be the 
% best way of doing things: it is probably better to apply 
% Chebyshev polynomials.)

DH=hilbtrans(D);

DC=D+i*DH; % Add the Hilbert transform to the original data and multiply by i.

% determine covariance matrix of U and determine its eigenvalues and eigenvectors
if nargin<2
   [V,EOFs,EC,error]=EOF2(DC);
else
   if NOE=='all'
      [V,EOFs,EC,error]=EOF2(DC);
   else
      [V,EOFs,EC,error]=EOF2(DC,NOE);
   end
end

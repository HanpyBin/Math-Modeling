function [V,TCPs,TC,error]=C_TCP(D,NOE)
% function [V,TCPs,TC,error]=C_TCP(D,NOE)
%
% This function decomposes a data set D into its Complex Teleconnection 
% patterns and eigenvalues V. 
%
% ******* INPUT PARAMETERS *************
% D =  each row is assumed to be a sample. Each column a variable.
%     Thus a column represents a time series of one variable
% NOE = required number of eigenvalues. (optional parameter)
%     (If no input is given, then all eigenvalues are computed)
%     If NOE is 'all' then all eigenvalues are computed.
% dt= time step of the problem (optional)
% t0= initial time t0 (optional)
% 
% ******* OUTPUT PARAMETERS ************
% V = vector of (real) eigenvalues (they are real because the 
%     covariance matrix is Hermitian)
% TCPs = matrix with each column representing a Teleconnection Pattern
% TC = TCP Coefficients, also called Teleconnection Coefficients
%      Basically the original data transformed to Teleconnection space
% error = compute L2-norm reconstruction error for each spatial point
% 
% This function uses svds from Matlab version 5
%
%
% written by Martijn Hooimeijer, 1999 (http://hydr.ct.tudelft.nl/wbk/public/hooimeijer/)

% first compute normalized data set
DN=normalize(D);

% Hilbert Transform of Data with fft. (Note: this may not be the 
% best way of doing things: it is probably better to apply 
% Chebyshev polynomials.)

DH=hilbtrans(DN);

DC=DN+i*DH; % Add the Hilbert transform to the original data and multiply by i.

% Determine singular value decomposition of the problem
if nargin<2
   [V,TCPs,TC,error]=EOF2(DC);
else
   if NOE=='all'
      [V,TCPs,TC,error]=EOF2(DC);
   else
      [V,TCPs,TC,error]=EOF2(DC,NOE);
   end
end


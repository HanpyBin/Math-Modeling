function [V,TCPs,TC,error]=TCP(D,p)
% function [V,TCPs,TC,error]=TCP(D,p)
%
% This function decomposes a data set D into its Teleconnection 
% patterns and eigenvalues V. The most effecient algorithm proposed by
% von Storch and Hannostock (1984) is used.
%
% ******* INPUT PARAMETERS *************
% D =  each row is assumed to be a sample. Each column a variable.
%     Thus a column represents a time series of one variable
% p = required number of eigenvalues. (optional parameter)
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

% first compute zero-averaged data sets
DS=normalize(D);

% Determine size of the data matrix (m=number of samples, n= number of variables)
[m,n]=size(DS);
q=min(m,n);

% Determine singular value decomposition of the problem
if nargin < 2
   [U,S,F]=svds(DS,min(m,n));
else
   [U,S,F]=svds(DS,min(q,p));
end

% rewrite the large eigenvalue matrix to a vector and 
% apply the appropriate normalisation
V=diag(S).^2/(m-1);

% Define the EOFs (with EOFs in the columns)
TCPs=F;

% Determine the EOF coefficients
TC=U*S;

% Determine the difference between the original data and the 
% reconstructed data
diff=(DS-TC*TCPs');

% determine the L2 error norm for each variable
error=sqrt(sum(abs(diff.^2)));
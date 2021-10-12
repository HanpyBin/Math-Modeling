function [V,EOFs,EC,error]=EOF(D,p)
% function [V,EOFs,EC,error]=EOF(D,p)
%
% This function decomposes a data set D into its EOFs 
% and eigenvalues V. The most effecient algorithm proposed by
% von Storch and Hannostock (1984) is used.
%
% D = each row is assumed to be a sample. Each column a variable.
% Thus a column represents a time series of one variable
% p = is an optional parameter indicating the number of 
% EOFs the user wants to take into account (smaller than
% the number of time steps and the number of samples).
%
% EOFs= matrix with EOFs in the columns
% V = vector with eigenvalues associated with the EOFs
% EC = EOF Coefficients
% error = the reconstruction error (L2-norm)
% 
% This function uses svds from Matlab version 5
%
% Written by Martijn Hooimeijer (1998)


% first compute zero-averaged data sets
DS=zeroavg(D);

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
EOFs=F;

% Determine the EOF coefficients (form the zero-averaged data)
EC=U*S;

% Determine the difference between the original data and the 
% reconstructed data
diff=(DS-EC*EOFs');

% determine the L2 error norm for each variable
error=sqrt(sum(abs(diff.^2)));
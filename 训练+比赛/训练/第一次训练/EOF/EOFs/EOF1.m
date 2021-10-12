function [V,EOFs,EC,error]=EOF1(D,p)
% function [V,EOFs,EC,error]=EOF1(D,p)
%
% This function decomposes a data set D into its EOFs 
% and eigenvalues V. Standard algorithm (usually slowest)
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

[m,n]=size(D); % Determine size of the data matrix
q=min(m,n);		 % (m=number of samples, n= number of variables)


% Determine the number of EOFs to be determined (NOE)
if nargin < 2
   NOE=q;
else
   if p=='all'
      NOE=q;
   else
      NOE=min(q,p);
   end
end

% Compute covariance matrix, and
[EOFs,S]=eigs(cov(D),NOE);

V=diag(S);

DS=zeroavg(D);
EC=DS*EOFs;

% Determine the difference between the original data and the 
% reconstructed data
diff=(DS-EC*EOFs');

% determine the L2 error norm for each variable
error=sqrt(sum(diff.^2));
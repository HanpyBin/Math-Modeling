function [V,EOFs,EC,error]=EOF_T(D,p)
% function [V,EOFs,EC,error]=EOF_T(D,p)
%
% This function decomposes a data set D into its EOFs 
% and eigenvalues V. The most effecient algorith proposed by
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

% first compute zero-averaged data sets
[m,n]=size(D);

DS1=zeroavg(D(1:m-1,1:n-1));
DS2=zeroavg(D(2:m,2:n));

% Determine size of the data matrix (m=number of samples, n= number of variables)
q=min(m-1,n-1);

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



% Estimated smallest covariance matrix
echo off
% If number of time samples greater than number of variables
% compute the ordinary Covariance Matrix CE
if m>=n    
   CE=DS1'*DS2/(m-2); % this yield and n-1 x n-1 Covariance Matrix
   [EOFs,S]=eigs(CE,eye(size(CE)),NOE);
end
% If number of time samples smaller than number of variables
% compute the ordinary Covariance Matrix CE
if m < n
   CE = DS1*DS2'/(m-2); % this yield and m-1 x m-1 Covariance Matrix
   [E,S]=eigs(CE,eye(size(CE)),p);
   EOFs=D'*E;
   for i=1:NOE
      EOFs(:,i)=EOFs(:,i)/norm(EOFs(:,i));
   end
   
end

% rewrite the large eigenvalue matrix to a vector and 
% apply the appropriate normalisation
V=diag(S);

% Determine the EOF coefficients
EC=DS1*EOFs;

% Determine the difference between the original data and the 
% reconstructed data
diff=(DS1-EC*EOFs');

% determine the L2 error norm for each variable
error=sqrt(sum(abs(diff.^2)));
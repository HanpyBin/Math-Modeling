function [V,EOFs,EC,error]=E_EOF(D,Lag,p)
% function [V,EOFs,EC,error]=E_EOF(D,Lag,p)
%
% This function decomposes a data set D into its extended EOFs 
% and eigenvalues V. The most effecient algorith proposed by
% von Storch and Hannostock (1984) is used.
%
% D = each row is assumed to be a sample. Each column a variable.
% Thus a column represents a time series of one variable
% Lag = The lag to be computed. The following covariance matrix will
% be analysed: C=<D(r,t), X(r,t-Lag)>
% p = is an optional parameter indicating the number of 
% EOFs the user wants to take into account (smaller than
% the number of time steps and the number of samples).
%
% EOFs= matrix with EOFs in the columns
% V = vector with eigenvalues associated with the EOFs
% EC = EOF Coefficients



% first compute zero-averaged data sets
DS=zeroavg(D);

% Determine size of the data matrix (m=number of samples, n= number of variables)
[m,n]=size(DS);
q=min(m,n);

% Determine the number of EOFs to be determined (NOE)
if nargin < 2
   error('You must provide a Lag time! Type "Help E_EOF" for help.');
end

if nargin < 3
   NOE=q;
else
   if p=='all'
      NOE=q;
   else
      NOE=min(q,p);
   end
end

D1=DS(1+Lag:m,:); % Create data set D from time step Lag to the end
D2=DS(1:m-Lag,:); % Create data set lagged with lag time steps

% Estimated smallest covariance matrix
echo off
% If number of time samples greater than number of variables
% compute the ordinary Covariance Matrix CE
if m>=n    
   CE=D1'*D2/(m-Lag-1); % this yield and n x n Covariance Matrix
   [EOFs,S]=eigs(CE,NOE);
end
% If number of time samples smaller than number of variables
% compute the ordinary Covariance Matrix CE
if m < n
   CE = D1*D2'/(m-Lag-1); % this yield and m x m Covariance Matrix
   [E,S]=eigs(CE,eye(size(CE)),NOE);
   EOFs=D1'*E;
   for i=1:NOE
      EOFs(:,i)=EOFs(:,i)/norm(EOFs(:,i));
   end
   
end

% rewrite the large eigenvalue matrix to a vector and 
% apply the appropriate normalisation
V=diag(S);

% Determine the EOF coefficients
EC=DS*EOFs;

% Determine the difference between the original data and the 
% reconstructed data
diff=(DS-EC*EOFs');

% determine the L2 error norm for each variable
error=sqrt(sum(abs(diff.^2)));
warning('Error estimation is wrong in this function so far');
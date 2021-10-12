function [N,Ma]=zeroavg(M,c)

% function [N,Ma]=zeroavg(M,c)
%
% This function computes the average of each column of a matrix M
% and subtracts it % from every entry in that column. 
% If the column contains a time % serie, the time serie will become 
% zero averaged. 
%
% If an extra argument "c"
% is passed to the function 
% (independent of its value) the averageing will
% not be performed over its columns bit over its rows.
% The zero averaged matrix is returns in matrix N.

[p,q]=size(M);

if nargin == 1
   Ma=sum(M)/p;
   N = M - repmat(Ma,p,1);
end
if nargin>1
   Ma=(sum(M')/q)';
   N=M-repmat(Ma,1,q);
end


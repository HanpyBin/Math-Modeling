function [N,Ma]=zeroavg(M,c)
% ¹éÒ»»¯
[p,q]=size(M);

if nargin == 1
   Ma=sum(M)/p;
   N = M - repmat(Ma,p,1);
end
if nargin>1
   Ma=(sum(M')/q)';
   N=M-repmat(Ma,1,q);
end


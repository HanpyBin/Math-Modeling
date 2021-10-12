function [V,EOFs,EC,error]=ReducedEOF(D, p, minVar, r)
% This function filters out any points with a variance that
% is smaller than the variance minVar.
% Is a fourth optional parameter r is given, then
% a relative size is computed. If minVar = 100, then 
% all variancs that are 100 times smaller than the maximum variance
% are filtered out.
% all EOF values for the points with small variance are set as 0.

% first determine the variance
tic
vv=var(D);

if nargin<4 
   threshhold=minVar
else
   threshhold=max(vv)/minVar
end

DR=D(:,vv>threshhold);

reduction_rate=sum(vv<=threshhold)/max(size(vv))

[V,EOFsR,EC,error]=EOF(DR,p);

EOFs(vv>threshhold,:)=EOFsR;
EOFs(vv<=threshhold,:)=0;
toc
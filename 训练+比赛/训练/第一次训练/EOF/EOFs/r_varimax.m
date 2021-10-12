function V=r_varimax(X)
% R_VARIMAX A function used for rotating EOFs
%  	R_VARIMAX determines the raw varimax measure of a 
%		set of EOFs. The purpose is to rotate the EOFs in 
% 		such a fashion that this criterion is minimised.
%
%		See "Analysis of Climate Variability",  H. von Storch, A. Navarra (Eds.)
%		page 234-235, 1995.
%		and "Rotation of Principal Components", Michael B. Richman,
%		J. of Climatology, VOl 6. pg 293-335., 1986
%
%		Also see N_VARIMAX (normalised varimax measure) and
%		OBLIMIN which determines oblique rotation of the eofs.

[n,m]=size(X);

V=sum( (n*sum(X(1:n,:).^4)-(sum(X(1:n,:).^2)).^2)/n^2);
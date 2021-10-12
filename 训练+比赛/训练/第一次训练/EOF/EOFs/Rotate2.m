function [f,g]=Rotate2(x,EOFs,X2,method)

[n,m]=size(x);

n2=min(size(EOFs));

if ((m==1) & (n2==n))
   Enew = EOFs*x;
else
   if (n==1) and (n2==m)
      Enew = EOFs*x';
   else
      error('vector sizes do not match');
   end
end
Enew=Enew./norm(x);
x=x./norm(x);

switch method
case 'r_varimax'
   f=-r_varimax(Enew);
end


if nargin>2
   g=pi/2-subspace(x,X2);
end

  
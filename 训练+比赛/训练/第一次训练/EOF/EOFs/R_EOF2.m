function r_eof(EOFs)

[m,n]=size(EOFs);

T0=zeros(n,n);

for i=1:n
   T(:,n)=fmins('RotateEOFs',T0(:,n),[],[],EOFs(:,n));
end;

clear;

% Stating the problem
% u(x,t)=a*sin(k*x-w*t)

a=1;
k=0.3;
w=-0.3;
dt=1;
dx=0.5;
x=0:dx:10;
t=0:dt:10;
n=length(t);

for i=1:n
   u(i,:)=a*sin(k*x-w*t(1,i)*ones(size(x)));
end;
%surf(x,t,u),rotate3d;

[U,B,lab,A,teta]=ceof(u,dt,0,4);
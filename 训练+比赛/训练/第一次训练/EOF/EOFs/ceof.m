function [Uc,B,lab,A,teta]=ceof(u,dt,t0,NOE);
% function [Uc,B,lab,A,teta]=ceof(u,dt,t0,NOE);
%
% OLD AND OUTDATED!! does not work properly.
%
% This function determines the complex empirical orthogonal functions of a
% data set contained in matrix u.
%
% It is assumed the columns in input matrix u are different spatial points
% and that the rows are different time points at each spatial points.
%
% dt is the time step of the problem.
% t0 is the initial time t0
% 
% NOE is the required number of eigenvalues. (If no input is given, then all eigenvalues are computed)
%
% lab is a vector of (real) eigenvalues (they are real because the covariance matrix is Hermitian)
% B is a matrix containing the complex eigenvalues
%
% For the method use in this file see T.P. Barnett, "Interaction of the Monsoon and Pacific Trade
% Wind System at Interannual Time Scales, Part I: The Equatorial Zone", Montly Weather Review, 
% VOL. 111, page 756-773, (C) 1983 American Meteorological Society.
%
% written by Martijn Hooimeijer, 1998 (http://hydr.ct.tudelft.nl/wbk/public/hooimeijer/)

[n,m]=size(u);  % n is number of time steps, m is number of spatial points

if nargin<2
   dt=1;
end
if nargin<3
   t0=0;
end

t=t0:dt:dt*n;

% First apply Fourier Transform. (Note: this may not be the best way of doing things:
% it is probably better to apply Chebyshev polynomials.)

X=fft(u);

% Then detemine coefficients a and b

for j=1:m % spatial parameter: in columns
	a0(1,j)=2*X(1,j)/n;       %(average)
   for k=1:n-1
      a(k,j) = 2*real(X(k+1,j))/n;
      b(k,j) = 2*imag(X(k+1,j))/n;
   end
end

% Transform data to U matrix (time averaged: so discard a0).
%
%           n/2  [   /                                                              \      
%  U(i,j) = sum  [  < a(k,j)*cos(2*pi*k*t(i)/(n*dt))+b(k,j)*sin(2*pi*k*t(i)/(n*dt))  >     
%           k=1  [   \                                                              /      
%                     /                                                              \   ]
%              +   i < a(k,j)*cos(2*pi*k*t(i)/(n*dt))-b(k,j)*sin(2*pi*k*t(i)/(n*dt))  >  ]
%                     \                                                              /   ]

% Initialize Uc 

Uc=ones(size(u));

for j=1:m    % spatial index
   for l=1:n % time index 
%      Uc(l,j)=a0(1,j);
      for k=1:n/2
         Uc(l,j)=Uc(l,j) + a(k,j)*cos(2*pi*k*t(l)/(n*dt))+b(k,j)*sin(2*pi*k*t(l)/(n*dt))+ i*( a(k,j)*cos(2*pi*k*t(l)/(n*dt))-b(k,j)*sin(2*pi*k*t(l)/(n*dt)) );
      end
   end
end

% determine covariance matrix of U and determine its eigenvalues and eigenvectors
if nargin<4
   [B,L]=eig(cov(Uc));
else
   [B,L]=eigs(cov(Uc),NOE);
end;

% rework matrix L of eigenvectors to vector lab
for k=1:max(size(L))
   lab(k,1)=real(L(k,k));
end

% Determine complex time-dependent principal components
A=Uc*B;

% various relevant measures will now be determined
% spatial phase function teta
%for l=1:max(size(L)) % index for EOF number (or mode number)
%   for j=1:m         % spatial index
%      teta(j,l)=atan(imag(B(j,l))/real(B(j,l)));
%   end
%end

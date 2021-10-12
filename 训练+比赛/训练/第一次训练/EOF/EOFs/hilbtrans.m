function XH=hilbtrans(X)
% function XH=hilbtrans(X)
%
% Hilbert Transform of data in X
% 
% PURPOSE: Return a series that has all periodic terms shifted by 90 degrees. 

    Y=fft(X);  % go to freq. domain. 
    N=size(Y,1);
    N2=floor(N/2)-1; % effect of odd and even # of elements 
    P(1:N2,:)=Y(1:N2,:)*i; % multiplying by I rotates counter c.w. 90 deg. 
    N2=N-N2; 
    P(N2:N,:)=Y(N2:N,:)/i; 
    XH=ifft(P); % go back to time domain 

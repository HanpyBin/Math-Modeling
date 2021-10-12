function [E,V]=PCA(A);

% It is assumed that variables are in columns and that 
% each row is a time step of each varable

echo off
C=cov(A);
[E,V1]=eigs(C,min(size(C)));
V=diag(V1);

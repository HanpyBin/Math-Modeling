function [Angles,Angles2]=EOFssa(A,B);
% This function operates on two orthogonal matrices (each forming a 
% subspace of Rn). First the angle between the first colomn of each matrix
% is determined. Then the angle between the two subspaces spanned by the first
% two columns of each matrix and so on. The purpose is to discover to what extent 
% the EOFs of different cases span the same space.
% The same computations are carried out for indiviual EOFs. By this it is meant 
% that the angle of the two EOFs whith corresonding column numbers in the matrices 
% A and B is computed.
% Author: Martijn Hooimeijer

D1=size(A);
D2=size(B);
if D1(1,1)==D2(1,1)
   n=min(D1(1,2),D2(1,2));
   for i=1:n
      for k=1:i
         X(:,k)=A(:,k);
         Y(:,k)=B(:,k);
      end
      Angles(i,1)=180*subspace(X,Y)/pi;
      Angles2(i,1)=180*subspace(A(:,i),B(:,i))/pi;
   end
   figure,plot(linspace(1,n,n),Angles,'bo-',linspace(1,n,n),Angles2,'r*-'), 
   title('Angles of subspaces for increasing No. of EOFs'), 
   xlabel('No. of EOFs'), ylabel('Angle in degrees'), 
   legend('EOFs combined','EOFs individually',0) ;
else
   error('Row dimensions of the matrices must be the same.')
end
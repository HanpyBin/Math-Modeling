function Angles=EOF_test(A,z);
% This function takes the patterns in matrix A.
% A is a matrix with three dimensions. 
% The first dimension is the number of pattern sets
% The second second is the number of points in each pattern set
% The  third dimension is the patterns number within the patterns set
%
% Angles between all the subspace are compared and stored in a matrix
% called Angles and they are measured in radians.
% z is number of EOFs to take into account.
% Author: Martijn Hooimeijer

   [m,n,o]=size(A);

   o=min(o,z);
	Angles=zeros(m,m);
      
   for i=1:m
      for j=1:m
         if i~=j
            Angles(i,j)=subspace(reshape(A(i,:,1:o),n,o),reshape(A(j,:,1:o),n,o));   
         else
%            Angles(i,i)=NaN;
         end         
      end
   end
   
   
   
%ָ��ͼ��Ԥ�������
close all;clear;clc;
f=imread('../../��1�⸽��/01.tif');
f=im2double(f);
figure,imshow(f)
title('ԭͼ')
%-----------�ָ����-------------------
%ȫ����ֵ�ָ��㷨
T1=graythresh(f);
G=im2bw(f,T1);  %��ֵ��
G=G.*f;
figure,imshow(G); 
title('ȫ����ֵ�ָ�'); %�ֲ���ֵ�ָ�

%����ͼ��
%��ͼ�����0
I=[zeros(size(f,1)+8,4) [zeros(4,size(f,2));f;zeros(4,size(f,2))] zeros(size(f,1)+8,4)];
%�ֿ飬�ֳ�16X16

image1=[];
for m=5:8:256
    image=[];
    for n=5:8:256
        %�ֿ�
          k=0;
%          block=I(m:m+15,n:n+15);
    for i=m:m+7
      for j=n:n+7
         c=I(i,j);
         %��i��ʸ�������ϻҶȺ�ֵ
         s(1)=I(i-4,j)+I(i-2,j)+I(i+2,j)+I(i+4,j);
         s(2)=I(i-4,j+2)+I(i-2,j+1)+I(i+2,j-1)+I(i+4,j-2);
         s(3)=I(i-4,j+4)+I(i-2,j+2)+I(i+2,j-2)+I(i+4,j-4);
         s(4)=I(i-2,j+4)+I(i-1,j+2)+I(i+1,j-2)+I(i+2,j-4);
         s(5)=I(i,j-4)+I(i,j-2)+I(i,j+2)+I(i,j+4);
         s(6)=I(i-2,j-4)+I(i-1,j-2)+I(i+1,j+2)+I(i+2,j+4);
         s(7)=I(i-4,j-4)+I(i-2,j-2)+I(i+2,j+2)+I(i+4,j+4);
         s(8)=I(i-4,j-2)+I(i-2,j-1)+I(i+2,j+1)+I(i+4,j+2);
         %�ж��Ƿ�Ϊǰ���㺯��
        a=4*c+min(s)+max(s);
      
         if a>(3/8)*sum(s)
             k=k+1;
%              image1(i-4,j-4)=I(i,j);
%          else
%              image1(i-4,j-4)=1;
         end    
       end
    end
     if k>20
         block=I(m:m+7,n:n+7);
     else
          block=ones(8,8);
     end
         image=[image block];
    end
   image1=[image1;image];
end
figure,imshow(image1)
title('����ͼ�ָ')

%-------------------ͼ����ǿ-------------------------------

A=[1/9 1/9 1/9;1/9 1/9 1/9;1/9 1/9 1/9];%��ֵ�˲�
B=imfilter(G,A,'replicate');
figure,imshow(B);
title('��ֵ�˲�');



%--------------------Gabor----------------------
[bank] = do_createfilterbank(size(G));
result = do_filterwithbank(G,bank);
A=result. amplitudes;

 for k=1:18
     B=zeros(256,256);
    B=A(:,:,k);
    figure,imshow(mat2gray(B))
 end

% [gabor,sigmax] = gbfilt2(4,3,3,16);%����Gabor�˲�������

% figure,imshow(sigmax);
% title('Gabor�˲����ͼ��')
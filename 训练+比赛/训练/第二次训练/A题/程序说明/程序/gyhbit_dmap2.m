%������ģ�巨��㷽��ͼ B.M.Mehtr��
clear;close all;
fp=imread('finger.tif');  %����ָ��ͼ��
imshow(fp);title('ԭʼָ��ͼ��');               %��ʾָ��ͼ��  
%�����Ƕ�ԭʼָ��ͼ����й�񻯣���񻯺�ĻҶȾ�ֵM0��Ϊ80������Var0Ϊ200
M0=80;  
Var0=200;
[len,wid]=size(fp);
fpn=zeros(len,wid);       %Ϊ��񻯺��ͼ�����ô洢�ռ�
M=mean2(fp);              %��ԭʼָ��ͼ��ҶȾ�ֵ
Var=std2(fp)^2;             %��ԭʼָ��ͼ��Ҷȷ���
%���
fp=double(fp);   %��uint8��ת����double������sqrt�ļ���
for i=1:len
    for j=1:wid
        if fp(i,j)>M
            fpn(i,j)=M0+sqrt( Var0*(fp(i,j)-M)^2/Var );  
        else
            fpn(i,j)=M0-sqrt( Var0*(fp(i,j)-M)^2/Var );
        end
    end
end
fpn=uint8(fpn);
figure,imshow(fpn);title('��񻯺��ָ��ͼ��');  %��ʾ��񻯺��ָ��ͼ��
aver_d=zeros(len,wid);
%����9*9����ģ����Ե���ĸ����ز��ܴ���
for i=5:len-4
    for j=5:wid-4                            
        aver_gray_d1=sum([abs(fp(i,j)-fp(i,j-4)),abs(fp(i,j)-fp(i,j-2)),abs(fp(i,j)-fp(i,j+2)),abs(fp(i,j)-fp(i,j+4))])+0.1;                    %��8�������ϵĻҶȱ仯��
        aver_gray_d2=sum([abs(fp(i,j)-fp(i-2,j-4)),abs(fp(i,j)-fp(i-1,j-2 )),abs(fp(i,j)-fp(i+1,j+2)),abs(fp(i,j)-fp(i+2,j+4))])+0.1;
        aver_gray_d3=sum([abs(fp(i,j)-fp(i-4,j-4)),abs(fp(i,j)-fp(i-2,j-2)),abs(fp(i,j)-fp(i+2,j+2)),abs(fp(i,j)-fp(i+4,j+4))])+0.1;
        aver_gray_d4=sum([abs(fp(i,j)-fp(i-4,j-2)),abs(fp(i,j)-fp(i-2,j-1)),abs(fp(i,j)-fp(i+2,j+1)),abs(fp(i,j)-fp(i+4,j+4))])+0.1;
        aver_gray_d5=sum([abs(fp(i,j)-fp(i-4,j)),abs(fp(i,j)-fp(i-2,j)),abs(fp(i,j)-fp(i+2,j)),abs(fp(i,j)-fp(i+4,j))])+0.1;
        aver_gray_d6=sum([abs(fp(i,j)-fp(i+4,j-2)),abs(fp(i,j)-fp(i+2,j-1)),abs(fp(i,j)-fp(i-2,j+1)),abs(fp(i,j)-fp(i-4,j+2))])+0.1;
        aver_gray_d7=sum([abs(fp(i,j)-fp(i+4,j-4)),abs(fp(i,j)-fp(i+2,j-2)),abs(fp(i,j)-fp(i-2,j+2)),abs(fp(i,j)-fp(i-4,j+4))])+0.1;
        aver_gray_d8=sum([abs(fp(i,j)-fp(i+2,j-4)),abs(fp(i,j)-fp(i+1,j-2)),abs(fp(i,j)-fp(i-2,j+1)),abs(fp(i,j)-fp(i-2,j+4))])+0.1;
        [minaver_d,aver_d(i,j)]=min([aver_gray_d1/aver_gray_d5,aver_gray_d2/aver_gray_d6,aver_gray_d3/aver_gray_d7,aver_gray_d4/aver_gray_d8...
                                aver_gray_d5/aver_gray_d1,aver_gray_d6/aver_gray_d2,aver_gray_d7/aver_gray_d3,aver_gray_d8/aver_gray_d4]);
    end
end
                          

%������ʾ�㷽��ͼ����������ͼ��imshow(bit_dmap,map)
%ȥ����Ե������,�õ��㷽��ͼ�����ݾ���bit_dmap
bit_dmap=imcrop(aver_d,[5 5 247 247]);        %ȥ����Ե��4������  
%����d_map����
map=[1 0 0;          %����1Ϊ��ɫ
     0 1 0;          %����2Ϊ��ɫ
     0 0 1;          %����3Ϊ��ɫ
     1 1 0;          %����4Ϊ��+��=��ɫ
     1 0 1;          %����5Ϊ��+��=���ɫ
     0 1 1;          %����6Ϊ��+��=��ɫ
     1 1 1;          %����7Ϊ��ɫ
     0 0 0];         %����8Ϊ��ɫ
figure,imshow(bit_dmap,map);colorbar;
title('��񻯺�������ģ�巨����ĵ㷽��ͼ');
text(300,80,{'����','����8Ϊ22.5��' ,'����7Ϊ45��','����6Ϊ67.5��','����5Ϊ-90��','����4Ϊ-67.5��','����3Ϊ-45��','����2Ϊ-22.5��','����1Ϊ0��'});


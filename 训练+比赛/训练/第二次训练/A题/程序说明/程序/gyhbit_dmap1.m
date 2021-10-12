%���鷨��㷽��ͼ
clear;close all;
fp=imread('../../../��1�⸽��/02.tif');  %����ָ��ͼ��
imshow(fp);title('ԭʼָ��ͼ��')               %��ʾָ��ͼ��  
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
        aver_gray_d1=sum([fpn(i,j-4),fpn(i,j-2),fpn(i,j+2),fpn(i,j+4)])/4;                    %��8�������ϵĻҶ�ƽ��ֵ��
        aver_gray_d2=sum([fpn(i-2,j-4),fpn(i-1,j-2),fpn(i+1,j+2),fpn(i+2,j+4)])/4;
        aver_gray_d3=sum([fpn(i-4,j-4),fpn(i-2,j-2),fpn(i+2,j+2),fpn(i+4,j+4)])/4;
        aver_gray_d4=sum([fpn(i-4,j-2),fpn(i-2,j-1),fpn(i+2,j+1),fpn(i+4,j+2)])/4;
        aver_gray_d5=sum([fpn(i-4,j),fpn(i-2,j),fpn(i+2,j),fpn(i+4,j)])/4;
        aver_gray_d6=sum([fpn(i+4,j-2),fpn(i+2,j-1),fpn(i-2,j+1),fpn(i-4,j+2)])/4;
        aver_gray_d7=sum([fpn(i+4,j-4),fpn(i+2,j-2),fpn(i-2,j+2),fpn(i-4,j+4)])/4;
        aver_gray_d8=sum([fpn(i+2,j-4),fpn(i+1,j-2),fpn(i-1,j+2),fpn(i-2,j+4)])/4;
        d_diff1=abs(aver_gray_d1-aver_gray_d5);                                    %��������ֱ����ĻҶ�ƽ��ֵ�������ֵ��
        d_diff2=abs(aver_gray_d2-aver_gray_d6);
        d_diff3=abs(aver_gray_d3-aver_gray_d7);
        d_diff4=abs(aver_gray_d4-aver_gray_d8);
        [max_d,max_d_index]=max([d_diff1,d_diff2,d_diff3,d_diff4]);           %ȡ��ֵ����ֵ��������������Ϊ���ܵļ��߷���
        %����max_d_index��max_d_index+4Ϊfp(i,j)���ܵļ��߷���
                                                                                           
        aver_gray_d=...
          [aver_gray_d1,aver_gray_d2,aver_gray_d3,aver_gray_d4,aver_gray_d5,aver_gray_d6,aver_gray_d7,aver_gray_d8];
        %ȡmax_d_index��max_d_index+4���������лҶ�ƽ��ֵ��fp(i,j)�ȽϽӽ��ķ�����Ϊ�㣨i,j���ķ���
            if abs(fpn(i,j)-aver_gray_d(max_d_index))<abs(fpn(i,j)-aver_gray_d(max_d_index+4))
                  aver_d(i,j)=max_d_index;
            else
                  aver_d(i,j)=max_d_index+4;
            end
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
title('��񻯺���鷨�ĵ㷽��ͼ');
text(300,80,{'����9*9ģ�壬����4��','������ֱ�����','�Ҷ�ƽ��ֵ','���õ��ĵ㷽��ͼ',...
   '����','����8Ϊ22.5��' ,'����7Ϊ45��','����6Ϊ67.5��','����5Ϊ-90��','����4Ϊ-67.5��','����3Ϊ-45��','����2Ϊ-22.5��','����1Ϊ0��'});

%�з취��㷽��ͼ
clear;close all;
fp=imread('finger.tif');  %����ָ��ͼ��
imshow(fp);title('ԭʼָ��ͼ��')               %��ʾָ��ͼ��  
fp=double(fp);             %��uint8��ת����double�����ں�������
M0=80;  
Var0=200;
[len,wid]=size(fp);
fpn=zeros(len,wid);       %Ϊ��񻯺��ͼ�����ô洢�ռ�
M=mean2(fp);              %��ԭʼָ��ͼ��ҶȾ�ֵ
Var=std2(fp)^2;             %��ԭʼָ��ͼ��Ҷȷ���
%���
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
        aver_gray_d1=sum([fp(i,j-4),fp(i,j-2),fp(i,j+2),fp(i,j+4)]);                    %��8�������ϵĻҶȺͣ�
        aver_gray_d2=sum([fp(i-2,j-4),fp(i-1,j-2),fp(i+1,j+2),fp(i+2,j+4)]);
        aver_gray_d3=sum([fp(i-4,j-4),fp(i-2,j-2),fp(i+2,j+2),fp(i+4,j+4)]);
        aver_gray_d4=sum([fp(i-4,j-2),fp(i-2,j-1),fp(i+2,j+1),fp(i+4,j+4)]);
        aver_gray_d5=sum([fp(i-4,j),fp(i-2,j),fp(i+2,j),fp(i+4,j)]);
        aver_gray_d6=sum([fp(i+4,j-2),fp(i+2,j-1),fp(i-2,j+1),fp(i-4,j+2)]);
        aver_gray_d7=sum([fp(i+4,j-4),fp(i+2,j-2),fp(i-2,j+2),fp(i-4,j+4)]);
        aver_gray_d8=sum([fp(i+2,j-4),fp(i+1,j-2),fp(i-1,j+2),fp(i-2,j+4)]);
        aver_gray_d=...
          [aver_gray_d1,aver_gray_d2,aver_gray_d3,aver_gray_d4,aver_gray_d5,aver_gray_d6,aver_gray_d7,aver_gray_d8];
        [max_d,max_d_index]=max(aver_gray_d);     %�ҶȺ����ķ���Ϊmax_d_index     
        [min_d,min_d_index]=min(aver_gray_d);     %�ҶȺ���С�ķ���Ϊmin_d_index                           
        %(i,j)�㴦�ķ���һ��ֻ������max_d_index��min_d_index  
        if   (4*fpn(i,j)+max_d+min_d) > 3/8*sum(aver_gray_d)
                  aver_d(i,j)=min_d_index;
        else
                  aver_d(i,j)=max_d_index;
        end
    end
end

%������ʾ�㷽��ͼ����������ͼ��imshow(bit_dmap,map)
%ȥ����Ե������,�õ��㷽��ͼ�����ݾ���bit_dmap
bit_dmap=imcrop(aver_d,[5 5 247 247]);        
%����d_map����
map=[1 0 0;          %����1Ϊ��ɫ
     0 1 0;          %����2Ϊ��ɫ
     0 0 1;          %����3Ϊ��ɫ
     1 1 0;          %����4Ϊ��+��=��ɫ
     1 0 1;          %����5Ϊ��+��=���ɫ
     0 1 1;          %����6Ϊ��+��=��ɫ
     1 1 1;          %����7Ϊ��ɫ
     0 0 0];         %����8Ϊ��ɫ
figure,imshow(bit_dmap,map);title('��񻯺��з취���õ㷽��ͼ');colorbar;
text(300,80,{'����','����8Ϊ22.5��' ,'����7Ϊ45��','����6Ϊ67.5��','����5Ϊ-90��','����4Ϊ-67.5��','����3Ϊ-45��','����2Ϊ-22.5��','����1Ϊ0��'});
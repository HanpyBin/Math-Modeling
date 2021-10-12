%�ɸĽ������õ��ĵ㷽��ͼ�������ֲ�����ͼ
clear;close all;
fp=imread('finger.tif');  %����ָ��ͼ��
imshow(fp);title('ԭʼָ��ͼ��')               %��ʾָ��ͼ�� 
M0=80;  
Var0=200;
[len,wid]=size(fp);
fpn=zeros(len,wid);       %Ϊ��񻯺��ͼ�����ô洢�ռ�
M=mean2(fp);              %��ԭʼָ��ͼ��ҶȾ�ֵ
Var=std2(fp)^2;             %��ԭʼָ��ͼ��Ҷȷ���
%���
fp=double(fp);   %��unit8��ת����double������sqrt�ļ���
for i=1:len
    for j=1:wid
        if fp(i,j)>M
            fpn(i,j)=M0+sqrt( Var0*(fp(i,j)-M)^2/Var );  
        else
            fpn(i,j)=M0-sqrt( Var0*(fp(i,j)-M)^2/Var );
        end
    end
end
fp=uint8(fpn);
figure,imshow(fp);title('��񻯺��ָ��ͼ��');  %��ʾ��񻯺��ָ��ͼ��
block_map=zeros(len,wid);
fp=double(fp);
%����9*9����ģ����Ե���ĸ����ز��ܴ���
for i=5:len-4
    for j=5:wid-4                            
         %��ÿ��������8�������ϵĻҶ�ƽ��ֵ��
        aver_gray_d1=sum( [fp(i,j),fp(i,j-4),fp(i,j-2),fp(i,j+2),fp(i,j+4)] )/5;                   
        aver_gray_d2=sum([fp(i,j),fp(i-2,j-4),fp(i-1,j-2),fp(i+1,j+2),fp(i+2,j+4)])/5;
        aver_gray_d3=sum([fp(i,j),fp(i-4,j-4),fp(i-2,j-2),fp(i+2,j+2),fp(i+4,j+4)])/5;
        aver_gray_d4=sum([fp(i,j),fp(i-4,j-2),fp(i-2,j-1),fp(i+2,j+1),fp(i+4,j+2)])/5;
        aver_gray_d5=sum([fp(i,j),fp(i-4,j),fp(i-2,j),fp(i+2,j),fp(i+4,j)])/5;
        aver_gray_d6=sum([fp(i,j),fp(i+4,j-2),fp(i+2,j-1),fp(i-2,j+1),fp(i-4,j+2)])/5;
        aver_gray_d7=sum([fp(i,j),fp(i+4,j-4),fp(i+2,j-2),fp(i-2,j+2),fp(i-4,j+4)])/5;
        aver_gray_d8=sum([fp(i,j),fp(i+2,j-4),fp(i+1,j-2),fp(i-1,j+2),fp(i-2,j+4)])/5;
         %��ÿ��������8�������ϵķ��
        std_d1=sqrt( sum( [ (aver_gray_d1-fp(i,j-4))^2,(aver_gray_d1-fp(i,j-2))^2,(aver_gray_d1-fp(i,j+2))^2,(aver_gray_d1-fp(i,j+4))^2 ] )/4);
        std_d2=sqrt( sum( [(aver_gray_d2-fp(i-2,j-4))^2,(aver_gray_d2-fp(i-1,j-2))^2,(aver_gray_d2-fp(i+1,j+2))^2,(aver_gray_d2-fp(i+2,j+4))^2] )/4);
        std_d3=sqrt( sum( [(aver_gray_d3-fp(i-4,j-4))^2,(aver_gray_d3-fp(i-2,j-2))^2,(aver_gray_d3-fp(i+2,j+2))^2,(aver_gray_d3-fp(i+4,j+4))^2] )/4);
        std_d4=sqrt( sum( [(aver_gray_d4-fp(i-4,j-2))^2,(aver_gray_d4-fp(i-2,j-1))^2,(aver_gray_d4-fp(i+2,j+1))^2,(aver_gray_d4-fp(i+4,j+2))^2] )/4);
        std_d5=sqrt( sum( [(aver_gray_d5-fp(i-4,j))^2,(aver_gray_d5-fp(i-2,j))^2,(aver_gray_d5-fp(i+2,j))^2,(aver_gray_d5-fp(i+4,j))^2] )/4);
        std_d6=sqrt( sum( [(aver_gray_d6-fp(i+4,j-2))^2,(aver_gray_d6-fp(i+2,j-1))^2,(aver_gray_d6-fp(i-2,j+1))^2,(aver_gray_d6-fp(i-4,j+2))^2] )/4);
        std_d7=sqrt( sum( [(aver_gray_d7-fp(i+4,j-4))^2,(aver_gray_d7-fp(i+2,j-2))^2,(aver_gray_d7-fp(i-2,j+2))^2,(aver_gray_d7-fp(i-4,j+4))^2] )/4);
        std_d8=sqrt( sum( [(aver_gray_d8-fp(i+2,j-4))^2,(aver_gray_d8-fp(i+1,j-2))^2,(aver_gray_d8-fp(i-1,j+2))^2,(aver_gray_d8-fp(i-2,j+4))^2] )/4);
        std_d=...
            [std_d1,std_d2,std_d3,std_d4,std_d5,std_d6,std_d7,std_d8];
        [minstd,minstd_index]=min(std_d);
        block_map(i,j)=minstd_index;
    end
end

%������ʾ�㷽��ͼ����������ͼ��imshow(bit_dmap,map)
%ȥ����Ե������,�õ��㷽��ͼ�����ݾ���bit_dmap
bit_dmap=imcrop(block_map,[5 5 247 247]);        %ȥ����Ե��4������  
%����map����
map=[1 0 0;          %����1Ϊ��ɫ
     0 1 0;          %����2Ϊ��ɫ
     0 0 1;          %����3Ϊ��ɫ
     1 1 0;          %����4Ϊ��+��=��ɫ
     1 0 1;          %����5Ϊ��+��=���ɫ
     0 1 1;          %����6Ϊ��+��=��ɫ
     1 1 1;          %����7Ϊ��ɫ
     0 0 0];         %����8Ϊ��ɫ
figure,imshow(bit_dmap,map);colorbar;
title('�Ľ������õ��ĵ㷽��ͼ');
text(300,80,{'����8Ϊ22.5��' ,'����7Ϊ45��','����6Ϊ67.5��','����5Ϊ-90��','����4Ϊ-67.5��','����3Ϊ-45��','����2Ϊ-22.5��','����1Ϊ0��'});

%����ͨ���㷽��ͼ���������ֲ�����ͼ
%ԭ������ƽ���˲��������Ե㷽��ͼ����ƽ������
cd_dmap=zeros(len,wid);
for  i=5:len-4
  for       j=5:wid-4                    
         blocknum=zeros(8,1);
         for m=-4:4                %ȡ9��9��ģ��
            for n=-4:4
                 
                 switch  block_map(i-m,j-n)  %��ÿС���ڼ��㷽��ֱ��ͼ
                       case 1   
                             blocknum(1)=blocknum(1)+1;           %����1��������Ŀ
                       case 2   
                             blocknum(2)=blocknum(2)+1;
                       case 3   
                             blocknum(3)=blocknum(3)+1;
                       case 4   
                             blocknum(4)=blocknum(4)+1;
                       case 5   
                             blocknum(5)=blocknum(5)+1;
                       case 6   
                             blocknum(6)=blocknum(6)+1;
                       case 7   
                             blocknum(7)=blocknum(7)+1;
                       case 8   
                             blocknum(8)=blocknum(8)+1;
                      end
           end                                                         %ÿ��С��ķ���ȷ��
       end
      [cd_maxd,cd_max_index]=max(blocknum);     %���ķ��򸳸�block_maxd_index���÷����������ĿΪcd_max_index
      cd_dmap(i,j)=cd_max_index;
  end
end
cd_dmap=imcrop(cd_dmap,[5 5 247 247]); 
figure,imshow(cd_dmap,map);colorbar;
title('�����ֲ�����ͼ');
text(300,80,{'����8Ϊ22.5��' ,'����7Ϊ45��','����6Ϊ67.5��','����5Ϊ-90��','����4Ϊ-67.5��','����3Ϊ-45��','����2Ϊ-22.5��','����1Ϊ0��'});

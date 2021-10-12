%��ָ�Ƶ㷽��ͼ���ָ�ƵĿ鷽��ͼ
clear;close all;
fp=imread('../../../��1�⸽��/02.tif');  %����ָ��ͼ��
imshow(fp);title('ԭʼָ��ͼ��')               %��ʾָ��ͼ�� 
[len,wid]=size(fp);
M0=100;  
Var0=200;
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
        aver_gray_d1=sum( [fp(i,j),fp(i,j-4),fp(i,j-2),fp(i,j+2),fp(i,j+4)] )/5;                    %��8�������ϵĻҶ�ƽ��ֵ��
        aver_gray_d2=sum([fp(i,j),fp(i-2,j-4),fp(i-1,j-2),fp(i+1,j+2),fp(i+2,j+4)])/5;
        aver_gray_d3=sum([fp(i,j),fp(i-4,j-4),fp(i-2,j-2),fp(i+2,j+2),fp(i+4,j+4)])/5;
        aver_gray_d4=sum([fp(i,j),fp(i-4,j-2),fp(i-2,j-1),fp(i+2,j+1),fp(i+4,j+2)])/5;
        aver_gray_d5=sum([fp(i,j),fp(i-4,j),fp(i-2,j),fp(i+2,j),fp(i+4,j)])/5;
        aver_gray_d6=sum([fp(i,j),fp(i+4,j-2),fp(i+2,j-1),fp(i-2,j+1),fp(i-4,j+2)])/5;
        aver_gray_d7=sum([fp(i,j),fp(i+4,j-4),fp(i+2,j-2),fp(i-2,j+2),fp(i-4,j+4)])/5;
        aver_gray_d8=sum([fp(i,j),fp(i+2,j-4),fp(i+1,j-2),fp(i-1,j+2),fp(i-2,j+4)])/5;
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
title('�Ľ������õ��ĵ㷽��ͼ');
text(300,80,{'����1Ϊ0��','����2Ϊ-22.5��','����3Ϊ-45��','����4Ϊ-67.5��','����5Ϊ-90��','����6Ϊ67.5��',...
    '����7Ϊ45��','����8Ϊ22.5��'});

%����ͨ���㷽��ͼ���鷽��ͼ
%�ȶ�ԭ���ĵ㷽��ͼ����ƽ��
smoothbit_map=ones(len,wid);
for i=5:len-4
    for j=5:wid-4
           masknum=[block_map(i-1,j-1),block_map(i-1,j),block_map(i-1,j+1),block_map(i,j-1),...
                    block_map(i,j+1),block_map(i+1,j-1),block_map(i+1,j),block_map(i+1,j+1)];     %masknum����(i,j)Ϊ���ĵ�8���ڽ�������
            numd=zeros(8,1);
           for m=1:8
               switch masknum(m)
                   case 1
                       numd(1)=numd(1)+1;                            %8�����з���Ϊ1�����ظ���
                   case 2
                       numd(2)=numd(2)+1;
                   case 3
                       numd(3)=numd(3)+1;
                   case 4
                       numd(4)=numd(4)+1;
                   case 5
                       numd(5)=numd(5)+1;
                   case 6
                       numd(6)=numd(6)+1;    
                   case 7
                       numd(7)=numd(7)+1;
                   case 8
                       numd(8)=numd(8)+1;
               end
           end                                                 %8�����з���Ϊ1�����ظ���
           
           [maxnumd,maxnumd_index]=max(numd);             %8�����з�����Ŀ���ķ���Ϊmaxnumd_index,��ĿΪmaxnumd
           numd(maxnumd_index)=-1;
           [submaxnumd,submaxnumd_index]=max(numd);       %8�����з�����Ŀ�ڶ���ķ���Ϊsubmaxnumd_index,��ĿΪsubmaxnumd 
           if (5<=maxnumd)&(maxnumd<=8)
                smoothbit_map(i,j)=maxnumd_index;
           elseif ( 3<=maxnumd & maxnumd<=5 )&(submaxnumd>=2)&( (maxnumd-submaxnumd)<=2 ) 
                smoothbit_map(i,j)=round( (maxnumd_index+submaxnumd_index)/2 );
           else
                 smoothbit_map(i,j)=block_map(i,j);
           end
    end
end
smoothed_bit_dmap=imcrop(smoothbit_map,[5 5 247 247]); 
figure,imshow(smoothed_bit_dmap,map);colorbar;
title('ƽ����ĵ㷽��ͼ');
text(300,80,{'����1Ϊ0��','����2Ϊ-22.5��','����3Ϊ-45��','����4Ϊ-67.5��','����5Ϊ-90��','����6Ϊ67.5��','����7Ϊ45��','����8Ϊ22.5��'});

block_dmap=ones(256,256);                   %���鷽��ͼ����洢�ռ䣬��ֵΪ1��ȫ��ɫ
for  i=1:32
  for       j=1:32                   %�ֳ�32*32����
      
       x=smoothbit_map([1+(i-1)*8:8+(i-1)*8],[1+(j-1)*8:8+(j-1)*8]);   
       y=block_dmap([1+(i-1)*8:8+(i-1)*8],[1+(j-1)*8:8+(j-1)*8]);      
       y_size=size(y);
       blocknum=zeros(8,1);
       for m=1:8                %ÿ��С����8*8�������
           for n=1:8

                 switch  x(m,n)  %��ÿС���ڼ��㷽��ֱ��ͼ
                       case 1   
                             blocknum(1)=blocknum(1)+1;           
                       case 2   
                             blocknum(2)=blocknum(2)+2;
                       case 3   
                             blocknum(3)=blocknum(3)+3;
                       case 4   
                             blocknum(4)=blocknum(4)+4;
                       case 5   
                             blocknum(5)=blocknum(5)+5;
                       case 6   
                             blocknum(6)=blocknum(6)+6;
                       case 7   
                             blocknum(7)=blocknum(7)+7;
                       case 8   
                             blocknum(8)=blocknum(8)+8;
                 end
           end
       end
         
                totalblock_d=sum(blocknum); 
                averblock_d=round(totalblock_d/64);
         
                %����averblock_d��ֵ���ڸ�С���ڻ��Ƹ÷���
                switch averblock_d
                case 1
                  y(4,[2:7])=0;                 %����1��������Ϊ0��ʱ�����8�е�2-15�е�Ԫ��Ϊ0����ɫ��
                case 2
                  idx=sub2ind(y_size,[  3 4 4 5 5 6  ],[2:7]);
                  y(idx)=0;                 
                case 3
                  idx=sub2ind(y_size,[2:7],[2:7]);
                  y(idx)=0;
                case 4
                  idx=sub2ind(y_size,[2:7],[  3 4 4 5 5 6  ]);
                  y(idx)=0;
                case 5
                  y([2:7],4)=0;
                case 6
                  idx=sub2ind(y_size,[7:-1:2],[   3 4 4 5 5 6 ]);
                  y(idx)=0;
                case 7
                  idx=sub2ind(y_size,[7:-1:2],[7:-1:2]);
                  y(idx)=0;                     
                case 8
                  idx=sub2ind(y_size,[  6 5 5 4 4 3  ],[2:7]);
                  y(idx)=0;
                end
                block_dmap([1+(i-1)*8:8+(i-1)*8],[1+(j-1)*8:8+(j-1)*8])=y;
          end
end
figure;imshow(block_dmap);title('��ָ�Ƶĵ㷽��ͼ��õĿ鷽��ͼ');
fp=double(fp);
rever_block_dmap=1-block_dmap;               %rever_block_dmap�ڵ�Ԫ�ط�0��1
rever_block_dmap=50*rever_block_dmap;       %��rever_block_dmap�ڵĻҶ�ֵ����50���Ա���ʾ���ӵ�ͼ��
addblock_dmap=imadd(fp,rever_block_dmap,'double');
figure;imshow(addblock_dmap,[]); title('ԭָ��ͼ��Ϳ鷽��ͼ�ĵ���ͼ��');     %��ʾԭָ��ͼ��Ϳ鷽��ͼ���ӵ�ͼ��

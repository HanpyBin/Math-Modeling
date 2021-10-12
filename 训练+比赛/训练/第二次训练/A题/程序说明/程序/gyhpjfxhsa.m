%由指纹点方向图求解指纹的块方向图
clear;close all;
fp=imread('../../../第1题附件/02.tif');  %读入指纹图象
imshow(fp);title('原始指纹图象')               %显示指纹图象 
[len,wid]=size(fp);
M0=100;  
Var0=200;
fpn=zeros(len,wid);       %为规格化后的图象设置存储空间
M=mean2(fp);              %求原始指纹图象灰度均值
Var=std2(fp)^2;             %求原始指纹图象灰度方差
%规格化
fp=double(fp);   %将unit8型转换成double，便于sqrt的计算
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
figure,imshow(fp);title('规格化后的指纹图象');  %显示规格化后的指纹图象
block_map=zeros(len,wid);
fp=double(fp);
%利用9*9的掩模，边缘的四个像素不能处理
for i=5:len-4
    for j=5:wid-4                            
        aver_gray_d1=sum( [fp(i,j),fp(i,j-4),fp(i,j-2),fp(i,j+2),fp(i,j+4)] )/5;                    %求8个方向上的灰度平均值；
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
%下面显示点方向图，利用索引图象，imshow(bit_dmap,map)
%去除边缘的像素,得到点方向图的数据矩阵bit_dmap
bit_dmap=imcrop(block_map,[5 5 247 247]);        %去除边缘的4个像素  
%定义d_map函数
map=[1 0 0;          %方向1为红色
     0 1 0;          %方向2为绿色
     0 0 1;          %方向3为蓝色
     1 1 0;          %方向4为红+绿=黄色
     1 0 1;          %方向5为红+蓝=洋红色
     0 1 1;          %方向6为绿+蓝=青色
     1 1 1;          %方向7为白色
     0 0 0];         %方向8为黑色
figure,imshow(bit_dmap,map);colorbar;
title('改进方法得到的点方向图');
text(300,80,{'方向1为0度','方向2为-22.5度','方向3为-45度','方向4为-67.5度','方向5为-90度','方向6为67.5度',...
    '方向7为45度','方向8为22.5度'});

%下面通过点方向图求解块方向图
%先对原来的点方向图进行平滑
smoothbit_map=ones(len,wid);
for i=5:len-4
    for j=5:wid-4
           masknum=[block_map(i-1,j-1),block_map(i-1,j),block_map(i-1,j+1),block_map(i,j-1),...
                    block_map(i,j+1),block_map(i+1,j-1),block_map(i+1,j),block_map(i+1,j+1)];     %masknum是以(i,j)为中心的8个邻近的像素
            numd=zeros(8,1);
           for m=1:8
               switch masknum(m)
                   case 1
                       numd(1)=numd(1)+1;                            %8领域中方向为1的像素个数
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
           end                                                 %8领域中方向为1的像素个数
           
           [maxnumd,maxnumd_index]=max(numd);             %8领域中方向数目最多的方向为maxnumd_index,数目为maxnumd
           numd(maxnumd_index)=-1;
           [submaxnumd,submaxnumd_index]=max(numd);       %8领域中方向数目第二多的方向为submaxnumd_index,数目为submaxnumd 
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
title('平滑后的点方向图');
text(300,80,{'方向1为0度','方向2为-22.5度','方向3为-45度','方向4为-67.5度','方向5为-90度','方向6为67.5度','方向7为45度','方向8为22.5度'});

block_dmap=ones(256,256);                   %给块方向图定义存储空间，初值为1，全白色
for  i=1:32
  for       j=1:32                   %分成32*32个块
      
       x=smoothbit_map([1+(i-1)*8:8+(i-1)*8],[1+(j-1)*8:8+(j-1)*8]);   
       y=block_dmap([1+(i-1)*8:8+(i-1)*8],[1+(j-1)*8:8+(j-1)*8]);      
       y_size=size(y);
       blocknum=zeros(8,1);
       for m=1:8                %每个小块由8*8像素组成
           for n=1:8

                 switch  x(m,n)  %在每小块内计算方向直方图
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
         
                %根据averblock_d的值，在该小块内绘制该方向
                switch averblock_d
                case 1
                  y(4,[2:7])=0;                 %方向1，即方向为0度时，令第8行第2-15列的元素为0（黑色）
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
figure;imshow(block_dmap);title('由指纹的点方向图求得的块方向图');
fp=double(fp);
rever_block_dmap=1-block_dmap;               %rever_block_dmap内的元素非0即1
rever_block_dmap=50*rever_block_dmap;       %将rever_block_dmap内的灰度值乘上50，以便显示叠加的图形
addblock_dmap=imadd(fp,rever_block_dmap,'double');
figure;imshow(addblock_dmap,[]); title('原指纹图象和块方向图的叠加图形');     %显示原指纹图象和块方向图叠加的图形

%根据连续分布方向图求块方向图 利用8*8的窗口
clear;close all;
fp=imread('finger.tif');  %读入指纹图象
imshow(fp);title('原始指纹图象')               %显示指纹图象 
M0=80;  
Var0=200;
[len,wid]=size(fp);
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
         %求每个像素在8个方向上的灰度平均值；
        aver_gray_d1=sum( [fp(i,j),fp(i,j-4),fp(i,j-2),fp(i,j+2),fp(i,j+4)] )/5;                   
        aver_gray_d2=sum([fp(i,j),fp(i-2,j-4),fp(i-1,j-2),fp(i+1,j+2),fp(i+2,j+4)])/5;
        aver_gray_d3=sum([fp(i,j),fp(i-4,j-4),fp(i-2,j-2),fp(i+2,j+2),fp(i+4,j+4)])/5;
        aver_gray_d4=sum([fp(i,j),fp(i-4,j-2),fp(i-2,j-1),fp(i+2,j+1),fp(i+4,j+2)])/5;
        aver_gray_d5=sum([fp(i,j),fp(i-4,j),fp(i-2,j),fp(i+2,j),fp(i+4,j)])/5;
        aver_gray_d6=sum([fp(i,j),fp(i+4,j-2),fp(i+2,j-1),fp(i-2,j+1),fp(i-4,j+2)])/5;
        aver_gray_d7=sum([fp(i,j),fp(i+4,j-4),fp(i+2,j-2),fp(i-2,j+2),fp(i-4,j+4)])/5;
        aver_gray_d8=sum([fp(i,j),fp(i+2,j-4),fp(i+1,j-2),fp(i-1,j+2),fp(i-2,j+4)])/5;
         %求每个像素在8个方向上的方差；
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
%定义map函数
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
text(300,80,{'方向8为22.5度' ,'方向7为45度','方向6为67.5度','方向5为-90度','方向4为-67.5度','方向3为-45度','方向2为-22.5度','方向1为0度'});

%下面通过点方向图求解块连续分布方向图
%原理：采用平滑滤波技术，对点方向图进行平滑处理。
cd_dmap=zeros(len,wid);
for  i=5:len-4
  for       j=5:wid-4                    
         blocknum=zeros(8,1);
         for m=-4:4                %取9×9的模板
            for n=-4:4
                 
                 switch  block_map(i-m,j-n)  %在模板内计算方向直方图
                       case 1   
                             blocknum(1)=blocknum(1)+1;           %方向1的像素数目
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
           end                                                         %模板的最大方向确定
       end
      [cd_maxd,cd_max_index]=max(blocknum);     %最大的方向赋给block_maxd_index，该方向的像素数目为cd_max_index
      cd_dmap(i,j)=cd_max_index;
  end
end
figure,imshow(imcrop(cd_dmap,[5 5 247 247]),map);colorbar;
title('连续分布方向图');
text(300,80,{'方向8为22.5度' ,'方向7为45度','方向6为67.5度','方向5为-90度','方向4为-67.5度','方向3为-45度','方向2为-22.5度','方向1为0度'});



%以下计算块方向图
%先将图象分块，通用做法分成32*32块,每块为8*8
block_dmap=ones(256,256);                   %给块方向图定义存储空间，初值为1，全白色
for  i=1:32
  for       j=1:32                   %分成32*32个块
       x=cd_dmap([1+(i-1)*8:8+(i-1)*8],[1+(j-1)*8:8+(j-1)*8]);  %未做平滑       
       y=block_dmap([1+(i-1)*8:8+(i-1)*8],[1+(j-1)*8:8+(j-1)*8]); %未做平滑 
       y_size=size(y);
       blocknum=zeros(8,1);
       for m=1:8                %每个小块由8*8像素组成
           for n=1:8
                 
                 switch  x(m,n)  %在每小块内计算方向直方图
                       case 1   
                             blocknum(1)=blocknum(1)+1;           %方向1的像素数目
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
           end                                                         %每个小块的方向确定
       end
                [block_maxd,block_maxd_index]=max(blocknum);     %最大的方向赋给block_maxd_index，该方向的像素数目为block_maxd
                %根据block_maxd_index的值，在该小块内绘制该方向
                switch block_maxd_index
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
figure;imshow(block_dmap);title('由指纹连续分布方向图求得的块方向图');
fp=double(fp);
rever_block_dmap=1-block_dmap;               %rever_block_dmap内的元素非0即1
rever_block_dmap=50*rever_block_dmap;       %将rever_block_dmap内的灰度值乘上50，以便显示叠加的图形
addblock_dmap=imadd(fp,rever_block_dmap,'double');
figure;imshow(addblock_dmap,[]); title('原指纹图象和块方向图的叠加图形');     %显示原指纹图象和块方向图叠加的图形
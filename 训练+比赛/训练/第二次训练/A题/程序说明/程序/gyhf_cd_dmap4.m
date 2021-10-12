%由改进方法得到的点方向图求连续分布方向图
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
                 
                 switch  block_map(i-m,j-n)  %在每小块内计算方向直方图
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
      [cd_maxd,cd_max_index]=max(blocknum);     %最大的方向赋给block_maxd_index，该方向的像素数目为cd_max_index
      cd_dmap(i,j)=cd_max_index;
  end
end
cd_dmap=imcrop(cd_dmap,[5 5 247 247]); 
figure,imshow(cd_dmap,map);colorbar;
title('连续分布方向图');
text(300,80,{'方向8为22.5度' ,'方向7为45度','方向6为67.5度','方向5为-90度','方向4为-67.5度','方向3为-45度','方向2为-22.5度','方向1为0度'});

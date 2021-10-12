%切缝法求点方向图
clear;close all;
fp=imread('finger.tif');  %读入指纹图象
imshow(fp);title('原始指纹图象')               %显示指纹图象  
fp=double(fp);             %将uint8型转换成double，便于后续计算
M0=80;  
Var0=200;
[len,wid]=size(fp);
fpn=zeros(len,wid);       %为规格化后的图象设置存储空间
M=mean2(fp);              %求原始指纹图象灰度均值
Var=std2(fp)^2;             %求原始指纹图象灰度方差
%规格化
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
figure,imshow(fpn);title('规格化后的指纹图象');  %显示规格化后的指纹图象
aver_d=zeros(len,wid);
%利用9*9的掩模，边缘的四个像素不能处理
for i=5:len-4
    for j=5:wid-4                            
        aver_gray_d1=sum([fp(i,j-4),fp(i,j-2),fp(i,j+2),fp(i,j+4)]);                    %求8个方向上的灰度和；
        aver_gray_d2=sum([fp(i-2,j-4),fp(i-1,j-2),fp(i+1,j+2),fp(i+2,j+4)]);
        aver_gray_d3=sum([fp(i-4,j-4),fp(i-2,j-2),fp(i+2,j+2),fp(i+4,j+4)]);
        aver_gray_d4=sum([fp(i-4,j-2),fp(i-2,j-1),fp(i+2,j+1),fp(i+4,j+4)]);
        aver_gray_d5=sum([fp(i-4,j),fp(i-2,j),fp(i+2,j),fp(i+4,j)]);
        aver_gray_d6=sum([fp(i+4,j-2),fp(i+2,j-1),fp(i-2,j+1),fp(i-4,j+2)]);
        aver_gray_d7=sum([fp(i+4,j-4),fp(i+2,j-2),fp(i-2,j+2),fp(i-4,j+4)]);
        aver_gray_d8=sum([fp(i+2,j-4),fp(i+1,j-2),fp(i-1,j+2),fp(i-2,j+4)]);
        aver_gray_d=...
          [aver_gray_d1,aver_gray_d2,aver_gray_d3,aver_gray_d4,aver_gray_d5,aver_gray_d6,aver_gray_d7,aver_gray_d8];
        [max_d,max_d_index]=max(aver_gray_d);     %灰度和最大的方向为max_d_index     
        [min_d,min_d_index]=min(aver_gray_d);     %灰度和最小的方向为min_d_index                           
        %(i,j)点处的方向一般只可能是max_d_index或min_d_index  
        if   (4*fpn(i,j)+max_d+min_d) > 3/8*sum(aver_gray_d)
                  aver_d(i,j)=min_d_index;
        else
                  aver_d(i,j)=max_d_index;
        end
    end
end

%下面显示点方向图，利用索引图象，imshow(bit_dmap,map)
%去除边缘的像素,得到点方向图的数据矩阵bit_dmap
bit_dmap=imcrop(aver_d,[5 5 247 247]);        
%定义d_map函数
map=[1 0 0;          %方向1为红色
     0 1 0;          %方向2为绿色
     0 0 1;          %方向3为蓝色
     1 1 0;          %方向4为红+绿=黄色
     1 0 1;          %方向5为红+蓝=洋红色
     0 1 1;          %方向6为绿+蓝=青色
     1 1 1;          %方向7为白色
     0 0 0];         %方向8为黑色
figure,imshow(bit_dmap,map);title('规格化后切缝法所得点方向图');colorbar;
text(300,80,{'其中','方向8为22.5度' ,'方向7为45度','方向6为67.5度','方向5为-90度','方向4为-67.5度','方向3为-45度','方向2为-22.5度','方向1为0度'});
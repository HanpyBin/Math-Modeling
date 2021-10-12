clear;
close all;
sample=imread('02.tif');%读入图片
figure,imshow(sample)

smooth=medfilt2(sample,[3,3]);%利用中值滤波平滑图像
figure,imshow(smooth)

smooth=im2double(smooth);
h=1/7.*[-1 -2 -1;-2 19 -2;-1 -2 -1];%高通滤波模板
% h=[0 -1 0,-1 5 -1,0 -1 0];
% h=[-1 -1 -1,-1 4 -1,-1 -1 -1];
% h=[1 -2 1,-2 5 -2,1 -2 1];
% h=1/2.*[-2 1 -2,1 6 1,-2 1 -2];
sharp=conv2(smooth,h,'same');%通过与模板卷积锐化图像
figure,imshow(sharp)

level=graythresh(sharp);%计算二值化阈值
bw=im2bw(sharp,level);%二值化图像
figure,imshow(bw)

decorated=decorate(bw);%修饰图像
figure,imshow(decorated)

% se=strel('diamond',1);
% eroded=imerode(decorated,se);
% figure,imshow(eroded)
% 
% dilated=imdilate(eroded,se);
% figure,imshow(dilated)

% opened=imopen(decorated,se);
% figure,imshow(opened)

thinned=thin4(decorated);%细化图像
figure,imshow(1-thinned)

minutiae=feat(thinned);%查找特征点：端点和分叉点
figure,imshow(minutiae)
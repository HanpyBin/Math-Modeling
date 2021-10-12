clear;
close all;
sample=imread('02.tif');%����ͼƬ
figure,imshow(sample)

smooth=medfilt2(sample,[3,3]);%������ֵ�˲�ƽ��ͼ��
figure,imshow(smooth)

smooth=im2double(smooth);
h=1/7.*[-1 -2 -1;-2 19 -2;-1 -2 -1];%��ͨ�˲�ģ��
% h=[0 -1 0,-1 5 -1,0 -1 0];
% h=[-1 -1 -1,-1 4 -1,-1 -1 -1];
% h=[1 -2 1,-2 5 -2,1 -2 1];
% h=1/2.*[-2 1 -2,1 6 1,-2 1 -2];
sharp=conv2(smooth,h,'same');%ͨ����ģ������ͼ��
figure,imshow(sharp)

level=graythresh(sharp);%�����ֵ����ֵ
bw=im2bw(sharp,level);%��ֵ��ͼ��
figure,imshow(bw)

decorated=decorate(bw);%����ͼ��
figure,imshow(decorated)

% se=strel('diamond',1);
% eroded=imerode(decorated,se);
% figure,imshow(eroded)
% 
% dilated=imdilate(eroded,se);
% figure,imshow(dilated)

% opened=imopen(decorated,se);
% figure,imshow(opened)

thinned=thin4(decorated);%ϸ��ͼ��
figure,imshow(1-thinned)

minutiae=feat(thinned);%���������㣺�˵�ͷֲ��
figure,imshow(minutiae)
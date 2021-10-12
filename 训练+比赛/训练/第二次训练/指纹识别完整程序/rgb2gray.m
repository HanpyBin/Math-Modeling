function [d]=rgb2gray(e);
a=imread('im2.bmp');
b=double(a);
c=rgb2hsv(b);
d=c(:,:,3);
d=d(1:400,1:400);



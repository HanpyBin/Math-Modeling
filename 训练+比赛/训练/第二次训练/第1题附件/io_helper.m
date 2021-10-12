clear, clc;
f=imread('./11.tif');
thresh = graythresh(f);
f2 = im2bw(f, 0.99);
subplot(1,2,1), imshow(f);
subplot(1,2,2), imshow(f2);
% h1 = fspecial('laplacian', 0);
% g1 = f - imfilter(f, h1);
% h2 = [1,1,1;1,-8,1;1,1,1];
% g2 = f - imfilter(f, h2);
% subplot(1,3,1), imshow(f);
% subplot(1,3,2), imshow(g1);
% subplot(1,3,3), imshow(g2);
% g = medfilt2(f);
% subplot(1,2,1), imshow(f);
% subplot(1,2,2), imshow(g)
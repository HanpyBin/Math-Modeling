
a=imread('1.bmp');
b=imread('4.bmp');
c=rgb2gray(a);
d=rgb2gray(b);
c=double(c);
d=double(d);
%图像的频域增强
[oimg,fimg,bwimg,eimg,c] =  fft_enhance_cubs(c);
[oimg,fimg,bwimg,eimg,d] =  fft_enhance_cubs(d);
figure(3);
subplot(2,2,1);
imshow(a,[]);
subplot(2,2,2);
imshow(c,[]);
subplot(2,2,3);
imshow(b,[]);
subplot(2,2,4);
imshow(d,[]);
%附录二：
%自适应阀值二值化；
figure(4);
c=adapt(c);
d=adapt(d);
subplot(1,2,1);
imshow(c,[]);
subplot(1,2,2);
imshow(d,[]);
%附录三：
%指纹的细化
c=bwmorph(c,'thin','inf');
fun=@minutie;
c = nlfilter(c,[3 3],fun);
figure(1);
imshow(c,[]);
d=bwmorph(d,'thin','inf');
fun=@minutie;
d = nlfilter(d,[3 3],fun);
figure(2);
imshow(d,[]);
%附录四：
%指纹特征的提取;
imtiqu(c,a,'a.mat');
imtiqu(d,b,'b.mat');

%附录五：
Name: a.mat 
Name: b.mat 




figure;
img = I1;
N=8;
img  =  double(img);
y_img=img;
img = pad_image(img,N);
nimg = img;
nimg    =   normalize_image(img,0,100);
%---------------------------------------
%orientation image
%---------------------------------------
oimg            =   blk_orientation_image(img,N);
%---------------------------------------
%smoothen orientation image
%---------------------------------------
oimg            =   smoothen_orientation_field(oimg);
%¨
[x,y]           =   meshgrid(-8:7,-16:15);
[blkht,blkwt]   =   size(oimg);
[ht,wt]         =   size(img);
yidx = 1; %index of the row block
for i = 0:blkht-1
    row     = (i*N+N/2);%+N for the pad
    xidx    = 1; %index of the col block
    for j = 0:blkwt-1
        col = (j*N+N/2);
        %row,col indicate the index of the center pixel
        th  = oimg(yidx,xidx);
        u = x*cos(th)-y*sin(th);
        v = x*sin(th)+y*cos(th);
        u           =   round(u+col); u(u<1)  = 1; u(u>wt) = wt;
        v           =   round(v+row); v(v<1)  = 1; v(v>ht) = ht;
        %find oriented block
        idx         =   sub2ind(size(img),v,u);
        blk         =   img(idx);
        blk         =   reshape(blk,[32,16]);
        %find x signature
        xsig        =   sum(blk,2);
        f(yidx,xidx) = find_peak_distance(xsig);
        xidx = xidx +1;
    end
    yidx = yidx +1;
end
fimg=filter_frequency_image(f);
y = do_gabor_filtering(img,oimg,fimg);     %gobor
% imshow(1-y);
level=graythresh(y);%计算二值化阈值
bw=im2bw(y,level);%二值化图像
%imshow(bw)
%% 图像细化
c=bwmorph(bw,'thin','inf');   %
fun=@minutie;
c = nlfilter(c,[3 3],fun);
imshow(c)
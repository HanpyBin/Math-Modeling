function [iseg, oimg]=bina(img, msk, ord)
% hObject    handle to bina_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
N=16;
msk=pad_image(msk,N);
img  =  double(img);
y_img=img;
img = pad_image(img,N);
[ht,wt]=size(img);
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
y = do_gabor_filtering(img,oimg,fimg);     %gobor§
figure,imshow(y);
saveas(gcf, [num2str(ord),'增强'], 'png')
yi=imscale(y);

yi(msk==0)=1;         % ¨¨°
%     figure(4);imshow(uint8(yi));           %
iseg=adapt(yi);       %
iseg(msk==0)=0;
iseg=1-iseg;
for k=1:3                    % §
    for i=2:ht-1
        for j=2:wt-1
            if iseg(i,j)==1
                sum1=sum(sum(iseg(i-1:i+1,j-1:j+1)));
                if sum1<5
                    iseg(i,j)=0;
                end
            else
                if(((iseg(i,j+1)*iseg(i-1,j+1)*iseg(i-1,j)+iseg(i,j-1)*iseg(i+1,j-1)*iseg(i+1,j))*(iseg(i-1,j)*iseg(i-1,j-1)*iseg(i,j-1)+iseg(i+1,j)*iseg(i+1,j+1)*iseg(i,j+1)))>=1)
                    iseg(i,j)=1;
                end
            end
        end
    end
end
iseg=1-iseg;
% imshow(iseg);
% title('二值化');
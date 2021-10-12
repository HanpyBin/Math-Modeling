function yi=prepro_1(img,msk);
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
%求指纹频率场
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
        end;
        yidx = yidx +1;
    end;
    fimg=filter_frequency_image(f);
    y = do_gabor_filtering(img,oimg,fimg);     %gobor滤波增强图像
   yi=imscale(y);

    yi(msk==0)=1;         % 求取指纹图像前景区域
%     figure(4);imshow(uint8(yi));           %图像增强
%     iseg=adapt(yi);       %二值化图像 
%     iseg(msk==0)=0;
%     iseg=1-iseg;        
%  for k=1:3                    % 二值化滤波
%    for i=2:ht-1
%        for j=2:wt-1
%            if iseg(i,j)==1
%                sum1=sum(sum(iseg(i-1:i+1,j-1:j+1)));
%                if sum1<5
%                    iseg(i,j)=0;
%                end
%            else
%               if(((iseg(i,j+1)*iseg(i-1,j+1)*iseg(i-1,j)+iseg(i,j-1)*iseg(i+1,j-1)*iseg(i+1,j))*(iseg(i-1,j)*iseg(i-1,j-1)*iseg(i,j-1)+iseg(i+1,j)*iseg(i+1,j+1)*iseg(i,j+1)))>=1)
%                    iseg(i,j)=1;
%               end
%            end
%        end
%    end
%   end
% iseg=1-iseg;
% % figure(5), imshow(iseg);                  %二值化
% c=bwmorph(iseg,'thin','inf');   %粗略细化
% fun=@minutie;
% c = nlfilter(c,[3 3],fun);
% % figure(6);imshow(c,[]);                      %细化
% i_thin=c(5:364,1:256); 
% msk=msk(5:364,1:256);  % 恢复原图像大小
% i_thin(i_thin>0)=1;
% image=i_thin;

%normalize image
%the resulting image has know mean and variance
%------------------------------------------------------------------------
% function nimg = normalize_image(img,m0,v0)
%     [ht,wt] =   size(img);
%     %compute mean and variances
%     m       =   mean(img(:));
%     v       =   var(img(:));
%     
%     gmidx   =   find(img > m); %greater than mean
%     lmidx   =   find(img <=m); %lesser than mean
%     
%     nimg(gmidx) = m0 + sqrt((v0*(img(gmidx)-m).^2)/v);
%     nimg(lmidx) = m0 - sqrt((v0*(img(lmidx)-m).^2)/v);
%     nimg        = reshape(nimg,[ht,wt]);
% %end function normalize_img
% 
% %------------------------------------------------------------------------
% %blk_orientation_image
% %derives the dominant orientation in each image block
% %------------------------------------------------------------------------
% function oimg = blk_orientation_image(img,N)
%     g       = complex_gradient(img);
%     gblk    = blkproc(g.^2,[N N],inline('sum(sum(x))'));
%     oimg    = 0.5*angle(gblk)+pi/2;
% %end function blk_orientation_image
% 
% 
% %------------------------------------------------------------------------
% %complex_gradient
% %returs du/dx+i*du/dy
% %------------------------------------------------------------------------
% function g = complex_gradient(img)
%     hy  = fspecial('sobel');
%     hx  = hy';
%     gx  = imfilter(img,hx,'same','symmetric');
%     gy  = imfilter(img,hy,'same','symmetric');
%     g   = gx+i*gy;
% %end function ibm_complex_gradient
% 
% %------------------------------------------------------------------------
% %smoothen_orientation_field
% %------------------------------------------------------------------------
% function oimg = smoothen_orientation_field(oimg)
%     g   =   cos(2*oimg)+i*sin(2*oimg);
%     g   =   imfilter(g,fspecial('gaussian',5));
%     oimg=   0.5*angle(g);
% %end function smoothen_orientation_field
% %blk_frequency_image
% %------------------------------------------------------------------------
% function [u,v] = find_tx_point(x,y,th)
%     u = x*cos(th)-y*sin(th);
%     v = x*sin(th)+y*cos(th);
% %end find_tx_point
% 
% %------------------------------------------------------------------------
% %blk_frequency_image
% %------------------------------------------------------------------------
% function f = find_peak_distance(x)
%     len     =   length(x);
%     p       =   [];
%     x       =   x-mean(x);
%     s       =   abs(fft(x,128));
%     idx     =   find(s == max(s));
%     f       =   128/idx(1);
% %end function 
% 
% %------------------------------------------------------------------------
% %filter_frequency_image
% %------------------------------------------------------------------------
% function f = filter_frequency_image(f)
%     [ht,wt]  = size(f);
%     maxiter  = 20;
%     %pad the image
%     f        = [zeros(ht,3),f,zeros(ht,3)];
%     f        = [zeros(3,wt+6);f;zeros(3,wt+6)];
%     nf       = zeros(size(f)); %new f
%     w        = fspecial('gaussian',7,2);
%     iter     = 1;
%     while(iter < maxiter)
%         for i = 4:ht+3
%             for j = 4:wt+3
%                 blk =   f(i-3:i+3,j-3:j+3);
%                 msk =   (blk>3 & blk<=25);
%                 if(f(i,j)< 3 | f(i,j)>25) %interpolate
%                     nf(i,j) = sum(sum((blk.*w).*msk))/sum(sum(w.*msk));
%                 else
%                     nf(i,j) = f(i,j);
%                 end;    
%             end;
%         end;
%         cnt   = sum(sum(nf(4:ht+3,4:wt+3) < 3 | nf(4:ht+3,4:wt+3) > 25));
%         if(cnt == 0)
%             break;
%         end;
%         iter = iter+1;
%         f    = nf;
%     end;
%     f       = nf(4:ht+3,4:wt+3);
%     f       = imfilter(f,fspecial('gaussian',7,2),'same','replicate');
% %end function filter_frequency_image
% 
% 
% %--------------------------------------------------------------------------
% %do_gabor_filtering
% %the code is a bit convoluted..will put more comments in the next version
% %--------------------------------------------------------------------------
% function y = do_gabor_filtering(img,oimg,fimg)
%     [ht,wt]         =   size(img);
%     [blkht,blkwt]   =   size(oimg);
%     N               =   round(ht/blkht);
%     %---------------------
%     %pad image
%     %---------------------
%     img             =   [zeros(ht,N/2),img,zeros(ht,N/2)];
%     img             =   [zeros(N/2,wt+N);img;zeros(N/2,wt+N)];
%     yidx = 1;
%     for i = 0:blkht-1
%         xidx = 1;
%         row  = N*i+N/2+1; %N/2 due to padding
%         for j = 0:blkwt-1
%             col = N*j+N/2+1;
%             blk  = img(row-N/2:row+N+N/2-1,col-N/2:col+N+N/2-1);
%             if(fimg(yidx,xidx) > 3 & fimg(yidx,xidx)<25)
%                 fblk = directional_filter(blk,oimg(yidx,xidx)+pi/2,fimg(yidx,xidx));
%                 y(row-N/2:row+N/2-1,col-N/2:col+N/2-1) = fblk(N/2:N+N/2-1,N/2:N+N/2-1);
%             else
%                 y(row-N/2:row+N/2-1,col-N/2:col+N/2-1) = 0;
%             end;
%             
%             xidx = xidx + 1;
%         end;
%         yidx = yidx+1;
%     end;
% %end function do_gabor_filtering
% 
% %--------------------------------------------------------------------------
% %directional filter
% %implements convolution in the FFT domain
% %--------------------------------------------------------------------------
% function y = directional_filter(blk,th,f)
%     
%     FFTN    = 32;
%     dbg_show_filter = 0;
%     f1      = fft2(blk,FFTN,FFTN);
%     [gr,gi] = gabor_kernel(5,5,f,th);
%     gr      = gr-mean(gr(:));
%    
%     if(dbg_show_filter)
%         subplot(1,2,1),imagesc(blk),colormap('gray'),axis image;
%         subplot(1,2,2),imagesc(gr),colormap('gray'),axis image;
%         pause;
%     end;
%     f2      = fft2(gr,FFTN,FFTN);
%     f       = ifft2(f1.*f2,32,32);
%     y       = fftshift(real(f(1:32,1:32)));
% %end



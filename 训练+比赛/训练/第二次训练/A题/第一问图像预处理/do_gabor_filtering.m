function y = do_gabor_filtering(img,oimg,fimg)
    [ht,wt]         =   size(img);
    [blkht,blkwt]   =   size(oimg);
    N               =   round(ht/blkht);
    %---------------------
    %pad image
    %---------------------
    img             =   [zeros(ht,N/2),img,zeros(ht,N/2)];
    img             =   [zeros(N/2,wt+N);img;zeros(N/2,wt+N)];
    yidx = 1;
    for i = 0:blkht-1
        xidx = 1;
        row  = N*i+N/2+1; %N/2 due to padding
        for j = 0:blkwt-1
            col = N*j+N/2+1;
            blk  = img(row-N/2:row+N+N/2-1,col-N/2:col+N+N/2-1);
            if(fimg(yidx,xidx) > 3 & fimg(yidx,xidx)<25)
                fblk = directional_filter(blk,oimg(yidx,xidx)+pi/2,fimg(yidx,xidx));
                y(row-N/2:row+N/2-1,col-N/2:col+N/2-1) = fblk(N/2:N+N/2-1,N/2:N+N/2-1);
            else
                y(row-N/2:row+N/2-1,col-N/2:col+N/2-1) = 0;
            end;
            
            xidx = xidx + 1;
        end;
        yidx = yidx+1;
    end;
%end function do_gabor_filtering
function y = directional_filter(blk,th,f)
    
    FFTN    = 32;
    dbg_show_filter = 0;
    f1      = fft2(blk,FFTN,FFTN);
    [gr,gi] = gabor_kernel(5,5,f,th);
    gr      = gr-mean(gr(:));
   
    if(dbg_show_filter)
        subplot(1,2,1),imagesc(blk),colormap('gray'),axis image;
        subplot(1,2,2),imagesc(gr),colormap('gray'),axis image;
        pause;
    end;
    f2      = fft2(gr,FFTN,FFTN);
    f       = ifft2(f1.*f2,32,32);
    y       = fftshift(real(f(1:32,1:32)));
%end
function oimg = blk_orientation_image(img,N)
    g       = complex_gradient(img);
    gblk    = blkproc(g.^2,[N N],inline('sum(sum(x))'));
    oimg    = 0.5*angle(gblk)+pi/2;
%end function blk_orientation_image
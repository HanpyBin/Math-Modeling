function oimg = smoothen_orientation_field(oimg)
    g   =   cos(2*oimg)+i*sin(2*oimg);
    g   =   imfilter(g,fspecial('gaussian',5));
    oimg=   0.5*angle(g);
    save('oimg1.mat','oimg');
%end function smoothen_orientation_field
%blk_frequency_image
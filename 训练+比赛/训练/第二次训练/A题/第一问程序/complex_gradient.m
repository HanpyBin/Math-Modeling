function g = complex_gradient(img)
    hy  = fspecial('sobel');
    hx  = hy';
    gx  = imfilter(img,hx,'same','symmetric');
    gy  = imfilter(img,hy,'same','symmetric');
    g   = gx+i*gy;
%end function ibm_complex_gradient

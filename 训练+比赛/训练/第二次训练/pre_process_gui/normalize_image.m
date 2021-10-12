function nimg = normalize_image(img,m0,v0)
    [ht,wt] =   size(img);
    %compute mean and variances
    m       =   mean(img(:));
    v       =   var(img(:));
    
    gmidx   =   find(img > m); %greater than mean
    lmidx   =   find(img <=m); %lesser than mean
    
    nimg(gmidx) = m0 + sqrt((v0*(img(gmidx)-m).^2)/v);
    nimg(lmidx) = m0 - sqrt((v0*(img(lmidx)-m).^2)/v);
    nimg        = reshape(nimg,[ht,wt]);
%end function normalize_img
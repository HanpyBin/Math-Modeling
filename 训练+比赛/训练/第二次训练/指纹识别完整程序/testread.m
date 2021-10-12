function b = testread(w);

% read the image w
% and cut it to a 200*200 image with 8 bit/pixels

a=imread(w);

a1 = double(a);
[height,width]=size(a1);
centerx=ceil(width/2);
centery=ceil(height/2);
b = a1(centery-99:centery+100,centerx-99:centerx+100);

%imagesc(b);

%colormap(gray);

function result=n_sum(x,y,image);

% image is the source image
% x,y can not be the boundary

s=0;


s= s + image(x,y-1);
s= s + image(x-1,y-1);
s= s + image(x-1,y);
s= s + image(x-1,y+1);
s= s + image(x+1,y-1);
s= s + image(x+1,y);
s= s + image(x+1,y+1);
s= s + image(x,y+1);

result=s;

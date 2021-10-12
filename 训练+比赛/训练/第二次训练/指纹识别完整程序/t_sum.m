function result=t_sum(x,y,image);

%transition sum
% image is the source image
% x, y can't be the boundary

s=0;

s = s + abs( image(x,y-1) - image(x+1,y-1) );
s = s + abs( image(x+1,y-1) - image(x+1,y) );
s = s + abs( image(x+1,y) - image(x+1,y+1) );
s = s + abs( image(x+1,y+1) - image(x,y+1) );
s = s + abs( image(x,y+1) - image(x-1,y+1) );
s = s + abs( image(x-1,y+1) - image(x-1,y) );
s = s + abs( image(x-1,y) - image(x-1,y-1) );
s = s + abs( image(x-1,y-1) - image(x,y-1) );


result = s;





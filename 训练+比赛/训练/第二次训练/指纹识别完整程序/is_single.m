function a = is_single(x,y,image);

'is_single'

% determine whether (x,y) is a single isolated point


s = 0;

s= s + image(x,y-1);
s= s + image(x-1,y-1);
s= s + image(x-1,y);
s= s + image(x-1,y+1);
s= s + image(x+1,y-1);
s= s + image(x+1,y);
s= s + image(x+1,y+1);
s= s + image(x,y+1);

 
if s == 0 

	a = 1;

else
	a = 0;


end;

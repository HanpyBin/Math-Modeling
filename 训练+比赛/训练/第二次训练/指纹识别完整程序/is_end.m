function a = is_end(x,y,image);

% determine whether (x,y) is a end point


s = 0;

s= s + image(x,y-1);
s= s + image(x-1,y-1);
s= s + image(x-1,y);
s= s + image(x-1,y+1);
s= s + image(x+1,y-1);
s= s + image(x+1,y);
s= s + image(x+1,y+1);
s= s + image(x,y+1);

 
if (s == 0 | s==1)

	a = 1;

else
	a = 0;


end;

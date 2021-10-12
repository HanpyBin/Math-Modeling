function a = is_branch(x,y,image);

% determine whether (x,y) is a branch point


s = 0;

s= s + image(x,y-1);
s= s + image(x-1,y-1);
s= s + image(x-1,y);
s= s + image(x-1,y+1);
s= s + image(x+1,y-1);
s= s + image(x+1,y);
s= s + image(x+1,y+1);
s= s + image(x,y+1);

 
if s == 3

	a = 1;

else
	a = 0;


end;

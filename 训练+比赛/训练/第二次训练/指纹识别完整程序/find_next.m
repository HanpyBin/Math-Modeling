function [next_x, next_y ] = find_next(image, path);


% called by go_to_next_element()
% it will track the ridge , and find out the next pixel on the ridge, 
% one condition : the next pixel can not be in the path,
% that means the tracking can not return back


[current, dummy] = size(path);

next_x = 0;
next_y = 0;

x = path( current ,1);
y = path( current ,2);

if current == 1

%only one pixel in the path list
% so, simply track forward


	if image(x,y-1) == 1

		next_x = x;
		next_y = y -1;

	elseif image(x-1,y-1) == 1

		next_x = x-1;
		next_y = y-1;

	elseif image(x-1,y) == 1

		next_x = x-1;
		next_y = y;

	elseif  image(x-1,y+1) == 1

		next_x = x-1;
		next_y = y+1;

	elseif image(x+1,y-1) == 1

		next_x = x+1;
		next_y = y-1;

	elseif image(x+1,y) == 1

		next_x = x+1;
		next_y = y;

	elseif image(x+1,y+1) == 1

		next_x = x+1;
		next_y = y+1;

	elseif image(x,y+1) == 1 

		next_x = x;
		next_y = y+1;

	end;   

else

% more than one pixels in the path
% need to check the back tracking condition

	p_x = path(current-1,1);
	p_y = path(current-1,2);

	if image(x,y-1) == 1 & (~(p_x == x & p_y == y-1))

                next_x = x;
                next_y = y -1;

        end;
	if image(x-1,y-1) == 1 & ~(p_x == x-1 & p_y == y-1)

                next_x = x-1;
                next_y = y-1;
	end;
        if image(x-1,y) == 1 & ~(p_x == x-1 & p_y == y)

                next_x = x-1;
                next_y = y;
	end;
        if  image(x-1,y+1) == 1 & ~(p_x == x-1 & p_y == y+1)

                next_x = x-1;
                next_y = y+1;
	end;
        if image(x+1,y-1) == 1 & ~(p_x == x+1 & p_y == y-1)

                next_x = x+1;
                next_y = y-1;
	end;
        if image(x+1,y) == 1  & ~(p_x == x+1 & p_y == y)

                next_x = x+1;
                next_y = y;  
	end;
        if image(x+1,y+1) == 1 & ~( p_x == x+1 & p_y == y+1)

                next_x = x+1;
                next_y = y+1;
	end;
        if image(x,y+1) == 1 & ~(p_x == x & p_y == y+1)  

                next_x = x;  
                next_y = y+1;

        end;
	

end;


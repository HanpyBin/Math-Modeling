function [path1,path2,path3] = separate( path1 , image )


next_x = zeros(3,1);
next_y = zeros(3.1);

x = path1(1,1);
y = path1(1,2);

%only one pixel in the path list
% so, simply track forward

count = 1;

        if image(x,y-1) == 1

                next_x(count) = x;
                next_y(count) = y -1;
		count = count + 1;
	end;

        if image(x-1,y-1) == 1

                next_x(count) = x-1;
                next_y(count) = y-1;
		count = count + 1;
	end;

        if image(x-1,y) == 1

                next_x(count) = x-1;
                next_y(count) = y;
		count = count + 1;
	end;

        if  image(x-1,y+1) == 1

                next_x(count) = x-1;
                next_y(count) = y+1;
		count = count + 1;
	end;

        if image(x+1,y-1) == 1

                next_x(count) = x+1; 
                next_y(count) = y-1;
		count = count + 1;
	end;

        if image(x+1,y) == 1

                next_x(count) = x+1;
                next_y(count) = y;
		count = count + 1;
	end;

        if image(x+1,y+1) == 1

                next_x(count) = x+1;
                next_y(count) = y+1;
		count = count + 1;
	end;
        
        if image(x,y+1) == 1

                next_x(count) = x;  
                next_y(count) = y+1;
		count = count + 1;

        end;



path1(2,1) = next_x(1);
path1(2,2) = next_y(1);
path2(2,1) = next_x(2);
path2(2,2) = next_y(2);
path3(2,1) = next_x(3);
path3(2,2) = next_y(3);

if count ~= 4

'--------------------------------'

end;

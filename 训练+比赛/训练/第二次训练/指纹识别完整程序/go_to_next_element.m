function out = go_to_next_element(in, path);


% called by end_track()
% with the input image and the path list, it will track to the next 
% connected element of the ridge


[ix,iy] = size(in);
[length, dummy] = size(path);

next_x = 0;
next_y = 0;
flag = 0;

% length is the length of the path


	%simply go to the next element


	if (path(length,1) <4) 

		flag = 1;
		
	end;
	if (path(length,1) > 197) 
		flag =1;
	end;
		
	if (path(length,2) <4) 
		flag = 1;

	end;
			
	if (path(length,2) > 197)
		flag =1;

	end;	
	

	if flag == 0
	[next_x,next_y] = find_next(in,path);

	end;
	
	%add it to the path
	
	path(length+1,1) = next_x;
	path(length+1,2) = next_y;


out = path;

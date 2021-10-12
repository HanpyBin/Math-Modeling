function [out, real_end ] =end_track(in,end_list,branch_list)

% 2/12

% this function will use the input image and the end_list to generate the 
% output image ( cleaned ) and the list of real minutiae ( end points )
% 
% out      ---  output  image
% real_end ---  real minutiae (end points)
% in       ---  input image
% end_list --- the list of valid and invalid end points

real_end = zeros(1,3);
end_count = 0;

'end_track'


out = in;

[number_of_end, dummy] = size(end_list);


for i=1:number_of_end


		%path  is a list of the tracked element in the currently 
		%tracking ridge
		
		path = zeros(1,2);

		path(1,1) = end_list(i,1);
		path(1,2) = end_list(i,2);

		if is_single(path(1,1),path(1,2),out) == 1

		%it is a single point (pore) it should be invalid minutia
		% and will be removed

			out(path(1,1),path(1,2)) = 0;

		else

		% loop for n times , n > max path length value
		

			flag = 0;
		
			for j=1:25	
			
				path = go_to_next_element(in, path);	
				
		   	% check two conditions here
			% if any one of the condition match
			% break the loop

				[len ,ddummy] = size(path); 
				curr_x = path(len,1);
				curr_y = path(len,2);


% three conditions will break the loop.

				if is_a_end_point(curr_x,curr_y,end_list) == 1
	'---> is a end'			
				%need to delete it from output image
				% 		
					flag = 1;	 	
					break;
				
				
				elseif is_a_branch_point(curr_x,curr_y,branch_list) == 1
	'--->is a branch'
				%need to delete it from output image
				%
					flag =1;
					break;

				elseif curr_x == 0 & curr_y == 0

	'---> curr is 0'
					flag = 1;
					break;

				end;

% no break
			j
			end; %end of the 25 loop

			% the path length of the ridge is 
			% longer than 24 pixels
			% it consider as a valid minutia (end points)
			% store it in the real_end		

			if flag == 0

			[ path_length, dddd] = size(path);			

			mean_x = 0;

			mean_y = 0;

			for k = 1:path_length

				mean_x = mean_x + path(k,1);
				mean_y = mean_y + path(k,2);
				
					
			end;
				mean_x = mean_x / path_length;
				mean_y = mean_y / path_length;

				theta = atan2( (mean_x - path(1,1)),(mean_y - path(1,2)) );
							
				end_count = end_count +1;
				real_end(end_count,1) = path(1,1);
				real_end(end_count,2) = path(1,2);

				real_end(end_count,3) = theta;	
					
			end;


		end; %else% 
			
i
	
end;


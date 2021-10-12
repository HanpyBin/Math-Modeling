function [out, real_branch ] =branch_track(in,end_list,branch_list)

% 2/12

% this function will use the input image and the end_list to generate the 
% output image ( cleaned ) and the list of read minutiae ( end points )
% 
% out      ---  output  image
% real_branch ---  real minutiae (branch points)
% in       ---  input image
% branch_list --- the list of valid and invalid branch points

real_branch = zeros(1,3);
branch_count = 0;

'branch_track'


out = in;

[number_of_branch, dummy] = size(branch_list);


for i=1:number_of_branch


		%path  is a list of the tracked element in the currently 
		%tracking ridge
		
		path1 = zeros(1,2);
		path2 = zeros(1,2);
		path3 = zeros(1,2);

		path1(1,1) = branch_list(i,1);
		path1(1,2) = branch_list(i,2);
		path2(1,1) = branch_list(i,1);
		path2(1,2) = branch_list(i,2);
		path3(1,1) = branch_list(i,1);
		path3(1,2) = branch_list(i,2);

		% loop for n times , n > max path length value
		

		flag = 0 ;
		flag1 = 0;
		flag2 = 0;
		flag3 = 0;
			for j=1:25	
				if ( j == 1)
					[path1 , path2 , path3] = separate( path1 ,in);
				else			
					path1 = go_to_next_element(in, path1);	
					path2 = go_to_next_element(in, path2);	
					path3 = go_to_next_element(in, path3);	
				end;

				flag1 = check_condition(path1,end_list , branch_list);
				flag2 = check_condition(path2,end_list , branch_list);
				flag3 = check_condition(path3,end_list , branch_list);

				if flag1 + flag2 + flag3 > 0
					
					flag = 1;break;
				end;
% no break
			j
			end; %end of the 25 loop

			% the path length of the ridge is 
			% longer than 24 pixels
			% it consider as a valid minutia (end points)
			% store it in the real_branch		

			flag

			if flag == 0 
				branch_count = branch_count +1;
				real_branch( branch_count,1 )= path1(1,1);
				real_branch( branch_count,2 )= path1(1,2);
			end;
			
i
	
end;


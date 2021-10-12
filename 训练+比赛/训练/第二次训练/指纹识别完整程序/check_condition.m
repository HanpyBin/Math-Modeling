function flag = check_condition( path , end_list , branch_list )

                        % check two conditions here
                        % if any one of the condition match
                        % break the loop
                
                                [len ,ddummy] = size(path);

                                curr_x = path(len,1);
			
                                curr_y = path(len,2);

                                        
				    flag = 0 ;
        
                                if is_a_branch_point(curr_x,curr_y,branch_list) == 1
%        '---> is a branch'
                                %need to delete it from output image
                                %   
                                        flag = 1;
                                
                                elseif is_a_end_point(curr_x,curr_y,end_list) == 1

%        '--->is a end'
                                %need to delete it from output image
                                %
                                        flag =1;
                                
                                elseif curr_x == 0 & curr_y == 0

%        '---> curr is 0'
                                        flag = 1;

                                end;


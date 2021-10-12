function [end_list,branch_list] = find_list(in);

%return the list of end points and branch points

% end point has only 1 or no neighbour
% branch point has exact 3 neigbours

% use functions is_end  and is_branch 


[w , h] = size(in);

end_list    = zeros(1,2);
branch_list = zeros(1,2);

end_count    = 0;
branch_count = 0;


for i=4:h-3
for j=4:w-3

	if in(i,j) == 1

	if is_end(i,j,in) == 1 
		
		end_count = end_count +1;

		end_list(end_count,1) = i;
		end_list(end_count,2) = j;

	end;

	if is_branch(i,j,in) == 1

		branch_count = branch_count +1;

		branch_list(branch_count,1) = i;	
		branch_list(branch_count,2) = j;

	end;	
	end;

end;
end;

		

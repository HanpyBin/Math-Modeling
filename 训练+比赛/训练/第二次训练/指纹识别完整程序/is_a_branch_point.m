function result = is_a_branch_point(x,y, branch_list);


%check position (x,y) is in the list or not

% return 1 is true , 0 otherwise


[number, dummy] = size(branch_list);

result = 0;

for i = 1:number


	if branch_list(i,1) == x & branch_list(i,2) == y

		result = 1;
		
		break;

	end;


end;

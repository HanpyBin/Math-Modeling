function result = is_a_end_point(x,y, end_list);

%check position (x,y) is in the list or not

% return 1 is true , 0 otherwise


[number, dummy] = size(end_list);

result = 0;

for i = 1:number


	if end_list(i,1) == x & end_list(i,2) == y

		result = 1;
		
		break;

	end;


end;

function point=center(in,real_end)

[num_point,dummy]=size(real_end);
[height,width]=size(in);
center=[ceil(height/2),ceil(width/2)];
min_distance=((real_end(1,1)-center(1))^2+(real_end(1,2)-center(2))^2)^0.5;
point=real_end(1,1:2);
for i=2:num_point
	distance=((real_end(i,1)-center(1))^2+(real_end(i,2)-center(2))^2)^0.5;
	if distance < min_distance
		min_distance=distance;
		point=real_end(i,:);
	
	end;
end;

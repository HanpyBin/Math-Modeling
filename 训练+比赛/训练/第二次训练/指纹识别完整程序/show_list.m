function show_list(list);

%show the image of all points in the list


[x,y] = size(list);

imag = zeros(200,200);

x
for i=1:x

	imag(list(i,1),list(i,2)) = 1;

end;


%figure;
colormap(gray);imagesc(imag);
	

function out_image=rotate(image,theta);

rotate=[cos(theta),sin(theta);-sin(theta),cos(theta)];

[height,width]=size(image);
out_image=zeros(height,width);
center=[ceil(height/2),ceil(width/2)];
newxy=zeros(2,1);
newx=0;newy=0;

for i=1:height
  for j=1:width
	newxy=rotate*[(j-center);(i-center)];
	newx=round(newxy(1,1))+center;newy=round(newxy(2,1))+center;
	newx=newx(1,1);
	newy=newy(1,1);
	if newx>0 & newx <=width & newy>0 & newy<=height	
		out_image(i,j)=image(newy,newx);
		
	end;

  end;
end;






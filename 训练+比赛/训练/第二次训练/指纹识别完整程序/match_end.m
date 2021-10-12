function [out_image2,out_real_end2,percent_match]=match_end(image1,real_end1,image2,real_end2)

center1=center(image1,real_end1);
center2=center(image2,real_end2);

translate=center1(1:2)-center2(1:2);
theta=center2(3)-center1(3)
rotate_matrix=[cos(theta),sin(theta);-sin(theta),cos(theta)];


[height,width]=size(image2);
outimage2=zeros(height,width);

for i=1-translate(1):height-translate(1)
  for j=1-translate(2):width-translate(2)
  	if i>0 & i<=height & j>0 & j<=width
		out_image2(i,j)=image2(i+translate(1),j+translate(2));
		%newxy=rotate*[j;i];
		%out_image2(i,j)=out_image2(newxy(2,1),newxy(1,1));
	end;
  end;
end;

out_image2=rotate(out_image2,-theta);

[num_point2,dum]=size(real_end2);

%centerxy=[ceil(height/2),ceil(width/2)];
centerx=ceil(width/2);
centery=ceil(height/2);
%centerx=center2(2)+translate(2);
%centery=center2(1)+translate(1);
%theta=5*pi/180;
for i=1:num_point2
	out_real_end2(i,1:2)=real_end2(i,1:2)+translate;
   
        newxy=rotate_matrix*[(out_real_end2(i,2)-centerx);(out_real_end2(i,1)-centery)];
        newx=round(newxy(1,1))+centerx;newy=round(newxy(2,1))+centery;
        if newx>0 & newx <=width & newy>0 & newy<=height
                %out_image(i,j)=image1(newy,newx);
                out_real_end2(i,1)=newy;out_real_end2(i,2)=newx;
                out_real_end2(i,3)=real_end2(i,3)-theta;
        end;
end;

[num_point1,dum]=size(real_end1);
xyrange=10; 
num_match=0;
for i=1:num_point1
   for j=1:num_point2
      if abs(real_end1(i,1)-out_real_end2(j,1))<xyrange & abs(real_end1(i,2)-out_real_end2(j,2))<xyrange
         [real_end1(i,:),out_real_end2(j,:)]
         num_match=num_match+1;
         break;
      end;
   end;
end;

percent_match=num_match/num_point1;
text=strcat('The percentage of matched points is  ',num2str(percent_match*100),'%');
msgbox(text);
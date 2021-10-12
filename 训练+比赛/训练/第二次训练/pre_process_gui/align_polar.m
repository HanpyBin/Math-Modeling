function align_end = align_polar(im_mark,x,y,theta);
number=length(im_mark);
    for i=1:number
    align_end(1,i)= sqrt((im_mark(2,i)-x)^2+(im_mark(1,i)-y)^2);
    angle=atan2((im_mark(1,i)-y),(im_mark(2,i)-x));
    if angle<0
        angle=angle+2*pi;
    end
    align_end(2,i)=angle*360/(2*pi);
    angle=abs(im_mark(3,i)-theta);
    if angle>180
       angle=360-angle;
    end
    align_end(3,i)=angle;
    align_end(4,i) = im_mark(4,i);
    end



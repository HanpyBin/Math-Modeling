function angle=get_angle(x0,y0,x1,y1)
angle=atan2(y1-y0,x1-x0);
if (angle<0)
    angle=angle+2*pi;
end

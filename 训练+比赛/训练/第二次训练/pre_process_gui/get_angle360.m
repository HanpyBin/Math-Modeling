function angle=get_angle360(angle1,angle2)
angle=abs(angle1-angle2);
if (angle>180)
    angle=360-angle;
end
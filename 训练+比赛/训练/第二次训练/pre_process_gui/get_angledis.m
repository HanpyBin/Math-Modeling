function angle=get_angledis(anglebeg,angleend)    % 0--360��
angle=anglebeg-angleend;
if angle<0
    angle=angle+360;
end
                
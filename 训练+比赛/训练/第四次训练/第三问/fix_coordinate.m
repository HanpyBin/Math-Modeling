function x = fix_coordinate(x)
global dots
for i = 1:size(x,1)
    if x(i,2) < -4
        x(i,2) = -4;
    end
    if x(i,1) > -1 && x(i,1) < 0 && x(i,2) > 3
        x(i,2) = 3;
    end
    ra = rand;
    if x(i,1) > -3 && x(i,1) < -1 && x(i,2) > 1 && x(i,2) < 3
        if ra < 0.25
            x(i,1)=-3;
        elseif ra >= 0.25 && ra < 0.5
            x(i,1)=-1;
        elseif ra >=0.5 && ra < 0.75
            x(i,2)=1;
        else
            x(i,2)=3;
        end
    end
    if x(i,1) >= 0 && x(i,1) <=5 && x(i,2) > 4
        x(i,2) = 4;
    end
    if rand > 0.5
        x(i,2) = round(x(i,2));
        x1 = floor(x(i,1));
        x2 = ceil(x(i,1));
        y1 = x(i,2);
        y2 = x(i,2);
    else
        x(i,1) = round(x(i,1));
        x1 = x(i,1);
        x2 = x(i,1);
        y1 = floor(x(i,2));
        y2 = ceil(x(i,2));
    end
    % 存在dot1和dot2重合的情况
    dot1 = find(dots(:,1)==x1 & dots(:,2)==y1);
    dot2 = find(dots(:,2)==x2 & dots(:,2)==y2);
    if isempty(dot1) && isempty(dot2)
        ra = rand;
        if ra <0.25
            x(i,1) = x(i,1)+1;
        elseif ra >=0.25 && ra < 0.5
            x(i,1) = x(i,1)-1;
        elseif ra >= 0.5 && ra < 0.75
            x(i,2) = x(i,2)+1;
        else
            x(i,2) = x(i,2)-1;
        end
    elseif isempty(dot1)
        x(i,1) = x2;
        x(i,2) = y2;
    elseif isempty(dot2)
        x(i,1) = x1;
        x(i,2) = y1;
    end
end
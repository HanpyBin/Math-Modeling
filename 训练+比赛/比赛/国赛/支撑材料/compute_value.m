function value = compute_value(location, cur_day, cur_water, cur_food)
global m;
%% 计算终点在该点的效用
M1 = 40; % M1肯定最大嘛
M2 = 9;
b = 3;
c = 0.8; % c＜1
if m(location, 25) + b <= 30 - cur_day && 3*cur_water + 2*cur_food + 3*2*9*(m(location, 25)+2+b) + 2*2*9*(m(location, 25)+1+b) <= 1200
    value1 = M1;
elseif m(location, 25) + b-1 <= 30 - cur_day && 3*cur_water + 2*cur_food + 3*2*9*(m(location, 25)+1+b-1) + 2*2*9*(m(location, 25)+1+b-1) <= 1200
    value1 = M1;
elseif m(location, 25) + b-2 <= 30 - cur_day && 3*cur_water + 2*cur_food + 3*2*9*(m(location, 25)+1+b-2) + 2*2*9*(m(location, 25)+1+b-2) <= 1200
    value1 = M1;
elseif m(location, 25) + b-3 <= 30 - cur_day && 3*cur_water + 2*cur_food + 3*2*9*(m(location, 25)+1+b-3) + 2*2*9*(m(location, 25)+1+b-3) <= 1200
    value1 = M1;
else % 必须要回终点了，效用值骤增
    value1 = 0;
end
%% 计算村庄在该点的效用
if 3*cur_water + 2*cur_food + 3*2*9*(m(location, 14)+1) + 2*2*9*(m(location, 14)+1) <= 1200
    value2 = M2;
else
    value2 = 0;
end

%% 计算矿山在该点的效用
location;
value3 = c^m(location, 18);

value = value1 + value2 + value3;
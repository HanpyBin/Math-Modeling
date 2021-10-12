%计算走该路径需要的时间
function [flag,timing] = computeTime(route, dis, opt)
len = 0;
timing = 0;
for i = 1:length(route)-1
    len = len + dis(route(i), route(i+1));
    if route(i) ~= 20
        timing = timing + 5;
    end
end
timing = timing + len / 50 * 60;
timing = timing / 60;
if opt == 1 && timing <= 4
    flag = 1;
elseif opt == 2 && timing <= 4
    flag = 1;
else
    flag = 0;
end
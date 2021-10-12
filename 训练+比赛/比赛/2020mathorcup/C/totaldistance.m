function [d, finaldot] = totaldistance(route, dis, d1)
d = d1;
for k = 1:length(route) - 1
    i = route(k);
    j = route(k+1);
    d = d + dis(i, j);
end
mini = inf;
for i = 1:13
    if dis(route(end), 3000+i) < mini
        mini = dis(route(end), 3000+i);
        finaldot = 3000+i;
    end
end
d = d + mini;
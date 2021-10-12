function d = totaldistance2(route, dis, startord, endord)
d = 0;
for k = 1:length(route) - 1
    i = route(k);
    j = route(k+1);
    d = d + dis(i, j);
end
d = d + dis(startord, route(1)) + dis(endord, route(end));
function d = totaldistance(route, dis)
d = dis(route(end), route(1));
for k = 1:length(route) - 1
    i = route(k);
    j = route(k+1);
    d = d + dis(i, j);
end
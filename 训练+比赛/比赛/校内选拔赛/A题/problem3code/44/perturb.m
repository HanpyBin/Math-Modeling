function route = perturb(route, method, dis, where20, opt)
%old_route = route;
numbercities = length(route);
i = randsample(numbercities, 1);
j = randsample(numbercities, 1);
switch method
    case 'reverse'
        citymin = min(i, j);
        citymax = max(i, j);
        route(citymin:citymax) = route(citymax:-1:citymin);
    case 'swap'
        route([i, j]) = route([j, i]);
end
%[route_new,route] = completeroute(route,where20);
%[flag, timing] = computeTime(route, dis, opt);
%if flag == 0
%    route_new = old_route;
%end
function route = perturb(route, method)
% ÄæĞò»òÕß½»»»
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
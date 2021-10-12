function [lcost, route] = computeLowCost(route, weight, need, dist)
m = length(route);
c = perms(route);
costs = zeros(1, size(c, 1));
for i = 1:size(c, 1)
    temp_weight = weight;
    costs(i) = costs(i) + 2*temp_weight*dist(20, c(i,1));
    temp_weight = temp_weight - need(c(i,1));
    for j = 1:size(c,2)-1
        costs(i) = costs(i) + 2*temp_weight*dist(c(i,j),c(i,j+1));
        temp_weight = temp_weight - need(c(i,j+1));
    end
    costs(i) = costs(i) + 0.4*dist(20,c(i,end));
end
[lcost, idx] = min(costs);
route = c(idx, :);
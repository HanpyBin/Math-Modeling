Cost = 0;
temp_route = Shortest_Route;
weight = 0;
for kk = length(temp_route):-1:1
    if kk < length(temp_route) && temp_route(kk+1) == 20
        Cost = Cost + 0.4*dist(temp_route(kk),20);
        weight = weight + z(temp_route(kk));
        continue;
    end
    
    if kk == length(temp_route)
        weight = weight + z(temp_route(kk));
        Cost = Cost + 0.4 * dist(temp_route(kk),20);
        continue;
    end
    
    Cost = Cost + 2*weight*dist(temp_route(kk), temp_route(kk+1));
    weight = weight + z(temp_route(kk));
    if temp_route(kk) == 20
        weight = 0;
    end
end
Cost
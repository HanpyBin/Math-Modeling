function [result, resultroute] = simulatedannealing(dist, num, ord, startord, endord)
m = length(num);
temperature = 100;
cooling_rate = 0.94;
index = randperm(m);
route = ord(index);
previous_distance = totaldistance2(route, dist, startord, endord);
% if previous_distance == 0
%     fprintf('111\n');
% end
temperature_iterations = 1;
choices={'reverse', 'swap'};
global_solution = inf;
global_route = route;
cnt = 0;
while 1.0 < temperature
    %fprintf('iteration=%d\n', temperature_iterations);
    choice = randperm(2);
    temp_route = perturb(route, choices{choice(1)});
    current_distance = totaldistance2(temp_route, dist, startord, endord);
    diff = current_distance - previous_distance;
    
    %fprintf('diff=%g, temp=%g, poss=%.3f\n', diff, temperature, exp(-diff/(temperature)));
    %fprintf('current_distance=%d\nold_distance=%d\n', current_distance, previous_distance);
    if (diff < 0) || (rand < exp(-diff/(temperature)))
        cnt = 0;
        %fprintf('updating...\n');
        route = temp_route;
        previous_distance = current_distance;
        temperature_iterations = temperature_iterations + 1;
        %paint(central_points, data1, dot, route);
        %drawnow
    else
        cnt = cnt + 1;
    end
    if cnt > 1000000
        break;
    end
    if previous_distance < global_solution
        global_solution = previous_distance;
        global_route = route;
    end
    if temperature_iterations == 100
        temperature = cooling_rate * temperature;
        temperature_iterations = 0;
    end
    %temperature;
    %diff;
    %previous_distance;
    %route;
end
result = previous_distance;
% if result == 0
%     fprintf('333\n');
% end
resultroute = route;
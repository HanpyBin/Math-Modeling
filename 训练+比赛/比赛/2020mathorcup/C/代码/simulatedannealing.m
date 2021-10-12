function [result, resultroute] = simulatedannealing(dist, num, ord, startord, endord)
m = length(num);
temperature = 100; % 初始温度
cooling_rate = 0.94; % 降温系数
index = randperm(m); % 随机生成初始解
route = ord(index);
previous_distance = totaldistance2(route, dist, startord, endord);
temperature_iterations = 1;
choices={'reverse', 'swap'}; % 两种产生新解的方式
global_solution = inf;
global_route = route;
cnt = 0;
while 1.0 < temperature
    choice = randperm(2);
    temp_route = perturb(route, choices{choice(1)});
    current_distance = totaldistance2(temp_route, dist, startord, endord);
    diff = current_distance - previous_distance;
    
    if (diff < 0) || (rand < exp(-diff/(temperature))) % 接受新解
        cnt = 0;
        route = temp_route;
        previous_distance = current_distance;
        temperature_iterations = temperature_iterations + 1;
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
end
result = previous_distance;
resultroute = route;
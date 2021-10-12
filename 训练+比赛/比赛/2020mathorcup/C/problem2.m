clear all; clc;
tic
dist = xlsread('problem1.xlsx');
central_points = xlsread('central.xlsx');
dist = dist / 1000;
[num, txt] = xlsread('����/����1���ֿ�����.xlsx', '����');
data1 = xlsread('����/����1���ֿ�����.xlsx', '����̨');
data1 = data1(:, 1:2);
task1=find(strcmp(txt, 'T0001'));
ord=zeros(1,task1(end)-1);
for i = 2:task1(end)
    ord(i-1) = (str2num(txt{i, 3}(2:4))-1)*15 + str2num(txt{i, 3}(5:end));
end
num = num(1:task1(end)-1);

temperature = 100;
cooling_rate = 0.94;
index = randperm(23);
route = ord(index);
[previous_distance, dot] = totaldistance(route, dist, dist(3010, route(1)));
temperature_iterations = 1;
cnt = 0;
choices={'reverse', 'swap'};
global_solution = inf;
global_route = route;
cnt = 0;
while 1.0 < temperature
    %fprintf('iteration=%d\n', temperature_iterations);
    choice = randperm(2);
    temp_route = perturb(route, choices{choice(1)});
    [current_distance,dot] = totaldistance(temp_route, dist, dist(3010, route(1)));
    diff = current_distance - previous_distance;
    
    %fprintf('diff=%g, temp=%g, poss=%.3f\n', diff, temperature, exp(-diff/(temperature)));
    %fprintf('current_distance=%d\nold_distance=%d\n', current_distance, previous_distance);
    if (diff < 0) || (rand < exp(-diff/(temperature)))
        cnt = 0;
        %fprintf('updating...\n');
        route = temp_route;
        previous_distance = current_distance;
        temperature_iterations = temperature_iterations + 1;
        paint(central_points, data1, dot, route);
        drawnow
    else
        cnt = cnt + 1;
    end
    %if cnt > 10000
    %    break;
    %end
    if previous_distance < global_solution
        global_solution = previous_distance;
        global_route = route;
    end
    if temperature_iterations == 50
        temperature = cooling_rate * temperature;
        temperature_iterations = 0;
    end
    diff;
    previous_distance;
    route;
end
ordtime = 0;
for i = 1:length(num)
    if num(i) < 3
        ordtime = ordtime + num(i) * 5;
    else
        ordtime = ordtime + num(i) * 4;
    end
end
endtime = previous_distance/1.5 + ordtime + 30;
toc
clear all; clc;
dist = xlsread('problem1.xlsx');
central_points = xlsread('central.xlsx');
dist = dist / 1000; % 将mm转化为m
[num, txt] = xlsread('附件/附件1：仓库数据.xlsx', '任务单');
data1 = xlsread('附件/附件1：仓库数据.xlsx', '复核台');
data1 = data1(:, 1:2); % 复核台的坐标
task1=find(strcmp(txt, 'T0001'));
ord=zeros(1,task1(end)-1); % 订单对应的货格，转化为1-3000
for i = 2:task1(end)
    ord(i-1) = (str2num(txt{i, 3}(2:4))-1)*15 + str2num(txt{i, 3}(5:end));
end
num = num(1:task1(end)-1);

% 进行模拟退火过程
temperature = 100; % 初始温度
cooling_rate = 0.94; % 降温系数
index = randperm(23); % 随机初始化
route = ord(index);
[previous_distance, dot] = totaldistance(route, dist, dist(3010, route(1)));
temperature_iterations = 1;
cnt = 0;
choices={'reverse', 'swap'}; % 两种产生新解的方式
global_solution = inf;
global_route = route;
cnt = 0;
while 1.0 < temperature
    choice = randperm(2);
    temp_route = perturb(route, choices{choice(1)});
    [current_distance,dot] = totaldistance(temp_route, dist, dist(3010, route(1))); % 产生新解
    diff = current_distance - previous_distance;
    
    if (diff < 0) || (rand < exp(-diff/(temperature))) % 接受新解
        cnt = 0;
        route = temp_route;
        previous_distance = current_distance;
        temperature_iterations = temperature_iterations + 1;
        paint(central_points, data1, dot, route); % 可视化处理
        drawnow
    else
        cnt = cnt + 1;
    end
    
    if previous_distance < global_solution
        global_solution = previous_distance;
        global_route = route;
    end
    if temperature_iterations == 50
        temperature = cooling_rate * temperature;
        temperature_iterations = 0;
    end
end
ordtime = 0; % 订单取货总时间
for i = 1:length(num) % 计算订单取货需要总时间
    if num(i) < 3
        ordtime = ordtime + num(i) * 5;
    else
        ordtime = ordtime + num(i) * 4;
    end
end
%endtime = previous_distance/1.5 + ordtime + 30; % 得到结束时间
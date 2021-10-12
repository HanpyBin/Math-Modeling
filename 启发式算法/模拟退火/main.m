clear all; clc;
load data;
% city=struct('lat', {39.54, 31.14, 39.09, 29.32, 45.45, 43.52, 41.5, 40.49, 38.02, 37.52, 36.38, 34.48, 34.16, 36.03, 38.2,...
%     36.38, 43.48,31.51,32.02,30.14,28.11,28.41,30.37,30.39,26.35,26.05,23.08,20.02,22.48,25,29.39,22.18,22.14,25.03},...
%     'long', {116.3,121.29,117.1,106.32,126.41,125.19,123.24,111.5,114.28,112.3,117,113.4,108.54,103.49,106.16,101.45,...
%     87.36,117.18,118.5,120.09,113,115.52,114.21,104.05,106.42,119.2,113.15,110.2,108.2,102.4,90.08,114.1,113.35,121.31});
numberofcities = length(city);
dis = distancematrix(city);
temperature = 1000;
cooling_rate = 0.94;

route = randperm(numberofcities);
previous_distance = totaldistance(route, dis);
temperature_iterations = 1;
cnt = 0;
while 1.0 < temperature
    temp_route = perturb(route, 'reverse');
    cnt = cnt + 1;
    current_distance = totaldistance(temp_route, dis);
    diff = current_distance - previous_distance;
    fprintf('diff=%d\ntemp=%d', diff, temperature);
    if (diff < 0) || (rand < exp(-diff/(temperature)))
        route = temp_route;
        previous_distance = current_distance;
        temperature_iterations = temperature_iterations + 1;
    end
    if temperature_iterations == 100
        temperature = cooling_rate * temperature;
        temperature_iterations = 0;
    end
end
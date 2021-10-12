clear;
global vis;
global temp_route;
global cnt;
global routes;
global temp_cnt;
load('distanceMatrix')
vis = zeros(1, 20);
cnt = 1;
temp_cnt = 1;
temp_route(temp_cnt) = 20;
temp_cnt = temp_cnt + 1;
DFS(20, 0, z);
function DFS(x, weight, need)
global vis;
global temp_route;
global routes;
global cnt;
global temp_cnt;
if weight > 6.0
    routes{cnt} = temp_route;
    cnt = cnt + 1;
    return;
end
for i = 1:20
    if vis(i) == 1
        continue;
    end
    vis(i) = 1;
    temp_route(temp_cnt:end)=[];
    temp_route(temp_cnt) = i;
    temp_cnt = temp_cnt + 1;
    DFS(i, weight + need(i), need);
    temp_cnt = temp_cnt - 1;
    vis(i) = 0;
end
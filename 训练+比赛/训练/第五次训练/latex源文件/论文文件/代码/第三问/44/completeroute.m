%��20��վ����뵽·���У����ز���20��վ��֮���·��
function [route_new,new_route] = completeroute(route, where20)
route_new = route;
cnt1 = 0;
cnt11 = 1;
flag = 0;
for i = 1:length(route)
    if flag == 0 && i == where20(cnt11)
        cnt1 = cnt1 + 1;
        new_route(cnt1)=20;
        cnt1 = cnt1 + 1;
        new_route(cnt1)=route(i);
        cnt11 = cnt11 + 1;
        if cnt11 > length(where20)
            flag = 1;
        end
        continue;
    end
    cnt1 = cnt1 + 1;
    new_route(cnt1) = route(i);
end
route = new_route;
new_route(end+1)=20;
%进行两辆车路径站点之间的片段交换
function route = crossover(route)
old_route = route;
route1 = route{1};
route2 = route{2};
m1 = length(route1);
m2 = length(route2);
array = randperm(m1-1);
s1 = min(array(1),array(2));
e1 = max(array(1),array(2));
array = randperm(m2-1);
s2 = min(array(1),array(2));
e2 = max(array(1),array(2));
cnt1 = 0;
for i = 1:s1-1
    cnt1 = cnt1 + 1;
    newroute1(cnt1) = route1(i);
end
for i = s2:e2
    cnt1 = cnt1 + 1;
    newroute1(cnt1) = route2(i);
end
for i = e1+1:m1
    cnt1 = cnt1 + 1;
    newroute1(cnt1) = route1(i);
end
cnt2 = 0;
for i = 1:s2-1
    cnt2 = cnt2 + 1;
    newroute2(cnt2) = route2(i);
end
for i = s1:e1
    cnt2 = cnt2 + 1;
    newroute2(cnt2) = route1(i);
end
for i = e2+1:m2
    cnt2 = cnt2 + 1;
    newroute2(cnt2) = route2(i);
end
route{1}=newroute1;
route{2}=newroute2;
function [where20, d] = totaldistance(route, dis, need)
route1 = route{1};
route2 = route{2};
route3 = route{3};
len = 0;
c = 0;
weight = 0;
where20{1}(1)=1;
where20{2}(1)=1;
where20{3}(1)=1;
cnt1 = 1;
cnt2 = 1;
cnt3 = 1;
for i = 1:length(route1)
    if i == 1
        len = len + dis(20, route1(1));
        c = c + 2*len*need(route1(1));
        weight = weight + need(route1(1));
        continue;
    end
    if weight + need(route1(i)) > 4
        cnt1 = cnt1 + 1;
        where20{1}(cnt1) = i;
        c = c + 0.2*dis(20, route1(i-1));
        weight = 0;
        len = 0;
        len = len + dis(20,route1(i));
        c = c + 2*len*need(route1(i));
        weight = weight + need(route1(i));
        continue;
    end
    len = len + dis(route1(i-1),route1(i));
    weight = weight + need(route1(i));
    c = c + 2*len*need(route1(i));
end
c = c + 0.2*dis(20, route1(end));
zzz=c;
len = 0;
weight = 0;
for i = 1:length(route2)
    if i == 1
        len = len + dis(20, route2(1));
        c = c + 2*len*need(route2(1));
        weight = weight + need(route2(1));
        continue;
    end
    if weight + need(route2(i)) > 4
        cnt2 = cnt2 + 1;
        where20{2}(cnt2) = i;
        c = c + 0.2*dis(20, route2(i-1));
        weight = 0;
        len = 0;
        len = len + dis(20,route2(i));
        c = c + 2*len*need(route2(i));
        weight = weight + need(route2(i));
        continue;
    end
    len = len + dis(route2(i-1),route2(i));
    weight = weight + need(route2(i));
    c = c + 2*len*need(route2(i));
end
c = c + 0.2*dis(20, route2(end));
for i = 1:length(route3)
    if i == 1
        len = len + dis(20, route3(1));
        c = c + 2*len*need(route3(1));
        weight = weight + need(route3(1));
        continue;
    end
    if weight + need(route3(i)) > 4
        cnt3 = cnt3 + 1;
        where20{3}(cnt3) = i;
        c = c + 0.2*dis(20, route3(i-1));
        weight = 0;
        len = 0;
        len = len + dis(20,route3(i));
        c = c + 2*len*need(route3(i));
        weight = weight + need(route3(i));
        continue;
    end
    len = len + dis(route3(i-1),route3(i));
    weight = weight + need(route3(i));
    c = c + 2*len*need(route3(i));
end
d = c + 0.2*dis(20, route3(end));
%zzz
%d-zzz
function route = crossover(route)
old_route = route;
route1 = route{1};
route2 = route{2};
route3 = route{3};
m1 = length(route1);
m2 = length(route2);
m3 = length(route3);
array = randperm(m1-1);
s(1) = min(array(1),array(2));
e(1) = max(array(1),array(2));
array = randperm(m2-1);
s(2) = min(array(1),array(2));
e(2) = max(array(1),array(2));
array = randperm(m3-1);
s(3) = min(array(1),array(2));
e(3) = max(array(1),array(2));
cnt = zeros(1,3);

ord = randperm(3);

for i = 1:s(1)-1
    cnt(1) = cnt(1) + 1;
    newroute1(cnt(1)) = route{1}(i);
end
for i = s(ord(1)):e(ord(1))
    cnt(1) = cnt(1) + 1;
    newroute1(cnt(1)) = route{ord(1)}(i);
end
for i = e(1)+1:m1
    cnt(1) = cnt(1) + 1;
    newroute1(cnt(1)) = route{1}(i);
end

for i = 1:s(2)-1
    cnt(2) = cnt(2) + 1;
    newroute2(cnt(2)) = route{2}(i);
end
for i = s(ord(2)):e(ord(2))
    cnt(2) = cnt(2) + 1;
    newroute2(cnt(2)) = route{ord(2)}(i);
end
for i = e(2)+1:m2
    cnt(2) = cnt(2) + 1;
    newroute2(cnt(2)) = route{2}(i);
end

for i = 1:s(3)-1
    cnt(3) = cnt(3) + 1;
    newroute3(cnt(3)) = route{3}(i);
end
for i = s(ord(3)):e(ord(3))
    cnt(3) = cnt(3) + 1;
    newroute3(cnt(3)) = route{ord(3)}(i);
end
for i = e(3)+1:m3
    cnt(3) = cnt(3) + 1;
    newroute3(cnt(3)) = route{3}(i);
end

route{1}=newroute1;
route{2}=newroute2;
route{3}=newroute3;
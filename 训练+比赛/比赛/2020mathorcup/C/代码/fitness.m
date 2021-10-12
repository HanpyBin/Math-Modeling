function [endtime, useratio] = fitness(ptasks, checkord, dist, check, ordtime)
% 计算出库时间与复核台利用率
m = length(check);
p = zeros(1, m);
for k = 1:9
    current_time = 0;
    for i = 1:length(ptasks{k})
        t1 = find(check == checkord(k, i+1));
        t2 = find(check == checkord(k, i));
        p(t1) = p(t1) + 1;
        timing(t1, p(t1)) = current_time + ordtime(ptasks{k}(i))+dist(ptasks{k}(i),...
            m*t2+t1-m)/1.5;
        current_time = timing(t1, p(t1));
    end
end
if size(timing, 1) < 5
    for i = 1:5-size(timing, 1)
        timing(size(timing, 1)+i, 1) = 0;
    end
end
for i = 1:m
    timing(i,:) = sort(timing(i,:));
end
st = zeros(1, m);
newtiming = zeros(size(timing));
for i = 1:m
    flag = 0;
    flagg = 0;
    for j = 1:length(timing(i,:))
        if timing(i, j) == 0
            st(i) = st(i) + 1;
            continue;
        end
        flag = 1;
        if flag == 1 && flagg == 0
            newtiming(i, 1) = timing(i, 1);
            flagg = 1;
            continue;
        end
        if timing(i, j) <= newtiming(i, j-1)+30
            newtiming(i, j) = newtiming(i, j-1)+30;
        else
            newtiming(i, j) = timing(i, j);
        end
    end
end
endtime = max(max(newtiming, [], 2));
timenousing = zeros(1, m);
for i = 1:m
    for j = st(i)+1:length(newtiming(i, :))-1
        if newtiming(i, j+1) > newtiming(i,j)+30
            timenousing(i) = timenousing(i) + newtiming(i,j+1)-newtiming(i,j)-30;
        end
    end
    if st(i) + 1 <= length(newtiming(i,:))
        timenousing(i) = timenousing(i) + newtiming(i,st(i)+1);
    end
end
useratio = zeros(size(timenousing));
for i = 1:4
    useratio(i) = 1 - timenousing(i)/(endtime+30);
end
endtime = endtime + 30;
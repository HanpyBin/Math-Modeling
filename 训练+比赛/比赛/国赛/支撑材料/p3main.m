clear, clc;
global m;
m = ones(13, 13);
m = m * 100000;
m(1,[2,4,5]) = 1;
m(2,[1,3,4]) = 1;
m(3,[2,4,8,9]) = 1;
m(4,[1,2,3,7,6,5]) = 1;
m(5, [1,4,6]) = 1;
m(6, [5, 4, 7, 12, 13]) = 1;
m(7, [4, 6, 12, 11]) = 1;
m(8, [3, 9]) = 1;
m(9, [3, 8, 10, 11]) = 1;
m(10, [9, 11, 13]) = 1;
m(11, [7, 12, 13, 10, 9]) = 1;
m(12, [6, 7, 11, 13]) = 1;
m(13, [6, 10, 11, 12]) = 1;
for i = 1:13
    m(i, i) = 0;
end
for k = 1:13
    for i = 1:13
        for j = 1:13
            if m(i,k)+m(k,j) < m(i,j)
                m(i, j) = m(i, k) + m(k, j);
            end
        end
    end
end

%% 开始模拟
water = [3, 5, 4, 9, 10];
food = [2, 10, 4, 9, 10];
% 第0天
result(1, 1) = 1;
result(1, 2) = 10000;
result(1, 3) = 0;
result(1, 4) = 0;

cur_loc = 1;
cur_day = 0;
while true
    cur_day = cur_day + 1;
    if rand > 0.5
        cur_weather = 1;
    else
        cur_weather = 2;
    end
    available_places = find(m(cur_loc, :));
    for k = 1:length(available_places)
        values(k) = compute_value(available_places(k));
        
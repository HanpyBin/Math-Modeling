clear all; clc;
data = xlsread('附件/附件1：仓库数据.xlsx', '货架');
data = data(:, 1:2); % 得到所有货架的坐标
central_points = zeros(3000, 2); % 中转点的坐标
m = 3000;
n = 200;
for i = 1:n
    for j = 1:15
            central_points(15*(i-1)+j, 1) = data(i, 1) - 750*mod(i, 2) + 1550*(1-mod(i, 2));
            central_points(15*(i-1)+j, 2) = data(i, 2) + 400 + 800*(j-1);
    end
end
% turning_points = zeros(2*n, 2); 
% for i = 1:n
%     for j = 1:2
%         turning_points(2*(i-1)+j, 1) = data(i, 1) - 750*mod(i, 2) + 1550*(1-mod(i, 2));
%         turning_points(2*(i-1)+j, 2) = data(i, 2) - mod(j, 2)*750 + (1-mod(j, 2))*(800*15+750);
%     end
% end

% 3000 * 3000的距离矩阵
dist = zeros(3013);
for i = 1:m
    for j = 1:m
        dist(i, j) = 1500 + abs(central_points(i, 1)-central_points(j, 1)) + abs(central_points(i, 2) - central_points(j, 2));
        if (mod(floor((i-1)/30), 4) == mod(floor((j-1)/30), 4) && floor((i-1)/15) ~= floor((j-1)/15))
            index_a = min(mod(i-1, 15) + 1, mod(j-1, 15) + 1);
            index_b = max(mod(i-1, 15) + 1, mod(j-1, 15) + 1);
            dist(i, j) = dist(i, j) + 2*min(1150+(index_a-1)*800, 1150+(15-index_b)*800);
        end
    end
end

% 单独处理13个复核台
data1 = xlsread('附件/附件1：仓库数据.xlsx', '复核台');
data1 = data1(:, 1:2);
p = 13;
for i = 1:p
    for j = 1:m
        dist(m+i, j) = abs(data1(i, 1) + 500 - central_points(j, 1)) + abs(data1(i, 2) + 500 - central_points(j, 2)) + 250;
        dist(j, m+i) = dist(m+i, j);
    end
end
% dist1 = zeros(1, m);
% for j = 1:p
%     for i = 1:m
%         dist1(i) = abs(data1(j, 1) + 500 - central_points(i, 1)) + abs(data1(j, 2) + 500 - central_points(i, 2));
%     end
%     index(j, 3) = min(dist1);
%     [x, y] = find(dist1==index(j, 3));
%     index(j, 3) = index(j, 3) - 500;
%     index(j, 1) = x(1);
%     index(j, 2) = y(1);
% end
% 
% for i = 1:m
%      for j = 1:p
%          dist(i, 3000+j) = abs(central_points(i, 1) - index(j, 1)) + abs(central_points(i, 2) - index(j, 2)) + index(j, 3) + 750;
%          dist(3000+j, i) = dist(i, 3000 + j);
%      end
% end
% 
for i = 1:p
    for j = 1:p
        dist(3000 + i, 3000 + j) = abs(data1(i, 1) - data1(j, 1)) + abs(data1(i, 2) - data1(j, 2));
    end
end
dist = dist-diag(diag(dist));
xlswrite('central.xlsx', central_points);
xlswrite('problem1.xlsx', dist);
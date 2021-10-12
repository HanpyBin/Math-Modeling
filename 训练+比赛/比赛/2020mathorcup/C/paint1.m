data = xlsread('附件/附件1：仓库数据.xlsx', '货格');
x = data(:, 1);
y = data(:, 2);
data1 = xlsread('附件/附件1：仓库数据.xlsx', '复核台');
x1 = data1(:, 1);
y1 = data1(:, 2);
hold on;
for i = 1:30
    rectangle('Position',[x(i),y(i),800,800],'LineWidth',1);
end
% for i = 1:length(x1)
%     plot(x1(i),y1(i),'*');
% end
hold off;
axis equal;
axis off;
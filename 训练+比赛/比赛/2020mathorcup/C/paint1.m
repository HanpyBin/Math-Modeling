data = xlsread('����/����1���ֿ�����.xlsx', '����');
x = data(:, 1);
y = data(:, 2);
data1 = xlsread('����/����1���ֿ�����.xlsx', '����̨');
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
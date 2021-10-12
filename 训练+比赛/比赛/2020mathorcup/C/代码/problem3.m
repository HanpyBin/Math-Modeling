clear all; clc;
dist = xlsread('problem1.xlsx');
dist = dist / 1000;
[num, txt] = xlsread('����/����1���ֿ�����.xlsx', '����');
task{1} = find(strcmp(txt, 'T0002'));
task{2} = find(strcmp(txt, 'T0003'));
task{3} = find(strcmp(txt, 'T0004'));
task{4} = find(strcmp(txt, 'T0005'));
task{5} = find(strcmp(txt, 'T0006'));
for i = 1:5
    for j = 1:task{i}(end)-task{i}(1)+1
        ord{i}(j) = (str2num(txt{task{i}(1)+j-1, 3}(2:4))-1)*15 + str2num(txt{task{i}(1)-1+j, 3}(5:end)); % ��Sxxxxxת��Ϊ1-3000������
    end
end
for i = 1:5
    num1{i} = num(task{i}(1)-1:task{i}(end)-1); % ÿ��������Ӧ������
end
ordtime = zeros(1, 5); % ÿ������ȡ����Ҫ��ʱ��
% ����ÿ��������Ҫ��ʱ��
for i = 1:5
    for j = 1:length(num1{i})
        if num1{i}(j) < 3
            ordtime(i) = ordtime(i) + num1{i}(j)*5;
        else
            ordtime(j) = ordtime(i) + num1{i}(j)*4;
        end
    end
end

dots = [3003, 3011]; % ��Ŀ�涨����������̨
routes = cell(5, 4); % 5�����񣬰���4��·�ߵĻ��񾭹�
for i = 1:5
    for j = 1:2
        for k = 1:2
            [result, route] = simulatedannealing(dist,num1{i},ord{i}, dots(j), dots(k));
            results(i, 2*j+k-2) = result;
            routes{i, 2*j+k-2} = route;
        end
    end
end
results = results';
routes = routes';
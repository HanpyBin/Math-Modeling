clear all; clc;
dist = xlsread('problem1.xlsx');
dist = dist / 1000;
[num, txt] = xlsread('附件/附件1：仓库数据.xlsx', '任务单');
task{1} = find(strcmp(txt, 'T0002'));
task{2} = find(strcmp(txt, 'T0003'));
task{3} = find(strcmp(txt, 'T0004'));
task{4} = find(strcmp(txt, 'T0005'));
task{5} = find(strcmp(txt, 'T0006'));
for i = 1:5
    for j = 1:task{i}(end)-task{i}(1)+1
        ord{i}(j) = (str2num(txt{task{i}(1)+j-1, 3}(2:4))-1)*15 + str2num(txt{task{i}(1)-1+j, 3}(5:end)); % 将Sxxxxx转化为1-3000的数字
    end
end
for i = 1:5
    num1{i} = num(task{i}(1)-1:task{i}(end)-1); % 每个订单对应的数量
end
ordtime = zeros(1, 5);
for i = 1:5
    for j = 1:length(num1{i})
        if num1{i}(j) < 3
            ordtime(i) = ordtime(i) + num1{i}(j)*5;
        else
            ordtime(j) = ordtime(i) + num1{i}(j)*4;
        end
    end
end
dots = [3003, 3011];
routes = cell(5, 4);
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
% xlswrite('problem3_results.xlsx', results);
% fid = fopen('problem3_routes.txt','w');
% for i = 1:4
%     for j = 1:5
%         for k = 1:length(routes{i, j})
%             fprintf(fid, '%d ', routes{i, j}(k));
%         end
%         fprintf(fid, '\n');
%     end
% end
x = zeros(4, 5);
%%%%%%%%%%%%%%%%%% 将lingo求解的x输入进来
endtime = problem3compute(results,x,ordtime);
% 手算利用率即可
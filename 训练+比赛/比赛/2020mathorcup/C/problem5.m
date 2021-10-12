clear all; clc;
dist = xlsread('problem1.xlsx');
dist = dist / 1000;
[num, txt] = xlsread('附件/附件1：仓库数据.xlsx', '任务单');
T = 'T00';
for i = 1:49
    if i < 10
        TT = [T, '0', num2str(i)];
    else
        TT = [T, num2str(i)];
    end
    task{i} = find(strcmp(txt,TT));
end
for i = 1:49
    for j = 1:task{i}(end)-task{i}(1)+1
        ord{i}(j) = (str2num(txt{task{i}(1)+j-1, 3}(2:4))-1)*15 + str2num(txt{task{i}(1)-1+j, 3}(5:end)); % 将Sxxxxx转化为1-3000的数字
    end
end
for i = 1:49
    num1{i} = num(task{i}(1)-1:task{i}(end)-1); % 每个订单对应的数量
end
restdots = [3002, 3004, 3005, 3006, 3007, 3008, 3009, 3011, 3013];
dots = [3001, 3003, 3010, 3012, 0];
routes = cell(49, 16); % 每个长订单中4*4种走法的小订单顺序
for u = 1:length(restdots)
    dots(5) = restdots(u);
    for i = 1:49
        for j = 1:5
            for k = 1:5
                [result, route] = simulatedannealing(dist,num1{i},ord{i}, dots(j), dots(k));
                results(i, 5*j+k-5) = result;
                routes{i, 5*j+k-5} = route;
            end
        end
    end
%xlswrite('problem5_results.xlsx', results);

% fid1 = fopen('problem4_results.txt','w');
% for i = 1:49
%     for j = 1:16
%         fprintf(fid1, '%.2f ', results(i, j));
%     end
%     fprintf(fid1,'\n');
% end
    for i = 1:49
        if num1{i}(1) < 3
            ordtime(i) = num1{i}(1) * 5;
        else
            ordtime(i) = num1{i}(1) * 4;
        end
        for j = 1:length(ord{i})-1
            if num1{i}(j+1) < 3
                ordtime(i) = ordtime(i) + num1{i}(j+1) * 5;
            else
                ordtime(i) = ordtime(i) + num1{i}(j+1) * 4;
            end
        end
    end
    ptasks = cell(1, 9);
    ptasksnum = [6,6,6,6,5,5,5,5,5];
    ords = randperm(49);
    cnt = 0;
    for i = 1:length(ptasksnum)
        taskord = [];
        for j = 1:ptasksnum(i)
            cnt = cnt + 1;
            taskord(j) = ords(cnt);
        end
        ptasks{i} = taskord;
    end
    checkord = zeros(9,10);
    for i=1:9
        checkord(i, :) = dots(round(rand(1, 10)*4)+1);
    end
    [joborder, checkord, endtime, ratio] = simulatedannealing4(ptasks,checkord,dots,results,ordtime);
    endtimes(u) = endtime;
end

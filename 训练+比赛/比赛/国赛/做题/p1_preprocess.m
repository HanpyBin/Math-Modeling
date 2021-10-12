clear, clc;
final_moneys = zeros(1,2000000);
for xxx = 1:1000000
    %% problem statement
    m = zeros(27, 27);
    m(1,2) = 1;
    m(1,25) = 1;
    m(2,1) = 1;
    m(2,3) = 1;
    m(3,2) = 1;
    m(3,4) = 1;
    m(3,25) = 1;
    m(4,[3,5,24,25]) = 1;
    m(5,[4,6,24]) = 1;
    m(6,[5,7,23,24]) = 1;
    m(7,[6,8,22]) = 1;
    m(8,[7,9,22]) = 1;
    m(9,[8,10,15,16,17,21,22]) = 1;
    m(10, [9,11,13,15]) = 1;
    m(11, [10,12,13]) = 1;
    m(12, [11, 13, 14]) = 1;
    m(13, [10,11,12,14,15]) = 1;
    m(14, [12,13,15,16]) = 1;
    m(15, [9, 10, 13, 14, 16]) = 1;
    m(16, [9, 14, 15, 17, 18]) = 1;
    m(17, [9, 16, 18, 21]) = 1;
    m(18, [16, 17, 19, 20]) = 1;
    m(19, [18, 20]) = 1;
    m(20, [18, 19, 21]) = 1;
    m(21, [20, 17, 9, 22, 23, 27]) = 1;
    m(22, [23, 7, 8, 9, 21]) = 1;
    m(23, [26, 21, 22, 6, 24]) = 1;
    m(24, [4, 5, 6, 23, 25, 26]) = 1;
    m(25, [1,3,4,24,26]) = 1;
    m(26, [25,24,23,27]) = 1;
    m(27, [26, 21]) = 1;
    
    results = zeros(31, 4);
    
    
    max_weight = 1200;
    deadline = 30;
    init_money = 10000;
    init_salary = 1000;
    max_water = 400;
    max_food = 600;
    water = [3,5,5,8,10];
    food = [2,10,7,6,10];
    days = [2,2,1,3,1,2,3,1,2,2,3,2,1,2,2,2,3,3,2,2,1,1,2,1,3,2,1,1,2,2];
    places = [25,24,23,23,22,9,9,15]; % 在这里我们可以给出到达村庄的最短路
    % 初始购置物资
    flag = 0;
    while flag == 0
        init_water = round(rand*max_water);
        init_food = round(rand*max_food);
        if init_water*water(1) + init_food*food(1) <= max_weight && init_water*water(2) + init_food*food(2) <= init_money
            flag = 1;
            init_money = init_money - init_water*water(2) - init_food*food(2);
        end
    end
    
    cur_water = init_water;
    cur_food = init_food;
    cur_money = init_money;
    cur_weight = init_water*water(1) + init_food*food(1);
    cur_loc = 1;
    
    results(1,1) = 1;
    results(1,2) = cur_money;
    results(1,3) = cur_water;
    results(1,4) = cur_food;
    
    for i = 1:length(places)
        cur_loc = places(i);
        if days(i) ~= 3
            cur_food = cur_food - 2*food(days(i)+2);
            cur_water = cur_water - 2*water(days(i)+2);
            cur_weight = cur_food + cur_water;
        else
            cur_food = cur_food - food(days(i)+2);
            cur_water = cur_water - water(days(i)+2);
            cur_weight = cur_food + cur_water;
        end
        results(i+1,1) = cur_loc;
        results(i+1,2) = cur_money;
        results(i+1,3) = cur_water;
        results(i+1,4) = cur_food;
    end
    % 此时已经到达村庄，随机购置物资
    flag = 0;
    while flag == 0
        buy_water = round(rand*(max_weight-cur_weight)/water(1));
        buy_food = round(rand*(max_weight-cur_weight)/food(1));
        if buy_water*water(1) + buy_food*food(1) <= max_weight - cur_weight && 2*buy_water*water(2) + 2*buy_food*food(2) <= cur_money
            flag = 1;
            cur_money = cur_money - 2*buy_water*water(2) - 2*buy_food*food(2);
            cur_water = cur_water + buy_water;
            cur_food = cur_food + buy_food;
            cur_weight = cur_food + cur_water;
        end
    end
    results(i+1,1) = cur_loc;
    results(i+1,2) = cur_money;
    results(i+1,3) = cur_water;
    results(i+1,4) = cur_food;
    % 开始随机模拟
    cur_day = length(places);
    while true
        cur_day = cur_day + 1;
        % 首先判断天气
        if days(cur_day) == 3 % 沙暴天气
            cur_loc = cur_loc;
            % 确定当前地点 只有村庄和矿山两种可能
            if cur_loc == 15 % 如果是村庄，在这里对于沙暴天气而言，我们前一天已经在村庄补给过，则这次不购买
                % 只吃东西
                cur_food = cur_food - food(days(cur_day)+2);
                cur_water = cur_water - water(days(cur_day)+2);
                cur_weight = cur_food + cur_water;
            elseif cur_loc == 12 % 如果是矿山
                % 判断是否要挖矿
                if rand > 0.1 % 如果挖矿，加钱
                    cur_food = cur_food - 3*food(days(cur_day)+2);
                    cur_water = cur_water - 3*water(days(cur_day)+2);
                    cur_weight = cur_food + cur_water;
                    cur_money = cur_money + init_salary;
                else % 不挖矿
                    cur_food = cur_food - food(days(cur_day)+2);
                    cur_water = cur_water - water(days(cur_day)+2);
                    cur_weight = cur_food + cur_water;
                end
            else % 既不是矿山也不是村庄
                cur_food = cur_food - food(days(cur_day)+2);
                cur_water = cur_water - water(days(cur_day)+2);
                cur_weight = cur_food + cur_water;
            end
        else % 不是沙暴天气
            % 判断位置
            if cur_loc ~= 12 % 如果不在矿山
                available_places = find(m(cur_loc,:) == 1);
                places_ongoing = randperm(length(available_places));
                places_ongoing = available_places(places_ongoing(1)); % 选出下一个要去的地点
                cur_loc = places_ongoing; % 移动 todo:如果是特殊地点，需要判断是否要触发事件
                cur_food = cur_food - 2*food(days(cur_day)+2);
                cur_water = cur_water - 2*water(days(cur_day)+2);
                cur_weight = cur_food + cur_water;
                % 如果当前地点是村庄，购置食物
                if cur_loc == 15
                    flag = 0;
                    cnt = 0;
                    while flag == 0
                        buy_water = round(rand*(max_weight-cur_weight)/water(1));
                        buy_food = round(rand*(max_weight-cur_weight)/food(1));
                        if buy_water*water(1) + buy_food*food(1) <= max_weight - cur_weight && 2*buy_water*water(2) + 2*buy_food*food(2) <= cur_money
                            flag = 1;
                            cur_money = cur_money - 2*buy_water*water(2) - 2*buy_food*food(2);
                            cur_water = cur_water + buy_water;
                            cur_food = cur_food + buy_food;
                            cur_weight = cur_food + cur_water;
                        end
                        cnt = cnt + 1;
                        if cnt == 1000 % 如果随机了1000次还是没有买到东西，就不买东西
                            break;
                        end
                    end
                end
            elseif cur_loc == 12 % 如果在矿山
                % 判断是否要挖矿，如果挖矿?就不移动
                if rand > 0.1
                    cur_loc = cur_loc;
                    cur_food = cur_food - 3*food(days(cur_day)+2);
                    cur_water = cur_water - 3*water(days(cur_day)+2);
                    cur_weight = cur_food + cur_water;
                    cur_money = cur_money + init_salary;
                else % 不挖矿选择移动
                    available_places = find(m(cur_loc,:) == 1);
                    places_ongoing = randperm(length(available_places));
                    places_ongoing = available_places(places_ongoing(1)); % 选出下一个要去的地点
                    cur_loc = places_ongoing; % 移动 todo:如果是特殊地点，需要判断是否要触发事件
                    cur_food = cur_food - 2*food(days(cur_day)+2);
                    cur_water = cur_water - 2*water(days(cur_day)+2);
                    cur_weight = cur_food + cur_water;
                    % 如果当前地点是村庄，购置食物
                    if cur_loc == 15
                        flag = 0;
                        cnt = 0;
                        while flag == 0
                            buy_water = round(rand*(max_weight-cur_weight)/water(1));
                            buy_food = round(rand*(max_weight-cur_weight)/food(1));
                            if buy_water*water(1) + buy_food*food(1) <= max_weight - cur_weight && 2*buy_water*water(2) + 2*buy_food*food(2) <= cur_money
                                flag = 1;
                                cur_money = cur_money - 2*buy_water*water(2) - 2*buy_food*food(2);
                                cur_water = cur_water + buy_water;
                                cur_food = cur_food + buy_food;
                                cur_weight = cur_food + cur_water;
                            end
                            cnt = cnt + 1;
                            if cnt == 1000 % 如果随机了1000次还是没有买到东西，就不买东西
                                break;
                            end
                        end
                    end
                end
            end
        end
        results(cur_day+1,1) = cur_loc;
        results(cur_day+1,2) = cur_money;
        results(cur_day+1,3) = cur_water;
        results(cur_day+1,4) = cur_food;
        % 判断生死状态或者是否到达终点
        % 判断食物状况
        if cur_water <= 0 || cur_food <= 0
            status = 0; % 人死亡，游戏重新开始
            break;
        end
        % 判断天数
        if cur_day == 30 && cur_loc ~= 27
            status = 0;
            break;
        end
        % 如果到达了终点
        if cur_loc == 27
            status = 1; % 游戏胜利，开始计算金钱
            final_money = cur_money + water(2)*cur_water + food(2)*cur_food;
            results(cur_day+1,1) = cur_loc;
            results(cur_day+1,2) = final_money;
            results(cur_day+1,3) = cur_water;
            results(cur_day+1,4) = cur_food;
            break;
        end
    end
    if status == 1
        
        if final_money >= max(final_moneys)
            final_results = results;
        end
        final_moneys(xxx) = final_money;
    else
        final_moneys(xxx) = 0;
    end
end
max(final_moneys)























%% 关卡2
% m = zeros(64, 64);
% m(1,[2,9]) = 1;
% for i = 2:7
%     m(i,[i-1,i+1,i+7, i+8]) = 1;
% end
% m(8,[7, 15, 16]) = 1;
% for i = 9:16:41
%     m(i,[i-8,i-7,i+1,i+8,i+9]) = 1;
% end
% for i = 17:16:49
%     m(i,[i-8,i+1,i+8]) = 1;
% end
% m(57, [49, 50, 58]) = 1;
% for i = 16:16:48
%     m(i, [i-8,i-1,i+8]) = 1;
% end
% for i = 24:16:56
%     m(i, [i-9,i-8,i-1,i+7,i+8])=1;
% end
% m(64, [56, 63]) = 1;
% for i = 1:2:5
%     for j = 1:6
%         m(2+i*8+j-1,[2+8*i-7+j-1,2+8*i-8+j-1,2+8*i-1+j-1,2+8*i+1+j-1,2+8*i+8+j-1,2+8*i+9+j-1]) = 1;
%     end
% end
% for i = 2:2:6
%     for j = 1:6
%         m(2+i*8+j-1,[2+8*i-9+j-1,2+8*i-8+j-1,2+8*i-1+j-1,2+8*i+1+j-1,2+8*i+8+j-1,2+8*i+7+j-1]) = 1;
%     end
% end
% m1 = m';
% m = m + m1;
% for i = 1:64
%     for j = 1:64
%         if m(i,j) ~= 0
%             m(i,j) = 1;
%         end
%     end
% end
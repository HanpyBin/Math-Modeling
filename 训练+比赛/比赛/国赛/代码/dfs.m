function dfs(cur_day, cur_loc, result, flag)
cur_day;
cur_loc;
global final_results
global max_money
%global check;
% flag表示是否是第一次来商店
water = [3,5,5,8,10];
food = [2,10,7,6,10];

days = [2,2,1,3,1,2,3,1,2,2,3,2,1,2,2,2,3,3,2,2,1,1,2,1,3,2,1,1,2,2];

route{1}=[25,24,23,22,9,15]; % 起点到村庄
route{2}=[14,12]; % 村庄到矿山
route{3}=[14,15]; % 矿山到村庄
%route{4}=[25,26,27]; % 起点到终点
route{5}=[25,24,23,22, 9,15,14,12]; % 起点到矿山
route{6}=[9,21,27]; % 村庄到终点
route{7}=[14,15,9,21,27]; % 矿山到终点
route{8}=[12]; % 矿山到矿山
route{9}=[12]; % 矿山到矿山，但是我休息
% 1为起点，15为村庄，12为矿山，27为终点

if cur_loc == 1
    to = [1,5];
    for i = 1:2
        new_result = result;
        new_day = cur_day;
        temp_route = route{to(i)};
        cnt = 1;
        while cnt <= length(route{to(i)})
            new_day = new_day + 1;
            if new_day > 30 % 超出30天
                status = 0;
                return;
            end
            if days(new_day) ~= 3 % 不是沙暴天气
                cur_loc = temp_route(cnt);
                cnt = cnt + 1;
                new_result(new_day+1, 1) = cur_loc; % 当前的位置
                new_result(new_day+1, 2) = new_result(new_day, 2); % 赚的钱和前一天相同，矿山第一天不能挣钱
                new_result(new_day+1, 3) = new_result(new_day, 3) + 2*water(days(new_day)+2);
                new_result(new_day+1, 4) = new_result(new_day, 4) + 2*food(days(new_day)+2);
            else
                cur_loc = cur_loc;
                new_result(new_day+1, 1) = cur_loc;
                new_result(new_day+1, 2) = new_result(new_day, 2); % 赚的钱和前一天相同，矿山第一天不能挣钱
                new_result(new_day+1, 3) = new_result(new_day, 3) + water(days(new_day)+2);
                new_result(new_day+1, 4) = new_result(new_day, 4) + food(days(new_day)+2);
            end
        end
        % 判断是否失败
        if new_day > 30
            status = 0;
            continue;
        end
        if new_day == 30 && new_result(end, 1) ~= 27
            status = 0;
            continue;
        end
        if water(1)*new_result(end,3)+food(1)*new_result(end,4) > 1200
            status = 0;
            continue;
        end
        % 触发事件到达商店，清零吃掉的水和食物
        if new_result(end, 1) == 15
            if flag == 0 % 如果是第一次来村庄
                new_result(end, 2) = new_result(end, 2) - water(2)*new_result(end, 3) - food(2)*new_result(end, 4);
                new_result(end, 3) = 0;
                new_result(end, 4) = 0;
                flag = 1;
            else
                new_result(end, 2) = new_result(end, 2) - 2*water(2)*new_result(end, 3) - 2*food(2)*new_result(end, 4);
                new_result(end, 3) = 0;
                new_result(end, 4) = 0;
            end
        end
        dfs(new_day, cur_loc, new_result, flag);
    end
elseif cur_loc == 15
    to = [2, 6];
    for i = 1:2
        new_result = result;
        new_day = cur_day;
        temp_route = route{to(i)};
        cnt = 1;
        while cnt <= length(route{to(i)})
            new_day = new_day + 1;
            if new_day > 30 % 超出30天
                status = 0;
                return;
            end
            if days(new_day) ~= 3 % 不是沙暴天气
                cur_loc = temp_route(cnt);
                cnt = cnt + 1;
                new_result(new_day+1, 1) = cur_loc; % 当前的位置
                new_result(new_day+1, 2) = new_result(new_day, 2); % 赚的钱和前一天相同，矿山第一天不能挣钱
                new_result(new_day+1, 3) = new_result(new_day, 3) + 2*water(days(new_day)+2);
                new_result(new_day+1, 4) = new_result(new_day, 4) + 2*food(days(new_day)+2);
            else
                cur_loc = cur_loc;
                new_result(new_day+1, 1) = cur_loc;
                new_result(new_day+1, 2) = new_result(new_day, 2); % 赚的钱和前一天相同，矿山第一天不能挣钱
                new_result(new_day+1, 3) = new_result(new_day, 3) + water(days(new_day)+2);
                new_result(new_day+1, 4) = new_result(new_day, 4) + food(days(new_day)+2);
            end
        end
        % 判断是否失败
        if new_day > 30
            status = 0;
            continue;
        end
        if new_day == 30 && new_result(end, 1) ~= 27
            status = 0;
            continue;
        end
        if water(1)*new_result(end,3)+food(1)*new_result(end,4) > 1200
            status = 0;
            continue;
        end
        % 触发事件到达商店，清零吃掉的水和食物
        if new_result(end, 1) == 15
            if flag == 0 % 如果是第一次来村庄
                new_result(end, 2) = new_result(end, 2) - water(2)*new_result(end, 3) - food(2)*new_result(end, 4);
                new_result(end, 3) = 0;
                new_result(end, 4) = 0;
                flag = 1;
            else
                new_result(end, 2) = new_result(end, 2) - 2*water(2)*new_result(end, 3) - 2*food(2)*new_result(end, 4);
                new_result(end, 3) = 0;
                new_result(end, 4) = 0;
            end
        end
        dfs(new_day, cur_loc, new_result, flag);
    end
elseif cur_loc == 12
    to = [3, 7, 8, 9];
    % 在矿山挖矿
    for i = 3:3
        new_result = result;
        new_day = cur_day;
        temp_route = route{to(3)};
        new_day = new_day + 1;
        if new_day > 30 % 超出30天
            status = 0;
            return;
        end
        % 不管是不是沙尘暴，我都要挖矿
        cur_loc = temp_route(1);
        new_result(new_day+1, 1) = cur_loc;
        new_result(new_day+1, 2) = new_result(new_day, 2) + 1000;
        new_result(new_day+1, 3) = new_result(new_day, 3) + 3*water(days(new_day)+2);
        new_result(new_day+1, 4) = new_result(new_day, 4) + 3*food(days(new_day)+2);
        % 判断是否失败
        if new_day > 30
            status = 0;
            continue;
        end
        if new_day == 30 && new_result(end, 1) ~= 27
            status = 0;
            continue;
        end
        if water(1)*new_result(end,3)+food(1)*new_result(end,4) > 1200
            status = 0;
            continue;
        end
        dfs(new_day, cur_loc, new_result, flag);
    end
    % 在矿山不挖矿
    for i = 4:4
        new_result = result;
        new_day = cur_day;
        temp_route = route{to(4)};
        new_day = new_day + 1;
        if new_day > 30 % 超出30天
            status = 0;
            return;
        end
        % 不挖矿，只休息
        cur_loc = temp_route(1);
        new_result(new_day+1, 1) = cur_loc;
        new_result(new_day+1, 2) = new_result(new_day, 2);
        new_result(new_day+1, 3) = new_result(new_day, 3) + water(days(new_day)+2);
        new_result(new_day+1, 4) = new_result(new_day, 4) + food(days(new_day)+2);
        % 判断是否失败
        if new_day > 30
            status = 0;
            continue;
        end
        if new_day == 30 && new_result(end, 1) ~= 27
            status = 0;
            continue;
        end
        if water(1)*new_result(end,3)+food(1)*new_result(end,4) > 1200
            status = 0;
            continue;
        end
        dfs(new_day, cur_loc, new_result, flag);
    end
    for i = 1:2
        new_result = result;
        new_day = cur_day;
        temp_route = route{to(i)};
        cnt = 1;
        while cnt <= length(route{to(i)})
            new_day = new_day + 1;
            if new_day > 30 % 超出30天
                status = 0;
                return;
            end
            if days(new_day) ~= 3 % 不是沙暴天气
                cur_loc = temp_route(cnt);
                cnt = cnt + 1;
                new_result(new_day+1, 1) = cur_loc; % 当前的位置
                new_result(new_day+1, 2) = new_result(new_day, 2); % 赚的钱和前一天相同，矿山第一天不能挣钱
                new_result(new_day+1, 3) = new_result(new_day, 3) + 2*water(days(new_day)+2);
                new_result(new_day+1, 4) = new_result(new_day, 4) + 2*food(days(new_day)+2);
            else
                cur_loc = cur_loc;
                new_result(new_day+1, 1) = cur_loc;
                new_result(new_day+1, 2) = new_result(new_day, 2); % 赚的钱和前一天相同，矿山第一天不能挣钱
                new_result(new_day+1, 3) = new_result(new_day, 3) + water(days(new_day)+2);
                new_result(new_day+1, 4) = new_result(new_day, 4) + food(days(new_day)+2);
            end
        end
        % 判断是否失败
        if new_day > 30
            status = 0;
            continue;
        end
        if new_day == 30 && new_result(end, 1) ~= 27
            status = 0;
            continue;
        end
        if water(1)*new_result(end,3)+food(1)*new_result(end,4) > 1200
            status = 0;
            continue;
        end
        % 触发事件到达商店，清零吃掉的水和食物
        if new_result(end, 1) == 15
            if flag == 0 % 如果是第一次来村庄
                new_result(end, 2) = new_result(end, 2) - water(2)*new_result(end, 3) - food(2)*new_result(end, 4);
                new_result(end, 3) = 0;
                new_result(end, 4) = 0;
                flag = 1;
            else
                new_result(end, 2) = new_result(end, 2) - 2*water(2)*new_result(end, 3) - 2*food(2)*new_result(end, 4);
                new_result(end, 3) = 0;
                new_result(end, 4) = 0;
            end
        end
        dfs(new_day, cur_loc, new_result, flag);
    end

else % 到达了终点
    final_money = result(end, 2) - 2*water(2)*result(end, 3) - 2*food(2)*result(end, 4);
%     if check == 0
%         result
%         check = 1;
%     end
    final_money;
    result(end, 2) = final_money;
    if final_money > max_money
        final_results = result;
        max_money = final_money;
        max_money;
    end
    return;
end
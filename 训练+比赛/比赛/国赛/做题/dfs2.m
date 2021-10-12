function dfs2(cur_day, cur_loc, result, flag)
cur_day;
cur_loc;
global final_results
global max_money
%global check;
% flag表示是否是第一次来商店
water = [3,5,5,8,10];
food = [2,10,7,6,10];

days = [2,2,1,3,1,2,3,1,2,2,3,2,1,2,2,2,3,3,2,2,1,1,2,1,3,2,1,1,2,2];

route{1}=[2,3,4,5,13,22,30]; % 起点到矿山1
route{2}=[2,3,4,5,13,22,30,39]; % 起点到村庄1
route{3}=[2,3,4,12,21,29,38,46,55]; % 起点到矿山2
route{4}=[2,3,4,12,21,29,28,46,55,62]; % 起点到村庄2
route{5}=[39]; % 矿山1到村庄1
route{6}=[30]; % 在矿山1挖矿
route{7}=[30]; % 在矿山1休息
route{8}=[39,47,55]; % 矿山1到矿山2
route{9}=[39,47,55,62]; % 矿山1到村庄2
route{10}=[39,47,56,64]; % 矿山1到终点
route{11}=[30]; %村庄1到矿山1
route{12}=[47, 55]; %村庄1到矿山2
route{13}=[47, 55, 62]; % 村庄1到村庄2
route{14}=[47,56,64]; % 村庄1到终点
route{15}=[47,39,30]; % 矿山2到矿山1
route{16}=[47,39]; % 矿山2到村庄1
route{17}=[62]; % 矿山2到村庄2
route{18}=[56,64]; % 矿山2到终点
route{23}=[55]; % 矿山2挖矿
route{24}=[55]; % 矿山2休息
route{19}=[55]; % 村庄2到矿山2
route{20}=[55, 47, 39]; % 村庄2到村庄1
route{21}=[55, 47, 39, 30]; % 村庄2到矿山1
route{22}=[63, 64]; % 村庄2到终点

%1为起点，39为村庄1，30为矿山1，62为村庄2，55为矿山2，64为终点

if cur_loc == 1
    to = [1,2,3,4];
    for i = 1:4
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
        if new_day == 30 && new_result(end, 1) ~= 64
            status = 0;
            continue;
        end
        if water(1)*new_result(end,3)+food(1)*new_result(end,4) > 1200
            status = 0;
            continue;
        end
        % 触发事件到达商店，清零吃掉的水和食物
        if new_result(end, 1) == 39 || new_result(end, 1) == 62
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
        dfs2(new_day, cur_loc, new_result, flag);
    end
elseif cur_loc == 39
    to = [11, 12, 13, 14];
    for i = 1:4
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
        if new_day == 30 && new_result(end, 1) ~= 64
            status = 0;
            continue;
        end
        if water(1)*new_result(end,3)+food(1)*new_result(end,4) > 1200
            status = 0;
            continue;
        end
        % 触发事件到达商店，清零吃掉的水和食物
        if new_result(end, 1) == 39 || new_result(end, 1) == 62
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
        dfs2(new_day, cur_loc, new_result, flag);
    end
elseif cur_loc == 62
    to = [19, 20, 21, 22];
    for i = 1:4
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
        if new_day == 30 && new_result(end, 1) ~= 64
            status = 0;
            continue;
        end
        if water(1)*new_result(end,3)+food(1)*new_result(end,4) > 1200
            status = 0;
            continue;
        end
        % 触发事件到达商店，清零吃掉的水和食物
        if new_result(end, 1) == 39 || new_result(end, 1) == 62
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
        dfs2(new_day, cur_loc, new_result, flag);
    end
elseif cur_loc == 30
    to = [5, 8, 9, 10, 6, 7];
    % 在矿山挖矿
    for i = 5:5
        new_result = result;
        new_day = cur_day;
        temp_route = route{to(i)};
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
        dfs2(new_day, cur_loc, new_result, flag);
    end
    % 在矿山不挖矿
    for i = 6:6
        new_result = result;
        new_day = cur_day;
        temp_route = route{to(i)};
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
        if new_day == 30 && new_result(end, 1) ~= 64
            status = 0;
            continue;
        end
        if water(1)*new_result(end,3)+food(1)*new_result(end,4) > 1200
            status = 0;
            continue;
        end
        dfs2(new_day, cur_loc, new_result, flag);
    end
    for i = 1:4
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
        if new_day == 30 && new_result(end, 1) ~= 64
            status = 0;
            continue;
        end
        if water(1)*new_result(end,3)+food(1)*new_result(end,4) > 1200
            status = 0;
            continue;
        end
        % 触发事件到达商店，清零吃掉的水和食物
        if new_result(end, 1) == 39 || new_result(end, 1) == 62
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
        dfs2(new_day, cur_loc, new_result, flag);
    end
elseif cur_loc == 55
    to = [15, 16, 17, 18, 23, 24];
    % 在矿山挖矿
    for i = 5:5
        new_result = result;
        new_day = cur_day;
        temp_route = route{to(i)};
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
        if new_day == 30 && new_result(end, 1) ~= 64
            status = 0;
            continue;
        end
        if water(1)*new_result(end,3)+food(1)*new_result(end,4) > 1200
            status = 0;
            continue;
        end
        dfs2(new_day, cur_loc, new_result, flag);
    end
    % 在矿山不挖矿
    for i = 6:6
        new_result = result;
        new_day = cur_day;
        temp_route = route{to(i)};
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
        dfs2(new_day, cur_loc, new_result, flag);
    end
    for i = 1:4
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
        if new_day == 30 && new_result(end, 1) ~= 64
            status = 0;
            continue;
        end
        if water(1)*new_result(end,3)+food(1)*new_result(end,4) > 1200
            status = 0;
            continue;
        end
        % 触发事件到达商店，清零吃掉的水和食物
        if new_result(end, 1) == 39 || new_result(end, 1) == 62
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
        dfs2(new_day, cur_loc, new_result, flag);
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
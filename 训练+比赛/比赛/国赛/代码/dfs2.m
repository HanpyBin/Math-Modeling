function dfs2(cur_day, cur_loc, result, flag)
cur_day;
cur_loc;
global final_results
global max_money
%global check;
% flag��ʾ�Ƿ��ǵ�һ�����̵�
water = [3,5,5,8,10];
food = [2,10,7,6,10];

days = [2,2,1,3,1,2,3,1,2,2,3,2,1,2,2,2,3,3,2,2,1,1,2,1,3,2,1,1,2,2];

route{1}=[2,3,4,5,13,22,30]; % ��㵽��ɽ1
route{2}=[2,3,4,5,13,22,30,39]; % ��㵽��ׯ1
route{3}=[2,3,4,12,21,29,38,46,55]; % ��㵽��ɽ2
route{4}=[2,3,4,12,21,29,28,46,55,62]; % ��㵽��ׯ2
route{5}=[39]; % ��ɽ1����ׯ1
route{6}=[30]; % �ڿ�ɽ1�ڿ�
route{7}=[30]; % �ڿ�ɽ1��Ϣ
route{8}=[39,47,55]; % ��ɽ1����ɽ2
route{9}=[39,47,55,62]; % ��ɽ1����ׯ2
route{10}=[39,47,56,64]; % ��ɽ1���յ�
route{11}=[30]; %��ׯ1����ɽ1
route{12}=[47, 55]; %��ׯ1����ɽ2
route{13}=[47, 55, 62]; % ��ׯ1����ׯ2
route{14}=[47,56,64]; % ��ׯ1���յ�
route{15}=[47,39,30]; % ��ɽ2����ɽ1
route{16}=[47,39]; % ��ɽ2����ׯ1
route{17}=[62]; % ��ɽ2����ׯ2
route{18}=[56,64]; % ��ɽ2���յ�
route{23}=[55]; % ��ɽ2�ڿ�
route{24}=[55]; % ��ɽ2��Ϣ
route{19}=[55]; % ��ׯ2����ɽ2
route{20}=[55, 47, 39]; % ��ׯ2����ׯ1
route{21}=[55, 47, 39, 30]; % ��ׯ2����ɽ1
route{22}=[63, 64]; % ��ׯ2���յ�

%1Ϊ��㣬39Ϊ��ׯ1��30Ϊ��ɽ1��62Ϊ��ׯ2��55Ϊ��ɽ2��64Ϊ�յ�

if cur_loc == 1
    to = [1,2,3,4];
    for i = 1:4
        new_result = result;
        new_day = cur_day;
        temp_route = route{to(i)};
        cnt = 1;
        while cnt <= length(route{to(i)})
            new_day = new_day + 1;
            if new_day > 30 % ����30��
                status = 0;
                return;
            end
            if days(new_day) ~= 3 % ����ɳ������
                cur_loc = temp_route(cnt);
                cnt = cnt + 1;
                new_result(new_day+1, 1) = cur_loc; % ��ǰ��λ��
                new_result(new_day+1, 2) = new_result(new_day, 2); % ׬��Ǯ��ǰһ����ͬ����ɽ��һ�첻����Ǯ
                new_result(new_day+1, 3) = new_result(new_day, 3) + 2*water(days(new_day)+2);
                new_result(new_day+1, 4) = new_result(new_day, 4) + 2*food(days(new_day)+2);
            else
                cur_loc = cur_loc;
                new_result(new_day+1, 1) = cur_loc;
                new_result(new_day+1, 2) = new_result(new_day, 2); % ׬��Ǯ��ǰһ����ͬ����ɽ��һ�첻����Ǯ
                new_result(new_day+1, 3) = new_result(new_day, 3) + water(days(new_day)+2);
                new_result(new_day+1, 4) = new_result(new_day, 4) + food(days(new_day)+2);
            end
        end
        % �ж��Ƿ�ʧ��
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
        % �����¼������̵꣬����Ե���ˮ��ʳ��
        if new_result(end, 1) == 39 || new_result(end, 1) == 62
            if flag == 0 % ����ǵ�һ������ׯ
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
            if new_day > 30 % ����30��
                status = 0;
                return;
            end
            if days(new_day) ~= 3 % ����ɳ������
                cur_loc = temp_route(cnt);
                cnt = cnt + 1;
                new_result(new_day+1, 1) = cur_loc; % ��ǰ��λ��
                new_result(new_day+1, 2) = new_result(new_day, 2); % ׬��Ǯ��ǰһ����ͬ����ɽ��һ�첻����Ǯ
                new_result(new_day+1, 3) = new_result(new_day, 3) + 2*water(days(new_day)+2);
                new_result(new_day+1, 4) = new_result(new_day, 4) + 2*food(days(new_day)+2);
            else
                cur_loc = cur_loc;
                new_result(new_day+1, 1) = cur_loc;
                new_result(new_day+1, 2) = new_result(new_day, 2); % ׬��Ǯ��ǰһ����ͬ����ɽ��һ�첻����Ǯ
                new_result(new_day+1, 3) = new_result(new_day, 3) + water(days(new_day)+2);
                new_result(new_day+1, 4) = new_result(new_day, 4) + food(days(new_day)+2);
            end
        end
        % �ж��Ƿ�ʧ��
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
        % �����¼������̵꣬����Ե���ˮ��ʳ��
        if new_result(end, 1) == 39 || new_result(end, 1) == 62
            if flag == 0 % ����ǵ�һ������ׯ
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
            if new_day > 30 % ����30��
                status = 0;
                return;
            end
            if days(new_day) ~= 3 % ����ɳ������
                cur_loc = temp_route(cnt);
                cnt = cnt + 1;
                new_result(new_day+1, 1) = cur_loc; % ��ǰ��λ��
                new_result(new_day+1, 2) = new_result(new_day, 2); % ׬��Ǯ��ǰһ����ͬ����ɽ��һ�첻����Ǯ
                new_result(new_day+1, 3) = new_result(new_day, 3) + 2*water(days(new_day)+2);
                new_result(new_day+1, 4) = new_result(new_day, 4) + 2*food(days(new_day)+2);
            else
                cur_loc = cur_loc;
                new_result(new_day+1, 1) = cur_loc;
                new_result(new_day+1, 2) = new_result(new_day, 2); % ׬��Ǯ��ǰһ����ͬ����ɽ��һ�첻����Ǯ
                new_result(new_day+1, 3) = new_result(new_day, 3) + water(days(new_day)+2);
                new_result(new_day+1, 4) = new_result(new_day, 4) + food(days(new_day)+2);
            end
        end
        % �ж��Ƿ�ʧ��
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
        % �����¼������̵꣬����Ե���ˮ��ʳ��
        if new_result(end, 1) == 39 || new_result(end, 1) == 62
            if flag == 0 % ����ǵ�һ������ׯ
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
    % �ڿ�ɽ�ڿ�
    for i = 5:5
        new_result = result;
        new_day = cur_day;
        temp_route = route{to(i)};
        new_day = new_day + 1;
        if new_day > 30 % ����30��
            status = 0;
            return;
        end
        % �����ǲ���ɳ�������Ҷ�Ҫ�ڿ�
        cur_loc = temp_route(1);
        new_result(new_day+1, 1) = cur_loc;
        new_result(new_day+1, 2) = new_result(new_day, 2) + 1000;
        new_result(new_day+1, 3) = new_result(new_day, 3) + 3*water(days(new_day)+2);
        new_result(new_day+1, 4) = new_result(new_day, 4) + 3*food(days(new_day)+2);
        % �ж��Ƿ�ʧ��
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
    % �ڿ�ɽ���ڿ�
    for i = 6:6
        new_result = result;
        new_day = cur_day;
        temp_route = route{to(i)};
        new_day = new_day + 1;
        if new_day > 30 % ����30��
            status = 0;
            return;
        end
        % ���ڿ�ֻ��Ϣ
        cur_loc = temp_route(1);
        new_result(new_day+1, 1) = cur_loc;
        new_result(new_day+1, 2) = new_result(new_day, 2);
        new_result(new_day+1, 3) = new_result(new_day, 3) + water(days(new_day)+2);
        new_result(new_day+1, 4) = new_result(new_day, 4) + food(days(new_day)+2);
        % �ж��Ƿ�ʧ��
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
            if new_day > 30 % ����30��
                status = 0;
                return;
            end
            if days(new_day) ~= 3 % ����ɳ������
                cur_loc = temp_route(cnt);
                cnt = cnt + 1;
                new_result(new_day+1, 1) = cur_loc; % ��ǰ��λ��
                new_result(new_day+1, 2) = new_result(new_day, 2); % ׬��Ǯ��ǰһ����ͬ����ɽ��һ�첻����Ǯ
                new_result(new_day+1, 3) = new_result(new_day, 3) + 2*water(days(new_day)+2);
                new_result(new_day+1, 4) = new_result(new_day, 4) + 2*food(days(new_day)+2);
            else
                cur_loc = cur_loc;
                new_result(new_day+1, 1) = cur_loc;
                new_result(new_day+1, 2) = new_result(new_day, 2); % ׬��Ǯ��ǰһ����ͬ����ɽ��һ�첻����Ǯ
                new_result(new_day+1, 3) = new_result(new_day, 3) + water(days(new_day)+2);
                new_result(new_day+1, 4) = new_result(new_day, 4) + food(days(new_day)+2);
            end
        end
        % �ж��Ƿ�ʧ��
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
        % �����¼������̵꣬����Ե���ˮ��ʳ��
        if new_result(end, 1) == 39 || new_result(end, 1) == 62
            if flag == 0 % ����ǵ�һ������ׯ
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
    % �ڿ�ɽ�ڿ�
    for i = 5:5
        new_result = result;
        new_day = cur_day;
        temp_route = route{to(i)};
        new_day = new_day + 1;
        if new_day > 30 % ����30��
            status = 0;
            return;
        end
        % �����ǲ���ɳ�������Ҷ�Ҫ�ڿ�
        cur_loc = temp_route(1);
        new_result(new_day+1, 1) = cur_loc;
        new_result(new_day+1, 2) = new_result(new_day, 2) + 1000;
        new_result(new_day+1, 3) = new_result(new_day, 3) + 3*water(days(new_day)+2);
        new_result(new_day+1, 4) = new_result(new_day, 4) + 3*food(days(new_day)+2);
        % �ж��Ƿ�ʧ��
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
    % �ڿ�ɽ���ڿ�
    for i = 6:6
        new_result = result;
        new_day = cur_day;
        temp_route = route{to(i)};
        new_day = new_day + 1;
        if new_day > 30 % ����30��
            status = 0;
            return;
        end
        % ���ڿ�ֻ��Ϣ
        cur_loc = temp_route(1);
        new_result(new_day+1, 1) = cur_loc;
        new_result(new_day+1, 2) = new_result(new_day, 2);
        new_result(new_day+1, 3) = new_result(new_day, 3) + water(days(new_day)+2);
        new_result(new_day+1, 4) = new_result(new_day, 4) + food(days(new_day)+2);
        % �ж��Ƿ�ʧ��
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
            if new_day > 30 % ����30��
                status = 0;
                return;
            end
            if days(new_day) ~= 3 % ����ɳ������
                cur_loc = temp_route(cnt);
                cnt = cnt + 1;
                new_result(new_day+1, 1) = cur_loc; % ��ǰ��λ��
                new_result(new_day+1, 2) = new_result(new_day, 2); % ׬��Ǯ��ǰһ����ͬ����ɽ��һ�첻����Ǯ
                new_result(new_day+1, 3) = new_result(new_day, 3) + 2*water(days(new_day)+2);
                new_result(new_day+1, 4) = new_result(new_day, 4) + 2*food(days(new_day)+2);
            else
                cur_loc = cur_loc;
                new_result(new_day+1, 1) = cur_loc;
                new_result(new_day+1, 2) = new_result(new_day, 2); % ׬��Ǯ��ǰһ����ͬ����ɽ��һ�첻����Ǯ
                new_result(new_day+1, 3) = new_result(new_day, 3) + water(days(new_day)+2);
                new_result(new_day+1, 4) = new_result(new_day, 4) + food(days(new_day)+2);
            end
        end
        % �ж��Ƿ�ʧ��
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
        % �����¼������̵꣬����Ե���ˮ��ʳ��
        if new_result(end, 1) == 39 || new_result(end, 1) == 62
            if flag == 0 % ����ǵ�һ������ׯ
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
else % �������յ�
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
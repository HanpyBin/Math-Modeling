function dfs(cur_day, cur_loc, result, flag)
cur_day;
cur_loc;
global final_results
global max_money
%global check;
% flag��ʾ�Ƿ��ǵ�һ�����̵�
water = [3,5,5,8,10];
food = [2,10,7,6,10];

days = [2,2,1,3,1,2,3,1,2,2,3,2,1,2,2,2,3,3,2,2,1,1,2,1,3,2,1,1,2,2];

route{1}=[25,24,23,22,9,15]; % ��㵽��ׯ
route{2}=[14,12]; % ��ׯ����ɽ
route{3}=[14,15]; % ��ɽ����ׯ
%route{4}=[25,26,27]; % ��㵽�յ�
route{5}=[25,24,23,22, 9,15,14,12]; % ��㵽��ɽ
route{6}=[9,21,27]; % ��ׯ���յ�
route{7}=[14,15,9,21,27]; % ��ɽ���յ�
route{8}=[12]; % ��ɽ����ɽ
route{9}=[12]; % ��ɽ����ɽ����������Ϣ
% 1Ϊ��㣬15Ϊ��ׯ��12Ϊ��ɽ��27Ϊ�յ�

if cur_loc == 1
    to = [1,5];
    for i = 1:2
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
        if new_day == 30 && new_result(end, 1) ~= 27
            status = 0;
            continue;
        end
        if water(1)*new_result(end,3)+food(1)*new_result(end,4) > 1200
            status = 0;
            continue;
        end
        % �����¼������̵꣬����Ե���ˮ��ʳ��
        if new_result(end, 1) == 15
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
        if new_day == 30 && new_result(end, 1) ~= 27
            status = 0;
            continue;
        end
        if water(1)*new_result(end,3)+food(1)*new_result(end,4) > 1200
            status = 0;
            continue;
        end
        % �����¼������̵꣬����Ե���ˮ��ʳ��
        if new_result(end, 1) == 15
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
        dfs(new_day, cur_loc, new_result, flag);
    end
elseif cur_loc == 12
    to = [3, 7, 8, 9];
    % �ڿ�ɽ�ڿ�
    for i = 3:3
        new_result = result;
        new_day = cur_day;
        temp_route = route{to(3)};
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
        dfs(new_day, cur_loc, new_result, flag);
    end
    % �ڿ�ɽ���ڿ�
    for i = 4:4
        new_result = result;
        new_day = cur_day;
        temp_route = route{to(4)};
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
        dfs(new_day, cur_loc, new_result, flag);
    end
    for i = 1:2
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
        if new_day == 30 && new_result(end, 1) ~= 27
            status = 0;
            continue;
        end
        if water(1)*new_result(end,3)+food(1)*new_result(end,4) > 1200
            status = 0;
            continue;
        end
        % �����¼������̵꣬����Ե���ˮ��ʳ��
        if new_result(end, 1) == 15
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
        dfs(new_day, cur_loc, new_result, flag);
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
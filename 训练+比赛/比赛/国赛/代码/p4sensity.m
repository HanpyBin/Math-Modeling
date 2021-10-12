function [max_money, mean_money, completion, harvest] = p4sensity(pa,pb)
global m;
m = ones(25, 25);
m = m * 10000;
m(1, [2,6]) = 1;
m(5, [4,10]) = 1;
m(21, [16, 22]) = 1;
m(25, [20, 24]) = 1;
for i = 2:4
    m(i, [i-1,i+1,i+5]) = 1;
end
for i = 22:24
    m(i, [i-5,i-1,i+1]) = 1;
end
for i = 6:5:16
    m(i, [i-5, i+5, i+1]) = 1;
end
for i = 10:5:20
    m(i, [i-5,i+5,i-1])=1;
end
xxx = [7,8,9,12,13,14,17,18,19];
for i = 1:length(xxx)
    m(xxx(i), [xxx(i)-5,xxx(i)-1,xxx(i)+1,xxx(i)+5]) = 1;
end

for i = 1:25
    m(i, i) = 0;
end
for k = 1:25
    for i = 1:25
        for j = 1:25
            if m(i,k)+m(k,j) < m(i,j)
                m(i, j) = m(i, k) + m(k, j);
            end
        end
    end
end


failure_cnt1 = 0;
failure_cnt2 = 0;
failure_cnt3 = 0;
failure_cnt4 = 0;
failure_cnt5 = 0;
failure_cnt6 = 0;
failure_cnt7 = 0;
failure_cnt8 = 0;
failure_cnt9 = 0;
success_cnt = 0;
max_money = 0;

%% ��ʼģ��
for kkk = 1:100000
    flag1 = 0; % �Ƿ��ǳ�ʼ�㹺������
    flag = 0;
    water = [3, 5, 3, 9, 10];
    food = [2, 10, 4, 9, 10];
    for i = 1:30
        weather_p = rand;
        if weather_p > 0 && weather_p < pa
            weather(i) = 1;
        elseif weather_p >= pa && weather_p < pb
            weather(i) = 2;
        else
            weather(i) = 3;
        end
    end
    % ��0��
    result = zeros(1, 4);
    result(1, 1) = 1;
    result(1, 2) = 10000;
    result(1, 3) = 0;
    result(1, 4) = 0;
    
    cur_loc = 1;
    cur_day = 0;
    
    for i = 1:30
        cur_day = cur_day + 1;
        cur_weather = weather(i);
        % �ж�����
        if cur_weather == 3
            cur_loc = cur_loc;
            if cur_loc == 14 % ����ڴ�ׯ, ��ô�ȳԷ����󲹸�
                result(cur_day+1, 1) = cur_loc;
                result(cur_day+1, 3) = result(cur_day, 3) + water(cur_weather+2);
                result(cur_day+1, 4) = result(cur_day, 4) + food(cur_weather+2);
                % TODO:�ж����ʱ����û�ж�����
                if water(1)*result(cur_day+1, 3) + food(1)*result(cur_day+1,4) > 1200
                    status = 0;
                    failure_cnt1 = failure_cnt1 + 1;
                    flag = 1;
                    break;
                end
                result(cur_day+1, 2) = result(cur_day, 2) - 2*water(2)*result(cur_day+1, 3) - 2*food(2)*result(cur_day+1,4);
                result(cur_day+1, 3) = 0;
                result(cur_day+1, 4) = 0;
            elseif cur_loc == 18 % ��������ڿ�ɽ�����ڿ�
                result(cur_day+1, 1) = cur_loc;
                result(cur_day+1, 2) = result(cur_day, 2);
                result(cur_day+1, 3) = result(cur_day, 3) + water(cur_weather+2);
                result(cur_day+1, 4) = result(cur_day, 4) + food(cur_weather+2);
                % TODO:�ж����ʱ����û�ж�����
                if water(1)*result(cur_day+1, 3) + food(1)*result(cur_day+1,4) > 1200
                    status = 0;
                    failure_cnt2 = failure_cnt2 + 1;
                    flag = 1;
                    break;
                end
            else % ��·�ϱ���ס��
                result(cur_day+1, 1) = cur_loc;
                result(cur_day+1, 2) = result(cur_day, 2);
                result(cur_day+1, 3) = result(cur_day, 3) + water(cur_weather+2);
                result(cur_day+1, 4) = result(cur_day, 4) + food(cur_weather+2);
                % TODO:�ж����ʱ����û�ж�����
                if water(1)*result(cur_day+1, 3) + food(1)*result(cur_day+1,4) > 1200
                    status = 0;
                    failure_cnt3 = failure_cnt3 + 1;
                    flag = 1;
                    break;
                end
            end
        else % ����ɳ������
            available_places = find(m(cur_loc, :) == 1);
            available_places = [available_places, cur_loc];
            values = [];
            for k = 1:length(available_places)
                % ������һ�п����е�����1
                values(k) = compute_value(available_places(k), cur_day, result(cur_day, 3), result(cur_day, 4));
            end
            [x, y] = max(values); % y�����ж��
            y = available_places(y(1)); % ѡ���һ��, ֮����Ի������ѡ��һ��
            result(cur_day+1, 1) = y; % �ƶ�
            cur_loc = y;
            if result(cur_day+1, 1) == 14 % ����ƶ�����ׯ
                result(cur_day+1, 3) = result(cur_day, 3) + 2*water(cur_weather+2);
                result(cur_day+1, 4) = result(cur_day, 4) + 2*food(cur_weather+2);
                if water(1)*result(cur_day+1, 3) + food(1)*result(cur_day+1,4) > 1200
                    status = 0;
                    failure_cnt4 = failure_cnt4 + 1;
                    flag = 1;
                    break;
                end
                if flag1 == 0
                    result(cur_day+1, 2) = result(cur_day, 2) - water(2)*result(cur_day+1, 3) - food(2)*result(cur_day+1,4);
                    flag1 = 1;
                else
                    result(cur_day+1, 2) = result(cur_day, 2) - 2*water(2)*result(cur_day+1, 3) - 2*food(2)*result(cur_day+1,4);
                end
                %result(cur_day+1, 2) = result(cur_day, 2) - 2*water(2)*result(cur_day+1, 3) - 2*food(2)*result(cur_day+1,4);
                result(cur_day+1, 3) = 0;
                result(cur_day+1, 4) = 0;
            elseif result(cur_day+1, 1) == 18 && result(cur_day, 1) ~= 18% ����ƶ�����ɽ, ��һ���޷��ڿ�
                result(cur_day+1, 3) = result(cur_day, 3) + 2*water(cur_weather+2);
                result(cur_day+1, 4) = result(cur_day, 4) + 2*food(cur_weather+2);
                result(cur_day+1, 2) = result(cur_day, 2);
                if water(1)*result(cur_day+1, 3) + food(1)*result(cur_day+1,4) > 1200
                    status = 0;
                    failure_cnt5 = failure_cnt5 + 1;
                    flag = 1;
                    break;
                end
            elseif result(cur_day+1, 1) == 18 && result(cur_day, 1) == 18 % �ӿ�ɽ����ɽ����ô���ڿ�
                result(cur_day+1, 2) = result(cur_day, 2) + 1000;
                result(cur_day+1, 3) = result(cur_day, 3) + 3*water(cur_weather+2);
                result(cur_day+1, 4) = result(cur_day, 4) + 3*food(cur_weather+2);
                if water(1)*result(cur_day+1, 3) + food(1)*result(cur_day+1,4) > 1200
                    status = 0;
                    failure_cnt6 = failure_cnt6 + 1;
                    flag = 1;
                    break;
                end
            elseif result(cur_day+1, 1) == 25 % ��������յ�
                status = 1;
                result(cur_day+1, 3) = result(cur_day, 3) + 2*water(cur_weather+2);
                result(cur_day+1, 4) = result(cur_day, 4) + 2*food(cur_weather+2);
                if water(1)*result(cur_day+1, 3) + food(1)*result(cur_day+1,4) > 1200
                    status = 0;
                    failure_cnt7 = failure_cnt7 + 1;
                    flag = 1;
                    break;
                end
                result(cur_day+1, 2) = result(cur_day, 2) - 2*water(2)*result(cur_day+1, 3) - 2*food(2)*result(cur_day+1, 4);
                result(cur_day+1, 4) = 0;
                result(cur_day+1, 3) = 0;
                if result(cur_day+1, 2) > max_money
                    max_money = result(cur_day+1, 2);
                    final_result = [];
                    final_result = result;
                end
                success_cnt = success_cnt + 1;
                earn(success_cnt) = result(cur_day+1, 2);
                flag = 1;
                break;
            else % ������������
                result(cur_day+1, 3) = result(cur_day, 3) + 2*water(cur_weather+2);
                result(cur_day+1, 4) = result(cur_day, 4) + 2*food(cur_weather+2);
                result(cur_day+1, 2) = result(cur_day, 2);
                if water(1)*result(cur_day+1, 3) + food(1)*result(cur_day+1,4) > 1200
                    status = 0;
                    failure_cnt8 = failure_cnt8 + 1;
                    flag = 1;
                    break;
                end
            end
        end
    end
    if flag == 0
        failure_cnt9 = failure_cnt9 + 1;
        bad_results{failure_cnt9} = result;
    end
end

% �����
max_money;
% ��������
mean_money = mean(earn);
% ͨ����
completion = success_cnt / 100000;
% ׬Ǯ������ͨ�ص���֮�еı���
harvest = length(find(earn>10000))/success_cnt;
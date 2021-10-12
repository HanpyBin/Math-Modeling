clear; clc;
load('distancematrix')
dis = dist;
temperature = 1000;
cooling_rate = 0.99;

route{1} = [1:7];
route{2} = [8:19];
[previous_where20,previous_distance] = totaldistance(route, dis, z);
[~,previous_croute1]=completeroute(route{1},previous_where20{1});
[~,previous_croute2]=completeroute(route{2},previous_where20{2});
[~,previous_time1]=computeTime(previous_croute1,dis,1);
[~,previous_time2]=computeTime(previous_croute2,dis,2);
previous_time=previous_time1+previous_time2;
temperature_iterations = 1;
no = 0;
no1 = 0;
iteration_cnt = 1;
while 1.0 < temperature
    temp_route{1} = perturb(route{1},'reverse', dis, previous_where20{1}, 1);
    temp_route{2} = perturb(route{2}, 'reverse', dis, previous_where20{2}, 2);
    %if computeTime(routenew12,dis,1)~=0 && computeTime(routenew22,dis,2)~=0
    [current_where20,current_distance] = totaldistance(temp_route, dis, z);
    [route_new11, routenew12]=completeroute(temp_route{1},current_where20{1});
    [route_new21, routenew22]=completeroute(temp_route{2},current_where20{2});
    [k11,k12]=computeTime(routenew12,dis,1);
    [k21,k22]=computeTime(routenew22,dis,2);
    if k11 ==1 && k21==1
        diff = current_distance - previous_distance;
        fprintf('diff=%d\ntemp=%d', diff, temperature);
        if (diff < 0) || (rand < exp(-diff/(temperature)))
            route = temp_route;
            previous_distance = current_distance;
            previous_time1=k12;
            previous_time2=k22;
            previous_time=k12+k22;
            low_cost(iteration_cnt) = previous_distance;
            iteration_cnt = iteration_cnt + 1;
            previous_where20 = current_where20;
            [xxx,nnew_route{1}]=completeroute(route{1},previous_where20{1});
            [xxx,nnew_route{2}]=completeroute(route{2},previous_where20{2});
            for i =1:2
                [x,y]=computeTime(nnew_route{i},dis,i)
                if x == 0
                    no = no + 1;
                end
            end
            temperature_iterations = temperature_iterations + 1;
        end
    end
    if rand > 0.8
        temp_route1 = crossover(route);
        [current_where20,current_distance] = totaldistance(temp_route1, dis, z);
        [route_new11, routenew12]=completeroute(temp_route1{1},current_where20{1});
        [route_new21, routenew22]=completeroute(temp_route1{2},current_where20{2});
        [k11,k12]=computeTime(routenew12,dis,1);
        [k21,k22]=computeTime(routenew22,dis,2);
        if computeTime(routenew12,dis,1)~=0 && computeTime(routenew22,dis,2)~=0
            diff = current_distance - previous_distance;
                if (diff < 0) || (rand < exp(-diff/(temperature)))
                    route = temp_route1;
                    previous_time1=k12;
                    previous_time2=k22;
                    previous_time=k12+k22;
                    previous_distance = current_distance;
                    low_cost(iteration_cnt) = previous_distance;
                    iteration_cnt = iteration_cnt + 1;
                    previous_where20 = current_where20;
                    [xxx,nnew_route{1}]=completeroute(route{1},previous_where20{1});
                    [xxx,nnew_route{2}]=completeroute(route{2},previous_where20{2});
                    for i =1:2
                        [x,y]=computeTime(nnew_route{i},dis,i)
                        if x == 0
                            no1 = no1 + 1;
                        end
                    end
                    temperature_iterations = temperature_iterations + 1;
                end
        end
    end
    if temperature_iterations >= 100
        temperature = cooling_rate * temperature;
        temperature_iterations = 0;
    end
end
%new_route{1} = zeros(1,length(route{1})+length(pervious_where20{1}));
%new_route{2} = zeros(1,length(route{2})+length(pervious_where20{2}));

[xxx,new_route{1}]=completeroute(route{1},previous_where20{1});
[xxx,new_route{2}]=completeroute(route{2},previous_where20{2});
% cnt1 = 0;
% cnt11 = 1;
% flag = 0;
% for i = 1:length(route{1})
%     if flag == 0 && i == previous_where20{1}(cnt11)
%         cnt1 = cnt1 + 1;
%         new_route{1}(cnt1)=20;
%         cnt1 = cnt1 + 1;
%         new_route{1}(cnt1)=route{1}(i);
%         cnt11 = cnt11 + 1;
%         if cnt11 > length(previous_where20{1})
%             flag = 1;
%         end
%         continue;
%     end
%     cnt1 = cnt1 + 1;
%     new_route{1}(cnt1) = route{1}(i);
% end
% new_route{1}(end+1)=20;
% cnt2 = 0;
% cnt22 = 1;
% flag = 0;
% for i = 1:length(route{2})
%     if flag == 0 && i == previous_where20{2}(cnt22)
%         cnt2 = cnt2 + 1;
%         new_route{2}(cnt2)=20;
%         cnt2 = cnt2 + 1;
%         new_route{2}(cnt2)=route{2}(i);
%         cnt22 = cnt22 + 1;
%         if cnt22 > length(previous_where20{2})
%             flag = 1;
%         end
%         continue;
%     end
%     cnt2 = cnt2 + 1;
%     new_route{2}(cnt2) = route{2}(i);
% end
% new_route{2}(end+1)=20;
new_route{1}
new_route{2}
%%作费用收敛折线图
plot(1:length(low_cost),low_cost);
xlabel('迭代次数'); ylabel('最小花费');
for i =1:2
     [x(i),y(i)]=computeTime(new_route{i},dis,i);
end
fprintf("最小花费为%.2f\n",previous_distance);

fprintf("第一辆车的用时为%.2f\n",y(1));
fprintf("第二辆车的用时为%.2f\n",y(2));
len = zeros(1,2);
for k = 1:2
    for i=1:length(new_route{k})-1
        len(k) = len(k) + dis(new_route{k}(i),new_route{k}(i+1));
    end
end
fprintf("第一辆车的总路程为%.2f\n",len(1));
fprintf("第二辆车的总路程为%.2f\n",len(2));
fprintf("第一辆车路径为:");
for i = 1:length(new_route{1})-1
    fprintf("%d->",new_route{1}(i));
end
fprintf("%d\n",new_route{1}(end));

fprintf("第二辆车路径为:");
for i = 1:length(new_route{2})-1
    fprintf("%d->",new_route{2}(i));
end
fprintf("%d\n",new_route{2}(end));
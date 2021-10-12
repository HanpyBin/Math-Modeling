clear;clc;
load('distanceMatrix');
Alpha=1;Beta=5;Rho=0.75;iter_max=500;Q=10;Cap=6;m=20;  %Cap为车辆最大载重
[R_best,L_best,L_ave,Shortest_Route,Shortest_Length]=ANT_VRP1(dist,z,Cap,iter_max,m,Alpha,Beta,Rho,Q); %蚁群算法求解VRP问题函数
Shortest_Route_1=Shortest_Route    %提取最优路线
Shortest_Length                      %提取最低费用
cnt = 0;
timing = zeros(1,10);
len = zeros(1,10);
%计算路径的长度与时间
for kk = 1:length(Shortest_Route)-1
    if(Shortest_Route(kk)) == 20
        cnt = cnt + 1;
    end
    timing(cnt) = timing(cnt) + dist(Shortest_Route(kk), Shortest_Route(kk+1))/50*60;
    len(cnt) = len(cnt) + dist(Shortest_Route(kk), Shortest_Route(kk+1));
    if(Shortest_Route(kk+1)) ~= 20
        timing(cnt) = timing(cnt) + 5;
    end
end
%将时间化为小时
timing = timing / 60;
%输出结果
fprintf("花费的总时间为%.2fh\n",sum(timing));
fprintf("总运费为%.2f元\n",Shortest_Length);
fprintf("总距离为%.2f\n", sum(len));
fprintf("路径为:");
for i = 1:length(Shortest_Route)-1
    fprintf("%d->",Shortest_Route(i));
end
fprintf("%d\n",Shortest_Route(end));
carcnt = 0;
for i = 1:length(Shortest_Route)
    if Shortest_Route(i) == 20
        carcnt = carcnt + 1;
    end
end
fprintf("共有%d个车次\n",carcnt-1);
fprintf("每个车次的路程:");
for i = 1:carcnt-1
    fprintf("%.2f  ", len(i));
end
fprintf("\n");
fprintf("每个车次的耗时:");
for i = 1:carcnt-1
    fprintf("%.2f  ",timing(i));
end
fprintf("\n");
%% ==============作图==============
figure(1)   %作迭代收敛曲线图
x=linspace(0,iter_max,iter_max);
y=L_best(:,1);
plot(x,y);
xlabel('迭代次数'); ylabel('最小花费');
 
figure(2)   %作最短路径图
plot([x(Shortest_Route)],[y(Shortest_Route)],'o-');
grid on
for i =1:length(x)
    text(x(i),y(i),['   ' num2str(i)]);
end
xlabel('站点所在横坐标'); ylabel('站点所在纵坐标');
%save('main2data');
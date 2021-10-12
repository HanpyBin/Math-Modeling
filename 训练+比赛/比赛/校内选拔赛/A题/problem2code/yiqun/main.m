clc;clear all
%% ==============提取数据==============

C=[x_label y_label];      %坐标矩阵
n=size(C,1);        %n表示节点（客户）个数
%% ==============计算距离矩阵==============
clear;clc;
load('distanceMatrix');
Alpha=1;Beta=5;Rho=0.75;iter_max=1000;Q=10;Cap=6;m=20;  %Cap为车辆最大载重
[R_best,L_best,L_ave,Shortest_Route,Shortest_Length]=ANT_VRP(dist,z,Cap,iter_max,m,Alpha,Beta,Rho,Q); %蚁群算法求解VRP问题通用函数，详见配套光盘
Shortest_Route_1=Shortest_Route    %提取最优路线
Shortest_Length                      %提取最短路径长度
 
%% ==============作图==============
figure(1)   %作迭代收敛曲线图
x=linspace(0,iter_max,iter_max);
y=L_best(:,1);
plot(x,y);
xlabel('迭代次数'); ylabel('最短路径长度');
 
figure(2)   %作最短路径图
plot([x(Shortest_Route)],[y(Shortest_Route)],'o-');
grid on
for i =1:length(x)
    text(x(i),y(i),['   ' num2str(i-1)]);
end
xlabel('客户所在横坐标'); ylabel('客户所在纵坐标');
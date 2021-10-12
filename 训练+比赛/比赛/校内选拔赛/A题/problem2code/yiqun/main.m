clc;clear all
%% ==============��ȡ����==============

C=[x_label y_label];      %�������
n=size(C,1);        %n��ʾ�ڵ㣨�ͻ�������
%% ==============����������==============
clear;clc;
load('distanceMatrix');
Alpha=1;Beta=5;Rho=0.75;iter_max=1000;Q=10;Cap=6;m=20;  %CapΪ�����������
[R_best,L_best,L_ave,Shortest_Route,Shortest_Length]=ANT_VRP(dist,z,Cap,iter_max,m,Alpha,Beta,Rho,Q); %��Ⱥ�㷨���VRP����ͨ�ú�����������׹���
Shortest_Route_1=Shortest_Route    %��ȡ����·��
Shortest_Length                      %��ȡ���·������
 
%% ==============��ͼ==============
figure(1)   %��������������ͼ
x=linspace(0,iter_max,iter_max);
y=L_best(:,1);
plot(x,y);
xlabel('��������'); ylabel('���·������');
 
figure(2)   %�����·��ͼ
plot([x(Shortest_Route)],[y(Shortest_Route)],'o-');
grid on
for i =1:length(x)
    text(x(i),y(i),['   ' num2str(i-1)]);
end
xlabel('�ͻ����ں�����'); ylabel('�ͻ�����������');
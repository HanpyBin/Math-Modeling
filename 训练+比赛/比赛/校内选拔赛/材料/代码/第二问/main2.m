clear;clc;
load('distanceMatrix');
Alpha=1;Beta=5;Rho=0.75;iter_max=500;Q=10;Cap=6;m=20;  %CapΪ�����������
[R_best,L_best,L_ave,Shortest_Route,Shortest_Length]=ANT_VRP1(dist,z,Cap,iter_max,m,Alpha,Beta,Rho,Q); %��Ⱥ�㷨���VRP���⺯��
Shortest_Route_1=Shortest_Route    %��ȡ����·��
Shortest_Length                      %��ȡ��ͷ���
cnt = 0;
timing = zeros(1,10);
len = zeros(1,10);
%����·���ĳ�����ʱ��
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
%��ʱ�仯ΪСʱ
timing = timing / 60;
%������
fprintf("���ѵ���ʱ��Ϊ%.2fh\n",sum(timing));
fprintf("���˷�Ϊ%.2fԪ\n",Shortest_Length);
fprintf("�ܾ���Ϊ%.2f\n", sum(len));
fprintf("·��Ϊ:");
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
fprintf("����%d������\n",carcnt-1);
fprintf("ÿ�����ε�·��:");
for i = 1:carcnt-1
    fprintf("%.2f  ", len(i));
end
fprintf("\n");
fprintf("ÿ�����εĺ�ʱ:");
for i = 1:carcnt-1
    fprintf("%.2f  ",timing(i));
end
fprintf("\n");
%% ==============��ͼ==============
figure(1)   %��������������ͼ
x=linspace(0,iter_max,iter_max);
y=L_best(:,1);
plot(x,y);
xlabel('��������'); ylabel('��С����');
 
figure(2)   %�����·��ͼ
plot([x(Shortest_Route)],[y(Shortest_Route)],'o-');
grid on
for i =1:length(x)
    text(x(i),y(i),['   ' num2str(i)]);
end
xlabel('վ�����ں�����'); ylabel('վ������������');
%save('main2data');
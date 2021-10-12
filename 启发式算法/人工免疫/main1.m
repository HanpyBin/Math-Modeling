tic
%%%%%免疫算法TSP问题%%%%
%%%%%初始化参数%%%%%
clear all;      %清除所有变量
close all;      %清图
clc;            %清屏
C=[39.54, 31.14, 39.09, 29.32, 45.45, 43.52, 41.5, 40.49, 38.02, 37.52, 36.38, 34.48, 34.16, 36.03, 38.2,...
    36.38, 43.48,31.51,32.02,30.14,28.11,28.41,30.37,30.39,26.35,26.05,23.08,20.02,22.48,25,29.39,22.18,22.14,25.03
    116.3,121.29,117.1,106.32,126.41,125.19,123.24,111.5,114.28,112.3,117,113.4,108.54,103.49,106.16,101.45,...
    87.36,117.18,118.5,120.09,113,115.52,114.21,104.05,106.42,119.2,113.15,110.2,108.2,102.4,90.08,114.1,113.35,121.31];
N=size(C,2);    %城市数目，基因数目
D=zeros(N);     %任意两个城市距离矩阵
NP=100;         %免疫个体数目
G=1000;         %最大免疫代数
Pc=0.1;         %交叉率
f=zeros(N,NP);  %中间变量
len=zeros(NP,1);
%%%%%求间距%%%%%
R = 6378.137;
for i=1:N
    for j=1:N
        D(i, j) = distance(C(1, i), C(2, i), C(1, j), C(2, j), R);
    end
end
%%%%%随机生成第一代%%%%%
for i=1:NP
    f(:,i)=randperm(N);
end
%%%%%计算路径长度%%%%%
 for i=1:NP
     len(i)=func3(D,f(:,i),N);
 end
[Sortlen,Index]=sort(len);
Sortf=f(:,Index);
Ncl=10;             %克隆个数
%%%%%遗传算法循环%%%%%
for gen=1:G
   for i=1:NP/2
    %%%%%选择操作%%%%%
    a=Sortf(:,i);
    Ca=repmat(a,1,Ncl);
    for j=1:Ncl
        p1=floor(1+N*rand());
        p2=floor(1+N*rand());
        while p1==p2
            p1=floor(1+N*rand());
            p2=floor(1+N*rand());
        end
        tmp=Ca(p1,j);
        Ca(p1,j)=Ca(p2,j);
        Ca(p2,j)=tmp;
    end
    Ca(:,1)=Sortf(:,i);
    %%%%%克隆抑制%%%%%
    for j=1:Ncl
        Calen(j)=func3(D,Ca(:,j),N);
    end
    [SortCalen,Index]=sort(Calen);
    SortCa=Ca(:,Index);
    af(:,i)=SortCa(:,1);
    alen(i)=SortCalen(1);
   end
   %%%%%种群刷新%%%%%
   for i=1:NP/2
       bf(:,i)=randperm(N);
       blen(i)=func3(D,bf(:,i),N);
   end
   %%%%%免疫种群与新种群合并%%%%%
   f=[af,bf];
   len=[alen,blen];
   [Sortlen,Index]=sort(len);
   Sortf=f(:,Index);
   trace(gen)=Sortlen(1);
end
%%%%%输出最优化结果%%%%%
fBest=Sortf(:,1);
Bestlen=trace(end);
figure
C = C';
for i=1:N-1
    plot([C(fBest(i),1),C(fBest(i+1),1)],[C(fBest(i),2),C(fBest(i+1),2)],'bo-')
    hold on
end
plot([C(fBest(N),1),C(fBest(1),1)],[C(fBest(N),2),C(fBest(1),2)],'bo-')
title(['最优化距离',num2str(Bestlen)]);
figure
plot(trace)
xlabel('迭代次数')
ylabel('目标函数值')
title('亲和度进化曲线')
toc
%%%%%计算路径总长度的函数%%%%%
function len=func3(D,f,N)
     len=D(f(N),f(1));
     for i=1:(N-1)
         len=len+D(f(i),f(i+1));
     end
end
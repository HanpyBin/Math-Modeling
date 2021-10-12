clear;
clc;
%L=xlsread('');各指标指示值
X=xlsread('problem2data.xlsx');%各评价方案的指标数据
L=[-1,-1,-1];
X(:,3) = 1./X(:,3);
%参与评价的方案数m,指标数n
[m,n]=size(X);

%标准化矩阵X后得到R
R=zeros(m,n);
for i=1:m
    for j=1:n
         %根据指标指示值判断是越大越优型指标还是越小越优型指标
        if L(j)==1
            %越大越优型指标的无量纲化
            R(i,j)=(X(i,j)-min(X(:,j)))/(max(X(:,j))-min(X(:,j)));
        else
            %越小越优型指标的无量纲化
            R(i,j)=(max(X(:,j))-X(i,j))/(max(X(:,j))-min(X(:,j)));
        end
    end
end

%给第j项指标对不同评价对象求和，得sumR
sumR=sum(R);
%初始化特征比重矩阵p
p=zeros(m,n);
%计算第i个评价对象第j项指标的特征比重p
for i=1:m
    for j=1:n
        p(i,j)=R(i,j)/sumR(j);
    end
end

%判断p中的元素是否为0，如果为0，p(i,j)*ln(p(i,j))=0
%用中间变量tp表示p(i,j)*ln(p(i,j))

tp=zeros(m,n);
for i=1:m
    for j=1:n
        %根据p(i,j)是否小于等于0给tp赋值
        if p(i,j)<=0
            tp(i,j)=0;
        else
            tp(i,j)=p(i,j)*log(p(i,j));
        end
    end
end

%计算第j项指标的条件熵H
H=-sum(tp);

%计算第j项指标的熵值E
E=H/log(m);

%计算差异系数G
G=1-E;

%计算熵权W
W=G/sum(G);

scores = R*W';

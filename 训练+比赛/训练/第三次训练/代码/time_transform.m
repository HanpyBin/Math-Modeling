clear,clc;
load temp1;
num=temp1;
[num1,txt1]=xlsread("../data1.csv");
txt1(1,:)=[];
txt1(:,2)=[];
timing=txt1(num(:),1);
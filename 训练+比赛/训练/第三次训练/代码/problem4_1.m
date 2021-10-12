clear,clc;
global num;
[num, txt] = xlsread("../data1.csv");
for i = 1:30
    num(end+1)=0;
end
load temp1
x = temp1;
BenchmarkFunction(x)
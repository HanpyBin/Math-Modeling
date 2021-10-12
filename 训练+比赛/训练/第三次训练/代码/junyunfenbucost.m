clear,clc;
[num, txt] = xlsread("../data1.csv");
x = 1:3:209;
BenchmarkFunction(x)
%clear;
[data, txt] = xlsread("data2.csv");
data = data(:,3:end);
[V,PC,D,G]=eof_test(zeroavg(data'));
%[V,EOFs,EC,error]=EOF(data, size(data, 2));
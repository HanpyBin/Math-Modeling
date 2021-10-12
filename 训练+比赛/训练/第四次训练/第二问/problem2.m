clear, clc;
load dismat1
data = xlsread("../附件3-违法情况统计.xlsx");
data(:,4) = data(:,2) .* data(:,3);
data(:,5) = (log(data(:,4)+1)+1) .* (1+data(:,2));
for i = 1:103
    for j = 1:103
        C(i,j) = data(j,5)/H(dismat(i,j));
    end
end
save("data.mat", 'data');

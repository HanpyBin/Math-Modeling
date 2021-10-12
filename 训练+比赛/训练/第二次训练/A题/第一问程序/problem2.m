clear, clc;
[endpoints5, bifurcations5] = get_code(10);
[endpoints6, bifurcations6] = get_code(11);
for i = 1:size(endpoints5,1)
    feature1(i,:)= [endpoints5(i,7), endpoints5(i,5), endpoints5(i,6), 1, endpoints5(i,3)];
end
for i = size(endpoints5,1)+1:size(endpoints5,1)+size(bifurcations5,1)
    feature1(i,:)= [bifurcations5(i-size(endpoints5,1),7), bifurcations5(i-size(endpoints5,1),5), bifurcations5(i-size(endpoints5,1),6), 2, bifurcations5(i-size(endpoints5,1),3)];
end

for i = 1:size(endpoints6,1)
    feature2(i,:)= [endpoints6(i,7), endpoints6(i,5), endpoints6(i,6), 1, endpoints6(i,3)];
end
for i = size(endpoints6,1)+1:size(endpoints6,1)+size(bifurcations6,1)
    feature2(i,:)= [bifurcations6(i-size(endpoints6,1),7), bifurcations6(i-size(endpoints6,1),5), bifurcations6(i-size(endpoints6,1),6), 2, bifurcations6(i-size(endpoints6,1),3)];
end
for i = 1:size(feature1,2)
    feature1(:,i) = (feature1(:,i)-min(feature1(:,i)))/(max(feature1(:,i))-min(feature1(:,i)));
    feature2(:,i) = (feature2(:,i)-min(feature2(:,i)))/(max(feature2(:,i))-min(feature2(:,i)));
end
d = zeros(size(feature1,1),size(feature2,1));
for i = 1:size(feature1,1)
    for j = 1:size(feature2,1)
        d(i,j)=sqrt((feature1(i,1)-feature2(j,1))^2+(feature1(i,2)-feature2(j,2))^2+(feature1(i,3)-feature2(j,3))^2+(feature1(i,4)-feature2(j,4))^2+(feature1(i,5)-feature2(j,5))^2);
    end
end
fid = fopen('d.txt','w');
for i = 1:size(d,1)
    for j = 1:size(d,2)
        fprintf(fid, '%.4f ', d(i,j));
    end
    fprintf(fid, '\n');
end
fclose(fid);
%[V2,PC2,D2,G2]=eof_test(zeroavg(intens'));
clear,clc;
data = xlsread("total_df.xlsx");
% ��ȡ1-6������
data1 = data(1:30,:);
for i = 1:size(data1, 2)
    temp = reshape(data1(:,i), 5, 6);
    feature1(:, :, i) = temp';
end
% ��ȡ7-8������
data2 = data(31:end,:);
for i = 1:size(data2,2)
    temp = reshape(data2(:,i), 4, 2);
    feature2(:,:,i) = temp';
end
% ����1-6�·ݵ�eof�ֽ�
for i = 1:size(data1, 2)
    [V1(:,:,i),PC1(:,:,i),D1(:,:,i),G1(:,:,i)]=eof_test(zeroavg(feature1(:,:,i)'));
end
for i = 1:size(data2,2)
    [V2(:,:,i),PC2(:,:,i),D2(:,:,i),G2(:,:,i)]=eof_test(zeroavg(feature2(:,:,i)'));
end
for i=1:6
    temp1(:,i) = PC1(:,1,i);
end
for i=1:20
    temp2(:,i) = V1(:,1,i);
end
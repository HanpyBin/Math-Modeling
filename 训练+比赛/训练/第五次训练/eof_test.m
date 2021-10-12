function [V,PC,D,G]=eof_test(X)

%V eigen vector (空间函数), V必须是pXp的，p为变量个数

%PC 时间函数 Y=V'X

%X 原始变量，列对应原始变量类型，行对应样本  原始变量的值都需要标准化处理，即减去均值，除以std

%size(X)
[V,D]=eig(X*X'); % V特征向量  D对角阵，即主成分
[diagonal,I] = sort(diag(D),'descend');
V=V(:,I);
PC=(V'*X)';
G = diagonal/sum(diagonal);

end

function [V,PC,D,G]=eof_test(X)

%V eigen vector (�ռ亯��), V������pXp�ģ�pΪ��������

%PC ʱ�亯�� Y=V'X

%X ԭʼ�������ж�Ӧԭʼ�������ͣ��ж�Ӧ����  ԭʼ������ֵ����Ҫ��׼����������ȥ��ֵ������std

%size(X)
[V,D]=eig(X*X'); % V��������  D�Խ��󣬼����ɷ�
[diagonal,I] = sort(diag(D),'descend');
V=V(:,I);
PC=(V'*X)';
G = diagonal/sum(diagonal);

end

clc
for i = 1:20
D=sort(diag(D1(:,:,i)),'descend');
e1=D(1)*sqrt(2/length(D));
d1=D(1)-D(2);
fprintf("ʪ���ܽ�ˮ���ĵ�һ�ռ�ģ̬north����,%g>%g\n",d1,e1);
end

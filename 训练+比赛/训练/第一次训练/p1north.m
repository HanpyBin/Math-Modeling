clc
D=sort(diag(D1),'descend');
e1=D(1)*sqrt(2/length(D));
d1=D(1)-D(2);
fprintf("ʪ���ܽ�ˮ���ĵ�һ�ռ�ģ̬north����,%g>%g\n",d1,e1);

D=sort(diag(D2),'descend');
e2=D(1)*sqrt(2/length(D));
d2=D(1)-D(2);
fprintf("���˽�ˮ���վ���ˮ�ڵĵ�һ�ռ�ģ̬north����,%g>%g\n",d2,e2);

D=sort(diag(D3),'descend');
e3=D(1)*sqrt(2/length(D));
d3=D(1)-D(2);
fprintf("cdd�ĵ�һ�ռ�ģ̬north����,%g>%g\n",d3,e3);

D=sort(diag(D4),'descend');
e4=D(1)*sqrt(2/length(D));
d4=D(1)-D(2);
fprintf("cwd�ĵ�һ�ռ�ģ̬north����,%g>%g\n",d4,e4);

D=sort(diag(D5),'descend');
e5=D(1)*sqrt(2/length(D));
d5=D(1)-D(2);
fprintf("rx1�ĵ�һ�ռ�ģ̬north����,%g>%g\n",d5,e5);

D=sort(diag(D6),'descend');
e6=D(1)*sqrt(2/length(D));
d6=D(1)-D(2);
fprintf("rx5�ĵ�һ�ռ�ģ̬north����,%g>%g\n",d6,e6);
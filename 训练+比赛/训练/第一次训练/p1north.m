clc
D=sort(diag(D1),'descend');
e1=D(1)*sqrt(2/length(D));
d1=D(1)-D(2);
fprintf("湿日总降水量的第一空间模态north检验,%g>%g\n",d1,e1);

D=sort(diag(D2),'descend');
e2=D(1)*sqrt(2/length(D));
d2=D(1)-D(2);
fprintf("极端降水期日均降水期的第一空间模态north检验,%g>%g\n",d2,e2);

D=sort(diag(D3),'descend');
e3=D(1)*sqrt(2/length(D));
d3=D(1)-D(2);
fprintf("cdd的第一空间模态north检验,%g>%g\n",d3,e3);

D=sort(diag(D4),'descend');
e4=D(1)*sqrt(2/length(D));
d4=D(1)-D(2);
fprintf("cwd的第一空间模态north检验,%g>%g\n",d4,e4);

D=sort(diag(D5),'descend');
e5=D(1)*sqrt(2/length(D));
d5=D(1)-D(2);
fprintf("rx1的第一空间模态north检验,%g>%g\n",d5,e5);

D=sort(diag(D6),'descend');
e6=D(1)*sqrt(2/length(D));
d6=D(1)-D(2);
fprintf("rx5的第一空间模态north检验,%g>%g\n",d6,e6);
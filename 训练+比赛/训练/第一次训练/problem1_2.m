clear;
%load freq;
load intens;
%load chongxianqi
% [V1,PC1,D1,G1]=eof_test(zeroavg(freq'));
[V2,PC2,D2,G2]=eof_test(zeroavg(intens'));
% [V3,PC3,D3,G3]=eof_test(zeroavg(pws41'));
load total_raining
[V1,PC1,D1,G1]=eof_test(zeroavg(total_raining'));
load cdd
[V3,PC3,D3,G3]=eof_test(zeroavg(cdd'));
load cwd
[V4,PC4,D4,G4]=eof_test(zeroavg(cwd'));
load rx1
[V5,PC5,D5,G5]=eof_test(zeroavg(rx1'));
load rx5
[V6,PC6,D6,G6]=eof_test(zeroavg(rx5'));
load jiduan_days
[V7,PC7,D7,G7]=eof_test(zeroavg(jiduan_days'));
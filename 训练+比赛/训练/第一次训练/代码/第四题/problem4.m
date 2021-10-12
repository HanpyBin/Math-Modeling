%% 中世纪
%clear;
%load total_raining
[V12,PC12,D12,G12]=eof_test(zeroavg(total_raining2'));
%load intens;
[V22,PC22,D22,G22]=eof_test(zeroavg(intens2'));
%load cdd
[V32,PC32,D32,G32]=eof_test(zeroavg(cdd2'));
%load cwd
[V42,PC42,D42,G42]=eof_test(zeroavg(cwd2'));
%load rx1
[V52,PC52,D52,G52]=eof_test(zeroavg(rx12'));
%load rx5
[V62,PC62,D62,G62]=eof_test(zeroavg(rx52'));

%% 后世纪
%load total_raining
[V13,PC13,D13,G13]=eof_test(zeroavg(total_raining3'));
%load intens;
[V23,PC23,D23,G23]=eof_test(zeroavg(intens3'));
%load cdd
[V33,PC33,D33,G33]=eof_test(zeroavg(cdd3'));
%load cwd
[V43,PC43,D43,G43]=eof_test(zeroavg(cwd3'));
%load rx1
[V53,PC53,D53,G53]=eof_test(zeroavg(rx13'));
%load rx5
[V63,PC63,D63,G63]=eof_test(zeroavg(rx53'));
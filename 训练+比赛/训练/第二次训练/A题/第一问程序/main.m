clear,clc;
for i =1:16
[endpoints, bifurcations] = get_code(i);
fid = fopen(['result',num2str(i),'.txt'],'w');
for i = 1:size(endpoints,1)
    fprintf(fid, '%.3f %.3f %.3f %d %d\n', endpoints(i,7), endpoints(i,5), endpoints(i,6), 1, endpoints(i,3));
end
for i = 1:size(bifurcations,1)
    fprintf(fid, '%.3f %.3f %.3f %d %d\n', bifurcations(i,7), bifurcations(i,5), bifurcations(i,6), 2, bifurcations(i,3));
end
fclose(fid)
end;
clear;clc;
load('distanceMatrix');
cnt = 1;
for i = 1:6
    routes{i} = combntns(1:19,i)
end
for i = 1:6
    for j = 1:length(routes{i})
        loads = 0;
        for k = 1:i
            loads = loads + z(routes{i}(j, k));
        end
        if loads <= 6.0
            finalroutes{cnt} = routes{i}(j,:);
            cnt = cnt + 1;
        end
    end
end
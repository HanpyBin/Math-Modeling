% 2669��·�����и��º������·�ߵ���С����
for i = 1:length(finalroutes)
    [lcosts(i),finalroutes1{i}] = computeLowCost(finalroutes{i}, total_loads(i), z, dist);
end
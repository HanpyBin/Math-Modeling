% 2669条路径进行更新和求出新路线的最小花费
for i = 1:length(finalroutes)
    [lcosts(i),finalroutes1{i}] = computeLowCost(finalroutes{i}, total_loads(i), z, dist);
end
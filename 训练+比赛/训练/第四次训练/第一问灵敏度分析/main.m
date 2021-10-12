clear, clc;
cnt = 1;
for i = 1.55:0.01:1.65
    dataprocess3(i);
    [target_val(cnt), target_co(cnt,:)] = ImperialistCompetitveAlgorithm_GlobalOptimizationStrategy();
    cnt = cnt + 1;
end
plot(1.55:.01:1.65,target_val);
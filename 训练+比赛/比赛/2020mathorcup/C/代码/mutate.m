function checkord = mutate(checkord, check)
% 复核台进行变异
mutatenum = randsample(90, 1);
for k = 1:mutatenum
    x = randsample(10, 1);
    y = randsample(9, 1);
    checkord(y, x) = check(randperm(length(check), 1));
end

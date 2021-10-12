clear;
[data, txt] = xlsread("2_obs_sta_jja_pre_553_1961_2005.csv");
NumOfDay = 92;
NumOfYear = 45;
NumOfSite = 553;
data = data(:,4:end);
for i = 1:NumOfSite
    [val,valord] = sort(data(:,i));
    threshold(i) = val(round(NumOfYear*NumOfDay*0.95));
    for j = 1:NumOfYear
        tempdata = data(1+NumOfDay*(j-1):NumOfDay*j,i);
        overval{j,i} = tempdata(find(tempdata >= threshold(i)));
    end
end
for i = 1:45
    for j = 2:553
        overval{i, 1} = [overval{i,1};overval{i,j}];
    end
end
for i = 1:45
    overvals{i,1} = overval{i, 1};
end
for i = 1:44
    overvals{1,1}= [overvals{1,1};overvals{i+1,1}];
end
phat = gamfit(overvals{1,1});
%overval = fillmissing(overval,'constant',0);
%save intens
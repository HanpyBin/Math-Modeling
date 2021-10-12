clear;
[data, txt] = xlsread("2_obs_sta_jja_pre_553_1961_2005.csv");
NumOfDay = 92;
NumOfYear = 45;
NumOfSite = 553;
data = data(:,4:end);
intens = zeros(NumOfYear, NumOfSite);
for i = 1:NumOfSite
    [val,valord] = sort(data(:,i));
    threshold(i) = val(round(NumOfYear*NumOfDay*0.95));
    for j = 1:NumOfYear
        tempdata = data(1+NumOfDay*(j-1):NumOfDay*j,i);
        intens(j,i) = mean(tempdata(find(tempdata >= threshold(i))));
    end
end
intens = fillmissing(intens,'constant',0);
save intens
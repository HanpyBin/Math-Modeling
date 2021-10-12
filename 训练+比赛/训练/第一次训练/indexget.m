%clear;
%[data,txt] = xlsread("2_obs_sta_jja_pre_553_1961_2005.csv");
dating = data(:,1:3);
data = data(:,4:end);
%% total_rain 总降水量(>1mm才计数)
for i = 1:45
    total_rain(i)=sum(data(find(data(1+92*(i-1):92*i,:)>1)));
end

%% 
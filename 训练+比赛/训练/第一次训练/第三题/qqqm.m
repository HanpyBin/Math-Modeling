% data全部加0.5保证没有0存在
load data_raw;
load data_fit;
data_raw = data_raw + 0.5;
data_fit = data_fit + 0.5;
for i = 1:553
    raw_gamcoef(i,1:2)=gamfit(data_raw(:,i));
    fit_gamcoef(i,1:2)=gamfit(data_fit(:,i));
end
for i = 1:553
    newfit_data(:,i) = gaminv(gamcdf(data_fit(:,i),fit_gamcoef(i,1),fit_gamcoef(i,2)),raw_gamcoef(i,1),raw_gamcoef(i,2))-0.5;
end
newfit_data(find(newfit_data<0))=0;
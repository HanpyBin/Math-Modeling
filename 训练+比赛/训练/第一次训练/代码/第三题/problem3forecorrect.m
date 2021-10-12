%% qm¶©Õý
%load data_fore;
%data_fore = data_fore - 0.5;
for i = 1:553
    newfit_fore(:,i) = gaminv(gamcdf(data_fore(:,i),fit_gamcoef(i,1),fit_gamcoef(i,2)),raw_gamcoef(i,1),raw_gamcoef(i,2))-0.5;
end
newfit_fore(find(newfit_fore<0))=0;
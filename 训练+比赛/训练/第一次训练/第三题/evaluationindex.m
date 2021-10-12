%clear;
%[data_raw,txt1] = xlsread("../2_obs_sta_jja_pre_553_1961_2005.csv");
%[data_fit,txt2] = xlsread("../3_BCC-CSM1.1-m.historical_1961-2005.csv");
%data_fit_date = data_fit(:,1:3);
%data_fit = data_fit(:,4:end);
%data_raw_date = data_raw(:,1:3);
%data_raw = data_raw(:,4:end);
load data_fit
load data_raw
% data_fit_norm = (data_fit - min([min(data_fit);min(data_raw)]))./(repmat(max([max(data_fit);max(data_raw)])-min([min(data_fit);min(data_raw)]),4140,1));
% data_raw_norm = (data_raw - min([min(data_fit);min(data_raw)]))./(repmat(max([max(data_fit);max(data_raw)])-min([min(data_fit);min(data_raw)]),4140,1));
% mse_m_o = sum((data_raw_norm-data_fit_norm).^2,2)/553;
% mse_o_o = var(data_fit_norm, 0, 2);
% SS = 1-mse_m_o./mse_o_o;
% plot(SS);
%set(gca,'YLim',[0 1])


%% M2
M2=(std(data_fit)./std(data_raw)-std(data_raw)./std(data_fit)).^2;
plot(M2);
%set(gca,'YLim',[0 1])
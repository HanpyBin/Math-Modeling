%load newfit_data
load data_raw
% data_fit_norm = (newfit_data - min([min(newfit_data);min(data_raw)]))./(repmat(max([max(newfit_data);max(data_raw)])-min([min(newfit_data);min(data_raw)]),4140,1));
% data_raw_norm = (data_raw - min([min(newfit_data);min(data_raw)]))./(repmat(max([max(newfit_data);max(data_raw)])-min([min(newfit_data);min(data_raw)]),4140,1));
% mse_m_o1 = sum((data_raw_norm-data_fit_norm).^2,2)/553;
% mse_o_o1 = var(data_fit_norm, 0, 2);
% SS1 = 1-mse_m_o1./mse_o_o1;
% plot(SS1);
%set(gca,'YLim',[0 1])


%% M2
% M21=(std(newfit_data)./std(data_raw)-std(data_raw)./std(newfit_data)).^2;
% plot(M21);
%set(gca,'YLim',[0 1])

%% LS method evaluation
load ls_data
data_fit_norm = (ls_data - min([min(ls_data);min(data_raw)]))./(repmat(max([max(ls_data);max(data_raw)])-min([min(ls_data);min(data_raw)]),4140,1));
data_raw_norm = (data_raw - min([min(ls_data);min(data_raw)]))./(repmat(max([max(ls_data);max(data_raw)])-min([min(ls_data);min(data_raw)]),4140,1));
mse_m_o2 = sum((data_raw_norm-data_fit_norm).^2,2)/553;
mse_o_o2 = var(data_fit_norm, 0, 2);
SS2 = 1-mse_m_o1./mse_o_o1;

%% M2
M22=(std(ls_data)./std(data_raw)-std(data_raw)./std(ls_data)).^2;
%plot(M22);
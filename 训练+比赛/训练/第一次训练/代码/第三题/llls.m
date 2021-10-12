load data_fit
load data_raw
ls_data = data_fit.*repmat((mean(data_raw)./mean(data_fit)),4140,1);
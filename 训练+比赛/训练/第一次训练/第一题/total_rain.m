% Ƶ�ʾ��Ǽ��˽���������ǿ�ȿ��Բ���֮ǰ��ǿ�ȣ������Ծ�������������
clear;
[data,txt] = xlsread("../2_obs_sta_jja_pre_553_1961_2005.csv");
dating = data(:,1:3);
data = data(:,4:end);
%%������
%% total_rain �ܽ�ˮ��(>1mm�ż���)
for i = 1:45
    for j = 1:553
        temp_data = data(1+92*(i-1):92*i,j);
        total_raining(i,j) = sum(temp_data(find(temp_data>1)));
        %total_rain(i,j)=sum(data(find(data(1+92*(i-1):92*i,:)>1)));
    end
end

%% CDD
for i = 1:45
    for j = 1:553
        temp_data = data(1+92*(i-1):92*i,j);
        maxcnt = 0;
        cnt = 0;
        flag = 0;
        for k = 1:92
            if temp_data(k) < 1
                if flag == 0
                    flag = 1;
                    cnt = cnt + 1;
                else
                    cnt = cnt + 1;
                end
                if cnt > maxcnt
                    maxcnt = cnt;
                end
            else
                if flag == 1
                    flag = 0;
                    cnt = 0;
                end
            end
        end
        cdd(i,j)=maxcnt;
    end
end

%% CWD
for i = 1:45
    for j = 1:553
        temp_data = data(1+92*(i-1):92*i,j);
        maxcnt = 0;
        cnt = 0;
        flag = 0;
        for k = 1:92
            if temp_data(k) >= 1
                if flag == 0
                    flag = 1;
                    cnt = cnt + 1;
                else
                    cnt = cnt + 1;
                end
                if cnt > maxcnt
                    maxcnt = cnt;
                end
            else
                if flag == 1
                    flag = 0;
                    cnt = 0;
                end
            end
        end
        cwd(i,j)=maxcnt;
    end
end

%%ǿ��
%%Rx1
for i = 1:45
    for j = 1:553
        temp_data = data(1+92*(i-1):92*i,j);
        rx1(i,j) = max(temp_data);
        %total_rain(i,j)=sum(data(find(data(1+92*(i-1):92*i,:)>1)));
    end
end

%%Rx5
for i = 1:45
    for j = 1:553
        temp_data = data(1+92*(i-1):92*i,j);
        for k = 1:92-4
            tempp_data(k) = sum(temp_data(k:k+4));
        end
        rx5(i,j) = max(tempp_data);
        %total_raining(i,j) = sum(temp_data(find(temp_data>1)));
        %total_rain(i,j)=sum(data(find(data(1+92*(i-1):92*i,:)>1)));
    end
end

%%Ƶ��
%%
NumOfDay = 92;
NumOfYear = 45;
NumOfSite = 553;
jiduan_days = zeros(NumOfYear, NumOfSite);
for i = 1:NumOfSite
    [val,valord] = sort(data(:,i));
    threshold(i) = val(round(NumOfYear*NumOfDay*0.95));
    for j = 1:NumOfYear
        tempdata = data(1+NumOfDay*(j-1):NumOfDay*j,i);
        jiduan_days(j,i) = length(tempdata(find(tempdata >= threshold(i))));
    end
end
jiduan_days = fillmissing(jiduan_days,'constant',0);
% [data,txt] = xlsread("../4_BCC-CSM1.1-m.rcp45_2006-2100.csv");
% dating = data(:,1:3);
% data = data(:,4:end);
% data1 = data(1:2760,:);
% data2 = data(2761:5520,:);
% data3 = data(5521:end,:);
%% total_rain 总降水量(>1mm才计数)
for i = 1:30
    for j = 1:553
        temp_data = data2(1+92*(i-1):92*i,j);
        total_raining2(i,j) = sum(temp_data(find(temp_data>1)));
    end
end
for i = 1:35
    for j = 1:553
        temp_data = data3(1+92*(i-1):92*i,j);
        total_raining3(i,j) = sum(temp_data(find(temp_data>1)));
    end
end
%% 阈值和强度
for i = 1:553
    [val,valord] = sort(data2(:,i));
    threshold2(i) = val(floor(30*92*0.95));
    for j = 1:30
        tempdata = data2(1+92*(j-1):92*j,i);
        intens2(j,i) = mean(tempdata(find(tempdata >= threshold2(i))));
    end
end
intens2 = fillmissing(intens2,'constant',0);
for i = 1:553
    [val,valord] = sort(data3(:,i));
    threshold3(i) = val(floor(30*92*0.95));
    for j = 1:35
        tempdata = data3(1+92*(j-1):92*j,i);
        intens3(j,i) = mean(tempdata(find(tempdata >= threshold3(i))));
    end
end
intens3 = fillmissing(intens3,'constant',0);

%% CDD
for i = 1:30
    for j = 1:553
        temp_data = data2(1+92*(i-1):92*i,j);
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
        cdd2(i,j)=maxcnt;
    end
end

for i = 1:35
    for j = 1:553
        temp_data = data3(1+92*(i-1):92*i,j);
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
        cdd3(i,j)=maxcnt;
    end
end

%% CWD
for i = 1:30
    for j = 1:553
        temp_data = data2(1+92*(i-1):92*i,j);
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
        cwd2(i,j)=maxcnt;
    end
end

for i = 1:35
    for j = 1:553
        temp_data = data3(1+92*(i-1):92*i,j);
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
        cwd3(i,j)=maxcnt;
    end
end

%% Rx1
for i = 1:30
    for j = 1:553
        temp_data = data2(1+92*(i-1):92*i,j);
        rx12(i,j) = max(temp_data);
    end
end

for i = 1:35
    for j = 1:553
        temp_data = data3(1+92*(i-1):92*i,j);
        rx13(i,j) = max(temp_data);
    end
end

%% Rx5
for i = 1:30
    for j = 1:553
        temp_data = data2(1+92*(i-1):92*i,j);
        for k = 1:92-4
            tempp_data(k) = sum(temp_data(k:k+4));
        end
        rx52(i,j) = max(tempp_data);
    end
end

for i = 1:35
    for j = 1:553
        temp_data = data3(1+92*(i-1):92*i,j);
        for k = 1:92-4
            tempp_data(k) = sum(temp_data(k:k+4));
        end
        rx53(i,j) = max(tempp_data);
    end
end
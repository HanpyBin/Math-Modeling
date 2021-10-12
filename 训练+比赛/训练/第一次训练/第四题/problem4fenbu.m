clear;
load newfit_fore

data1 = newfit_fore(1:2760,:);
data2 = newfit_fore(2761:5520,:);
data3 = newfit_fore(5521:end,:);

%% 中世纪
NumOfDay = 92;
NumOfYear = 30;
NumOfSite = 553;
for i = 1:NumOfSite
    [val,valord] = sort(data2(:,i));
    threshold2(i) = val(round(NumOfYear*NumOfDay*0.95));
    for j = 1:NumOfYear
        tempdata = data2(1+NumOfDay*(j-1):NumOfDay*j,i);
        overval2{j,i} = tempdata(find(tempdata >= threshold2(i)));
    end
end
for i = 1:30
    for j = 2:553
        overval2{i, 1} = [overval2{i,1};overval2{i,j}];
    end
end
for i = 1:30
    overvals2{i,1} = overval2{i, 1};
end
for i = 1:30
    temp = overvals2{i,1};
    ord = find(isinf(temp)==1);
    overvals2{i,1}(ord) = min(temp);
    cnt2(i) = length(overvals2{i,1});
end
for i = 1:29
    overvals2{1,1}=[overvals2{1,1};overvals2{i+1,1}];
end
phat2=gamfit(overvals2{1,1});
% for i = 1:30
%     phat2(i,1:2)=g
%overval = fillmissing(overval,'constant',0);
%save intens

%% 后世纪
NumOfDay = 92;
NumOfYear = 35;
NumOfSite = 553;
for i = 1:NumOfSite
    [val,valord] = sort(data3(:,i));
    threshold3(i) = val(round(NumOfYear*NumOfDay*0.95));
    for j = 1:NumOfYear
        tempdata = data3(1+NumOfDay*(j-1):NumOfDay*j,i);
        overval3{j,i} = tempdata(find(tempdata >= threshold3(i)));
    end
end
for i = 1:35
    for j = 2:553
        overval3{i, 1} = [overval3{i,1};overval3{i,j}];
    end
end
for i = 1:35
    overvals3{i,1} = overval3{i, 1};
end
for i = 1:35
    temp = overvals3{i,1};
    ord = find(isinf(temp)==1);
    overvals3{i,1}(ord) = min(temp);
    cnt3(i) = length(overvals3{i,1});
end
for i = 1:34
    overvals3{1,1}=[overvals3{1,1};overvals3{i+1,1}];
end
phat3=gamfit(overvals3{1,1});
%overval = fillmissing(overval,'constant',0);
%save intens
function TheEmpire = AssimilateColonies(TheEmpire,dismat)
NumOfCities = size(TheEmpire.ImperialistPosition, 2);
assimilateprob = 0.5;
for j = 1:size(TheEmpire.ColoniesPosition, 1)
    vis = zeros(1, NumOfCities);
    posi = rand(1, NumOfCities); % Step 1
    R = find(posi >= assimilateprob);
    newColoniesPosition = zeros(1, NumOfCities);
    newColoniesPosition(R) = TheEmpire.ImperialistPosition(R); % Step 2
    vis(TheEmpire.ImperialistPosition(R)) = 1;
    for k = 1:NumOfCities % Step 3
        pos = find(newColoniesPosition == TheEmpire.ColoniesPosition(j, k));
        if isempty(pos) == 0
            newColoniesPosition(pos) = TheEmpire.ColoniesPosition(j,k);
            vis(TheEmpire.ColoniesPosition(j,k)) = 1;
        end
    end
    % Step 4
    notappearcities = find(vis == 0);
    notappearpos = find(newColoniesPosition == 0);
    for i = 1:length(notappearcities)
        minidiff = inf;
        ord = 1;
        for k = 1:length(notappearpos)
            if notappearpos(k) == 1 && newColoniesPosition(NumOfCities) ~= 0 && newColoniesPosition(2) ~= 0
                tempdiff = dismat(notappearcities(i),newColoniesPosition(NumOfCities)) + ...
                    dismat(notappearcities(i),newColoniesPosition(2)) - dismat(newColoniesPosition(NumOfCities),newColoniesPosition(2));
                if tempdiff < minidiff
                    minidiff = tempdiff;
                    ord = k;
                end
                continue;
            end
            if notappearpos(k) == NumOfCities && newColoniesPosition(NumOfCities-1) ~= 0 && newColoniesPosition(1) ~= 0
                tempdiff = dismat(notappearcities(i),newColoniesPosition(NumOfCities-1)) + ...
                    dismat(notappearcities(i),newColoniesPosition(1)) - dismat(newColoniesPosition(NumOfCities-1),newColoniesPosition(1));
                if tempdiff < minidiff
                    minidiff = tempdiff;
                    ord = k;
                end
                continue;
            end
            temppos = notappearpos(k);
            if temppos == 1 || temppos == NumOfCities
                continue;
            end
            %temppos
            if newColoniesPosition(temppos-1) ~= 0 && newColoniesPosition(temppos+1)~=0
                tempdiff = dismat(notappearcities(i),newColoniesPosition(temppos-1)) + ...
                    dismat(notappearcities(i),newColoniesPosition(temppos+1))-dismat(newColoniesPosition(temppos-1),newColoniesPosition(temppos+1));
                if tempdiff < minidiff
                    minidiff = tempdiff;
                    ord = k;
                end
            end
        end
        %notappearpos
        %ord
        %notappearpos(ord)
        %newColoniesPosition
        %notappearpos
        %ord
        newColoniesPosition(notappearpos(ord)) = notappearcities(i);
        % 考虑某个位置已经被插入城市，如果跳过
        notappearpos = find(newColoniesPosition == 0);
    end
end
function [TheEmpire, EmpireCandidate]=ImperialisticReinforce(TheEmpire, dismat)
% 暂时先不产生新帝国吧，我偷懒一直可以的
NumOfCities = size(TheEmpire.ImperialistPosition, 2);
newColoniesPosition = TheEmpire.ImperialistPosition;
posperm = randperm(NumOfCities);
posa = min(posperm(1), posperm(2));
posb = max(posperm(1), posperm(2));
newColoniesPosition(posa:posb) = newColoniesPosition(posb:-1:posa);
NumOfRemove = round(NumOfCities/10);
removecities = randperm(NumOfCities);
removecities = removecities(1:NumOfRemove);
removed = newColoniesPosition(removecities);
newColoniesPosition(removecities) = 0;
removedperms = perms(removed);
minidis = inf;
for k = 1:size(removedperms, 1)
    route = newColoniesPosition;
    route(removecities) = removedperms(k,:);
    tempdis = getdistance(route,dismat);
    if tempdis < minidis
        minidis = tempdis;
        ord = k;
    end
end
newColoniesPosition(removecities) = removedperms(ord, :);
if minidis < TheEmpire.ImperialistCost
    OldImperialistPosition = TheEmpire.ImperialistPosition;
    OldImperialistCost = TheEmpire.ImperialistCost;
    
    TheEmpire.ImperialistPosition = newColoniesPosition;
    TheEmpire.ImperialistCost = minidis;
    
    EmpireCandidate.ImperialistPosition = OldImperialistPosition;
    EmpireCandidate.ImperialistCost = OldImperialistCost;
    %TheEmpire.ColoniesPosition(i, :) = OldImperialistPosition;
    %TheEmpire.ColoniesCost(i) = OldImperialistCost;
else
    EmpireCandidate.ImperialistPosition = newColoniesPosition;
    EmpireCandidate.ImperialistCost = minidis;
end
%TheEmpire
% for i =1:size(TheEmpire.ColoniesPosition, 1)
%     newColoniesPosition = TheEmpire.ColoniesPosition(i,:);
%     posperm = randperm(NumOfCities);
%     posa = min(posperm(1), posperm(2));
%     posb = max(posperm(1), posperm(2));
%     newColoniesPosition(posa:posb) = newColoniesPosition(posb:-1:posa);
%     NumOfRemove = round(NumOfCities/10);
%     removecities = randperm(NumOfCities);
%     removecities = removecities(1:NumOfRemove);
%     removed = newColoniesPosition(removecities);
%     newColoniesPosition(removecities) = 0;
%
%     removedperms = perms(removed);
%     minidis = inf;
%     for k = 1:size(removedperms, 1)
%         route = newColoniesPosition;
%         route(removecities) = removedperms(k,:);
%         tempdis = getdistance(route,dismat);
%         if tempdis < minidis
%             minidis = tempdis;
%             ord = k;
%         end
%     end
%     newColoniesPosition(removecities) = removedperms(ord);
%
%     if minidis < TheEmpire.ImperialistCost
%         OldImperialistPosition = Empire.ImperialistPosition;
%         OldImperialistCost = Empire.ImperialistCost;
%
%         Empire.ImperialistPosition = newColoniesPosition;
%         Empire.ImperialCost = minidis;
%
%         Empire.ColoniesPosition(i, :) = OldImperialistPosition;
%         Empire.ColoniesCost(i) = OldImperialistCost;
%     end
% end
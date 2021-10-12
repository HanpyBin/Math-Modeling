function Empires = CreateInitialEmpires(InitialCountries,InitialCost,AlgorithmParams, ProblemParams)

AllImperialistsPosition = InitialCountries(1:AlgorithmParams.NumOfInitialImperialists,:);
AllImperialistsCost = InitialCost(1:AlgorithmParams.NumOfInitialImperialists,:);

AllColoniesPosition = InitialCountries(AlgorithmParams.NumOfInitialImperialists+1:end,:);
AllColoniesCost = InitialCost(AlgorithmParams.NumOfInitialImperialists+1:end,:);

if max(AllImperialistsCost)>0
    AllImperialistsPower = 1.3 * max(AllImperialistsCost) - AllImperialistsCost;
else
    AllImperialistsPower = 0.7 * max(AllImperialistsCost) - AllImperialistsCost;
end

AllImperialistNumOfColonies = round(AllImperialistsPower/sum(AllImperialistsPower) * AlgorithmParams.NumOfAllColonies);
AllImperialistNumOfColonies(end) = AlgorithmParams.NumOfAllColonies - sum(AllImperialistNumOfColonies(1:end-1));
RandomIndex = randperm(AlgorithmParams.NumOfAllColonies);

Empires(AlgorithmParams.NumOfInitialImperialists).ImperialistPosition = 0;

for ii = 1:AlgorithmParams.NumOfInitialImperialists
    Empires(ii).ImperialistPosition = AllImperialistsPosition(ii,:);
    Empires(ii).ImperialistCost = AllImperialistsCost(ii,:);
    R = RandomIndex(1:AllImperialistNumOfColonies(ii)); 
    RandomIndex = RandomIndex(AllImperialistNumOfColonies(ii)+1:end);
    % 个人认为RandomIndex(AllImperialistNumOfColonies(ii)+1:end);有问题
    % 应该改为RandomIndex = RandomIndex(AllImperialistNumOfColonies(ii)+1:end);
    Empires(ii).ColoniesPosition = AllColoniesPosition(R,:);
    Empires(ii).ColoniesCost = AllColoniesCost(R,:);
    Empires(ii).TotalCost = Empires(ii).ImperialistCost + AlgorithmParams.Zeta * mean(Empires(ii).ColoniesCost);
end

for ii = 1:numel(Empires)
    if numel(Empires(ii).ColoniesPosition) == 0
        Empires(ii).ColoniesPosition = GenerateNewCountry(1,ProblemParams);                 % 
        Empires(ii).ColoniesCost = feval(ProblemParams.CostFuncName,Empires(ii).ColoniesPosition);
    end
end

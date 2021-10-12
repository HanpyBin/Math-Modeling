function TheEmpire = AssimilateColonies(TheEmpire,AlgorithmParams,ProblemParams)

% for i = 1:numel(Imperialists)
%     Imperialists{i}.Number_of_Colonies_matrix = [Imperialists{i}.Number_of_Colonies_matrix      Imperialists{i}.Number_of_Colonies];
%
%     Imperialists_cost_matrix (i) = Imperialists{i}.cost_just_by_itself;
%
%     Imperialists_position_matrix(i,:) = Imperialists{i}.position;

NumOfColonies = size(TheEmpire.ColoniesPosition,1);

Vector = repmat(TheEmpire.ImperialistPosition,NumOfColonies,1)-TheEmpire.ColoniesPosition;

% ?这里怎么没用上偏移角度？
TheEmpire.ColoniesPosition = TheEmpire.ColoniesPosition + AlgorithmParams.AssimilationCoefficient * rand(size(Vector)) .* Vector;
TheEmpire.ColoniesPosition = round(TheEmpire.ColoniesPosition);
TheEmpire.ColoniesPosition = sort(TheEmpire.ColoniesPosition,2);
MinVarMatrix = repmat(ProblemParams.VarMin,NumOfColonies,1);
MaxVarMatrix = repmat(ProblemParams.VarMax,NumOfColonies,1);

% 这一步是将非解空间的解拉回边界
TheEmpire.ColoniesPosition=max(TheEmpire.ColoniesPosition,MinVarMatrix);
TheEmpire.ColoniesPosition=min(TheEmpire.ColoniesPosition,MaxVarMatrix);

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
TheEmpire.ColoniesPosition = TheEmpire.ColoniesPosition + 2 * AlgorithmParams.AssimilationCoefficient * rand(size(Vector)) .* Vector;

TheEmpire.ColoniesPosition = fix_coordinate1(TheEmpire.ColoniesPosition);

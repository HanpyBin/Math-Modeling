function TheEmpire = RevolveColonies(TheEmpire,AlgorithmParams,ProblemParams)
    NumOfRevolvingColonies = ceil(AlgorithmParams.RevolutionRate * numel(TheEmpire.ColoniesCost));
    RevolvedPosition = GenerateNewCountry(NumOfRevolvingColonies , ProblemParams);
    R = randperm(numel(TheEmpire.ColoniesCost));
    R = R(1:NumOfRevolvingColonies);
    TheEmpire.ColoniesPosition(R,:) = RevolvedPosition;
end
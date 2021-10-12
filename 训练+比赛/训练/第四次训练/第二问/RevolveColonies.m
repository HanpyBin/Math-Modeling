function TheEmpire = RevolveColonies(TheEmpire,AlgorithmParams,ProblemParams)
    NumOfRevolvingColonies = round(AlgorithmParams.RevolutionRate * numel(TheEmpire.ColoniesCost));
    if NumOfRevolvingColonies > 0
        RevolvedPosition = GenerateNewCountry(NumOfRevolvingColonies , ProblemParams);
        R = randperm(numel(TheEmpire.ColoniesCost));
        R = R(1:NumOfRevolvingColonies);
        TheEmpire.ColoniesPosition(R,:) = RevolvedPosition;
    end
end
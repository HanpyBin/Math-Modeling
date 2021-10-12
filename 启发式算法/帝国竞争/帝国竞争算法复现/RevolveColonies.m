function TheEmpire = RevolveColonies(TheEmpire,AlgorithmParams)
    NumOfRevolvingColonies = round(AlgorithmParams.RevolutionRate * numel(TheEmpire.ColoniesCost));
    if NumOfRevolvingColonies > numel(TheEmpire)
        NumOfRevolvingColonies = numel(TheEmpire);
    end
    for i = 1:NumOfRevolvingColonies
        posperm = randperm(size(TheEmpire.ImperialistPosition,2));
        posa = min(posperm(1), posperm(2));
        posb = max(posperm(1), posperm(2));
        TheEmpire.ColoniesPosition(i, posa:posb) = TheEmpire.ColoniesPosition(i, posb:-1:posa);
        %t = TheEmpire.ColoniesPosition(i, posa);
        %TheEmpire.ColoniesPosition(i, posa) = TheEmpire.ColoniesPosition(i, posb);
        %TheEmpire.ColoniesPosition(i, posb) = t;
    end
end
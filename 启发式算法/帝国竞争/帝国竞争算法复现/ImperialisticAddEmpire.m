function Empires = ImperialisticAddEmpire(Empires, EmpireCandidate,ProblemParams, dismat)
if rand > 0.95
    Cost = EmpireCandidate.ImperialistCost;
    [~, order] = sort(Cost);
    newEmpire = EmpireCandidate(order(1));
    newEmpire.ColoniesPosition = GenerateNewCountry(1,ProblemParams);
    newEmpire.ColoniesCost = feval(ProblemParams.CostFuncName,newEmpire.ColoniesPosition, dismat);
    newEmpire.TotalCost = 0;
    Empires(end+1) = newEmpire;
end
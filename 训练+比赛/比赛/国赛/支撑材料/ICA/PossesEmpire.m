function TheEmpire = PossesEmpire(TheEmpire)
    
    ColoniesCost = TheEmpire.ColoniesCost;

    [MinColoniesCost BestColonyInd]=min(ColoniesCost);
    if MinColoniesCost < TheEmpire.ImperialistCost

        OldImperialistPosition = TheEmpire.ImperialistPosition;
        OldImperialistCost = TheEmpire.ImperialistCost;

        TheEmpire.ImperialistPosition = TheEmpire.ColoniesPosition(BestColonyInd,:);
        TheEmpire.ImperialistCost = TheEmpire.ColoniesCost(BestColonyInd);

        TheEmpire.ColoniesPosition(BestColonyInd,:) = OldImperialistPosition;
        TheEmpire.ColoniesCost(BestColonyInd) = OldImperialistCost;
    end

end
function TheEmpire = PossesEmpire(TheEmpire)
    
    ColoniesCost = TheEmpire.ColoniesCost;

    [MinColoniesCost BestColonyInd]=min(ColoniesCost);
    if MinColoniesCost < TheEmpire.ImperialistCost

        OldImperialistPosition = TheEmpire.ImperialistPosition;
        OldImperialistCost = TheEmpire.ImperialistCost;
        OldImperialistOrds = TheEmpire.ImperialistOrds;
        TheEmpire.ImperialistPosition = TheEmpire.ColoniesPosition(BestColonyInd,:);
        TheEmpire.ImperialistCost = TheEmpire.ColoniesCost(BestColonyInd);
        TheEmpire.ImperialistOrds = TheEmpire.ColoniesOrds(BestColonyInd, :);
        TheEmpire.ColoniesPosition(BestColonyInd,:) = OldImperialistPosition;
        TheEmpire.ColoniesCost(BestColonyInd) = OldImperialistCost;
        TheEmpire.ColoniesOrds(BestColonyInd, :) = OldImperialistOrds;
    end

end
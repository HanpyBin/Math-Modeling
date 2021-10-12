function Empires=ImperialisticCompetition(Empires)
    if rand > .11 
        return
    end
    if numel(Empires)<=1
        return;
    end

    TotalCosts = [Empires.TotalCost];
    [MaxTotalCost WeakestEmpireInd] = max(TotalCosts);
    TotalPowers = MaxTotalCost - TotalCosts;
    PossessionProbability = TotalPowers / sum(TotalPowers);
    
    SelectedEmpireInd = SelectAnEmpire(PossessionProbability);
    
    nn = numel(Empires(WeakestEmpireInd).ColoniesCost);
    jj = myrandint(nn,1,1);
    
    Empires(SelectedEmpireInd).ColoniesPosition = [Empires(SelectedEmpireInd).ColoniesPosition
                                                   Empires(WeakestEmpireInd).ColoniesPosition(jj,:)];
                                               
    Empires(SelectedEmpireInd).ColoniesCost = [Empires(SelectedEmpireInd).ColoniesCost
                                               Empires(WeakestEmpireInd).ColoniesCost(jj)];

    Empires(WeakestEmpireInd).ColoniesPosition = Empires(WeakestEmpireInd).ColoniesPosition([1:jj-1 jj+1:end],:);
    Empires(WeakestEmpireInd).ColoniesCost = Empires(WeakestEmpireInd).ColoniesCost([1:jj-1 jj+1:end],:);
            
    %% Collapse of the the weakest colony-less Empire
    nn = numel(Empires(WeakestEmpireInd).ColoniesCost);
    if nn<=1
        Empires(SelectedEmpireInd).ColoniesPosition = [Empires(SelectedEmpireInd).ColoniesPosition
                                                       Empires(WeakestEmpireInd).ImperialistPosition];

        Empires(SelectedEmpireInd).ColoniesCost = [Empires(SelectedEmpireInd).ColoniesCost
                                                   Empires(WeakestEmpireInd).ImperialistCost];
                                               
        Empires=Empires([1:WeakestEmpireInd-1 WeakestEmpireInd+1:end]);
    end

end

function Index = SelectAnEmpire(Probability)
    R = rand(size(Probability));
    D = Probability - R;
    [MaxD Index] = max(D);
end

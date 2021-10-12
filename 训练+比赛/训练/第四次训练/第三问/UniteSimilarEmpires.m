function Empires=UniteSimilarEmpires(Empires,AlgorithmParams,ProblemParams)
    
    TheresholdDistance = AlgorithmParams.UnitingThreshold * norm(ProblemParams.SearchSpaceSize);
    NumOfEmpires = numel(Empires);

    for ii = 1:NumOfEmpires-1
        for jj = ii+1:NumOfEmpires
            DistanceVector = Empires(ii).ImperialistPosition - Empires(jj).ImperialistPosition;
            Distance = norm(DistanceVector);
            if Distance<=TheresholdDistance
                if Empires(ii).ImperialistCost < Empires(jj).ImperialistCost
                    BetterEmpireInd=ii;
                    WorseEmpireInd=jj;
                else
                    BetterEmpireInd=jj;
                    WorseEmpireInd=ii;
                end
                
                Empires(BetterEmpireInd).ColoniesPosition = [Empires(BetterEmpireInd).ColoniesPosition
                                                             Empires(WorseEmpireInd).ImperialistPosition
                                                             Empires(WorseEmpireInd).ColoniesPosition];
                
                Empires(BetterEmpireInd).ColoniesCost = [Empires(BetterEmpireInd).ColoniesCost
                                                         Empires(WorseEmpireInd).ImperialistCost
                                                         Empires(WorseEmpireInd).ColoniesCost];
                
                Empires(BetterEmpireInd).ColoniesOrds = [Empires(BetterEmpireInd).ColoniesOrds
                                                         Empires(WorseEmpireInd).ImperialistOrds
                                                         Empires(WorseEmpireInd).ColoniesOrds];
                % Update TotalCost for new United Empire                                     
                Empires(BetterEmpireInd).TotalCost = Empires(BetterEmpireInd).ImperialistCost + AlgorithmParams.Zeta * mean(Empires(BetterEmpireInd).ColoniesCost);
                                     
                Empires = Empires([1:WorseEmpireInd-1 WorseEmpireInd+1:end]);
                return;
            end
            
        end
    end
    
end

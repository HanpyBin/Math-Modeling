function DisplayEmpires(Empires,AlgorithmParams,ProblemParams,DisplayParams)
    
    if ~DisplayParams.PlotEmpires
        return;
    end
    
    if (ProblemParams.NPar ~= 2) && (ProblemParams.NPar ~= 3)
        return;
    end

    if ~any(findall(0)==DisplayParams.EmpiresFigureHandle)
        return;
    end
    
    
    if ProblemParams.NPar == 2
        for ii = 1:numel(Empires)
            plot(DisplayParams.EmpiresAxisHandle,Empires(ii).ImperialistPosition(1),Empires(ii).ImperialistPosition(2),'p',...
                'MarkerEdgeColor','k',...
                'MarkerFaceColor',DisplayParams.ColorMatrix(ii,:),...
                'MarkerSize',70*numel(Empires(ii).ColoniesCost)/AlgorithmParams.NumOfAllColonies + 13);
            hold on
            
            plot(DisplayParams.EmpiresAxisHandle,Empires(ii).ColoniesPosition(:,1),Empires(ii).ColoniesPosition(:,2),'ok',...
                'MarkerEdgeColor','k',...
                'MarkerFaceColor',DisplayParams.ColorMatrix(ii,:),...
                'MarkerSize',8);
        end
        
        xlim([DisplayParams.AxisMargin.Min(1) DisplayParams.AxisMargin.Max(1)]);
        ylim([DisplayParams.AxisMargin.Min(2) DisplayParams.AxisMargin.Max(2)]);
        hold off
    end

    if  ProblemParams.NPar == 3
        figure(1)
        for ii = 1:numel(Empires)
            plot3(DisplayParams.EmpiresAxisHandle,Empires(ii).ImperialistPosition(1),Empires(ii).ImperialistPosition(2),Empires(ii).ImperialistPosition(3),'p',...
                'MarkerEdgeColor','k',...
                'MarkerFaceColor',DisplayParams.ColorMatrix(ii,:),...
                'MarkerSize',70*numel(Empires(ii).ColoniesCost)/AlgorithmParams.NumOfAllColonies + 13);
            hold on
            
            plot3(DisplayParams.EmpiresAxisHandle,Empires(ii).ColoniesPosition(:,1),Empires(ii).ColoniesPosition(:,2),Empires(ii).ColoniesPosition(:,3),'ok',...
                'MarkerEdgeColor','k',...
                'MarkerFaceColor',DisplayParams.ColorMatrix(ii,:),...
                'MarkerSize',8);
        end

        xlim([DisplayParams.AxisMargin.Min(1) DisplayParams.AxisMargin.Max(1)]);
        ylim([DisplayParams.AxisMargin.Min(2) DisplayParams.AxisMargin.Max(2)]);
        zlim([DisplayParams.AxisMargin.Min(3) DisplayParams.AxisMargin.Max(3)]);
        hold off
    end
    
    pause(0.05);
end
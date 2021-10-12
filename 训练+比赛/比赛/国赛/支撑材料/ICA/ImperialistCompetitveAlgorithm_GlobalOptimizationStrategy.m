close all
clc; clear
global s;

%% Problem Statement
ProblemParams.CostFuncName = 'rbtestsinfunc';
ProblemParams.CostFuncExtraParams = '';
ProblemParams.NPar = 3;
ProblemParams.VarMin = -1;
ProblemParams.VarMax = 2;

if numel(ProblemParams.VarMin)==1
    ProblemParams.VarMin=repmat(ProblemParams.VarMin,1,ProblemParams.NPar);
    ProblemParams.VarMax=repmat(ProblemParams.VarMax,1,ProblemParams.NPar);
end

ProblemParams.SearchSpaceSize = ProblemParams.VarMax - ProblemParams.VarMin;

s = [];
%% Algorithmic Parameter Setting
AlgorithmParams.NumOfCountries = 200;
AlgorithmParams.NumOfInitialImperialists = 8;
AlgorithmParams.NumOfAllColonies = AlgorithmParams.NumOfCountries - AlgorithmParams.NumOfInitialImperialists;
AlgorithmParams.NumOfDecades = 2000;
AlgorithmParams.RevolutionRate = 0.3;
AlgorithmParams.AssimilationCoefficient = 2;
AlgorithmParams.AssimilationAngleCoefficient = .5;
AlgorithmParams.Zeta = 0.02;
AlgorithmParams.DampRatio = 0.99;
AlgorithmParams.StopIfJustOneEmpire = false;
AlgorithmParams.UnitingThreshold = 0.02;

zarib = 1.05;
alpha = 0.1;

%% Display Setting
DisplayParams.PlotEmpires = false;
if DisplayParams.PlotEmpires
    DisplayParams.EmpiresFigureHandle = figure('Name','Plot of Empires','NumberTitle','off');
    DisplayParams.EmpiresAxisHandle = axes;
end

DisplayParams.PlotCost = true;    % "true" to plot. "false"
if DisplayParams.PlotCost
    DisplayParams.CostFigureHandle = figure('Name','Plot of Minimum and Mean Costs','NumberTitle','off');
    DisplayParams.CostAxisHandle = axes; 
end

ColorMatrix = [1   0   0  ; 0 1   0    ; 0   0 1    ; 1   1   0  ; 1   0 1    ; 0 1   1    ; 1 1 1       ;
               0.5 0.5 0.5; 0 0.5 0.5  ; 0.5 0 0.5  ; 0.5 0.5 0  ; 0.5 0 0    ; 0 0.5 0    ; 0 0 0.5     ;
               1   0.5 1  ; 0.1*[1 1 1]; 0.2*[1 1 1]; 0.3*[1 1 1]; 0.4*[1 1 1]; 0.5*[1 1 1]; 0.6*[1 1 1]];
DisplayParams.ColorMatrix = [ColorMatrix ; sqrt(ColorMatrix)];

DisplayParams.AxisMargin.Min = ProblemParams.VarMin;
DisplayParams.AxisMargin.Max = ProblemParams.VarMax;

%% Creation of Initial Empires
InitialCountries = GenerateNewCountry(AlgorithmParams.NumOfCountries , ProblemParams);

% Calculates the cost of each country. The less the cost is, the more is the power.
if isempty(ProblemParams.CostFuncExtraParams)
    InitialCost = feval(ProblemParams.CostFuncName,InitialCountries);    
else
    InitialCost = feval(ProblemParams.CostFuncName,InitialCountries,ProblemParams.CostFuncExtraParams);
end
[InitialCost,SortInd] = sort(InitialCost);                          % Sort the cost in assending order. The best countries will be in higher places
InitialCountries = InitialCountries(SortInd,:);                     % Sort the population with respect to their cost.

Empires = CreateInitialEmpires(InitialCountries,InitialCost,AlgorithmParams, ProblemParams);

%% Main Loop
MinimumCost = repmat(nan,AlgorithmParams.NumOfDecades,1);
MeanCost = repmat(nan,AlgorithmParams.NumOfDecades,1);

if DisplayParams.PlotCost
    axes(DisplayParams.CostAxisHandle);
    if any(findall(0)==DisplayParams.CostFigureHandle)
        h_MinCostPlot=plot(MinimumCost,'r','LineWidth',1.5,'YDataSource','MinimumCost');
        hold on;
        h_MeanCostPlot=plot(MeanCost,'k:','LineWidth',1.5,'YDataSource','MeanCost');
        hold off;
        pause(0.05);
    end
end

for Decade = 1:AlgorithmParams.NumOfDecades
    AlgorithmParams.RevolutionRate = AlgorithmParams.DampRatio * AlgorithmParams.RevolutionRate;

    Remained = AlgorithmParams.NumOfDecades - Decade
    for ii = 1:numel(Empires)
        %% Assimilation;  Movement of Colonies Toward Imperialists (Assimilation Policy)
        Empires(ii) = AssimilateColonies(Empires(ii),AlgorithmParams,ProblemParams);

        %% Revolution;  A Sudden Change in the Socio-Political Characteristics
        % 该殖民地改革操作可能导致势力较强的殖民地丢失，导致寻优精度降低
        Empires(ii) = RevolveColonies(Empires(ii),AlgorithmParams,ProblemParams);
        
        %% New Cost Evaluation
        if isempty(ProblemParams.CostFuncExtraParams)
            Empires(ii).ColoniesCost = feval(ProblemParams.CostFuncName,Empires(ii).ColoniesPosition);
        else
            Empires(ii).ColoniesCost = feval(ProblemParams.CostFuncName,Empires(ii).ColoniesPosition,ProblemParams.CostFuncExtraParams);
        end

        %% Empire Possession  (****** Power Possession, Empire Possession)
        Empires(ii) = PossesEmpire(Empires(ii));
        
        %% Computation of Total Cost for Empires
        Empires(ii).TotalCost = Empires(ii).ImperialistCost + AlgorithmParams.Zeta * mean(Empires(ii).ColoniesCost);
    
    end
    
    %% Uniting Similiar Empires
    Empires = UniteSimilarEmpires(Empires,AlgorithmParams,ProblemParams);

    %% Imperialistic Competition
    Empires = ImperialisticCompetition(Empires);
    
    if numel(Empires) == 1 && AlgorithmParams.StopIfJustOneEmpire
        break
    end

    %% Displaying the Results
    DisplayEmpires(Empires,AlgorithmParams,ProblemParams,DisplayParams);
    
    ImerialistCosts = [Empires.ImperialistCost];
    MinimumCost(Decade) = min(ImerialistCosts);
    MeanCost(Decade) = mean(ImerialistCosts);

    if DisplayParams.PlotCost
        refreshdata(h_MinCostPlot);
        refreshdata(h_MeanCostPlot);
        drawnow;
        pause(0.01);
    end
    
end
MinimumCost(end)
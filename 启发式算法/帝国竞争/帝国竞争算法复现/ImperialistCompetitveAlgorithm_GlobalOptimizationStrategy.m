%% Imperialist Competitive Algorithm (ICA);
tic
%close all
clc; clear
load data
%% Problem Statement
% cities=[16.4700 96.1000
% 16.4700 94.4400
% 20.0900 92.5400
% 22.3900 93.3700
% 25.2300 97.2400
% 22.0000 96.0500
% 20.4700 97.0200
% 17.2000 96.2900
% 16.3000 97.3800
% 14.0500 98.1200
% 16.5300 97.3800
% 21.5200 95.5900
% 19.4100 97.1300
% 20.0900 92.5500];
ProblemParams.CostFuncName = 'getdistance';
ProblemParams.CostFuncExtraParams = '';
ProblemParams.NPar = 34;                           % Number of optimization variables of your objective function. "NPar" is the dimention of the optimization problem.
                                                   % the number of the city
                                                   % in TSP problem

%ProblemParams.SearchSpaceSize = ProblemParams.VarMax - ProblemParams.VarMin;

%% Algorithmic Parameter Setting
AlgorithmParams.NumOfCountries = 200;               % Number of initial countries.
AlgorithmParams.NumOfInitialImperialists = 8;      % Number of Initial Imperialists.
AlgorithmParams.NumOfAllColonies = AlgorithmParams.NumOfCountries - AlgorithmParams.NumOfInitialImperialists;
AlgorithmParams.NumOfDecades = 1000;
AlgorithmParams.RevolutionRate = 0.3;               % Revolution is the process in which the socio-political characteristics of a country change suddenly.
AlgorithmParams.AssimilationCoefficient = 2;        % In the original paper assimilation coefficient is shown by "beta".
AlgorithmParams.AssimilationAngleCoefficient = .5;  % In the original paper assimilation angle coefficient is shown by "gama".
AlgorithmParams.Zeta = 0.02;                        % Total Cost of Empire = Cost of Imperialist + Zeta * mean(Cost of All Colonies);
AlgorithmParams.DampRatio = 0.99;
AlgorithmParams.StopIfJustOneEmpire = false;         % Use "true" to stop the algorithm when just one empire is remaining. Use "false" to continue the algorithm.
AlgorithmParams.UnitingThreshold = 0.02;            % The percent of Search Space Size, which enables the uniting process of two Empires.

zarib = 1.05;                       % **** Zarib is used to prevent the weakest impire to have a probability equal to zero
alpha = 0.1;                        % **** alpha is a number in the interval of [0 1] but alpha<<1. alpha denotes the importance of mean minimum compare to the global mimimum.

%% Display Setting
DisplayParams.PlotEmpires = false;    % "true" to plot. "false" to cancel ploting.
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


%% Creation of Initial Empires
InitialCountries = GenerateNewCountry(AlgorithmParams.NumOfCountries , ProblemParams);

% Calculate distance matrix
for i = 1:size(city, 2)
    for j = 1:size(city, 2)
        dismat(i, j) = distance(city(i).lat,city(i).long,city(j).lat,city(j).long);
    end
end
% Calculates the cost of each country. The less the cost is, the more is the power.
if isempty(ProblemParams.CostFuncExtraParams)
    InitialCost = feval(ProblemParams.CostFuncName,InitialCountries, dismat);    
    %size(InitialCost)
else
    InitialCost = feval(ProblemParams.CostFuncName,InitialCountries,ProblemParams.CostFuncExtraParams);
end
[InitialCost,SortInd] = sort(InitialCost);                          % Sort the cost in assending order. The best countries will be in higher places
InitialCountries = InitialCountries(SortInd,:);                     % Sort the population with respect to their cost.
Empires = CreateInitialEmpires(InitialCountries,InitialCost,AlgorithmParams, ProblemParams, dismat);

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
        Empires(ii) = AssimilateColonies(Empires(ii), dismat);

        %% Revolution;  A Sudden Change in the Socio-Political Characteristics
        % 该殖民地改革操作可能导致势力较强的殖民地丢失，导致寻优精度降低
        Empires(ii) = RevolveColonies(Empires(ii),AlgorithmParams);
        
        %% New Cost Evaluation
        Empires(ii).ColoniesCost = feval(ProblemParams.CostFuncName,Empires(ii).ColoniesPosition,dismat);
        %% Empire Possession  (****** Power Possession, Empire Possession)
        Empires(ii) = PossesEmpire(Empires(ii));
        
        %% Empire Reinforcement
        [Empires(ii),EmpireCandidate(ii)] = ImperialisticReinforce(Empires(ii), dismat);
        
        %% Computation of Total Cost for Empires
        Empires(ii).TotalCost = Empires(ii).ImperialistCost + AlgorithmParams.Zeta * mean(mean(Empires(ii).ColoniesCost));
    
    end
    
    %% Uniting Similiar Empires
    % in tsp problem, we omit it
    %Empires = UniteSimilarEmpires(Empires,AlgorithmParams,ProblemParams);
    
    %% Empire Reinforcement about adding empire
    Empires = ImperialisticAddEmpire(Empires, EmpireCandidate,ProblemParams, dismat);
    Empires(end).TotalCost = Empires(end).ImperialistCost + AlgorithmParams.Zeta * mean(mean(Empires(end).ColoniesCost));
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
    
end % End of Algorithm
MinimumCost(end)
toc
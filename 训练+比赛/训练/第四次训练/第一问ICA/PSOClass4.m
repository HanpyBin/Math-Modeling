%% Particle Swarm Optimization
clc
clear
global dots
global dismat
global path_var
load dots
load('../dismat1')
load path_var
%% Problem Statement
Npar = 2;
FN = 'BenchmarkFunction';
FunNumber = 6;
VarLow = -5;
VarHigh = 5;

%% Parameters
C1 = 1.5;
C2 = 4-C1;
Inertia = .3;
DampRatio = .95;
ParticleSize = 10;
MaxIter = 200;

GlobalBest = 0;
GlobalBestCost = 10000;

%% Initialization
GB = [];

for ii = 1:ParticleSize
    Particle{ii}.Position = rand(1,Npar) * (VarHigh - VarLow) + VarLow;
    Particle{ii}.Position = fix_coordinate(Particle{ii}.Position);
    Particle{ii}.Cost = feval(FN,Particle{ii}.Position);
    Particle{ii}.Velocity = rand(1,Npar);
    Particle{ii}.LocalBest = Particle{ii}.Position;
    Particle{ii}.LocalBestCost = Particle{ii}.Cost;
    if Particle{ii}.Cost < GlobalBestCost
        GlobalBest = Particle{ii}.Position;
        GlobalBestCost = Particle{ii}.Cost;
    end
end

%% Main Loop
for jj = 1:MaxIter
    for ii = 1:ParticleSize
        Inertia = Inertia * DampRatio;
        Particle{ii}.Velocity = rand * Inertia * Particle{ii}.Velocity + C1 * rand * (Particle{ii}.LocalBest - Particle{ii}.Position) +  C2 * rand * (GlobalBest - Particle{ii}.Position);
        Particle{ii}.Position = Particle{ii}.Position + Particle{ii}.Velocity;

        Particle{ii}.Position(Particle{ii}.Position > VarHigh) = VarHigh;
        Particle{ii}.Position(Particle{ii}.Position < VarLow) = VarLow;
        Particle{ii}.Position = fix_coordinate1(Particle{ii}.Position);
        Particle{ii}.Cost = feval(FN,Particle{ii}.Position);
        if Particle{ii}.Cost < Particle{ii}.LocalBestCost
            Particle{ii}.LocalBest = Particle{ii}.Position;
            Particle{ii}.LocalBestCost = Particle{ii}.Cost;

            if Particle{ii}.Cost < GlobalBestCost
                Particle{ii}.Cost
                GlobalBest = Particle{ii}.Position;
                GlobalBestCost = Particle{ii}.Cost;
            end
        end
    end
    GB = [GB GlobalBestCost];
end

% %% Function Plot
% x = -10:.05:10;
% y = -10:.05:10;
% [X,Y] = meshgrid(x,y);
% Z = 60 + X.^2 + Y.^2 - 30*(cos(20* X) + cos(20*Y));
% surf(X,Y,Z)
%%
plot(GB,'LineWidth',1.5)
GlobalBest
GlobalBestCost

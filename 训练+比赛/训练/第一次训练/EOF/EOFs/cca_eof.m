function [alphax,alphay,PX,PY]=cca_eof(X,Y,n)
% Based on von Storch (1994) "Analysis of Climate Variability" ch. 13.


[m,co]=size(X); % m = number of timesteps; n= number of coordinates

% Determine EOFs and EOF coordinates ECx and ECy
[Vx,Ex,ECx]=eof(zeroavg(X),n);
[Vy,Ey,ECy]=eof(zeroavg(Y),n);

% Determine EOF coeffienciets such that variance=1
betax=ECx./repmat(sqrt(Vx)',m,1);
betay=ECy./repmat(sqrt(Vy)',m,1);

% these diagonals matrices descibe the power of each vector
SX=diag(sqrt(Vx));
SY=diag(sqrt(Vy));

% Determine crosscovariance matrix of EOF coordinates
sigmaXY=crosscov(ECx,ECy);

% Compute matrix for computation of adjoint patters
AX=sigmaXY*sigmaXY';
AY=sigmaXY'*sigmaXY;

% Determine adjoint patterns from AX and AY (eigenvectors)
[paX,lambdaX]=eig(AX);
[paY,lambdaY]=eig(AY);
% NOTE: in EOF coordinates, the CCA patterns are self-adjoint and therefore
% the adjoint patterns are equal to the paX and paY patterns

% Determine Canonical Correlation Coefficients alphax and alphay
alphax=(paX*betax')';
alphay=(paY*betay')';

% Now determine the CC patterns in Euclidean space
PX=Ex*SX*paX;
PY=Ey*SY*paY;


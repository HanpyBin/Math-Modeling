D=load('datamartijn');
[V,EOFs,EC,error]=EOF(D);
[p,q]=size(D); % grootte van matrix

% Deze code levert GOEDE resultaten op
% (met nul-middeling, gebruikt de EC output van EOF script)

[DS,DM]=zeroavg(D); % maak data nul-gemiddeld en bepaal gemiddelde
DSR=EC*EOFs'; % reconstrueer nul gemiddelde data
DR1=DSR+repmat(DM,p,1); % tel gemiddelde waarde op
figure, plot(DR1(1,:)' -D(1,:)');
title('GOED! Nul-middeling, EC uit EOF script');

% Deze code levert SLECHTE resulaten
% (geen nul-middeling, genereert zelf EC uit data)
EC2=(EOFs'*D')';
DR2=EC2*EOFs';
figure, plot(DR2(1,:)' -D(1,:)');
title('SLECHT! Geen nul-middeling, EC uit data');

% Deze code levert GOEDE resulaten op
% (WEL nul-middeling, genereert zelf EC uit data)
EC3=(EOFs'*DS')';
DSR3=EC3*EOFs';
DR3=DSR3+repmat(DM,p,1);
figure, plot(DR3(1,:)' -D(1,:)');
title('GOED! Nul-middeling, EC uit data');

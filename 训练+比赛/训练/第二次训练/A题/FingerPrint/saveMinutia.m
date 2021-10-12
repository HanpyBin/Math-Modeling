function saveMinutia(name,MinutiaFin,MinutiaSep)
name=strrep(name,' ','_');
date=datestr(now,29);
FileName=[name '_' date '.txt'];

file=fopen(FileName,'wt');
fprintf(file,'%s \n','-------------------------------------------------------------------');
fprintf(file,'%s \n',['Name: ' name]);
fprintf(file,'%s \n',['Date: ' date]);
fprintf(file,'%s','Number of Terminations: ');
fprintf(file,'%2.0f \n',size(MinutiaFin,1));
fprintf(file,'%s','Number of Bifurcations: ');
fprintf(file,'%2.0f \n',size(MinutiaSep,1));
fprintf(file,'%s \n','-------------------------------------------------------------------');
fprintf(file,'%s \n','-------------------------------------------------------------------');
fprintf(file,'%s \n','Terminations :');
fprintf(file,'%s \n','-------------------------------------------------------------------');
fprintf(file,'%s \n','X          Y     Angle');
fprintf(file,'%3.0f \t %3.0f \t %3.2f \n',MinutiaFin');
fprintf(file,'%s \n','-------------------------------------------------------------------');
fprintf(file,'%s \n','Bifurcations :');
fprintf(file,'%s \n','-------------------------------------------------------------------');
fprintf(file,'%s \n','X          Y     Angle 1     Angle 2    Angle 3');
fprintf(file,'%3.0f \t %3.0f \t %3.2f \t \t %3.2f \t \t %3.2f \n',MinutiaSep');
fclose(file);



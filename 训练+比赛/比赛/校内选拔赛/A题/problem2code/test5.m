m = length(finalroutes1);
total_times = zeros(1,m);
for i = 1:m
    for j = 1:length(finalroutes1{i})-1
        total_times(i) = total_times(i) + dist(finalroutes1{i}(j),finalroutes1{i}(j+1));
    end
    total_times(i) = total_times(i) + dist(20, finalroutes1{i}(1))+dist(20,finalroutes1{i}(end));
    total_times(i) = total_times(i) / 50;
    total_times(i) = total_times(i)*60 + 5*length(finalroutes1{i});
end
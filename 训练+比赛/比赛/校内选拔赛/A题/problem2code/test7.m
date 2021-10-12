maxx = 0;
for i = 1:length(finalroutes1)
    if length(finalroutes1{i})==5
        if total_times(i) > maxx
            idx = i;
            maxx = total_times(i);
        end
    end
end
maxx
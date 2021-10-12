for i = 1:length(finalroutes)
    for j = 1:length(finalroutes)
        if length(intersect(finalroutes{i},finalroutes{j})) > 0
            P(i,j) = 0;
        else
            P(i,j) = 1;
        end
    end
end

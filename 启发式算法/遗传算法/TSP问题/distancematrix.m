function dis = distancematrix(city)
numberofcities = length(city);
R = 6378.137;
for i = 1:numberofcities
    for j = i+1:numberofcities
        dis(i, j) = distance(city(i).lat, city(i).long, city(j).lat, city(j).long, R);
        dis(j, i) = dis(i, j);
    end
end
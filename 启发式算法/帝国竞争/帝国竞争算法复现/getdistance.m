function dis = getdistance(routes, dismat)
for i = 1:size(routes, 1)
    dis(i, 1) = dismat(routes(i, 1), routes(i, end));
    for j = 1:length(routes(i,:))-1
        dis(i, 1) = dis(i, 1) + dismat(routes(i, j),routes(i, j+1));
    end
end
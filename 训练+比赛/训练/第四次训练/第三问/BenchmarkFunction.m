function [z, ords]=BenchmarkFunction(X)
global C1
global dots
global dismat
global data
al = 0.525;
for i = 1:size(X, 1)
    x = X(i,1);
    y = X(i,2);
    x1 = floor(x);
    x2 = ceil(x);
    y1 = floor(y);
    y2 = ceil(y);
    ord1 = find(dots(:,1) == x1 & dots(:,2) == y1);
    ord2 = find(dots(:,1) == x2 & dots(:,2) == y2);
    if ord1 == ord2
        temp = data(:,5)' ./ H(dismat(ord1,:));
        [temp, ords(i, :)] = min([C1;temp]);
        temp1 = C1 ./ H(dismat(ord1,:));
        temp = al*temp + (1-al)*temp1;
        z(i) = max(temp);
    else

        dist_1 = (abs(x-x1)+abs(y-y1)) * dismat(ord2, ord1);
        dist_2 = (abs(x-x2)+abs(y-y2)) * dismat(ord1, ord2);
        dist_3 = dismat(ord1, :);
        %dist_3(ord1, 1) = 100000;
        dist_4 = dismat(ord2, :);
        %dist_4(ord2, 1) = 100000;
        dist_3 = dist_3 + dist_1;
        dist_4 = dist_4 + dist_2;
        dist_3 = H(dist_3);
        dist_4 = H(dist_4);
        dist_3 = data(:,5)' ./ dist_3;
        dist_4 = data(:,5)' ./ dist_4;
        merge_dist = [dist_3;dist_4];
        dist_5 = dist_3 ./ H(dismat(70,:));
        dist_6 = dist_4 ./ H(dismat(70,:));
        merge_dist1 = [dist_5;dist_6];
        ord1;
        ord2;
        merge_dist;
        temp = min(merge_dist);
        temp1 = min(merge_dist1);
        temp = [C1;temp];
        [temp, ords(i, :)] = min(temp);
        z(i)=max(al*temp+(1-al)*temp1);
    end
end
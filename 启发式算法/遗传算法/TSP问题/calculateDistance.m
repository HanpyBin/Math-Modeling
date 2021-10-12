function [ distances ] = calculateDistance( city )
%�������
R = 6378.137;
[~, col] = size(city);
distances = zeros(col);
for i=1:col
    for j=1:col
        %distances(i,j)= distances(i,j)+ sqrt( (city(1,i)-city(1,j))^2 + (city(2,i)-city(2,j))^2  );
        distances(i, j) = distance(city(1, i), city(2, i), city(1, j), city(2, j), R);
    end
end
end
function d = distance(lat1, long1, lat2, long2)
R=6378.137;%地球半径用于求两个城市的球面距离
y1 = lat1/180*pi; x1 = long1/180*pi;
y2 = lat2/180*pi; x2 = long2/180*pi;
dy = y1-y2; dx = x1-x2;
d = 2*R*asin(sqrt(sin(dy/2)^2+sin(dx/2)^2*cos(y1)*cos(y2)));
end
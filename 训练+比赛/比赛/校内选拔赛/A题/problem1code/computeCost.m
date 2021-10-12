clear;
load('distanceMatrix')
route=[20 8 9 10 17 16 18 15 14 19 13 12 11 6 5 2 1 3 4 7 20];
cost = 0;
for i = 19:-1:1
    cost = cost + 2 * load * dist(route(i), route(i+1));
    load = load - z(i)
end
cost1 = cost + 0.6 * dist(route(1),route(2));
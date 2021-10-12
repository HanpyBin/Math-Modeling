function paint(dots, dots1, fdot, route)
route1 = zeros(length(route)+2, 2);
route1(1, :) = dots1(10, :);
route1(2:end-1, :) = dots(route, :);
route1(end, :) = dots1(fdot-3000, :);
plot(route1(:, 1), route1(:, 2), 'g-', route1(1, 1), route1(1, 2), 'r*', route1(end, 1), route1(end, 2), 'r*');
grid on;
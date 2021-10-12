function z = rbtestsinfunc(s)
global s;
global u;
for i = size(s, 1)
    for j = size(s, 2)
        z = (abs(u{i}(s(i,j), p(-i))-u{i}(p))+u{i}(s(i,j),p(-i))-u{i}(:))^2;
    end
end
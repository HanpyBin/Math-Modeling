f=@(x)(sin(x)./x);
lb=0;
ub=1;
T = zeros(1, 100);
T(1) = 1;
ord = 1;
for i = 2:100
    temp = 0;
    for j = 1:2^(i-2)
        temp = temp + f(lb + (j-1/2)*(ub-lb)/(2^(i-2)));
    end
    T(i) = T(i-1) / 2 + (ub-lb)/(2^(i-1))*temp;
    if abs(T(i) - T(i-1)) < 1e-7
        ord = i;
        break
    end
end
T(ord)
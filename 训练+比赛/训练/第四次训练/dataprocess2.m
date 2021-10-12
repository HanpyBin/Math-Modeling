clear, clc;
load dots;
data = xlsread("Â·¾¶±àºÅ¾ØÕó.xlsx");
path_var = zeros(103, 103);
% row = 11 - 2y
% col = 11 + 2x
nxt = [0,2;0,-2;2,0;-2,0];
for i = 1:2:19
    for j = 1:2:21
        for k = 1:4
            ti = i + nxt(k,1);
            tj = j + nxt(k,2);
            if ti < 1 || ti >19 || tj < 1 || tj > 21
                continue;
            end
            variety = data((i+ti)/2, (j+tj)/2);
            if variety == 10000
                continue;
            end
            x1 = (j-11)/2;
            y1 = (11-i)/2;
            x2 = (tj-11)/2;
            y2 = (11-ti)/2;
            ord1 = find(dots(:,1)==x1 & dots(:,2)==y1);
            ord2 = find(dots(:,1)==x2 & dots(:,2)==y2);
            path_var(ord1, ord2) = variety;
        end
    end
end
save('path_var.mat','path_var');
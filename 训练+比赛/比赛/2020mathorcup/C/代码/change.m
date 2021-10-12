function raworder = change(x)
% 将1-3000转化为Sxxxxx的形式
if mod(x, 15) == 0
    first = x/15;
    second = 15;
else
    first = floor(x/15)+1;
    second = mod(x,15);
end
if first < 100 && first >= 10
    first = ['0',num2str(first)];
elseif first < 10
    first = ['00', num2str(first)];
else
    first = num2str(first);
end
if second < 10
    second = ['0',num2str(second)];
else
    second = num2str(second);
end
raworder = ['S',first,second];
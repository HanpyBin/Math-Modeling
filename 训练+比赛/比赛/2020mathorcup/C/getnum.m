function dropnum = getnum(raword, taskord, txt)
aaa = find(strcmp(txt, taskord));
[xx, yy] = find(strcmp(txt(aaa, :), raword));
dropnum = cell2mat(txt(xx+aaa(1)-1,end));
if length(dropnum) > 1
    raword
    taskord
end
dropnum = dropnum(1);
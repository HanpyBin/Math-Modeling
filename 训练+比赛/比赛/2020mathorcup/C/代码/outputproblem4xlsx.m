row = 1;
for i = 1:length(ptasks)
    name = ['P',num2str(i)];
    checkagent = checkord(i, 1);
    if checkagent < 3010
        rawcheckagent = ['FH0', num2str(checkagent-3000)];
    else
        rawcheckagent = ['FH', num2str(checkagent-3000)];
    end
    if ptasks{i}(1) < 10
        checktaskord = ['T000', num2str(ptasks{i}(1))];
    else
        checktaskord = ['T00', num2str(ptasks{i}(1))];
    end
    xlsfile{row, 1} = name;
    xlsfile{row, 2} = checktaskord;
    xlsfile{row, 3} = rawcheckagent;
    xlsfile{row, 4} = checkagent;
    xlsfile{row, 5} = 0;
    row = row + 1;
    for j = 1:length(ptasks{i})
        if ptasks{i}(j) < 10
            taskord = ['T000',num2str(ptasks{i}(j))];
        else
            taskord = ['T00', num2str(ptasks{i}(j))];
        end
        d1 = find(dots==checkord(i, j));
        d2 = find(dots==checkord(i,j+1));
        temp_route = routes(4*d1+d2-4, ptasks{i}(j));
        temp_route = cell2mat(temp_route);
        for k = 1:length(temp_route)
            raword{k}=change(temp_route(k));
            dropnum(k)=getnum(raword{k}, taskord, txt);
        end
        for k = 1:length(temp_route)
            xlsfile{row, 1} = name;
            xlsfile{row, 2} = taskord;
            xlsfile{row, 3} = raword{k};
            xlsfile{row, 4} = temp_route(k);
            xlsfile{row, 5} = dropnum(k);
            row = row + 1;
        end
        checkagent = checkord(i, j+1);
        if checkagent < 3010
            rawcheckagent = ['FH0', num2str(checkagent-3000)];
        else
            rawcheckagent = ['FH', num2str(checkagent-3000)];
        end
        xlsfile{row, 1} = name;
        xlsfile{row, 2} = taskord;
        xlsfile{row, 3} = rawcheckagent;
        xlsfile{row, 4} = checkagent;
        xlsfile{row, 5} = 0;
        row = row + 1;
    end
end
        
        
        
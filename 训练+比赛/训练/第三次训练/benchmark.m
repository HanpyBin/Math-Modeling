function z=BenchmarkFunction(x)
    %%%%%%%%%%%%todo:时间在num的索引之外
    A = 10;
    V = 60; % 车载容量
    S = zeros(209, 10); % 209个时间点,10个站
    for i = 1:size(x, 1) % 对第一个解
        temp = x(i, :);
        temp = sort(temp);
        for j = 1:size(x, 2)
            if j == 1 % 对第一辆车
                % 第一辆车在第一个站
                coming = 0;
                for jj = 1:temp(j)
                    coming = coming + num(jj)*5/20;
                end
                if coming > V
                    W(j,1)=V;
                    L(j,1)=coming-V; % 第一辆车在第一个站未上车人数
                    U(j,1)=V;
                else
                    W(j,1)=coming;
                    L(j,1)=0;
                    U(j,1)=coming;
                end
                % 第一辆车在2-9个站
                for jj = 2:9
                    coming = 0;
                    for jjj = 1:jj
                        coming = coming + num(jjj)*5/20;
                    end
                    D(j,jj)=W(j,jj-1)*2/(2+A-jj);
                    W(j,jj) = W(j,jj-1)-D(j,jj);
                    if coming > V-W(j,jj)
                        U(j,jj)=V-W(j,jj);
                        L(j,jj)=coming - U(j,jj);
                        W(j,jj)=V;
                    else
                        U(j,jj) = coming;
                        L(j,jj) = 0;
                        W(j,jj) = W(j,jj)+coming;
                    end
                end
                D(j,10)=W(j,9);
                W(j,10)=0;
                continue;
            end
            % 对第后面的车
            % 第一站
            coming = 0;
            for jj = 1:temp(j)
                coming = coming + 5/20*num(jj);
            end
            for jj = 1:j-1
                coming = coming - U(jj,1);
            end
            if coming > V
                U(j,1) = V;
                L(j,1) = coming - V;
                W(j,1) = V;
            else
                U(j,1) = coming;
                L(j,1) = 0;
                W(j,1) = coming;
            end
            for jj=2:A-1
                coming = 0;
                for jjj = 1:
                
        end
    end
function R=BenchmarkFunction(x)
global num;
%%%%%%%%%%%%todo:时间在num的索引之外
mu = 0.25;
A = 10;
V = 60; % 车载容量
w1=1;
w2=1;
for solution = 1:size(x, 1) % 对第一个解
    bus_start_time = x(solution, :);
    % 对第一辆车
    % 第一个站
    D(1,1) = 0;
    coming = 0;
    for i = 1:bus_start_time(1)
        coming = coming+mu*num(i);
    end
    Q(1,1)=coming;
    if Q(1,1) > V
        U(1,1) = V;
        W(1,1) = V;
    else
        U(1,1) = coming;
        W(1,1) = coming;
    end
    Z(1,1)=Q(1,1)-U(1,1);
    % 对2-9个站
    for i = 2:A-1
        D(1,i) = W(1,i-1)*2/(2+A-i);
        coming = 0;
        for j = 1:bus_start_time(1)+i-1
            coming = coming+mu*num(j);
        end
        Q(1,i) = coming;
        if V-W(1,i-1)+D(1,i) >= Q(1,i)
            U(1,i) = Q(1,i);
            W(1,i) = W(1,i-1)-D(1,i)+Q(1,i);
        else
            U(1,i) = V-W(1,i-1)+D(1,i);
            W(1,i) = V;
        end
        Z(1,i)=Q(1,i)-U(1,i);
    end
    % 对第10个站
    D(1,10)=W(1,A-1);
    Q(1,10)=0;
    U(1,10)=0;
    W(1,10)=0;
    Z(1,10)=0;
    % 对后面的车
    for i=2:size(x, 2)
        % 第一个站
        D(i,1)=0;
        coming = 0;
        for j = bus_start_time(i-1)+1:bus_start_time(i)
            coming = coming+mu*num(j);
        end
        Q(i,1)=coming+Z(i-1,1);
        if Q(i,1) > V
            U(i,1)=V;
            W(i,1)=V;
        else
            U(i,1)=Q(i,1);
            W(i,1)=Q(i,1);
        end
        Z(i,1)=Q(i,1)-U(i,1);
        %对2-9个站
        for j = 2:A-1
            D(i,j) = W(i,j-1)*2/(2+A-j);
            coming = 0;
            for jj = bus_start_time(i-1)+j:bus_start_time(i)+j-1
                coming = coming + mu*num(jj);
            end
            Q(i,j) = Z(i-1,j)+coming;
            if V-W(i,j-1)+D(i,j) < Q(i,j)
                U(i,j)=V-W(i,j-1)+D(i,j);
                W(i,j)=V;
            else
                U(i,j)=Q(i,j);
                W(i,j)=W(i,j-1)-D(i,j)+U(i,j);
            end
            Z(i,j)=Q(i,j)-U(i,j);
        end
        % 对第10个站
        D(i,A)=W(i,A-1);
        Q(i,A)=0;
        U(i,A)=0;
        W(i,A)=0;
        Z(i,A)=0;
    end
    T(solution) = 0;
    for i=2:size(x,2)
        for s=1:A
            T(solution) = T(solution)+(Z(i-1,s)+5*Q(i,s))*(bus_start_time(i)-bus_start_time(i-1)).^2/2;
        end
    end
    T(solution) = T(solution)+5*(Z(1,s)+Q(1,s))*(bus_start_time(1)-1)/2;
    T(solution) = T(solution)+5*(Z(1,s)+Q(1,s))*(209-bus_start_time(size(x,2)))/2;
    %T
    C(solution)=0;
    for i = 1:209
        C(solution) = C(solution)-mu*num(i);
    end
    C(solution) = C(solution) + size(x,2)*150/60*10*5;
    R(solution) = w1*T(solution)*30/60+w2*C(solution);
end
function cnt = bresenham(f, x0, y0, x, y)
% ����n������������ĵ㴩��������
%���ĵ���������(x0,y0)
%��������������(x(i),y(i)) i=1,2,...,N

%f;%��ϸ�����ͼ���������������
N = length(x);

cnt=zeros(1,N);
for i=1:N
    flag = 0;
    cnt(i)=0;
    %һ��Ҫ�岹�Ĳ���
    T=abs(y0-y(i))+abs(x0-x(i));
    if x0-x(i)==0
        if y(i)-y0>0
            for j=1:T
                cnt(i)=cnt(i)+countting(x(i),y(i),x(i),y(i)-1,f);
                y(i)=y(i)-1;
            end
        else
            for j=1:T
                cnt(i)=cnt(i)+countting(x(i),y(i),x(i),y(i)+1,f);
                y(i)=y(i)+1;
            end
        end
        
    elseif y0-y(i)==0
        if x(i)-x0>0
            for j=1:T
                cnt(i)=cnt(i)+countting(x(i),y(i),x(i)-1,y(i),f);
                x(i)=x(i)-1;
            end
        else
            for j=1:T
                cnt(i)=cnt(i)+countting(x(i),y(i),x(i)+1,y(i),f);
                x(i)=x(i)+1;
            end
        end
        
    elseif x(i)-x0>0 && y(i)-y0>0
        temp=T;
        for j=1:T
            if x(i) == x0
                flag = 1;
                break;
            end
            if y(i) == y0
                flag = 1;
                break;
            end
            if (y(i)-y0)/(x(i)-x0)>=1
                cnt(i)=cnt(i)+countting(x(i),y(i),x(i),y(i)-1,f);
                y(i)=y(i)-1;
            else
                cnt(i)=cnt(i)+countting(x(i),y(i),x(i)-1,y(i),f);
                x(i)=x(i)-1;
            end
            temp = temp-1;
        end
        if x(i)==x0 && flag == 1
            for j = 1:temp
                cnt(i) = cnt(i)+countting(x(i),y(i),x(i),y(i)-1,f);
                y(i)=y(i)-1;
            end
        end
        if y(i) == y0 && flag == 1
            for j = 1:temp
                cnt(i)=cnt(i)+countting(x(i),y(i),x(i)-1,y(i),f);
                x(i)=x(i)-1;
            end
        end
    elseif (x(i)-x0)>0 && y(i)-y0<0
        temp = T;
        for j=1:T
            if x(i) == x0
                flag = 1;
                break;
            end
            if y(i) == y0
                flag = 1;
                break;
            end
            if (y(i)-y0)/(x(i)-x0)<=-1
                cnt(i)=cnt(i)+countting(x(i),y(i),x(i),y(i)+1,f);
                y(i)=y(i)+1;
            else
                cnt(i)=cnt(i)+countting(x(i),y(i),x(i)-1,y(i),f);
                x(i)=x(i)-1;
            end
            temp = temp - 1;
        end
        if x(i) == x0 && flag == 1
            for j = 1:temp
                cnt(i) = cnt(i)+countting(x(i),y(i),x(i),y(i)+1,f);
                y(i)=y(i)+1;
            end
        end
        if y(i) == y0 && flag == 1
            for j = 1:temp
                cnt(i)=cnt(i)+countting(x(i),y(i),x(i)-1,y(i),f);
                x(i)=x(i)-1;
            end
        end
    elseif (x(i)-x0)<0 && y(i)-y0>0
        temp = T;
        for j = 1:T
            if x(i) == x0
                flag = 1;
                break;
            end
            if y(i) == y0
                flag = 1;
                break;
            end
            if (y(i)-y0)/(x(i)-x0)<=-1
                cnt(i)=cnt(i)+countting(x(i),y(i),x(i),y(i)-1,f);
                y(i)=y(i)-1;
            else
                cnt(i)=cnt(i)+countting(x(i),y(i),x(i)+1,y(i),f);
                x(i)=x(i)+1;
            end
            temp = temp-1;
        end
        if x(i) == x0 && flag == 1
            for j = 1:temp
                cnt(i) = cnt(i)+countting(x(i),y(i),x(i),y(i)-1,f);
                y(i)=y(i)-1;
            end
        end
        if y(i) == y0 && flag == 1
            for j = 1:temp
                cnt(i)=cnt(i)+countting(x(i),y(i),x(i)+1,y(i),f);
                x(i)=x(i)+1;
            end
        end
    elseif (x(i)-x0)<0 && y(i)-y0<0
        temp = T;
        for j = 1:T
            if x(i) == x0
                flag = 1;
                break;
            end
            if y(i) == y0
                flag = 1;
                break;
            end
            if (y(i)-y0)/(x(i)-x0)>=1
                cnt(i)=cnt(i)+countting(x(i),y(i),x(i),y(i)+1,f);
                y(i)=y(i)+1;
            else
                cnt(i)=cnt(i)+countting(x(i),y(i),x(i)+1,y(i),f);
                x(i)=x(i)+1;
            end
            temp = temp-1;
        end
        if x(i)==x0 && flag == 1
            for j = 1:temp
                cnt(i) = cnt(i)+countting(x(i),y(i),x(i),y(i)+1,f);
                y(i)=y(i)+1;
            end
        end
        if y(i) == y0 && flag == 1
            for j = 1:temp
                cnt(i)=cnt(i)+countting(x(i),y(i),x(i)+1,y(i),f);
                x(i)=x(i)+1;
            end
        end
    end
end

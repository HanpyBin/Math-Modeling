function T=decorate(A)
[row,vol]=size(A);
T=ones(row,vol);
while ~isequal(T,A)
    T=A;
    for i=3:row-2%������е�С��
        for j=3:vol-2
            if A(i-1,j)==0 && A(i-1,j+1)==0 && A(i,j-2)==0 && A(i,j-1)==0 && A(i,j)==1 && A(i,j+1)==1 && A(i,j+2)==0 && A(i,j+3)==0 && A(i+1,j)==0 && A(i+1,j+1)==0
                A(i,j)=0;
                A(i,j+1)=0;
                continue;
            end
            if A(i-2,j)==0 && A(i-1,j)==0 && A(i,j-1)==0 && A(i,j)==1 && A(i,j+1)==0 && A(i+1,j-1)==0 && A(i+1,j)==1 && A(i+1,j+1)==0 && A(i+2,j)==0 && A(i+3,j)==0
                A(i,j)=0;
                A(i+1,j)=0;
                continue;
            end
            if A(i-1,j)==0 && A(i-1,j+1)==0 && A(i,j-1)==0 && A(i,j)==1 && A(i,j+1)==0 && A(i+1,j-2)==0 && A(i+1,j-1)==1 && A(i+1,j)==0 && A(i+2,j-2)==0 && A(i+2,j-1)==0
                A(i,j)=0;
                A(i+1,j-1)=0;
                continue;
            end
            if A(i-1,j-1)==0 && A(i-1,j)==0 && A(i,j-1)==0 && A(i,j)==1 && A(i,j+1)==0 && A(i+1,j)==0 && A(i+1,j+1)==1 && A(i+1,j+2)==0 && A(i+2,j+1)==0 && A(i+2,j+2)==0
                A(i,j)=0;
                A(i+1,j+1)=0;
                continue;
            end
            if A(i-2,j-1)==0 && A(i-2,j)==0 && A(i-2,j+1)==0 && A(i-1,j-2)==0 && A(i-1,j+2)==0 && A(i,j-2)==0 && A(i,j)==1 && A(i,j+2)==0 && A(i+1,j-2)==0 && A(i+1,j+2)==0 && A(i+2,j-1)==0 && A(i+2,j)==0 && A(i+2,j+1)==0
                A(i,j)=0;
                continue;
            end
            if A(i-1,j-1)==0 && A(i-1,j)==0 && A(i-1,j+1)==0 && A(i,j-2)==0 && A(i,j)==1 && A(i,j+2)==0 && A(i+1,j-2)==0 && A(i+1,j)==1 && A(i+1,j+2)==0 && A(i+2,j-1)==0 && A(i+2,j)==0 && A(i+2,j+1)==0
                A(i,j)=0;
                A(i+1,j)=0;
                continue;
            end
            if A(i-2,j)==0 && A(i-2,j+1)==0 && A(i-1,j-1)==0 && A(i-1,j+2)==0 && A(i,j-1)==0 && A(i,j)==1 && A(i,j+1)==1 && A(i,j+2)==0 && A(i+1,j-1)==0 && A(i+1,j+2)==0 && A(i+2,j)==0 && A(i+2,j+1)==0
                A(i,j)=0;
                A(i,j+1)=0;
                continue;
            end
            if A(i-2,j-1)==0 && A(i-2,j)==0 && A(i-1,j-2)==0 && A(i-1,j+1)==0 && A(i,j-2)==0 && A(i,j)==1 && A(i,j+2)==0 && A(i+1,j-1)==0 && A(i+1,j+2)==0 && A(i+2,j)==0 && A(i+2,j+1)==0
                A(i,j)=0;
                continue;
            end
            if A(i-2,j)==0 && A(i-2,j+1)==0 && A(i-1,j-1)==0 && A(i-1,j+2)==0 && A(i,j-2)==0 && A(i,j)==1 && A(i,j+2)==0 && A(i+1,j-2)==0 && A(i+1,j+1)==0 && A(i+2,j-1)==0 && A(i+2,j)==0
                A(i,j)=0;
                continue;
            end
            if A(i-2,j-1)==0 && A(i-2,j)==0 && A(i-1,j-2)==0 && A(i-1,j+1)==0 && A(i,j-2)==0 && A(i,j)==1 && A(i,j+2)==0 && A(i+1,j-2)==0 && A(i+1,j+2)==0 && A(i+2,j-1)==0 && A(i+2,j)==0 && A(i+2,j+1)==0
                A(i,j)=0;
                continue;
            end
            if A(i-2,j)==0 && A(i-2,j+1)==0 && A(i-1,j-1)==0 && A(i-1,j+2)==0 && A(i,j-2)==0 && A(i,j)==1 && A(i,j+2)==0 && A(i+1,j-2)==0 && A(i+1,j+2)==0 && A(i+2,j-1)==0 && A(i+2,j)==0 && A(i+2,j+1)==0
                A(i,j)=0;
                continue;
            end
        end
    end
end


T=ones(row,vol);
while ~isequal(T,A)
    T=A;
    for i=2:row-1%�Զ�ֵͼ��ģ���������������
        for j=2:vol-1
            if A(i-1,j-1)==0 && A(i,j-1)==0 && A(i+1,j-1)==0 && A(i-1,j+1)==0 && A(i,j+1)==0 && A(i+1,j+1)==0 && A(i,j)==1
                A(i,j)=0;
                continue;
            end
            if A(i-1,j-1)==0 && A(i-1,j)==0 && A(i-1,j+1)==0 && A(i+1,j-1)==0 && A(i+1,j)==0 && A(i+1,j+1)==0 && A(i,j)==1
                A(i,j)=0;
                continue;
            end
            if A(i,j)==0 && A(i-1,j-1)==1 && A(i-1,j)==1 && A(i-1,j+1)==1 && A(i,j-1)==1 && A(i,j+1)==1 && A(i+1,j-1)==1 && A(i+1,j)==1 && A(i+1,j+1)==1
                A(i,j)=1;
                continue;
            end
        end
    end
end


T=ones(row,vol);
while ~isequal(T,A)
    T=A;
    for i=2:row-1%ȥ��ë��
        for j=2:vol-1
            if A(i-1,j-1)==1 && A(i-1,j)==1 && A(i-1,j+1)==1 && A(i,j-1)==1 && A(i,j)==0 && A(i,j+1)==1 && A(i+1,j-1)==0 && A(i+1,j)==0 && A(i+1,j+1)==0
                A(i,j)=1;
                continue;
            end
            if A(i-1,j-1)==1 && A(i-1,j)==1 && A(i-1,j+1)==0 && A(i,j-1)==1 && A(i,j)==0 && A(i,j+1)==0 && A(i+1,j-1)==1 && A(i+1,j)==1 && A(i+1,j+1)==0
                A(i,j)=1;
                continue;
            end
            if A(i-1,j-1)==0 && A(i-1,j)==1 && A(i-1,j+1)==1 && A(i,j-1)==0 && A(i,j)==0 && A(i,j+1)==1 && A(i+1,j-1)==0 && A(i+1,j)==1 && A(i+1,j+1)==1
                A(i,j)=1;
                continue;
            end
            if A(i-1,j-1)==0 && A(i-1,j)==0 && A(i-1,j+1)==0 && A(i,j-1)==1 && A(i,j)==0 && A(i,j+1)==1 && A(i+1,j-1)==1 && A(i+1,j)==1 && A(i+1,j+1)==1
                A(i,j)=1;
                continue;
            end
            if A(i-1,j-1)==1 && A(i-1,j)==1 && A(i-1,j+1)==1 && A(i,j-1)==0 && A(i,j)==1 && A(i,j+1)==0 && A(i+1,j-1)==0 && A(i+1,j)==0 && A(i+1,j+1)==0
                A(i,j)=0;
                continue;
            end
            if A(i-1,j-1)==1 && A(i-1,j)==0 && A(i-1,j+1)==0 && A(i,j-1)==1 && A(i,j)==1 && A(i,j+1)==0 && A(i+1,j-1)==1 && A(i+1,j)==0 && A(i+1,j+1)==0
                A(i,j)=0;
                continue;
            end
            if A(i-1,j-1)==0 && A(i-1,j)==0 && A(i-1,j+1)==1 && A(i,j-1)==0 && A(i,j)==1 && A(i,j+1)==1 && A(i+1,j-1)==0 && A(i+1,j)==0 && A(i+1,j+1)==1
                A(i,j)=0;
                continue;
            end
            if A(i-1,j-1)==0 && A(i-1,j)==0 && A(i-1,j+1)==0 && A(i,j-1)==0 && A(i,j)==1 && A(i,j+1)==0 && A(i+1,j-1)==1 && A(i+1,j)==1 && A(i+1,j+1)==1
                A(i,j)=0;
                continue;
            end
        end
    end
end


T=ones(row,vol);
while ~isequal(T,A)
    T=A;
    for i=3:row-2%ȥ��ë��
        for j=3:vol-2
            if A(i-1,j-1)==1 && A(i-1,j)==1 && A(i-1,j+1)==1 && A(i,j-1)==1 && A(i,j)==0 && A(i,j+1)==1 && A(i+1,j-1)==1 && A(i+1,j)==0 && A(i+1,j+1)==0 && A(i+2,j)==0 && A(i+2,j+1)==0
                A(i,j)=1;
                continue
            end
            if A(i-2,j-1)==0 && A(i-2,j)==0 && A(i-1,j-1)==0 && A(i-1,j)==0 && A(i-1,j+1)==1 && A(i,j-1)==1 && A(i,j)==0 && A(i,j+1)==1 && A(i+1,j-1)==1 && A(i+1,j)==1 && A(i+2,j+1)==1
                A(i,j)=1;
                continue;
            end
            if A(i-1,j-1)==1 && A(i-1,j)==1 && A(i-1,j+1)==1 && A(i,j-1)==1 && A(i,j)==0 && A(i,j+1)==0 && A(i,j+2)==0 && A(i+1,j-1)==1 && A(i+1,j)==1 && A(i+1,j+1)==0 && A(i+1,j+2)==0
                A(i,j)=1;
                continue;
            end
            if A(i-1,j-2)==0 && A(i-1,j-1)==0 && A(i-1,j)==1 && A(i-1,j+1)==1 && A(i,j-2)==0 && A(i,j-1)==0 && A(i,j)==0 && A(i,j+1)==1 && A(i+1,j-1)==1 && A(i+1,j)==1 && A(i+2,j+1)==1
                A(i,j)=1;
                continue;
            end
        end
    end
end

T=A;
end
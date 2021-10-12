function T=feat(A)
[row,vol]=size(A);
endpoint=zeros(row,vol);
bifurcation=zeros(row,vol);
for i=2:row-1
    for j=2:vol-1
        if A(i,j)==1
            continue;
        end
        D=[A(i-1,j-1) A(i-1,j) A(i-1,j+1);A(i,j-1) A(i,j) A(i,j+1);A(i+1,j-1) A(i+1,j) A(i+1,j+1)];
        onenum=nnz(D);
        zeronum=8-onenum;%计算邻接点黑点的个数
        if zeronum==1%判断是否端点
            endpoint(i,j)=1;
        end
        if zeronum==3%判断是否分叉点
            if A(i-1,j-1)==0 && A(i-1,j)==1 && A(i-1,j+1)==0 && A(i,j-1)==1 && A(i,j+1)==1 && A(i+1,j-1)==1 && A(i+1,j)==0 && A(i+1,j+1)==1
                bifurcation(i,j)=1;
            elseif A(i-1,j-1)==0 && A(i-1,j)==1 && A(i-1,j+1)==1 && A(i,j-1)==1 && A(i,j+1)==0 && A(i+1,j-1)==0 && A(i+1,j)==1 && A(i+1,j+1)==1
                bifurcation(i,j)=1;
            elseif A(i-1,j-1)==1 && A(i-1,j)==0 && A(i-1,j+1)==1 && A(i,j-1)==1 && A(i,j+1)==1 && A(i+1,j-1)==0 && A(i+1,j)==1 && A(i+1,j+1)==0
                bifurcation(i,j)=1;
            elseif A(i-1,j-1)==1 && A(i-1,j)==1 && A(i-1,j+1)==0 && A(i,j-1)==0 && A(i,j+1)==1 && A(i+1,j-1)==1 && A(i+1,j)==1 && A(i+1,j+1)==0
                bifurcation(i,j)=1;
            elseif A(i-1,j-1)==1 && A(i-1,j)==1 && A(i-1,j+1)==0 && A(i,j-1)==0 && A(i,j+1)==1 && A(i+1,j-1)==1 && A(i+1,j)==0 && A(i+1,j+1)==1
                bifurcation(i,j)=1;
            elseif A(i-1,j-1)==0 && A(i-1,j)==1 && A(i-1,j+1)==1 && A(i,j-1)==1 && A(i,j+1)==0 && A(i+1,j-1)==1 && A(i+1,j)==0 && A(i+1,j+1)==1
                bifurcation(i,j)=1;
            elseif A(i-1,j-1)==1 && A(i-1,j)==0 && A(i-1,j+1)==1 && A(i,j-1)==1 && A(i,j+1)==0 && A(i+1,j-1)==0 && A(i+1,j)==1 && A(i+1,j+1)==1
                bifurcation(i,j)=1;
            elseif A(i-1,j-1)==1 && A(i-1,j)==0 && A(i-1,j+1)==1 && A(i,j-1)==0 && A(i,j+1)==1 && A(i+1,j-1)==1 && A(i+1,j)==1 && A(i+1,j+1)==0
                bifurcation(i,j)=1;
            elseif A(i-1,j-1)==0 && A(i-1,j)==1 && A(i-1,j+1)==0 && A(i,j-1)==1 && A(i,j+1)==1 && A(i+1,j-1)==1 && A(i+1,j)==1 && A(i+1,j+1)==0
                bifurcation(i,j)=1;
            elseif A(i-1,j-1)==0 && A(i-1,j)==1 && A(i-1,j+1)==1 && A(i,j-1)==1 && A(i,j+1)==1 && A(i+1,j-1)==0 && A(i+1,j)==1 && A(i+1,j+1)==0
                bifurcation(i,j)=1;
            elseif A(i-1,j-1)==0 && A(i-1,j)==1 && A(i-1,j+1)==0 && A(i,j-1)==1 && A(i,j+1)==1 && A(i+1,j-1)==0 && A(i+1,j)==1 && A(i+1,j+1)==1
                bifurcation(i,j)=1;
            elseif A(i-1,j-1)==1 && A(i-1,j)==1 && A(i-1,j+1)==0 && A(i,j-1)==1 && A(i,j+1)==1 && A(i+1,j-1)==0 && A(i+1,j)==1 && A(i+1,j+1)==0
                bifurcation(i,j)=1;
            elseif A(i-1,j-1)==1 && A(i-1,j)==0 && A(i-1,j+1)==1 && A(i,j-1)==0 && A(i,j+1)==0 && A(i+1,j-1)==1 && A(i+1,j)==1 && A(i+1,j+1)==1
                bifurcation(i,j)=1;
            elseif A(i-1,j-1)==1 && A(i-1,j)==1 && A(i-1,j+1)==1 && A(i,j-1)==0 && A(i,j+1)==0 && A(i+1,j-1)==1 && A(i+1,j)==0 && A(i+1,j+1)==1
                bifurcation(i,j)=1;
            elseif A(i-1,j-1)==1 && A(i-1,j)==0 && A(i-1,j+1)==1 && A(i,j-1)==0 && A(i,j+1)==0 && A(i+1,j-1)==1 && A(i+1,j)==0 && A(i+1,j+1)==1
                bifurcation(i,j)=1;
            elseif A(i-1,j-1)==1 && A(i-1,j)==0 && A(i-1,j+1)==1 && A(i,j-1)==1 && A(i,j+1)==0 && A(i+1,j-1)==1 && A(i+1,j)==0 && A(i+1,j+1)==1
                bifurcation(i,j)=1;
            else
                continue;
            end
        end
    end
end

%去除边缘效应，去除距离图像边缘25以内的特征点
for i=1:25
    endpoint(i,j)=0;
    bifurcation(i,j)=0;
end

for i=row-24:row
    endpoint(i,j)=0;
    bifurcation(i,j)=0;
end

for j=1:25
    endpoint(i,j)=0;
    bifurcation(i,j)=0;
end

for j=vol-24:vol
    endpoint(i,j)=0;
    bifurcation(i,j)=0;
end

%去除断点，去除相距小于6的两个端点
for i=26:row-25
    for j=26:vol-25
        if endpoint(i,j)==1
            flag=0;
            for k=i-5:i+5
                for l=j-5:j+5
                    if k==i && l==j
                        continue;
                    end
                    if endpoint(k,l)==1
                        endpoint(k,l)=0;
                        flag=1;
                    end
                end
            end
            if flag==1
                endpoint(i,j)=0;
            end
        end
    end
end

for i=26:row-25%去除伪小桥、小洞和毛刺，通过将分叉点作为起始点来跟踪纹线，若两个分叉点或者分叉点和端点的距离小于12，则删除
    for j=26:vol-25
        if bifurcation(i,j)==1
            flag=0;
            m=1;
            abc=zeros(3,2);
            for k=i-1:i+1%记录起始分叉点的三个黑邻点位置
                for l=j-1:j+1
                    if k==i && l==j
                        continue;
                    end
                    if A(k,l)==0;
                        abc(m,1)=k;
                        abc(m,2)=l;
                        m=m+1;
                    end
                end
            end
            for n=1:3%分别对这三个邻点进行检验
                temr=abc(n,1);
                temv=abc(n,2);
                D=[A(temr-1,temv-1) A(temr-1,temv) A(temr-1,temv+1);A(temr,temv-1) A(temr,temv) A(temr,temv+1);A(temr+1,temv-1) A(temr+1,temv) A(temr+1,temv+1)];
                onenum=nnz(D);
                zeronum=8-onenum;
                if zeronum>3
                    bifurcation(temr,temv)=0;
                    flag=1;
                    continue;
                end
                ind=1;
                def=zeros(2,2);
                for o=1:2
                    if o==n
                        ind=ind+1;
                    end
                    def(o,1)=abc(ind,1);
                    def(o,2)=abc(ind,2);
                    ind=ind+1;
                end
                if zeronum==3 && ((def(1,1)<temr-1 | def(1,1)>temr+1 | def(1,2)<temv-1 | def(1,2)>temv+1) && (def(2,1)<temr-1 | def(2,1)>temr+1 | def(2,2)<temv-1 | def(2,2)>temv+1))
                    bifurcation(temr,temv)=0;
                    flag=1;
                    continue;
                end
                if zeronum==1
                    endpoint(temr,temv)=0;
                    flag=1;
                    continue;
                end
                ghi=zeros(2,2);
                if zeronum==3
                    if (abs(def(1,1)-temr)<=1) && (abs(def(1,2)-temv)<=1)
                        ind=1;
                    elseif (abs(def(2,1)-temr)<=1) && (abs(def(2,2)-temv)<=1)
                        ind=2;
                    end
                    r=0;
                    for p=temr-1:temr+1
                        for q=temv-1:temv+1
                            if p==temr && q==temv
                                continue;
                            end
                            if A(p,q)==0;
                                if ~((p==def(ind,1) && q==def(ind,2)) | (p==i && q==j))
                                    ghi(1,1)=p;
                                    ghi(1,2)=q;
                                    r=1;
                                    break;
                                end
                            end
                        end
                        if r==1
                            break;
                        end
                    end
                end
                if zeronum==2
                    r=0;
                    for p=temr-1:temr+1
                        for q=temv-1:temv+1
                            if p==temr && q==temv
                                continue;
                            end
                            if A(p,q)==0
                                if ~(p==i && q==j)
                                    ghi(1,1)=p;
                                    ghi(1,2)=q;
                                    r=1;
                                    break;
                                end
                            end
                        end
                        if r==1
                            break;
                        end
                    end
                    if (ghi(1,1)==def(1,1) && ghi(1,2)==def(1,2)) | (ghi(1,1)==def(2,1) && ghi(1,2)==def(2,2))
                        continue;
                    end
                end
                ghi(2,1)=temr;
                ghi(2,2)=temv;
                for s=1:9
                    t=ghi(1,1);
                    v=ghi(1,2);
                    w=ghi(2,1);
                    x=ghi(2,2);
                    if endpoint(t,v)==1
                        endpoint(t,v)=0;
                        flag=1;
                        break;
                    end
                    if bifurcation(t,v)==1
                        bifurcation(t,v)=0;
                        flag=1;
                        break;
                    end
                    r=0;
                    for p=t-1:t+1
                        for q=v-1:v+1
                            if p==t && q==v
                                continue;
                            end
                            if A(p,q)==0
                                if ~(p==w && q==x)
                                    ghi(1,1)=p;
                                    ghi(1,2)=q;
                                    r=1;
                                    break;
                                end
                            end
                        end
                        if r==1
                            ghi(2,1)=t;
                            ghi(2,2)=v;
                            break;
                        end
                    end
                end
            end
            if flag==1
                bifurcation(i,j)=0;
            end
        end
    end
end

[X,map]=gray2ind(A,256);%显示端点和分叉点，分叉点用红色表示，端点用绿色表示
RGB=ind2rgb(X,map);
RGB2=RGB;
for i=2:row-1
    for j=2:vol-1
        if RGB(i,j,1)==0 && RGB(i,j,2)==0 && RGB(i,j,3)==0
            if endpoint(i,j)==1
                RGB2(i,j,1)=0;
                RGB2(i,j,2)=1;
                RGB2(i-1,j,2)=1;
                RGB2(i,j-1,2)=1;
                RGB2(i,j+1,2)=1;
                RGB2(i+1,j,2)=1;
                RGB2(i,j,3)=0;
            end
            if bifurcation(i,j)==1
                RGB2(i,j,1)=1;
                RGB2(i-1,j,1)=1;
                RGB2(i,j-1,1)=1;
                RGB2(i,j+1,1)=1;
                RGB2(i+1,j,1)=1;
                RGB2(i,j,2)=0;
                RGB2(i,j,3)=0;
            end
        end
    end
end

T=RGB2;
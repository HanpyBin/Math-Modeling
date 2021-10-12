function [XofCenter,YofCenter]=centralizing(fingerprint)
imgN=size(fingerprint,1);
imgM=size(fingerprint,2);
image=wiener2(fingerprint,[3 3]);
[Gx,Gy]=gradient(image);
orientnum=wiener2(2.*Gx.*Gy,[3 3]);
orientden=wiener2((Gx.^2)-(Gy.^2),[3 3]);
W=8;
l1=9;
orient=zeros(imgN/W,imgM/W);
points=(imgN/W)* (imgM/W);
for i=1:1:points
    x=floor((i-1)/(imgM/W))* W+1;
    y=mod(i-1,(imgN/W))* W+1;
    numblock=orientnum(y:y+W-1,x:x+W-1);
    denblock=orientden(y:y+W-1,x:x+W-1);
    somma_num=sum(sum(numblock));
    somma_denom=sum(sum(denblock));
    if somma_denom~=0
        inside = somma_num/somma_denom;
        angle=0.5*atan(inside);
    else
        angle=pi/2;
    end
    %each block
    if angle<0
        if somma_num<0
            angle=angle+pi/2;
        else
            angle=angle+pi;
        end
    else
        if somma_num>0
            angle=angle+pi/2;
        end
    end
    orient(1 +(y-1)/W,1+(x-1)/W)=angle;
end
binarize=(orient<pi/2);
[bi,bj]=find(binarize);
xdir=zeros(W,W);
ydir=zeros(W,W);
for k=1:1:size(bj,1)
    i=bj(k);
    j=bi(k);
    if orient(j,i)<pi/2
        x=fix(l1*cos(orient(j,i)-pi/2)/(W/2));
        y=fix(l1*sin(orient(j,i)-pi/2)/(W/2));
        xdir(j,i)=i-x;
        ydir(j,i)=j-y;
    end
end
binarize2=zeros(imgN/W,imgM/W);
for i=1:1:size(bj,1)
    x=bj(i);
    y=bi(i);
    if~(xdir(y,x)<1||ydir(y,x)<1||xdir(y,x)>imgM/W||ydir(y,x)>imgN/W)
        while binarize(ydir(y,x),xdir(y,x))>0
            xtemp=xdir(y,x);
            ytemp=ydir(y,x);
            if xtemp<1||ytemp<1||xtemp>imgM/W||ytemp>imgN/W
                break;
            end
            x=xtemp;
            y=ytemp;
            if xdir(y,x)<1||ydir(y,x)<1||xdir(y,x)>imgM/W||ydir(y,x)>imgN/W
                if x-1>0
                    while binarize(y,x-1)>0
                        x=x-1;
                        if x-1<1
                            break;
                        end
                    end
                end
                break;
            end
        end
    end
    binarize2(y,x)=binarize2(y,x)+1;
end
[temp,y]=max(binarize2(1:end-7,:));
[temp2,x]=max(temp);
angle=orient(y(x),x)-pi/2;
XofCenter=round(x*W-(W/2)-(l1/2)*cos(angle));
YofCenter=round(y(x)*W-(W/2)-(l1/2)*sin(angle));
%Outputprint=binarize2;
end
function sign=countting(x1,y1,x2,y2,f)%f «Õº∆¨
    if f(y2,x2)-f(y1,x1)==0
        sign=0;
    else
        sign=0.5;
    end
end
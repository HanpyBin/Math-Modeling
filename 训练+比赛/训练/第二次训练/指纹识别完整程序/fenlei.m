function result=fenlei(in);
%根据纹型进行分类处理

[height,width]=size(in);

num1=0;
num2=0;
num3=0;
num4=0;
num5=0;
num6=0;
num7=0;
num8=0;
num9=0;
num10=0;
centerx=height/2;
centery=width/2;
t11=centerx;
t21=centerx;
t31=centerx;
t41=centerx;
t51=centerx;
t61=centerx;
t71=centerx;
t81=centerx;
t91=centerx;
t101=centerx;
t12=centery;
t22=centery;
t32=centery;
t42=centery;
t52=centery;
t62=centery;
t72=centery;
t82=centery;
t92=centery;
t102=centery;
i=centerx;
j=centery;
out=zeros(height,width);
while (i<centerx+80)&(j<centery+80)
    i=i+1;
    j=j+3;
    if (in(i,j)==1)&((i>centerx+10)|(j>centery+10))&(abs(t11-i)+abs(t12-j)>6)
        out(i,j)=1;
        t11=i;
        t12=j;
                num1=num1+1;
    end
     if (in(i,j+1)==1)&((i>centerx+10)|(j+1>centery+10))&(abs(t11-i)+abs(t12-j-1)>6)
                out(i,j+1)=1;
                t11=i;
                t12=j+1;
                        num1=num1+1;
    end
        if (in(i,j+2)==1)&((i>centerx+10)|(j+2>centery+10))&(abs(t11-i)+abs(t12-j-2)>6)
        out(i,j+2)=1;
         t11=i;
         t12=j+2;
         num1=num1+1;
    end
end
i=centerx;
j=centery;
while (i<centerx+80)&(j<centery+80)
    i=i+1;
    j=j+2;
    if in(i,j)==1&((i>centerx+10)|(j>centery+10))&(abs(t21-i)+abs(t22-j)>6)
       t21=i;
       t22=j;
       out(i,j)=2;
       num2=num2+1;
    end
    if in(i,j+1)==1&((i>centerx+10)|(j+1>centery+10))&(abs(t21-i)+abs(t22-j-1)>6)
               t21=i;
               t22=j+1;
               out(i,j+1)=2;
               num2=num2+1;
    end
end
i=centerx;
j=centery;
while (i<centerx+80)&(j<centery+80)
    i=i+1;
    j=j+1;
    if in(i,j)==1&((i>centerx+10)|(j>centery+10))&(abs(t31-i)+abs(t32-j)>6)
       t31=i;
       t32=j;
       out(i,j)=3;
        num3=num3+1;
    end
end
i=centerx;
j=centery;
while (i<centerx+80)&(j<centery+80)
    i=i+2;
    j=j+1;
    if in(i,j)==1&((i>centerx+10)|(j>centery+10))
        if (abs(t41-i)+abs(t42-j)>6)
       t41=i;
       t42=j;
                out(i,j)=4;
                num4=num4+1;
         end
           
    end
    if in(i+1,j)==1&((i+1>centerx+10)|(j>centery+10))
        if (abs(t41-i-1)+abs(t42-j)>6)
      t41=i+1;
      t42=j;
                out(i+1,j)=4; 
                num4=num4+1;
            end
            
    end
end
i=centerx;
j=centery;
while (i<centerx+80)&(j<centery+80)
    i=i+3;
    j=j+1;
    if in(i,j)==1&((i>centerx+10)|(j>centery+10))&(abs(t51-i)+abs(t52-j)>6)
               t51=i;
               t52=j;
                out(i,j)=5; 
                num5=num5+1;
    end
    if in(i+1,j)==1&((i+1>centerx+10)|(j>centery+10))&(abs(t51-i-1)+abs(t52-j)>6)
               t51=i+1;
               t52=j;
                out(i+1,j)=5;
                num5=num5+1;
    end
    if in(i+2,j)==1&((i+2>centerx+10)|(j>centery+10))&(abs(t51-i-2)+abs(t52-j)>6)
               t51=i+2;
               t52=j;
                out(i+2,j)=5; 
                num5=num5+1;
    end
end
    
i=centerx;
j=centery;
while (i<centerx+80)&(j>centery-80)
    i=i+1;
    j=j-3;
    if (in(i,j)==1)&((i>centerx+10)|(j<centery-10))&(abs(t61-i)+abs(t62-j)>6)
        t61=i;
        t62=j;
        num6=num6+1;
        out(i,j)=6;
    end
     if (in(i,j-1)==1)&((i>centerx+10)|(j-1<centery-10))&(abs(t61-i)+abs(t62-j+1)>6)
        t61=i;
        t62=j-1;
        num6=num6+1;
        out(i,j-1)=6;
    end
    if (in(i,j-2)==1)&((i>centerx+10)|(j-2<centery-10))&(abs(t61-i)+abs(t62-j+2)>6)
        t61=i;
        t62=j-2;
        num6=num6+1;
        out(i,j-2)=6;
    end
end
i=centerx;
j=centery;
while (i<centerx+80)&(j>centery-80)
    i=i+1;
    j=j-2;
    if (in(i,j)==1)&((i>centerx+10)|(j<centery-10))&(abs(t71-i)+abs(t72-j)>6)
        t71=i;
        t72=j;
        num7=num7+1;
                out(i,j)=7;
    end
    if (in(i,j-1)==1)&((i>centerx+10)|(j-1<centery-10))&(abs(t71-i)+abs(t72-j+1)>6)
                t71=i;
        t72=j-1;
        num7=num7+1;
                out(i,j-1)=7;
    end
end
i=centerx;
j=centery;
while (i<centerx+80)&(j>centery-80)
    i=i+1;
    j=j-1;
    if (in(i,j)==1)&((i>centerx+10)|(j<centery-10))&(abs(t81-i)+abs(t82-j)>6)
        t81=i;
        t82=j;
        num8=num8+1;
                out(i,j)=8;
    end
end
i=centerx;
j=centery;
while (i<centerx+80)&(j>centery-80)
    i=i+2;
    j=j-1;
    if (in(i,j)==1)&((i>centerx+10)|(j<centery-10))&(abs(t91-i)+abs(t92-j)>6)
        t91=i;
        t92=j;
        num9=num9+1;
                out(i,j)=9;
    end
    if (in(i+1,j)==1)&((i+1>centerx+10)|(j<centery-10))&(abs(t91-i-1)+abs(t92-j)>6)
        t91=i+1;
        t92=j;
        num9=num9+1;
                out(i+1,j)=9;
    end
end
i=centerx;
j=centery;
while (i<centerx+80)&(j>centery-80)
    i=i+3;
    j=j-1;
    if (in(i,j)==1)&((i>centerx+10)|(j<centery-10))&(abs(t101-i)+abs(t62-j)>6)
        t101=i;
        t102=j;
        num10=num10+1;
                out(i,j)=10;
    end
    if (in(i+1,j)==1)&((i+1>centerx+10)|(j<centery-10))&(abs(t101-i-1)+abs(t102-j)>6)
        t101=i+1;
        t102=j;
        num10=num10+1;
        out(i+1,j)=10;
    end
        if (in(i+2,j)==1)&((i+2>centerx+10)|(j<centery-10))&(abs(t101-i-2)+abs(t102-j)>6)
        t101=i+2;
        t102=j;
        num10=num10+1;
        out(i+2,j)=10;
    end
end
num16=(num1-num6);
num27=(num2-num7);
num38=(num3-num8);
num49=(num4-num9);
num510=(num5-num10);
if abs(num38)>3
    if num38>0 & num16+num27+num38+num49+num510>5
        type=1;
    else
        type=2;
    end
else
    type=3;
end
result1=[num1 num2 num3 num4 num5 num6 num7 num8 num9 num10];
result=[num16 num27 num38 num49 num510];

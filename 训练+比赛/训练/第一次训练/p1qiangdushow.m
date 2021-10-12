x=1961:2005; % 时间列
y=PC2(:,1); % 数据列
N=length(y);
n=length(y);
Sk=zeros(size(y));
UFk=zeros(size(y));
s=0;
for i=2:n
   for j=1:i
         if y(i)>y(j)
           s=s+1;
         else
           s=s+0;
         end
   end
   Sk(i)=s;
   E=i*(i-1)/4; 
  Var=i*(i-1)*(2*i+5)/72; 
  UFk(i)=(Sk(i)-E)/sqrt(Var);
end
y2=zeros(size(y));
Sk2=zeros(size(y));
UBk=zeros(size(y));
s=0;
for i=1:n
    y2(i)=y(n-i+1);
end
for i=2:n
   for j=1:i
         if y2(i)>y2(j)
           s=s+1;
         else
           s=s+0;
         end
   end
   Sk2(i)=s;
   E=i*(i-1)/4; 
  Var=i*(i-1)*(2*i+5)/72;
  UBk(i)=0-(Sk2(i)-E)/sqrt(Var);
end
UBk2=zeros(size(y));
for i=1:n
   UBk2(i)=UBk(n-i+1);
end
h1=plot(x,UFk,'r-','linewidth',1.5);
hold on
h2=plot(x,UBk2,'b-.','linewidth',1.5);
axis([min(x),max(x),-5,6]);
xlabel('年份','FontName','TimesNewRoman','FontSize',12);
ylabel('时间序列系数','FontName','TimesNewRoman','Fontsize',12);
hold on
plot(x,0*ones(N,1),'-.','linewidth',1); 
ylim([-3 7]);
h3=plot(x,1.96*ones(N,1),':','linewidth',1);
plot(x,-1.96*ones(N,1),':','linewidth',1);
legend([h1 h2 h3],'UF统计量','UB统计量','0.05显著水平','Location','NorthEast');
f1=UFk;
f2=UBk2;

function f=imtiqu(b,a,filename)

D=6;


LTerm=(b==1);
figure(8);
imshow(LTerm)
LTermLab=bwlabel(LTerm);
propTerm=regionprops(LTermLab,'Centroid');
CentroidTerm=round(cat(1,propTerm(:).Centroid));
figure(5);

imshow(b,[])

set(gcf,'position',[1 1 600 600]);
hold on
plot(CentroidTerm(:,1),CentroidTerm(:,2),'ro')


LBif=(b==3);
LBifLab=bwlabel(LBif);
propBif=regionprops(LBifLab,'Centroid','Image');
CentroidBif=round(cat(1,propBif(:).Centroid));
plot(CentroidBif(:,1),CentroidBif(:,2),'go')
%process1
Distance=DistEuclidian(CentroidBif,CentroidTerm);
SpuriousMinutae=Distance<D;
[i,j]=find(SpuriousMinutae);
CentroidBif(i,:)=[];
CentroidTerm(j,:)=[];
%process2
Distance=DistEuclidian(CentroidBif);
SpuriousMinutae=Distance<D;
[i,j]=find(SpuriousMinutae);
CentroidBif(i,:)=[];

%process3
Distance=DistEuclidian(CentroidTerm);
SpuriousMinutae=Distance<D;
[i,j]=find(SpuriousMinutae);
CentroidTerm(i,:)=[];

hold off
imshow(~b)
hold on
plot(CentroidTerm(:,1),CentroidTerm(:,2),'ro')
plot(CentroidBif(:,1),CentroidBif(:,2),'go')
hold off



Kopen=imclose(b,strel('square',7));

KopenClean= imfill(Kopen,'holes');
KopenClean=bwareaopen(KopenClean,5);
imshow(KopenClean)
KopenClean([1 end],:)=0;
KopenClean(:,[1 end])=0;
ROI=imerode(KopenClean,strel('disk',10));
figure(6);
imshow(ROI)

imshow(a)
hold on
imshow(ROI)
alpha(0.5)

hold on
plot(CentroidTerm(:,1),CentroidTerm(:,2),'ro')
plot(CentroidBif(:,1),CentroidBif(:,2),'go')
hold off


[m,n]=size(a(:,:,1));
indTerm=sub2ind([m,n],CentroidTerm(:,1),CentroidTerm(:,2));
Z=zeros(m,n);
Z(indTerm)=1;
ZTerm=Z.*ROI;
[CentroidTermX,CentroidTermY]=find(ZTerm);

indBif=sub2ind([m,n],CentroidBif(:,1),CentroidBif(:,2));
Z=zeros(m,n);
Z(indBif)=1;
ZBif=Z.*ROI;
[CentroidBifX,CentroidBifY]=find(ZBif);



%imshow(a)
%hold on
%plot(CentroidTermX,CentroidTermY,'ro','linewidth',2)
%plot(CentroidBifX,CentroidBifY,'go','linewidth',2)


%table
Table=[3*pi/4 2*pi/3 pi/2 pi/3 pi/4
       5*pi/6 0 0 0 pi/6
       pi 0 0 0 0
      -5*pi/6 0 0 0 -pi/6
      -3*pi/4 -2*pi/3 -pi/2 -pi/3 -pi/4];

for ind=1:length(CentroidTermX)
    Klocal=b(CentroidTermY(ind)-2:CentroidTermY(ind)+2,CentroidTermX(ind)-2:CentroidTermX(ind)+2);
    Klocal(2:end-1,2:end-1)=0;
    [i,j]=find(Klocal);
    m=size(i,1);
    n=size(j,1);
    u=zeros(1,m*n);
    for k=1:m
        for l=1:n
            u(1,k*l)=Table(i(k,1),j(l,1));
        end
    end
    
    OrientationTerm(ind,1)=mean2(u);
end
OrientationTerm=OrientationTerm(1:ind,1);
dxTerm=sin(OrientationTerm)*5;
dyTerm=cos(OrientationTerm)*5;
figure
imshow(b)
set(gcf,'position',[1 1 600 600]);
hold on
plot(CentroidTermX,CentroidTermY,'ro','linewidth',2)
plot([CentroidTermX CentroidTermX+dyTerm]',...
    [CentroidTermY CentroidTermY-dxTerm]','r','linewidth',2)




for ind=1:length(CentroidBifX)
    Klocal=b(CentroidBifY(ind)-2:CentroidBifY(ind)+2,CentroidBifX(ind)-2:CentroidBifX(ind)+2);
    Klocal(2:end-1,2:end-1)=0;
    [i,j]=find(Klocal);
    if length(i)~=3
        CentroidBifY(ind)=NaN;
        CentroidBifX(ind)=NaN;
        OrientationBif(ind)=NaN;
    else
        for k=1:3
            OrientationBif(ind,k)=Table(i(k),j(k));
            dxBif(ind,k)=sin(OrientationBif(ind,k))*5;
            dyBif(ind,k)=cos(OrientationBif(ind,k))*5;

        end
    end
end
dxBif=dxBif(1:ind,k);
dyBif=dyBif(1:ind,k);
plot(CentroidBifX,CentroidBifY,'go','linewidth',2)


MinutiaTerm=[CentroidTermX,CentroidTermY,OrientationTerm];
MinutiaBif=[CentroidBifX,CentroidBifY,OrientationBif];
file=fopen(filename,'wt');
fprintf(file,'%s \n',['Name: ' filename]);
fprintf(file,'%s \n','-------------------------------------------------------------------');
fprintf(file,'%s \n','Ö¸ÎÆÄ©ÉÒ :');
fprintf(file,'%s \n','-------------------------------------------------------------------');
fprintf(file,'%s \n','X          Y     Angle');
fprintf(file,'%3.0f \t %3.0f \t %3.2f \n',MinutiaTerm');
fprintf(file,'%s \n','-------------------------------------------------------------------');
fprintf(file,'%s \n','Ö¸ÎÆ·Ö²æ :');
fprintf(file,'%s \n','-------------------------------------------------------------------');
fprintf(file,'%s \n','X          Y     Angle 1     Angle 2    Angle 3');
fprintf(file,'%3.0f \t %3.0f \t %3.2f \t \t %3.2f \t \t %3.2f \n',MinutiaBif');
fclose(file);

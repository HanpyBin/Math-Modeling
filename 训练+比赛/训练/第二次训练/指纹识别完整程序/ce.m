a=imread('2.bmp');
b=rgb2gray(a);
b=double(b);

[oimg,fimg,bwimg,eimg,b] =  fft_enhance_cubs(b);
figure(1);
imshow(b);
[m,n]=size(b);
;%自适应阀值二值化；
m1=m/8;
n1=n/8;
for i=1:m1
   for j=1:n1
      t=mean2(b((i-1)*8+1:(i-1)*8+8,(j-1)*8+1:(j-1)*8+8));
      for k=(i-1)*8+1:(i-1)*8+8
          for l=(j-1)*8+1:(j-1)*8+8
              if b(k,l)<t
                  b(k,l)=1;
              else 
                  b(k,l)=0;
              end
          end
      end
   end
end
%边缘检测和分割
for i=1:m
    for j=1:n
        if b(i,j)>1
            b(i,j)=0;
        end
    end
end


figure(2);
imshow(b,[])



for i=1:m
    for j=1:n
        if b(i,j)==1
            for k=1:j
                b(i,k)=1;
            end
            break;
        end
    end
end

for i=1:m
    for j=n:-1:1
        if b(i,j)==1
            for k=n:-1:j
                b(i,k)=1;
            end
            break;
        end
    end
end
%彻底二值化；
for i=1:m
    for j=1:n
        if b(i,j)==1
            b(i,j)=0;
        else
            b(i,j)=1;
        end
    end
end
figure(3);
imshow(b,[]);

b=bwmorph(b,'thin','inf');
fun=@minutie;
b = nlfilter(b,[3 3],fun);




figure(4);
imshow(b,[]);
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
ZTerm=Z.*ROI';
[CentroidTermX,CentroidTermY]=find(ZTerm);

indBif=sub2ind([m,n],CentroidBif(:,1),CentroidBif(:,2));
Z=zeros(m,n);
Z(indBif)=1;
ZBif=Z.*ROI';
[CentroidBifX,CentroidBifY]=find(ZBif);



imshow(a)
hold on
plot(CentroidTermX,CentroidTermY,'ro','linewidth',2)
plot(CentroidBifX,CentroidBifY,'go','linewidth',2)


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
    OrientationTerm(ind,1)=Table(i,j);
end
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

plot(CentroidBifX,CentroidBifY,'go','linewidth',2)
OrientationLinesX=[CentroidBifX CentroidBifX+dyBif(:,1);CentroidBifX CentroidBifX+dyBif(:,2);CentroidBifX CentroidBifX+dyBif(:,3)]';
OrientationLinesY=[CentroidBifY CentroidBifY-dxBif(:,1);CentroidBifY CentroidBifY-dxBif(:,2);CentroidBifY CentroidBifY-dxBif(:,3)]';
plot(OrientationLinesX,OrientationLinesY,'g','linewidth',2)















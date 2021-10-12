% clear;clc;close all;
% img=imread('E:\图片\2.bmp');
function [term,term_theta,bif,bif_theta]=extract(img,i_thin,msk)
% msk=segment_print(img,0);
theta=ori_finger(img,msk);
% i_thin=prepro(img,msk);
%指纹特征点的提取
[ht,wt]=size(i_thin);     %白色为脊线
cha_m=zeros(ht,wt);
nterm=0;nbif=0;
for i=3:ht-3                %粗提取特征点
    for j=3:wt-3
        if i_thin(i,j)==1
            if abs(i_thin(i-1,j)-i_thin(i-1,j+1))+abs(i_thin(i-1,j-1)-i_thin(i-1,j))+...
     +abs(i_thin(i,j-1)-i_thin(i-1,j-1))+abs(i_thin(i+1,j-1)-i_thin(i,j-1))+...
     +abs(i_thin(i+1,j)-i_thin(i+1,j-1))+abs(i_thin(i+1,j+1)-i_thin(i+1,j))+...
     +abs(i_thin(i,j+1)-i_thin(i+1,j+1))+abs(i_thin(i-1,j+1)-i_thin(i,j+1))==2
            nterm=nterm+1;
            term(1,nterm)=i;
            term(2,nterm)=j;
            cha_m(i,j)=1;
            end
            if abs(i_thin(i-1,j)-i_thin(i-1,j+1))+abs(i_thin(i-1,j-1)-i_thin(i-1,j))+...
     +abs(i_thin(i,j-1)-i_thin(i-1,j-1))+abs(i_thin(i+1,j-1)-i_thin(i,j-1))+...
     +abs(i_thin(i+1,j)-i_thin(i+1,j-1))+abs(i_thin(i+1,j+1)-i_thin(i+1,j))+...
     +abs(i_thin(i,j+1)-i_thin(i+1,j+1))+abs(i_thin(i-1,j+1)-i_thin(i,j+1))==6
            nbif=nbif+1;
            bif(1,nbif)=i;
            bif(2,nbif)=j;
            cha_m(i,j)=2;
            end
        end
    end
end
 figure,imshow(i_thin),hold on,plot(term(2,:),term(1,:),'bo'),
 plot(bif(2,:),bif(1,:),'ro');
 
for i=1:nterm       %消除边界点
    if term(1,i)<20|term(1,i)+20>ht|term(2,i)+20>wt|term(2,i)<20
        cha_m(term(1,i),term(2,i))=0;
    else
       if sum(msk(term(1,i),1:term(2,i)-10))==0|sum(msk(term(1,i),term(2,i)+10:wt))==0|...
          sum(msk(1:term(1,i)-10,term(2,i)))==0|sum(msk(term(1,i)+10:ht,term(2,i)))==0 
       cha_m(term(1,i),term(2,i))=0;
       end
    end
end
for i=1:nbif
     if bif(1,i)<20|bif(1,i)+20>ht|bif(2,i)+20>wt|bif(2,i)<20
        cha_m(bif(1,i),bif(2,i))=0;
     else
       if sum(msk(bif(1,i),1:bif(2,i)-10))==0|sum(msk(bif(1,i),bif(2,i)+10:wt))==0|...
          sum(msk(1:bif(1,i)-10,bif(2,i)))==0|sum(msk(bif(1,i)+10:ht,bif(2,i)))==0 
   cha_m(bif(1,i),bif(2,i))=0;
       end
     end
end

 for i=1:nterm-1               %根据距离判断去除伪特征点
     for j=i+1:nterm
        if sqrt((term(1,i)-term(1,j))^2+(term(2,i)-term(2,j))^2)<8
            cha_m(term(1,i),term(2,i))=0;
            cha_m(term(1,j),term(2,j))=0;
        end
     end
     for j=1:nbif
        if sqrt((term(1,i)-bif(1,j))^2+(term(2,i)-bif(2,j))^2)<8
            cha_m(term(1,i),term(2,i))=0;
            cha_m(bif(1,j),bif(2,j))=0;
        end
     end
 end
 for i=1:nbif-1
     for j=i+1:nbif 
            if sqrt((bif(1,i)-bif(1,j))^2+(bif(2,i)-bif(2,j))^2)<8
            cha_m(bif(1,i),bif(2,i))=0;
            cha_m(bif(1,j),bif(2,j))=0;
        end
     end
 end
  nterm=0;nbif=0;
   term=[];bif=[];
 for i=1:ht
     for j=1:wt
   if cha_m(i,j)==1
    nterm=nterm+1;
    term(1,nterm)=i;
    term(2,nterm)=j;
   end
   if cha_m(i,j)==2
       nbif=nbif+1;
       bif(1,nbif)=i;
       bif(2,nbif)=j;
   end
     end
 end
figure,imshow(i_thin),hold on,plot(term(2,:),term(1,:),'bo'),
plot(bif(2,:),bif(1,:),'ro'); 

 d=zeros(1,nterm); len=11; num=zeros(1,nterm); n=ones(1,nterm);
 for i=1:nterm              %装配特征点 term, term_theta;
     term_n(:,1)=find_n(i_thin,term(1,i),term(2,i),len);
    angle1=get_angle(term(2,i),term(1,i),term_n(2,1),term_n(1,1));
     angle2=theta(term(1,i),term(2,i));
     angle3=get_angledis(angle1,angle2);
     if (angle3>90&angle3<270)
         term(3,i)=angle2+180;
     else
         term(3,i)=angle2;
     end
     a=term(3,i)*pi/180+pi/4;
     x11=term(2,i)+fix(16*cos(a)+0.5);
     y11=term(1,i)+fix(16*sin(a)+0.5);
     term_theta(1,i)=theta(y11,x11);
     a=a+2*pi/3;
     x11=term(2,i)+fix(16*cos(a)+0.5);
     y11=term(1,i)+fix(16*sin(a)+0.5);
     term_theta(2,i)=theta(y11,x11);
     a=a+2*pi/3;
     x11=term(2,i)+fix(16*cos(a)+0.5);
     y11=term(1,i)+fix(16*sin(a)+0.5);
     term_theta(3,i)=theta(y11,x11);
 end
%  
 for i=1:nbif               %装配分叉点，bif,bif_theta
     n=1;
     for k1=-1:1
         for k2=-1:1
             if (k1==0&k2==0)
                 continue
             end
             if i_thin(bif(1,i)+k1,bif(2,i)+k2)==1
                 b_now(1,n)=bif(1,i)+k1;
                 b_now(2,n)=bif(2,i)+k2;
                 n=n+1;
             end
         end
     end
     for n=1:3
         n_term(:,n)=find_8(i_thin,b_now(1,n),b_now(2,n),bif(1,i),bif(2,i),len-1);
     end
     d0=sqrt((n_term(1,1)-n_term(1,2))^2+(n_term(2,1)-n_term(2,2))^2);
     d1=sqrt((n_term(1,1)-n_term(1,3))^2+(n_term(2,1)-n_term(2,3))^2);
     d2=sqrt((n_term(1,2)-n_term(1,3))^2+(n_term(2,2)-n_term(2,3))^2);
     if (d0<d1&d0<d2)
        x11=n_term(2,1); y11=n_term(1,1);
        x21=n_term(2,2); y21=n_term(1,2);
     end
     if (d1<d2&d1<d0)
        x11=n_term(2,1); y11=n_term(1,1);
        x21=n_term(2,3); y21=n_term(1,3);
     end
     if (d2<d1&d2<d0)
        x11=n_term(2,2); y11=n_term(1,2);
        x21=n_term(2,3); y21=n_term(1,3);
     end
     angle1=get_angle(bif(2,i),bif(1,i),(x11+x21)/2,(y11+y21)/2);
     angle2=theta(bif(1,i),bif(2,i));
     angle3=get_angledis(angle1,angle2);
     if (angle3>90&angle3<270)
         bif(3,i)=angle2+180;
     else
         bif(3,i)=angle2;
     end
     a=bif(3,i)*pi/180+pi/4;
     x11=bif(2,i)+fix(16*cos(a)+0.5);
     y11=bif(1,i)+fix(16*sin(a)+0.5);
     bif_theta(1,i)=theta(y11,x11);
     a=a+2*pi/3;
     x11=bif(2,i)+fix(16*cos(a)+0.5);
     y11=bif(1,i)+fix(16*sin(a)+0.5);
     bif_theta(2,i)=theta(y11,x11);
     a=a+2*pi/3;
     x11=bif(2,i)+fix(16*cos(a)+0.5);
     y11=bif(1,i)+fix(16*sin(a)+0.5);
     bif_theta(3,i)=theta(y11,x11);
 end



 
 
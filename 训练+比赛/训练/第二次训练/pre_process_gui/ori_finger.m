function theta=ori_finger(img,msk);
% img=imread('E:\ͼƬ\1.bmp');
% msk=segment_print(img,0);
img=double(img);
[mf,nf]=size(img);
sobely=fspecial('sobel');
sobelx=sobely';
gra_x=zeros(mf,nf);gra_y=zeros(mf,nf);
so_y=[-1,0,1;-2,0,2;-1,0,1];so_x=[1,2,1;0,0,0;-1,-2,-1];
for k1=2:mf-1
    for k2=2:nf-1
        gra_x(k1,k2)=sum(sum(so_x.*img(k1-1:k1+1,k2-1:k2+1)));
        gra_y(k1,k2)=sum(sum(so_y.*img(k1-1:k1+1,k2-1:k2+1)));
    end
end
gra2=gra_x+gra_y; theta=zeros(mf,nf);
for k1=1:2:mf
    for k2=1:2:nf
         if msk(k1,k2)==0
             theta(k1,k2)=255;theta(k1+1,k2)=255;
             theta(k1,k2+1)=255;theta(k1+1,k2+1)=255;
             continue
         end
        if k1-7<1
            star1=1;
        else star1=k1-7;
        end
        if k1+7>mf
            end1=mf;
        else end1=k1+7;
        end
        if k2-7<1
            star2=1;
        else star2=k2-7;
        end
        if k2+7>nf
            end2=nf;
        else end2=k2+7;
        end
        vy=sum(sum(gra_x(star1:end1,star2:end2).^2-gra_y(star1:end1,star2:end2).^2));
        vx=sum(sum(2*gra_x(star1:end1,star2:end2).*gra_y(star1:end1,star2:end2)));
        fangle=atan2(vx,vy);
        if fangle<0   fangle=fangle+pi;
        end
        theta(k1,k2)=fangle*180/pi; 
%         if theta(k1,k2)<=0   theta(k1,k2)=theta(k1,k2)+180;
%         end  
%         theta(k1,k2)=180-theta(k1,k2);
        theta(k1+1,k2)=theta(k1,k2);
        theta(k1,k2+1)=theta(k1,k2);    theta(k1+1,k2+1)=theta(k1,k2);
    end
end 
    
                
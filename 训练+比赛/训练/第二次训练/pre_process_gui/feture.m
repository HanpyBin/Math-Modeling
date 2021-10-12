function i_thin=feture(img)

msk=segment_print(img,0);
% theta=ori_finger(img,msk);
i_thin=prepro(img,msk);
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
 figure(7),imshow(i_thin),hold on,plot(term(2,:),term(1,:),'bo'), plot(bif(2,:),bif(1,:),'ro');
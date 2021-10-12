function get_fet(i_thin)

% figure(33);imshow(i_thin)
term = [];
i_thino=i_thin;
[ht,wt]=size(i_thin);
cha_m=zeros(ht,wt);
nterm=0;nbif=0;
for i=3:ht-3
    for j=3:wt-3
        if i_thino(i,j)==1
            if abs(i_thino(i-1,j)-i_thino(i-1,j+1))+abs(i_thino(i-1,j-1)-i_thino(i-1,j))+abs(i_thino(i,j-1)-i_thino(i-1,j-1))+abs(i_thino(i+1,j-1)-i_thino(i,j-1))+abs(i_thino(i+1,j)-i_thino(i+1,j-1))+abs(i_thino(i+1,j+1)-i_thino(i+1,j))+abs(i_thino(i,j+1)-i_thino(i+1,j+1))+abs(i_thino(i-1,j+1)-i_thino(i,j+1))==2
                nterm=nterm+1;
                term(1,nterm)=i;
                term(2,nterm)=j;
                cha_m(i,j)=1;
            end
            if abs(i_thino(i-1,j)-i_thino(i-1,j+1))+abs(i_thino(i-1,j-1)-i_thino(i-1,j))+abs(i_thino(i,j-1)-i_thino(i-1,j-1))+abs(i_thino(i+1,j-1)-i_thino(i,j-1))+abs(i_thino(i+1,j)-i_thino(i+1,j-1))+abs(i_thino(i+1,j+1)-i_thino(i+1,j))+abs(i_thino(i,j+1)-i_thino(i+1,j+1))+abs(i_thino(i-1,j+1)-i_thino(i,j+1))==6
                nbif=nbif+1;
                bif(1,nbif)=i;
                bif(2,nbif)=j;
                cha_m(i,j)=2;
            end
        end
    end
end

imshow(i_thino);
hold on;
plot(term(2,:),term(1,:),'go');
plot(bif(2,:),bif(1,:),'ro');
title('Ãÿ’˜Ã·»°');
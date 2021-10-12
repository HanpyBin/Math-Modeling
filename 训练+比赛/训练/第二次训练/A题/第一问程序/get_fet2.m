function get_fet2(i_thin, msk)
[i_thin2,term,bif]=mark(i_thin,msk);
imshow(i_thin2);
hold on;
size(term)
plot(term(2,:),term(1,:),'bo'),plot(bif(2,:),bif(1,:),'ro');
title('ÌØÕ÷±ê¼Ç');
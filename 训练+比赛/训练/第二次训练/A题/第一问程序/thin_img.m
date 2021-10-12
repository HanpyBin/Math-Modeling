function c=thin_img(iseg, msk)

c=bwmorph(iseg,'thin','inf');   %
fun=@minutie;
c = nlfilter(c,[3 3],fun);

i_thin=c(5:364,1:256);
msk=msk(5:364,1:256);  % ¨®
i_thin(i_thin>0)=1;

% imshow(c);
% title('Ï¸ »¯');
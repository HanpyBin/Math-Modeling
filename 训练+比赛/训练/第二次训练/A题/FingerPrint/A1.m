I=imread('Empreinte.bmp');
subplot(421);
imshow(I);
set(gcf,'position',[1 1 600 600]);
J=I(:,:,1)>160;
subplot(322);imshow(J)
set(gcf,'position',[1 1 600 600])
K=bwmorph(~J,'thin','inf');
subplot(323);imshow(~K)
set(gcf,'position',[1 1 600 600]);
fun=@minutie;
L = nlfilter(K,[3 3],fun);
%LTerm=(L==1);
%subplot(324);
%imshow(LTerm);
LTermLab=bwlabel(J);
subplot(324);
imshow(LTermLab)
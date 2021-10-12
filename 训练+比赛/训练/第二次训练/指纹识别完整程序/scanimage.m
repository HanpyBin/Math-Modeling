function image1=scanimage
% dialog for opening files

%imagefile1=inputdlg('Please input the filename of image');
[imagefile1 , pathname]= uigetfile('*.*;*.*','´ò¿ªÖ¸ÎÆÍ¼Ïñ'); 
if imagefile1 ~= 0 
cd(pathname);
image1=testread(char(imagefile1));
end;
%image1=testread(char(imagefile1));




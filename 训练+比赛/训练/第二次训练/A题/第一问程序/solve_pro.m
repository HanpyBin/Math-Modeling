function [endpoint_x, endpoint_y,bifurcation_x,bifurcation_y, endpoint_line_num, bifurcation_line_num, corepoint_x, corepoint_y, oimg] = solve_pro(ord)
% function [img] = solve_pro(ord)
load 1;
path = ['../../第1题附件/',num2str(ord,'%02d'),'.tif'];
img=im2double(imread(path,'tif'));
msk = fenge(img);
figure,imshow(msk);
saveas(gcf, [num2str(ord),'分割'], 'png')
[iseg, oimg]=bina(img, msk, ord);
imshow(iseg);
saveas(gcf, [num2str(ord),'二值化'], 'png')
c = thin_img(iseg, msk);
figure,imshow(c);
saveas(gcf, [num2str(ord),'细化'], 'png')
% imshow(c)
c(find(c>0))=1;
% imshow(c)
[endpoint_x, endpoint_y, bifurcation_x, bifurcation_y] = feat(1-c, msk, ord);
% imshow(c)
endpoint_line_num = bresenham(c,corepoint_final(ord,1),corepoint_final(ord,2),endpoint_y, endpoint_x);
endpoint_line_num = floor(endpoint_line_num);
bifurcation_line_num = bresenham(c, corepoint_final(ord,1),corepoint_final(ord,2),bifurcation_y, bifurcation_x);
bifurcation_line_num = floor(bifurcation_line_num);
corepoint_x = corepoint_final(ord,1);
corepoint_y = corepoint_final(ord,2);
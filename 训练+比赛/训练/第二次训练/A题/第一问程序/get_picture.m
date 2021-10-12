clear, clc;
for i = 7:16
[img] = solve_pro(i);
figure,imshow(img);
saveas(gcf, [num2str(i),'ԭͼ'], 'png')
end
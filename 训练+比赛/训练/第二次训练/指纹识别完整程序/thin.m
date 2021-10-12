function [out] = thin(in);
tic;
out = in;

h= waitbar(0,'please wait...')

count = 2;
for i = 1:count
	out = thinning6(in);

	in = out;
   waitbar(i/count);

end;
close(h);
result=fenlei(out);
imagesc(out);
imwrite(out,'youji.bmp');
%msgbox(toc,'消耗时间','modal');
uiwait(msgbox(toc,'消耗时间','modal'));


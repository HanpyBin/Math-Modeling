function [o] = thres(a,W);

%Adaptive thresholding is performed by segmenting image a
[w,h] = size(a);

z= waitbar(0,'please wait...')

for i=1:W:w
for j=1:W:h

mean_thres = 0;

        for k=i:i+W-1
        for l=j:j+W-1

                mean_thres = mean_thres + a(k,l);

        end;
        end;

        mean_thres = mean_thres / (W^2);
        mean_thres

        for k=i:i+W-1
        for l=j:j+W-1

                if a(k,l) > mean_thres;

                        o(k,l) = 1;

                else
                        o(k,l) = 0;

                end;

        end;
        end;

end;
   waitbar(i/w);
     
end;

close(z);

imagesc(o);
colormap(gray);

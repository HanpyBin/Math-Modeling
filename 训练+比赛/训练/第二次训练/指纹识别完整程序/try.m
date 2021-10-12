function q=try(w);

% test script to run all functions
%

a = testread(1);

o = thres(a,20);

figure;
colormap(gray);imagesc(o);


for i=1:12
        out = thinning(o);


o =out;

end;
	 figure;
        colormap(gray);imagesc(out);


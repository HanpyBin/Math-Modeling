function test(w);

a = testread(1);

figure;
colormap(gray);imagesc(a);


o = thres(a,20);

figure;
colormap(gray);imagesc(o);

out = thinning(o);

figure;
colormap(gray);imagesc(out);


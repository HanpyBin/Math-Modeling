function [q, l ,s ] = trf(w);

% q is output image
% l is end_list
% s is branch_list
% w is dummy (e.g 1)


%update 2/12

% test script to run all functions
% will print out the result too

a = testread(w);


figure;
colormap(gray);imagesc(a);


o = thres(a,20);


%figure;
%colormap(gray);imagesc(o);


for i=1:12
        out = thinning2(o);


o =out;

end;

q = m_connect(o);

figure;
colormap(gray);imagesc(q)

[l,s] = find_list(q);


show_list(l);
title('end');
show_list(s);
title('branch');



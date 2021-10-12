function f = filter_frequency_image(f)
    [ht,wt]  = size(f);
    maxiter  = 20;
    %pad the image
    f        = [zeros(ht,3),f,zeros(ht,3)];
    f        = [zeros(3,wt+6);f;zeros(3,wt+6)];
    nf       = zeros(size(f)); %new f
    w        = fspecial('gaussian',7,2);
    iter     = 1;
    while(iter < maxiter)
        for i = 4:ht+3
            for j = 4:wt+3
                blk =   f(i-3:i+3,j-3:j+3);
                msk =   (blk>3 & blk<=25);
                if(f(i,j)< 3 || f(i,j)>25) %interpolate
                    nf(i,j) = sum(sum((blk.*w).*msk))/sum(sum(w.*msk));
                else
                    nf(i,j) = f(i,j);
                end
            end
        end
        cnt   = sum(sum(nf(4:ht+3,4:wt+3) < 3 | nf(4:ht+3,4:wt+3) > 25));
        if(cnt == 0)
            break;
        end
        iter = iter+1;
        f    = nf;
    end
    f       = nf(4:ht+3,4:wt+3);
    f       = imfilter(f,fspecial('gaussian',7,2),'same','replicate');
%end function filter_frequency_image

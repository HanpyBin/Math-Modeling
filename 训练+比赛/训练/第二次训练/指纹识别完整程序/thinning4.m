function out = thinning4(in);

%thinning process obtain a one pixel wide image skeleton
% use function n_sum and t_sum

[w,h] = size(in);

out = in;

for i= 2:h-1
for j= 2:w-1

        if out(i,j) == 1
             if  out(i-1,j)+out(i,j+1)+out(i+1,j)+out(i,j-1)<4
                if 1 < n_sum(i,j,out) &  n_sum(i,j,out) < 6 
                        if  t_sum(i,j,out) == 2                      
                                                out(i,j) = 0;
                        else
                                                out(i,j) = 1;
                                        end;
                                else
                                        out(i,j) = 1;
                                end;
                        else
                                out(i,j) = 1;

                        end;
                end;

        end;                

end;
end;
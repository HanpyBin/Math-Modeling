function out = thinning2(in);

%thinning process obtain a one pixel wide image skeleton
% use function n_sum and t_sum

[w,h] = size(in);

out = in;

for i= 3:h-2
for j= 3:w-2

        if out(i,j) == 1

                if 1 < n_sum(i,j,out) &  n_sum(i,j,out) < 7 
                        if  t_sum(i,j,out) == 2
                                 if or ( and_157(i,j,out) == 0  , t_sum(i,j-1,out) ~= 2 )
                                         if or (and_357(i,j,out) == 0  , t_sum(i+1,j,out) ~=2 )   
                                     %        if and_157(i,j,out) == 0
                                     % if  and_357(i,j,out) == 0   
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




                




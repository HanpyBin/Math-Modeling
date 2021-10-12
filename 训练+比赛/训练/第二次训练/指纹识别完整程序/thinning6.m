function out=thinning6(in)
 %其中的索引表是将thinning3 thinning 5中的为1的元素合起来得到的。

%initial index table
%index=[0	0	0	0	0	0	0	1	0	0	1	1	0	0	1	1	0	0	0	0	0	0	0	0	0	0	1	1	1	0	1	1	0	0	0	0	0	0	0	0	1	0	0	0	1	0	0	0	0	0	0	0	0	0	0	0	1	0	0	0	1	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	0	0	0	1	0	0	0	1	0	0	0	0	0	0	0	1	0	0	0	1	0	0	0	0	0	1	1	0	0	1	1	0	0	0	0	0	0	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	1	1	0	0	1	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	1	0	1	0	0	0	0	0	0	0	0	0	0	0	0	1	1	0	0	0	0	0	0	1	0	0	0	0	0	0	0];
%new index table
index=[1	0	0	1	0	0	1	1	0	0	1	1	1	0	1	1	0	0	0	0	0	0	0	0	1	0	1	1	1	0	1	1	0	0	0	0	0	0	0	0	1	0	1	0	1	0	0	0	1	0	0	0	0	0	0	0	1	0	0	0	1	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	0	0	0	0	0	0	0	1	0	0	0	1	0	0	0	1	0	0	0	0	0	0	0	1	0	0	0	1	0	1	1	1	0	1	1	0	0	1	1	0	0	1	0	0	0	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	1	1	1	0	0	0	0	0	1	0	0	0	0	0	0	0	1	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	1	1	0	0	1	1	0	0	0	0	0	0	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	1	0	1	0	0	0	0	0	0	0	0	0	0	0	0	1	1	0	0	0	0	0	0	1	0	0	0	0	0	0	0];
out=in;
[width,height]=size(in);
length=width*height;
for k=1:6
for i= 2:width-1
for j= 2:height-1

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
for m=1:6
for i=2:width-2
    for j=2:height-2
        if out(i,j)==1    
           num= out(i-1,j-1)+out(i-1,j) * 2+out(i-1,j+1) * 4+out(i,j+1) * 8+out(i+1,j+1) * 16+out(i+1,j) * 32+out(i+1,j-1) * 64 + out(i,j-1) * 128;
           if  index(num+1)==1
               out(i,j)=0;             
           end           
           if num==74
              out(i,j+1)=0;
              out(i+1,j+1)=0;
            end
           if num==146
              out(i-1,j)=0;
              out(i-1,j+1)=1;
           end
           if num==164
               out(i-1,j-1)=1;
              out(i,j-1)=0;
           end
           if num==41
             out(i+1,j-1)=1;
            out(i+1,j)=0;
            end
                      %保留模板
           if out(i-1,j)==1 & out(i-1,j+2)==0 &out(i,j-1)==0 &out(i,j+1)==1 &out(i,j+2)==0 & out(i+1,j)==1 & out(i+1,j+2)==0 
               out(i,j)=1;
           end
           if out(i-1,j+1)==0 &out(i-1,j+2)==0 &out(i,j-1)==0 & out(i,j+1)==1 & out(i,j+2)==0 & out(i+1,j+1)==1
               out(i,j)=1;
               if num==120 & out(i-1,j+2)==0 & out(i+1,j+2)==1 &out(i+2,j-1:j+2)==[1 1 1 1]
                   out(i,j)=0;
               end
           end
           if out(i-1,j+1)==1 & out(i,j-1)==0 & out(i,j+1)==1 &out(i,j+2)==0 & out(i+1,j+1)==0 out(i+1,j+2)==0
               out(i,j)=1;
           end
           if out(i-1,j)==0 & out(i,j-1)==1 & out(i,j+1)==1 & out(i+1,j)==1 &out(i+2,j-1)==0 & out(i+2,j)==0 & out(i+2,j+1)==0
               out(i,j)=1;
           end
           if out(i-1,j)==0 & out(i+1,j-1)==1 & out(i,j+1)==1 & out(i+1,j+1)==0 & out(i+2,j)==0 & out(i+2,j+1)==0
               out(i,j)=1;
               if num==225 & out(i-1,j+2)==0 & out(i,j+2)==0 & out(i+1,j+2)==0 & out(i+2,j-1:j+2)==[1 0 0 0]
                   out(i,j)=0;
               end
           end
           if out(i-1,j)==0 & out(i+1,j-1)==0 & out(i+1,j)==1 & out(i+1,j+1)==1 & out(i+2,j-1)==0 & out(i+2,j)==0
               out(i,j)=1;
               if num==60 & out(i-1,j+2)==1 & out(i,j+2)==1 & out(i+1,j+2)==1 & out(i+2,j-1:j+2)==[0 0 1 1]
                   out(i,j)=0;
               end
           end  
                          
          end
      end
  end
end
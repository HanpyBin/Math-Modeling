function term_n=find_n(i_thin,point_y,point_x,N)
n=0;
for k=-1:1
    for j=-1:1
        if (k==0&j==0)
            continue;
        end
        if i_thin(point_y+k,point_x+j)==1
           con(1,1)=point_y+k; con(2,1)=point_x+j;
           n=n+1;
        end
    end
end
if n==3|n==0     %为孤立的点或点为叉点
    term_n(1,1)=point_y; term_n(2,1)=point_x;
    return;
end
if n==1;        %为连续的点，继续寻找
    m_now=con(1,1); n_now=con(2,1);
    m_last=point_y;n_last=point_x;
    count=0;
    while count<N
      if sum(sum(i_thin(m_now-1:m_now+1,n_now-1:n_now+1)))==4|...
         sum(sum(i_thin(m_now-1:m_now+1,n_now-1:n_now+1)))==2    %寻找的点为叉点\端点
      term_8(1,1)=m_now; term_8(2,1)=n_now;   
      break;
      end 
      for k=-1:1
          for j=-1:1
               if (k==0&j==0)|(m_now+k==m_last&n_now+j==n_last)
                     continue;
               end
                   if (i_thin(m_now+k, n_now+j)==1)
                       m_last=m_now; n_last=n_now;
                       m_now=m_now+k; n_now=n_now+j;
                       count=count+1;
                   end
          end
      end
    end
end
term_n(1,1)=m_now;term_n(2,1)=n_now;
end

        
function term_n=find_8(i_thin,point_ny,point_nx,point_ly,point_lx,N)
    m_now=point_ny; n_now=point_nx;
    m_last=point_ly;n_last=point_lx;
    count=0;
    while count<8
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

term_n(1,1)=m_now;term_n(2,1)=n_now;


        
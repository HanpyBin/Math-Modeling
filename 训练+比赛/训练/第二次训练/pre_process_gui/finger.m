align.similar=0;  align.count=0; align.r=0; align.x=0; align.y=0;
n_ibif=length(i_bif); n_mbif=length(m_bif);

i_bif(4,:)=2;  m_bif(4,:)=2;   i_term(4,:)=1; m_term(4,:)=1;
i_mark=[i_term, i_bif];  m_mark=[m_term, m_bif];
i_marknum=length(i_mark);   m_marknum= length(m_mark);

%对分叉点进行 配准

for i=1:n_ibif
    for j=1:n_mbif
        if (i_bif_theta(1,i)~=255&&m_bif_theta(1,j)~=255)
            a1=get_jiajiao(i_bif_theta(1,i),rem(i_bif(3,i),180));
            a2=get_jiajiao(m_bif_theta(1,j),rem(m_bif(3,j),180));
            if abs(a1-a2)>10
                continue
            end
        end
        if (i_bif_theta(1,i)~=255&&m_bif_theta(1,j)~=255)&...
                (i_bif_theta(2,i)~=255&&m_bif_theta(2,j)~=255)
            a1=get_jiajiao(i_bif_theta(1,i),i_bif_theta(2,i));
            a2=get_jiajiao(m_bif_theta(1,j),m_bif_theta(2,j));
            if abs(a1-a2)>10
                continue
            end
        end
      if (i_bif_theta(1,i)~=255&&m_bif_theta(1,j)~=255)&...
                (i_bif_theta(3,i)~=255&&m_bif_theta(3,j)~=255)
            a1=get_jiajiao(i_bif_theta(1,i),i_bif_theta(3,i));
            a2=get_jiajiao(m_bif_theta(1,j),m_bif_theta(3,j));
            if abs(a1-a2)>10
                continue
            end
      end
     if (i_bif_theta(2,i)~=255&&m_bif_theta(2,j)~=255)&...
                (i_bif_theta(3,i)~=255&&m_bif_theta(3,j)~=255)
            a1=get_jiajiao(i_bif_theta(2,i),i_bif_theta(3,i));
            a2=get_jiajiao(m_bif_theta(2,j),m_bif_theta(3,j));
            if abs(a1-a2)>10
                continue
            end
     end
       align.r= get_angledis(i_bif(3,i),m_bif(3,j));
       align.x= i_bif(2,i) - m_bif(2,j);
       align.y= i_bif(1,i) - m_bif(1,j);
       %  得到x,y,r 进行配准align_im
       align_mark =align_im(i_mark,align.r,align.x,align.y);  %输入校正后的特征点
       
       score=0; matchNum=0;    
       flagT=zeros(1,i_marknum); flagA=zeros(1,m_marknum);
       for m=1:i_marknum
           if flagT(m)==1        %是否已有匹配对象
               continue;
           end
           for n=1:m_marknum
               if flagA(n)==1
                   continue;
               end
               if align_mark(4,m)~=m_mark(4,n)
                   continue;
               end
               
               angle= get_angle360(align_mark(3,m),m_mark(3,n));
               if angle>=10
                   continue;
               end
               dis=sqrt((align_mark(1,m)-m_mark(1,n))^2+(align_mark(2,m)-m_mark(2,n))^2);
               if dis>=10
                   continue;
               end
               flagT(m)=1;
               flagA(m)=1;    %标记
               score=score+ (10-angle);
               score=score+ (10-dis);
               matchNum=matchNum+1;
               
               if  (matchNum>=10)     %简单快速识别指纹法
                  disp('匹配成功，为同一指纹');
                  return;
               end
           end
       end
    end
end
       if matchNum<10
           disp('为不同指纹');
       end
       % 对 配准后的特征点 进行匹配
       
    
    
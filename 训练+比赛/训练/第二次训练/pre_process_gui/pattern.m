clear;
clc;
% close all;
img_1=imread('../��1�⸽��/01.tif');
img_2=imread('../��1�⸽��/02.tif');

msk_1=segment_print(img_1,0);
msk_2=segment_print(img_2,0);

i_thin1=prepro(img_1,msk_1);
i_thin2=prepro(img_2,msk_2);

[i_term,i_term_theta,i_bif,i_bif_theta] = extract(img_1,i_thin1,msk_1);
[m_term,m_term_theta,m_bif,m_bif_theta] = extract(img_2,i_thin2,msk_2); 




% align.similar=0;  align.count=0; align.r=0; align.x=0; align.y=0;
n_ibif=length(i_bif); n_mbif=length(m_bif);

i_bif(4,:)=2;  m_bif(4,:)=2;   i_term(4,:)=1; m_term(4,:)=1;

i_mark=[i_term, i_bif];  m_mark=[m_term, m_bif];  % ����ͼ��ģ��ͼ���������

i_marknum=length(i_mark);   m_marknum= length(m_mark);

%�Էֲ����� ��׼
num_n=0;p=0;
% for i=1:n_ibif
   for i=1:n_ibif
    for j=1:n_mbif
        if rem(i_bif(3,i),180)-rem(m_bif(3,j),180)>10
            continue
        end
        
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
%      disp(j);
%      p=p+1;
%      figure(p),imshow(i_thin1),hold on, plot(i_bif(2,i),i_bif(1,i),'bo');
%      figure(p+1),imshow(i_thin2),hold on, plot(m_bif(2,j),m_bif(1,j),'bo');
     % ����㼯�任
%     aa=aa+1;
%        align.r= get_angledis(i_bif(3,i),m_bif(3,j));
%        align.x= i_bif(2,i) - m_bif(2,j);
%        align.y= i_bif(1,i) - m_bif(1,j);
       %  �õ�x,y,r ������׼align_im
%        align_mark =align_im(i_mark,align.r,align.x,align.y);  %����У�����������
 
     %������任 i_mark,  m_mark,i_bif(2,i),i_bif(1,i);m_bif(2,j),m_bif(1,j);
      x1 = i_bif(2,i);   y1= i_bif(1,i);  theta1=i_bif(3,i);
      x2 = m_bif(2,j);   y2= m_bif(1,j);  theta2=m_bif(3,j);  
      theta3 = i_bif(3,i) - m_bif(3,j);
      
      polar_in = align_polar(i_mark, x1, y1, theta1);
      
      polar_model=align_polar(m_mark, x2, y2, theta2);
      guding=polar_in(2,21);
      
      polar_in(2,:) = rem(polar_in(2,:)-theta3+360,360);     %ת������
       
       score=0; matchNum=0;    
       flagT=zeros(1,i_marknum); flagA=zeros(1,m_marknum);
       for m=1:i_marknum
           if flagT(m)==1        %�Ƿ�����ƥ�����
               continue;
           end
           for n=1:m_marknum   
               if flagA(n)==1
                   continue;
               end
               
               if polar_model(4,n)~=polar_in(4,m)    %�ж������������
                   continue;
               end
               
%                angle_diff = abs(rem( abs(polar_in(2,m)-polar_model(2,n))+360 , 360));
               angle_diff = abs(polar_in(2,m)-polar_model(2,n));
               if angle_diff>180                    %�ж�������ļ��ǲ�
                   angle_diff = angle_diff-180;
               end
               
               if angle_diff>=5
                   continue;
               end
               
               dis=abs(polar_in(1,m) - polar_model(1,n));   %�жϼ��뾶��
               if dis>=5
                   continue;
               end
               
               theta_diff=abs(rem(abs(polar_in(3,m)-polar_model(3,n))+360,360));   %�ж������㷽��ǲ�
               if theta_diff>180
                   theta_diff=theta_diff-180;
               end
               if theta_diff>10
                   continue;
               end
               flagT(m)=1;
               flagA(m)=1;    %���
%                score=score+ (10-angle);
%                score=score+ (10-dis);
               matchNum=matchNum+1;
%                p=p+1;
%                figure(p),imshow(i_thin1),hold on, plot(i_bif(2,i),i_bif(1,i),'bo');
%                 figure(p),imshow(i_thin2),hold on, plot(m_bif(2,j),m_bif(1,j),'bo');
               if  (matchNum>=10)     %�򵥿���ʶ��ָ�Ʒ�
                  disp('ƥ��ɹ���Ϊͬһָ��');
%                   figure(p+1),imshow(i_thin1),hold on, plot(i_bif(2,i),i_bif(1,i),'bo');
%                   figure(p+1),imshow(i_thin2),hold on, plot(m_bif(2,j),m_bif(1,j),'bo');
                  return;
               end
           end
       end
%        num_n=num_n+1;
    end
end
       if matchNum<10
           disp('Ϊ��ָͬ��');
       end
       % �� ��׼��������� ����ƥ��
       
    
    



%%ͼ��С��ָ��ʶ��
%%Ԥ�������1��
clear,clc;close all;
%%����ͼ��
fing=imread('../��1�⸽��/02.tif');
[mf,nf]=size(fing);
figure(1);
imshow(fing);title('ԭʼͼ');
fing=double(fing);
fing=medfilt2(fing);%��ֵ�˲�
%�涨��ͼ��
Mo=120;Vo=120;
mean_f=sum(sum(fing))/(mf*nf);
var_f=sum(sum((fing-mean_f).^2))/(mf*nf);
rat_fin=mean_f/sqrt(var_f);
for k1=1:mf
    for k2=1:nf
        tp=sqrt(Vo^2*(fing(k1,k2)-mean_f)^2/var_f);
        if fing(k1,k2)>=mean_f
            fing(k1,k2)=Mo+tp;
        else fing(k1,k2)=Mo-tp;
        end
    end
end
 figure(2);
imshow(uint8(fing));title('�涨��ͼ');  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%ͼ���뱳���ָ�
%Ϊ�˱��ڷָ�ɴ�СΪ16*16�Ŀ飬��ͼ����

if rem(mf,16)~=0
   mm=fix(mf/16)+1;
else mm=mf/16;
end
if rem(nf,16)~=0
   nn=fix(nf/16)+1;
else nn=nf/16;
end
seg_fin=ones(mm*16,nn*16)*255;
seg_fing=zeros(mf,nf);
var=zeros(mm,nn);mean_fin=zeros(mm,nn);mean_fin1=zeros(mm,nn);
for k1=1:mf
    for k2=1:nf
        seg_fin(k1,k2)=fing(k1,k2);
    end
end
for k1=1:mm
    for k2=1:nn
        mean=0;
        %��Ҷ�ƽ��ֵ
        temp2=seg_fin((k1-1)*16+1:k1*16,(k2-1)*16+1:k2*16);
        mean=sum(sum(temp2))/(16*16);
        back=0;vie=0;
        flag_var=0; dm=180;
        sum_mea=0;sum_num=0;
        while flag_var==0;
            for j1=1:16
                for j2=1:16
                    if temp2(j1,j2)>mean
                        back=back+1;
                    else vie=vie+1;
                    end
                end
            end
            if abs(back-vie)<26  %��W^2*0.1��
                flag_var=1;
            else if back>vie
                    mean=mean+1;
                else mean=mean-1;
                end
            end
        end
        if flag_var==1
            mean_fin1(k1,k2)=mean;
           for j1=1:16
                for j2=1:16
                    if temp2(j1,j2)<mean+dm&temp2(j1,j2)>mean-dm
                        sum_mea=sum_mea+temp2(j1,j2);
                        sum_num=sum_num+1;
                    end
                end
           end
           mean_fin(k1,k2)=sum_mea/sum_num;
           for j1=1:16
                for j2=1:16
                    if temp2(j1,j2)<mean+dm&temp2(j1,j2)>mean-dm
                        var(k1,k2)=(temp2(j1,j2)-mean_fin(k1,k2)).^2+var(k1,k2);
                    end
                end
           end
           var(k1,k2)=var(k1,k2)/sum_num;
        end
    end
end
%ͨ�����ֵ��鷽��ıȽϷָ�ͼ��
for k1=1:mm
    for k2=1:nn
        rat=mean_fin(k1,k2)/sqrt(var(k1,k2));
        if rat>rat_fin*5.5
               seg_fin((k1-1)*16+1:k1*16,(k2-1)*16+1:k2*16)=255;er=89;
        end
    end
end
for k1=1:mf
    for k2=1:nf
        seg_fing(k1,k2)=seg_fin(k1,k2);
    end
end
figure(3);imshow(uint8(seg_fing));title('�ָ�');    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%�ָ����


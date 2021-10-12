%�����ݶȷ����ָ�ƵĿ鷽��ͼ
%clear;close all;
%fp=imread('../../../��1�⸽��/02.tif');  %����ָ��ͼ��
fp = I1;
% fpΪ[0,1], ʹ��im2unit8����ת����[0, 255]�����䣬�����ȷ����������
fp = im2uint8(fp);
imshow(fp);title('../../../��1�⸽��/10.tif')               %��ʾָ��ͼ��
%�����Ƕ�ԭʼָ��ͼ����й�񻯣���񻯺�ĻҶȾ�ֵM0��Ϊ80������Var0Ϊ200
M0=80;
Var0=200;
[len,wid]=size(fp);
fpn=zeros(len,wid);       %Ϊ��񻯺��ͼ�����ô洢�ռ�
M=mean2(fp);              %��ԭʼָ��ͼ��ҶȾ�ֵ
Var=std2(fp)^2;             %��ԭʼָ��ͼ��Ҷȷ���
%���
fp=double(fp);   %��uint8��ת����double������sqrt�ļ���
for i=1:len
    for j=1:wid
        if fp(i,j)>M
            fpn(i,j)=M0+sqrt( Var0*(fp(i,j)-M)^2/Var );
        else
            fpn(i,j)=M0-sqrt( Var0*(fp(i,j)-M)^2/Var );
        end
    end
end
fpn=uint8(fpn);
figure,imshow(fpn);title('��񻯺��ָ��ͼ��');  %��ʾ��񻯺��ָ��ͼ��

sobelx=[-1 0 1;-2 0 2;-1 0 1];
sobely=sobelx';
dx=zeros(len,wid);
dy=dx;
theta=dx;
%����x��y�����ϵ��ݶ�dx��dy

I_pad=padarray(fp,[1, 1],'symmetric');
for i=1:len
    for j=1:wid
        %���ͼ���ӿ�����
        Block=I_pad(i:i+2,j:j+2);
        %��Sobel�ں˶���������
        %x�������ֵ
        dx(i,j)=sum(sum(Block.*sobelx));
        %y�������ֵ
        dy(i,j)=sum(sum(Block.*sobely));
    end
end

block_dmap=ones(480,640);                   %���鷽��ͼ����洢�ռ䣬��ֵΪ1
w = 8;
Vx=zeros(60,80);
Vy=Vx;
jiaodu=Vx;
gausfilter = fspecial('gaussian', [5,5]);
for i = 1:len/w
    for j = 1:wid/w
                %����鷽��
        x=dx([1+(i-1)*w:w+(i-1)*w],[1+(j-1)*w:w+(j-1)*w]);
        y=dy([1+(i-1)*w:w+(i-1)*w],[1+(j-1)*w:w+(j-1)*w]);
        temp=x.*y;
        Vx(i,j)=2*sum(temp(:));
        temp=x.^2-y.^2;
        Vy(i,j)=sum(temp(:));
    end
end
Vx1 = Vx;
Vy1 = Vy;
for  i=1:len/w
    for       j=1:wid/w                  %�ֳ�32*32����
        Vx(i,j) = imfilter(Vx1(i,j), gausfilter, 'replicate');
        Vy(i,j) = imfilter(Vy1(i,j), gausfilter, 'replicate');
        if Vy(i,j)==0
            jiaodu(i,j)=0;
        else
            jiaodu(i,j)=1/2*atan( Vx(i,j)/Vy(i,j) );
            theta([1+(i-1)*w:w+(i-1)*w],[1+(j-1)*w:w+(j-1)*w])=jiaodu(i,j);
        end
        %���ȸĳɽǶ�
        theta([1+(i-1)*w:w+(i-1)*w],[1+(j-1)*w:w+(j-1)*w])=theta([1+(i-1)*w:w+(i-1)*w],[1+(j-1)*w:w+(j-1)*w])*180/pi;
        jiaodu(i,j)=jiaodu(i,j)*180/pi;
        if  Vy(i,j)>0
            jiaodu(i,j)=jiaodu(i,j)+90;
            theta([1+(i-1)*w:w+(i-1)*w],[1+(j-1)*w:w+(j-1)*w])=theta([1+(i-1)*w:w+(i-1)*w],[1+(j-1)*w:w+(j-1)*w])+90;
        end
        if   Vy(i,j)<0 && Vx(i,j)>0
            jiaodu(i,j)=jiaodu(i,j)+180;
            theta([1+(i-1)*w:w+(i-1)*w],[1+(j-1)*w:w+(j-1)*w])=theta([1+(i-1)*w:w+(i-1)*w],[1+(j-1)*w:w+(j-1)*w])+180;
        end
        if  jiaodu(i,j)<=11.25 ||  jiaodu(i,j)>168.75
            y1=1;
        elseif    jiaodu(i,j)>11.25 && jiaodu(i,j)<=33.75
            y1=2;
        elseif    jiaodu(i,j)>33.75 &&  jiaodu(i,j)<=56.25
            y1=3;
        elseif   jiaodu(i,j)>56.25 && jiaodu(i,j)<=78.75
            y1=4;
        elseif   jiaodu(i,j)>78.75 && jiaodu(i,j)<=101.25
            y1=5;
        elseif    jiaodu(i,j)>101.25 && jiaodu(i,j)<=123.75
            y1=6;
        elseif    jiaodu(i,j)>123.75 && jiaodu(i,j)<=146.25
            y1=7;
        elseif   jiaodu(i,j)>146.25 && jiaodu(i,j)<=168.75
            y1=8;
        end
        angle_xy=ones(w,w);
        
        switch  y1
            case 1
                angle_xy(4,[2:7])=0;                 %����1��������Ϊ0��ʱ�����8�е�2-15�е�Ԫ��Ϊ0����ɫ��
            case 2
                idx=sub2ind(size(angle_xy),[  3 4 4 5 5 6  ],[2:7]);
                angle_xy(idx)=0;
            case 3
                idx=sub2ind(size(angle_xy),[2:7],[2:7]);
                angle_xy(idx)=0;
            case 4
                idx=sub2ind(size(angle_xy),[2:7],[  3 4 4 5 5 6  ]);
                angle_xy(idx)=0;
            case 5
                angle_xy([2:7],4)=0;
            case 6
                idx=sub2ind(size(angle_xy),[7:-1:2],[   3 4 4 5 5 6 ]);
                angle_xy(idx)=0;
            case 7
                idx=sub2ind(size(angle_xy),[7:-1:2],[2:7]);
                angle_xy(idx)=0;
            case 8
                idx=sub2ind(size(angle_xy),[  6 5 5 4 4 3  ],[2:7]);
                angle_xy(idx)=0;
        end
        
        block_dmap([1+(i-1)*w:w+(i-1)*w],[1+(j-1)*w:w+(j-1)*w])=angle_xy;
    end
end


figure;imshow(block_dmap);title('RAO�ݶȷ���õĿ鷽��ͼ');
fp=double(fp);
rever_block_dmap=1-block_dmap;               %rever_block_dmap�ڵ�Ԫ�ط�0��1
rever_block_dmap=255*rever_block_dmap;       %��rever_block_dmap�ڵĻҶ�ֵ����250���Ա���ʾ���ӵ�ͼ��
addblock_dmap=imadd(fp,rever_block_dmap,'double');
figure;imshow(addblock_dmap,[]); title('ԭָ��ͼ��Ϳ鷽��ͼ�ĵ���ͼ��');     %��ʾԭָ��ͼ��Ϳ鷽��ͼ���ӵ�ͼ��
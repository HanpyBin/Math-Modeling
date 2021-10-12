clc;
clear all;
close all;
I=im2double(imread('../../��1�⸽��/02.tif','tif'));
[M,N]=size(I);

%%
%=============================��Ե���(һ)=================================
%Sobel����
Lx=[-1 -2 -1;
    0 0 0;
    1 2 1];
Ly=[-1 0 1;
    -2 0 2;
    -1 0 1];
%���Խ�
L_45=[0 1 2;
    -1 0 1;
    -2 -1 0];
L_135=[-2 -1 0;
    -1 0 1;
    0 1 2];
n=3;
%���ͼ��
g=zeros(M,N);
gx=zeros(M,N);
gy=zeros(M,N);
ga=zeros(M,N);
%����
th=0.6863;
gth=zeros(M,N);
n_l=floor(n/2);
%��ԭͼ������չ�����㴦��߽�
I_pad=padarray(I,[n_l,n_l],'symmetric');
for i=1:M
    for j=1:N
        %���ͼ���ӿ�����
        Block=I_pad(i:i+2*n_l,j:j+2*n_l);
        %��Sobel�ں˶���������
        %x�������ֵ
        gx(i,j)=abs(sum(sum(Block.*Lx)));
        %y�������ֵ
        gy(i,j)=abs(sum(sum(Block.*Ly)));
        %         %45�Ⱦ���ֵ
        %         g45(i,j)=abs(sum(sum(Block.*L_45)));
        %         %135�Ⱦ���ֵ
        %         g135(i,j)=abs(sum(sum(Block.*L_135)));
        %         %���ݶ�ǿ��
        %         gall(i,j)=abs(sum(sum(Block.*Lx)))+abs(sum(sum(Block.*Ly)))+abs(sum(sum(Block.*L_45)))+abs(sum(sum(Block.*L_135)));
        %         %���ݶ�ǿ��2
        %         gall2(i,j)=abs(sum(sum(Block.*L_45)))+abs(sum(sum(Block.*L_135)));
        %�ݶ�ǿ��
        g(i,j)=abs(sum(sum(Block.*Lx)))+abs(sum(sum(Block.*Ly)));
        %�Ƕ�
        ga(i,j)=atan(gy(i,j)/gx(i,j));
        %�������޵��ݶ�ǿ��
        if g(i,j)>=th
            gth(i,j)=g(i,j);
        end
    end
end
%% δ�Ľ��㷨
I2 = I;
w = 3;
S = zeros(floor(M/w), floor(N/w));
for i = 1:M/w
    for j = 1:N/w
        Vx(i,j) = sum(sum(2*gx(1+(i-1)*w:i*w, 1+(j-1)*w:j*w).*gy(1+(i-1)*w:i*w, 1+(j-1)*w:j*w)));
        Vy(i,j) = sum(sum(gx(1+(i-1)*w:i*w, 1+(j-1)*w:j*w).^2-gy(1+(i-1)*w:i*w, 1+(j-1)*w:j*w).^2));
        Ve(i,j) = sum(sum((gx(1+(i-1)*w:i*w, 1+(j-1)*w:j*w)+gy(1+(i-1)*w:i*w, 1+(j-1)*w:j*w)).^2));
        C(i, j) = sqrt((Vx(i,j).^2 + Vy(i,j).^2) / (w.^2)/Ve(i,j));
        if C(i,j) > 0.3
            S(i,j) = 1;
        end
    end
end
% ����������
for k = 1:3
    S2 = padarray(S,[n_l,n_l],'symmetric');
    for i = 1:M/w
        for j = 1:N/w
            if S2(i+1,j+1) == 0
                if sum(sum(S2(i:i+2*n_l,j:j+2*n_l))) > 4
                    S(i, j) = 1;
                end
            elseif S2(i+1, j+1) == 1
                if sum(sum(S2(i:i+2*n_l,j:j+2*n_l))) <= 4
                    S(i,j) = 0;
                end
            end
        end
    end
end
for i = 1:M/w
    for j = 1:N/w
        if S(i, j) == 0
            I2(1+(i-1)*w:i*w, 1+(j-1)*w:j*w) = 0;
        end
    end
end
subplot(1,2,1), imshow(I);
subplot(1,2,2), imshow(I2);
%% �Ľ��㷨
I1 = I;
w1 = 3;
S1 = zeros(floor(M/w1), floor(N/w1));
for i = 1:M/w1
    for j = 1:N/w1
        g_block(i,j) = mean(mean(g(1+(i-1)*w1:i*w1, 1+(j-1)*w1:j*w1)));
        if g_block(i,j) > 0.3
            S1(i,j) = 1;
        end
    end
end
% ����������
for k = 1:3
    S2 = padarray(S1,[n_l,n_l],'symmetric');
    for i = 1:M/w1
        for j = 1:N/w1
            if S2(i+1,j+1) == 0
                if sum(sum(S2(i:i+2*n_l,j:j+2*n_l))) > 4
                    S1(i, j) = 1;
                end
            elseif S2(i+1, j+1) == 1
                if sum(sum(S2(i:i+2*n_l,j:j+2*n_l))) <= 4
                    S1(i,j) = 0;
                end
            end
        end
    end
end

for i = 1:M/w
    for j = 1:N/w
        if S1(i, j) == 0
            I1(1+(i-1)*w:i*w, 1+(j-1)*w:j*w) = 0;
        end
    end
end
subplot(1,3,1), imshow(I);
subplot(1,3,2), imshow(I2);
subplot(1,3,3), imshow(I1);
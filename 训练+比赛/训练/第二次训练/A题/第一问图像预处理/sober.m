clc;
clear all;
close all;
I=im2double(imread('../../第1题附件/02.tif','tif'));
[M,N]=size(I);

%%
%=============================边缘检测(一)=================================
%Sobel算子
Lx=[-1 -2 -1;
    0 0 0;
    1 2 1];
Ly=[-1 0 1;
    -2 0 2;
    -1 0 1];
%检测对角
L_45=[0 1 2;
    -1 0 1;
    -2 -1 0];
L_135=[-2 -1 0;
    -1 0 1;
    0 1 2];
n=3;
%输出图像
g=zeros(M,N);
gx=zeros(M,N);
gy=zeros(M,N);
ga=zeros(M,N);
%门限
th=0.6863;
gth=zeros(M,N);
n_l=floor(n/2);
%对原图进行扩展，方便处理边界
I_pad=padarray(I,[n_l,n_l],'symmetric');
for i=1:M
    for j=1:N
        %获得图像子块区域
        Block=I_pad(i:i+2*n_l,j:j+2*n_l);
        %用Sobel内核对子区域卷积
        %x方向绝对值
        gx(i,j)=abs(sum(sum(Block.*Lx)));
        %y方向绝对值
        gy(i,j)=abs(sum(sum(Block.*Ly)));
        %         %45度绝对值
        %         g45(i,j)=abs(sum(sum(Block.*L_45)));
        %         %135度绝对值
        %         g135(i,j)=abs(sum(sum(Block.*L_135)));
        %         %总梯度强度
        %         gall(i,j)=abs(sum(sum(Block.*Lx)))+abs(sum(sum(Block.*Ly)))+abs(sum(sum(Block.*L_45)))+abs(sum(sum(Block.*L_135)));
        %         %总梯度强度2
        %         gall2(i,j)=abs(sum(sum(Block.*L_45)))+abs(sum(sum(Block.*L_135)));
        %梯度强度
        g(i,j)=abs(sum(sum(Block.*Lx)))+abs(sum(sum(Block.*Ly)));
        %角度
        ga(i,j)=atan(gy(i,j)/gx(i,j));
        %带有门限的梯度强度
        if g(i,j)>=th
            gth(i,j)=g(i,j);
        end
    end
end
%% 未改进算法
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
% 消除独立块
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
%% 改进算法
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
% 消除独立块
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
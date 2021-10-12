function [f, theta] = getftheta(img)
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
        ga(i,j)=0.5 * atan(gy(i,j)/gx(i,j));
        %带有门限的梯度强度
        if g(i,j)>=th
            gth(i,j)=g(i,j);
        end
    end
end
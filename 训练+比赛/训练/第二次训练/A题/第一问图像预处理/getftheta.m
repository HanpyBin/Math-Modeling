function [f, theta] = getftheta(img)
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
        ga(i,j)=0.5 * atan(gy(i,j)/gx(i,j));
        %�������޵��ݶ�ǿ��
        if g(i,j)>=th
            gth(i,j)=g(i,j);
        end
    end
end
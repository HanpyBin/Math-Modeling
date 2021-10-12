clear;
clc;
%L=xlsread('');��ָ��ָʾֵ
X=xlsread('problem2data.xlsx');%�����۷�����ָ������
L=[-1,-1,-1];
X(:,3) = 1./X(:,3);
%�������۵ķ�����m,ָ����n
[m,n]=size(X);

%��׼������X��õ�R
R=zeros(m,n);
for i=1:m
    for j=1:n
         %����ָ��ָʾֵ�ж���Խ��Խ����ָ�껹��ԽСԽ����ָ��
        if L(j)==1
            %Խ��Խ����ָ��������ٻ�
            R(i,j)=(X(i,j)-min(X(:,j)))/(max(X(:,j))-min(X(:,j)));
        else
            %ԽСԽ����ָ��������ٻ�
            R(i,j)=(max(X(:,j))-X(i,j))/(max(X(:,j))-min(X(:,j)));
        end
    end
end

%����j��ָ��Բ�ͬ���۶�����ͣ���sumR
sumR=sum(R);
%��ʼ���������ؾ���p
p=zeros(m,n);
%�����i�����۶����j��ָ�����������p
for i=1:m
    for j=1:n
        p(i,j)=R(i,j)/sumR(j);
    end
end

%�ж�p�е�Ԫ���Ƿ�Ϊ0�����Ϊ0��p(i,j)*ln(p(i,j))=0
%���м����tp��ʾp(i,j)*ln(p(i,j))

tp=zeros(m,n);
for i=1:m
    for j=1:n
        %����p(i,j)�Ƿ�С�ڵ���0��tp��ֵ
        if p(i,j)<=0
            tp(i,j)=0;
        else
            tp(i,j)=p(i,j)*log(p(i,j));
        end
    end
end

%�����j��ָ���������H
H=-sum(tp);

%�����j��ָ�����ֵE
E=H/log(m);

%�������ϵ��G
G=1-E;

%������ȨW
W=G/sum(G);

scores = R*W';

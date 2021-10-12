%利用梯度法求解指纹的块方向图
%clear;close all;
%fp=imread('../../../第1题附件/02.tif');  %读入指纹图象
fp = I1;
% fp为[0,1], 使用im2unit8将其转换到[0, 255]的区间，则可正确叠加两个场
fp = im2uint8(fp);
imshow(fp);title('../../../第1题附件/10.tif')               %显示指纹图象
%以下是对原始指纹图象进行规格化，规格化后的灰度均值M0设为80，方差Var0为200
M0=80;
Var0=200;
[len,wid]=size(fp);
fpn=zeros(len,wid);       %为规格化后的图象设置存储空间
M=mean2(fp);              %求原始指纹图象灰度均值
Var=std2(fp)^2;             %求原始指纹图象灰度方差
%规格化
fp=double(fp);   %将uint8型转换成double，便于sqrt的计算
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
figure,imshow(fpn);title('规格化后的指纹图象');  %显示规格化后的指纹图象

sobelx=[-1 0 1;-2 0 2;-1 0 1];
sobely=sobelx';
dx=zeros(len,wid);
dy=dx;
theta=dx;
%计算x和y方向上的梯度dx和dy

I_pad=padarray(fp,[1, 1],'symmetric');
for i=1:len
    for j=1:wid
        %获得图像子块区域
        Block=I_pad(i:i+2,j:j+2);
        %用Sobel内核对子区域卷积
        %x方向绝对值
        dx(i,j)=sum(sum(Block.*sobelx));
        %y方向绝对值
        dy(i,j)=sum(sum(Block.*sobely));
    end
end

block_dmap=ones(480,640);                   %给块方向图定义存储空间，初值为1
w = 8;
Vx=zeros(60,80);
Vy=Vx;
jiaodu=Vx;
gausfilter = fspecial('gaussian', [5,5]);
for i = 1:len/w
    for j = 1:wid/w
                %计算块方向
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
    for       j=1:wid/w                  %分成32*32个块
        Vx(i,j) = imfilter(Vx1(i,j), gausfilter, 'replicate');
        Vy(i,j) = imfilter(Vy1(i,j), gausfilter, 'replicate');
        if Vy(i,j)==0
            jiaodu(i,j)=0;
        else
            jiaodu(i,j)=1/2*atan( Vx(i,j)/Vy(i,j) );
            theta([1+(i-1)*w:w+(i-1)*w],[1+(j-1)*w:w+(j-1)*w])=jiaodu(i,j);
        end
        %弧度改成角度
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
                angle_xy(4,[2:7])=0;                 %方向1，即方向为0度时，令第8行第2-15列的元素为0（黑色）
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


figure;imshow(block_dmap);title('RAO梯度法求得的块方向图');
fp=double(fp);
rever_block_dmap=1-block_dmap;               %rever_block_dmap内的元素非0即1
rever_block_dmap=255*rever_block_dmap;       %将rever_block_dmap内的灰度值乘上250，以便显示叠加的图形
addblock_dmap=imadd(fp,rever_block_dmap,'double');
figure;imshow(addblock_dmap,[]); title('原指纹图象和块方向图的叠加图形');     %显示原指纹图象和块方向图叠加的图形
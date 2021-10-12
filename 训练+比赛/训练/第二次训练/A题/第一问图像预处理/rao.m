%利用梯度法求解指纹的块方向图
%clear;close all;
%fp=imread('../../../第1题附件/02.tif');  %读入指纹图象
fp = I1;
% fp为[0,1], 使用im2unit8将其转换到[0, 255]的区间，则可正确叠加两个场
fp = im2uint8(fp);
imshow(fp);title('../../../第1题附件/10.tif')               %显示指纹图象
[len,wid]=size(fp);
% 利用sober算子计算x和y方向上的梯度
sobelx=[-1 0 1;-2 0 2;-1 0 1];
sobely=sobelx';
dx=zeros(len,wid);
dy=dx;
theta=dx;
%计算x和y方向上的梯度dx和dy

%规格化
fp=double(fp);   %将uint8型转换成double，便于sqrt的计算
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
direction = zeros(60, 80);
for  i=1:len/w
    for       j=1:wid/w                  %分成32*32个块
%         Vx(i,j) = imfilter(Vx1(i,j), gausfilter, 'replicate');
%         Vy(i,j) = imfilter(Vy1(i,j), gausfilter, 'replicate');
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
            direction(i, j) = 0;
        elseif    jiaodu(i,j)>11.25 && jiaodu(i,j)<=33.75
            y1=2;
            direction(i,j) = 7;
        elseif    jiaodu(i,j)>33.75 &&  jiaodu(i,j)<=56.25
            y1=3;
            direction(i,j) = 6;
        elseif   jiaodu(i,j)>56.25 && jiaodu(i,j)<=78.75
            y1=4;
            direction(i,j) = 5;
        elseif   jiaodu(i,j)>78.75 && jiaodu(i,j)<=101.25
            y1=5;
            direction(i,j) = 4;
        elseif    jiaodu(i,j)>101.25 && jiaodu(i,j)<=123.75
            y1=6;
            direction(i,j) = 3;
        elseif    jiaodu(i,j)>123.75 && jiaodu(i,j)<=146.25
            y1=7;
            direction(i, j) = 2;
        elseif   jiaodu(i,j)>146.25 && jiaodu(i,j)<=168.75
            y1=8;
            direction(i,j) = 1;
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

% %% 提取频率场
% for i = len/w
%     for j = wid/w
%         f(i,j) = find_peak_distance(theta([1+(i-1)*w:w+(i-1)*w],[1+(j-1)*w:w+(j-1)*w]));
%     end
% end
% frequency_field = filter_frequency_image(f);
% enhanced_img = do_gabor_filtering(mat2gray(I1),jiaodu, frequency_field);
% imshow(enhanced_img);
%% 计算中心点
% flag = 0;
% block_fix = zeros(30, 40);
% for i = 1:30
%     for j = 1:40
%         temp = direction(1+(i-1)*2:2+(i-1)*2,1+(j-1)*2:2+(j-1)*2);
%         block_fix(i,j) = mode(temp(:));
%     end
% end
% for i = 1:30
%     for j = 1:40
%         if block_fix(i, j) == 1 || block_fix(i,j) == 2 || block_fix(i,j) == 3
%             if j+1 <= 80
%                 if block_fix(i,j+1) == 5 || block_fix(i,j+1) == 6 || block_fix(i,j+1) == 7
%                     if flag < 1
%                     center_i = i;
%                     center_j = j;
%                     flag = 1;
%                     end
%                 end
%             end
%             if j+2 <= 80
%                 if (block_fix(i,j+1)==0 || block_fix(i,j+1)==1 || block_fix(i,j+1)==7)&&(block_fix(i,j+2)==5||block_fix(i,j+2)==6||block_fix(i,j+2)==7)
%                     if flag < 2
%                     center_i = i+1;
%                     center_j = j;
%                     flag = 2;
%                     end
%                 end
%             end
%             if j+3 <= 80
%                 if (block_fix(i,j+1)==0||block_fix(i,j+1)==1||block_fix(i,j+1)==7)&&(block_fix(i,j+2)==0||block_fix(i,j+2)==1||block_fix(i,j+2)==7)&&(block_fix(i,j+3)==5||block_fix(i,j+3)==6||block_fix(i,j+3)==7)
%                     if flag < 3
%                     center_i = i+1;
%                     center_j = j;
%                     flag = 3;
%                     end
%                 end
%             end
%         end
%     end
% end
% figure;
% fp1 = I1;
% fp1([1+(center_i-1)*w:w+(center_i-1)*w],[1+(center_j-1)*w:w+(center_j-1)*w]) = 255;
% imshow(fp1);
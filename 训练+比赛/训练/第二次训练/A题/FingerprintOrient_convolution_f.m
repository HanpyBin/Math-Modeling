function [f_angle,f_grad] = FingerprintOrient_convolution_f(f,r1)
%%%%%%%%%%%%% function description %%%%%%%%%%%%%%%%%%%%%%%%
%%%%input    f:Array of img  ;  r1:window of average that control
%%%%relationship between the pix and its neighbors
%%%%
%%%%output   f_angle:array that is to show Orientation field   ;
%%%%         f_grad :array that is to show Grad field 
%%%%                            @author  Faith 15.12.22
%%%%                                    v2.0    16.8.3
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%% ����ͼƬ,ȡ���ӿ� %%%%%%%%%%%
f1 = f;
r = r1;

%%%%��ȡ���ͼƬ��Ϣ%%%%%%
f2 = im2double(f1);
% f2 = f1;
[height,width] = size(f1);

EPI	= 57.29578;     %%%%%360/2pi���ǶȺͻ��ȵĻ���

%%%%%%%%��ʼ������%%%%%%%%%%%%%%%%
f_temp = f2;
f_angle = zeros(height,width);
Vx = zeros(height,width);
Vy = zeros(height,width);
f_grad =  zeros(height,width);
%%%%%%%%%%%%%%%%%%%%%%%%%soble����%%%%%%%%%%%%%%%%%%%%%%%%%%
% soble_x = [-1 0 1; -2 0 2; -1 0 1];
% soble_y = [1 2 1; 0 0 0; -1 -2 -1];

%%%%%%%%%%%%%% �������ر��� %%%%%%%%%%%%%%%

%%%%%%%������%%%%%%%%%%%%%%%
f_linex = f_temp(:);
f_tempy = f_temp';
f_liney = f_tempy(:);

soble_x = [-1 -2 -1 zeros(1,2*height -3) 1 2 1];
soble_y = [1 2 1 zeros(1,2*width-3) -1 -2 -1];

f_num = size(f_linex,1);
soblex_num = size(soble_x,2);
sobley_num = size(soble_y,2);

%%%%%%%%%%%%%%%%%%�����˼�%%%%%%%%%%%%%%%%%
% for i = 1:(f_num -soblex_num + 1)
%     f_lineVx(i) =  f_linex(i:i+length(soble_x)-1)' * soble_x';
% end
% for i = 1:(f_num -sobley_num + 1)
%     f_lineVy(i) =  f_liney(i:i+length(soble_y)-1)' * soble_y';
% end
% 
% 
% f_x = [zeros(1,(soblex_num-1)/2) f_lineVx zeros(1,(soblex_num-1)/2)];
% f_y = [zeros(1,(sobley_num-1)/2) f_lineVy zeros(1,(sobley_num-1)/2)];
%%%%%%%%%%

%%%%%%%%%%%%%%%% conv ���%%%%%%%%%%%%%%%%%%
tic

f_lineVx = -conv(f_linex',soble_x);
f_lineVy = -conv(f_liney',soble_y);

f_x = f_lineVx(1+(soblex_num-1)/2: length(f_lineVx)-(soblex_num-1)/2);
f_y = f_lineVy(1+(sobley_num-1)/2: length(f_lineVy)-(sobley_num-1)/2);

%%%%%%%%%%%%

%%%%%%%%%�ظ�ͼ����Ӧ��С%%%%%%%%%%
f_xx = reshape(f_x,height,width);
f_yy = reshape(f_y,width,height);
f_yy = f_yy';

toc
%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%ԭ������%%%%%%%%%%%%%%%%%%%%%%%%%%%
tic

for x = 1:height
    for y = 1: width
         lvx = 0;
         lvy = 0;
         gradsum = 0;
         num = 0;
            %%%%%%%%%%%%%%%%%%%r * r ���µĴ���%%%%%%%%%%%%%%%%%%%
            for i = -r:r
                %%%%%%%%%%%%%%%%%% �߽紦�� %%%%%%%%%%%%%%%%%%%%%
                if(x + i -1 < 1 || x + i + 1 > height )
                    continue;
                end
                    for j = -r:r
                        if (y + j -1 < 1 || y + j + 1 > width)
                            continue;
                        end
                        
                        %%%%%%%%%%%%%%% soble ���� x���� �� y���� ��ƫ��
                        %%%%%%%%%%%%%%% x -1 0 1   y   1  2  1
                        %%%%%%%%%%%%%%%   -2 0 2       0  0  0
                        %%%%%%%%%%%%%%%   -1 0 1      -1 -2 -1
                        %%%%%�����ԣ������ֱ������ʽ��������֮
%                         Vx(x+i,y+j) = sum(sum(f_temp(x+i-1:x+i+1,y+j-1:y+j+1).*soble_x)); 
%                         Vy(x+i,y+j) = sum(sum(f_temp(x+i-1:x+i+1,y+j-1:y+j+1).*soble_y));
          
                         Vx(x+i,y+j) = f_temp(x+i+1,y+j+1) - f_temp(x+i+1,y+j-1) + f_temp(x+i,y+j+1)*2 - f_temp(x+i,y+j-1)*2 + f_temp(x+i-1,y+j+1) - f_temp(x+i-1,y+j-1);
                         Vy(x+i,y+j) = (f_temp(x+i-1,y+j+1) - f_temp(x+i+1,y+j+1)) + (f_temp(x+i-1,y+j)*2 - f_temp(x+i+1,y+j)*2) + (f_temp(x+i-1,y+j-1) - f_temp(x+i+1,y+j-1) );

                    end
            end
    end
end

toc
%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%���������������Աȣ��㷨˼�벻�䣬���ݴ���ʽ�ı�%%%%%%%%%
% figure(111)
% imshow(uint8(f_xx - Vx));
% 
% figure(222)
% imshow(uint8(f_yy - Vy));

%%%%%%%%%%%%%% Ԥ����Ե� %%%%%%%%%%%%%%%
figure (1)
imshow(uint8(f_angle));
figure (2)
imshow(uint8(f_grad));

end






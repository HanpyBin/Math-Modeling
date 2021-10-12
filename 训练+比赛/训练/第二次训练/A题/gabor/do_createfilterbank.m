
%首先实现滤波器：

function [bank] = do_createfilterbank(imsize)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% 函数实现：创建Gabor 滤波组
%
%%% 必选参数：
%   imsize – 图像大小
%%% 可选参数：
%   freqnum — 频率数目
%   orientnum — 方向数目
%   f       —   频率域中的采样步长
%   kmax    —   最大的采样频率
%   sigma   —   高斯窗的宽度与波向量长度的比率
%
%%% 返回结果：
%   bank
%           .freq        —     滤波频率
%           .orient      —     滤波方向
%           .filter      —     Gabor滤波
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

conf = struct('freqnum',3, 'orientnum',6,'f',sqrt(2), 'kmax',(pi/2), 'sigma',(sqrt(2)*pi));

% conf = do_getargm(conf);

bank = cell(1,conf.freqnum*conf.orientnum);
for f0=1:conf.freqnum
%     fprintf(‘处理频率 %d \n’, f0);
    for o0=1:conf.orientnum
        [filter_,freq_,orient_] = do_gabor(imsize,(f0-1),(o0-1),conf.kmax,conf.f,conf.sigma,conf.orientnum);
        bank{(f0-1)*conf.orientnum + o0}.freq = freq_; %以orient增序排列
        bank{(f0-1)*conf.orientnum + o0}.filter = filter_;
        bank{(f0-1)*conf.orientnum + o0}.orient = orient_;
    end
end

for ind = 1:length(bank)
    bank{ind}.filter=fftshift(bank{ind}.filter);
end


% Gabor 滤波实现(1)已经创建了Gabor滤波组，现在可以使用该滤波组对图像进行转换，得到振幅和相位。


% 整个程序可以如下使用。 im = imread(‘image.jpg’); im = rgb2gray(im); bank = do_createfilterbank(size(im)); result = do_filterwithbank(im,bank);  

 


 



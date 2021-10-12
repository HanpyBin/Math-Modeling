
%����ʵ���˲�����

function [bank] = do_createfilterbank(imsize)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% ����ʵ�֣�����Gabor �˲���
%
%%% ��ѡ������
%   imsize �C ͼ���С
%%% ��ѡ������
%   freqnum �� Ƶ����Ŀ
%   orientnum �� ������Ŀ
%   f       ��   Ƶ�����еĲ�������
%   kmax    ��   ���Ĳ���Ƶ��
%   sigma   ��   ��˹���Ŀ���벨�������ȵı���
%
%%% ���ؽ����
%   bank
%           .freq        ��     �˲�Ƶ��
%           .orient      ��     �˲�����
%           .filter      ��     Gabor�˲�
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

conf = struct('freqnum',3, 'orientnum',6,'f',sqrt(2), 'kmax',(pi/2), 'sigma',(sqrt(2)*pi));

% conf = do_getargm(conf);

bank = cell(1,conf.freqnum*conf.orientnum);
for f0=1:conf.freqnum
%     fprintf(������Ƶ�� %d \n��, f0);
    for o0=1:conf.orientnum
        [filter_,freq_,orient_] = do_gabor(imsize,(f0-1),(o0-1),conf.kmax,conf.f,conf.sigma,conf.orientnum);
        bank{(f0-1)*conf.orientnum + o0}.freq = freq_; %��orient��������
        bank{(f0-1)*conf.orientnum + o0}.filter = filter_;
        bank{(f0-1)*conf.orientnum + o0}.orient = orient_;
    end
end

for ind = 1:length(bank)
    bank{ind}.filter=fftshift(bank{ind}.filter);
end


% Gabor �˲�ʵ��(1)�Ѿ�������Gabor�˲��飬���ڿ���ʹ�ø��˲����ͼ�����ת�����õ��������λ��


% ���������������ʹ�á� im = imread(��image.jpg��); im = rgb2gray(im); bank = do_createfilterbank(size(im)); result = do_filterwithbank(im,bank);  

 


 



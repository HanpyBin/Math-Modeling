clear, clc;
load a;
load dots;
load path_var;
speed = xlsread("����2-��·�ν�ͨͳ��.xlsx");
co = xlsread("ÿ���ڵ�Ȩ��.xlsx");
% �Ƚ������ߵ�·���1
path_var(find(a==0))=1;
co(find(co==1.4)) = 1.0;
co(find(co==1.3)) = 1.0;
co(find(co==1.2)) = 1.0;
dismat = ones(103, 103, 3);
dismat = dismat * 1000;
% ����Floyd�㷨���ÿ����֮�����̾���
% ������֪��֮��ľ���
for c = 1:3
    for i = 1:103
        dismat(i,i,c) = 0;
    end
    for i = 1:103
        for j = 1:103
            if path_var(i,j) > 1
                dismat(i,j,c) = 0.5/speed(path_var(i,j)-1,c);
            end
        end
    end
    for k = 1:103
        for i = 1:103
            for j = 1:103
                if dismat(i,j,c) > dismat(i,k,c) + dismat(k,j,c)
                    dismat(i,j,c) = dismat(i,k,c) + dismat(k,j,c);
                end
            end
        end
    end
end
dismat = mean(dismat, 3);



for i = 1:103
    dismat(:,i) = dismat(:,i) * co(i,1);
end



% for c = 1:3
%     total_time_mean = sum(dismat(:,:,c));
%     mean_location{c} = find(total_time_mean == min(total_time_mean));
%     total_time_minmax = max(dismat(:,:,c));
%     minmax_location{c} = find(total_time_minmax == min(total_time_minmax));
% end
% ����ʱ�������Ȩ�����
% ����ڵ�Ȩ��
% total_time_mean = mean(dismat);
% mean_location = find(total_time_mean == min(total_time_mean));
total_time_minmax = max(dismat, [], 2);
minmax_location = find(total_time_minmax == min(total_time_minmax));
save('dismat1.mat','dismat')
temp = dismat(minmax_location,:)';
xlswrite('result3.xlsx',temp);
% ����Ҫ���临�Ƶ���һ���ļ���
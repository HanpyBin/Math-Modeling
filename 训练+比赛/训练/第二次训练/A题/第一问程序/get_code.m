function [endpoints, bifurcations]=get_code(ord)
[endpoint_x, endpoint_y,bifurcation_x,bifurcation_y, endpoint_line_num, bifurcation_line_num, corepoint_y, corepoint_x,oimg] = solve_pro(ord);
%% ɸѡ������
R = 100;
% �Զ˵����ɸѡ
endpoints = []; % ��һ��Ϊx���꣬�ڶ���Ϊy���꣬������Ϊ��������������������Ϊ���򳡣�������Ϊ������ϵ�µĽǶ�
                % ������Ϊ���򳡽ǶȲ�ֵ, ��7��Ϊ���룬��8��Ϊ��
bifurcations = [];
for i = 1:length(endpoint_x)
    if sqrt((corepoint_x-endpoint_x(i))^2+(corepoint_y-endpoint_y(i))^2) <= R
        endpoints(end+1,1)=endpoint_x(i);
        endpoints(end,2) = endpoint_y(i);
        endpoints(end,3) = endpoint_line_num(i);
    end
end
for i = 1:length(bifurcation_x)
    if sqrt((corepoint_x-bifurcation_x(i))^2+(corepoint_y-bifurcation_y(i))^2) <= R
        bifurcations(end+1,1)=bifurcation_x(i);
        bifurcations(end,2) = bifurcation_y(i);
        bifurcations(end,3) = bifurcation_line_num(i);
    end
end

%% ���㷽�򳡽ǶȲ�
% ���ĵ����ڽǶȳ�
core_angle = oimg(floor(corepoint_y/16), floor(corepoint_x/16));
% ����˵�
for i = 1:size(endpoints,1)
    endpoints(i,4) = oimg(floor(endpoints(i,2)/16),floor(endpoints(i,1)/16));
    endpoints(i,4) = endpoints(i,4)-core_angle;
    if endpoints(i,1) == corepoint_x
        endpoints(i,5) = 0;
    else
        endpoints(i,5) = atan((endpoints(i,2)-corepoint_y)/(endpoints(i,1)-corepoint_x))-core_angle;
    end
    endpoints(i,6) = endpoints(i,4)-core_angle;
    endpoints(i,7) = sqrt((corepoint_x-endpoints(i,1))^2+(corepoint_y-endpoints(i,2))^2);
end
%���㽻���
for i = 1:size(bifurcations,1)
    bifurcations(i,4) = oimg(floor(bifurcations(i,2)/16),floor(bifurcations(i,1)/16));
    bifurcations(i,4) = bifurcations(i,4)-core_angle;
    if bifurcations(i,1) == corepoint_x
        bifurcations(i,5) = 0;
    else
        bifurcations(i,5) = atan((bifurcations(i,2)-corepoint_y)/(bifurcations(i,1)-corepoint_x))-core_angle;
    end
    bifurcations(i,6) = bifurcations(i,4)-core_angle;
    bifurcations(i,7) = sqrt((corepoint_x-bifurcation_x(i))^2+(corepoint_y-bifurcation_y(i))^2);
end
% ����2669�����ݵĸ�����
total_loads = zeros(1, length(finalroutes));
for i = 1:length(finalroutes)
    for j = 1:length(finalroutes{i})
        total_loads(i) = total_loads(i) + z(finalroutes{i}(j));
    end
end
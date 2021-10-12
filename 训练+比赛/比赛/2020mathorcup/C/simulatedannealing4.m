function [ptasks, checkord, previous_endtime, previous_ratio] = simulatedannealing4(ptasks, checkord, check, dist, ordtime)
temperature = 500;
cooling_rate = 0.97;
temperature_iterations = 1;
[previous_endtime, previous_ratio] = fitness(ptasks, checkord,dist,check,ordtime);
cnt = 0;
while 1.0 < temperature
    %fprintf('temper=%d, iter=%d\n', temperature, temperature_iterations);
    temp_ptasks = cross(ptasks);
    temp_checkord = mutate(checkord, check);
    [current_endtime, current_ratio] = fitness(temp_ptasks,temp_checkord,dist,check,ordtime);
    diff = current_endtime - previous_endtime;
    if (diff < 0) || (rand < exp(-diff/(temperature)))
        cnt = 0;
        ptasks = temp_ptasks;
        checkord = temp_checkord;
        previous_endtime = current_endtime;
        previous_ratio = current_ratio;
        temperature_iterations = temperature_iterations + 1;
    else
        cnt = cnt + 1;
    end
    if cnt > 1000000
        break;
    end
    if temperature_iterations == 100
        %current_endtime;
        temperature = cooling_rate * temperature;
        temperature_iterations = 0;
    end
end
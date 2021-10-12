function endtime = problem3compute(results, x, ordtime)
endtime = sum(sum(results .* x))/1.5;
endtime = endtime + sum(ordtime);
endtime = endtime + 30;
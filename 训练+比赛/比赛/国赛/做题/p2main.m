clear, clc;
global final_results;
global max_money;
%global check;
max_money = 0;
%check = 0;
result(1, 1) = 1;
result(1, 2) = 10000;
result(1, 3) = 0;
result(1, 4) = 0;
final_results = result;
dfs2(0, 1, result, 0);
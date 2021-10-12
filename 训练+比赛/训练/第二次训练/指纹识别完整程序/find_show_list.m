function [end_list1]=find_show_list(o1)
[end_list1,branch_list1]=find_list(o1);
subplot(2,2,3);
showlist(end_list1);
subplot(2,2,4);
showlist(end_list2);
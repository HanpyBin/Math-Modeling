function [percent_match,real_end1,out_real_end2]=finger(finger_image1,finger_image2);
[image1,end_list1,branch_list1]=trf(finger_image1);
[image1,real_end1]=end_track(image1,end_list1,branch_list1);
[image2,end_list2,branch_list2]=trf(finger_image2);
[image2,real_end2]=end_track(image2,end_list2,branch_list2);
[out_image2,out_real_end2,percent_match]=match_end(image1,real_end1,image2,real_end2);
'The percentage of matching real end point is:' 
percent_match
% The gui of our fingerprint program 
clear;
close all;
figure
w=0;
text11='ָ��1';text12='ָ�� 2';
h=uicontrol('Style','pushbutton','String','��ʼ','Callback','image1=scanimage;image2=scanimage;subplot(2,2,1);imagesc(image1);title(text11);subplot(2,2,2);imagesc(image2);title(text12);colormap(gray);','Position',[0,10,80,20]);
%text='Please input the block size';
%h=uicontrol('Style','pushbutton','String','��ֵ��','Callback','W=inputdlg(tex
%t);W=str2num(char(W));subplot(2,2,3);o1=thres(image1,W);title(text21);subplot(2,2,4);o2=thres(image2,W);title(text22);','Position',[100,10,80,20]);
text21='��ֵ�� 1';text22='��ֵ�� 2';
h=uicontrol('Style','pushbutton','String','��ֵ��','Callback','W=8;W=8;subplot(2,2,3);o1=thres(image1,W);title(text21);subplot(2,2,4);o2=thres(image2,W);title(text22);','Position',[100,10,80,20]);
text31='ϸ�� 1';text32='ϸ�� 2';
h=uicontrol('Style','pushbutton','String','ϸ��','Callback','subplot(2,2,3);o1=thin(o1);title(text31);subplot(2,2,4);o2=o1;title(text32);','Position',[200,10,80,20]);
%h=uicontrol('Style','pushbutton','String','ϸ��','Callback','subplot(2,2,3);o1=thin(o1);title(text31);subplot(2,2,4);o2=thin(o2);title(text32);','Position',[200,10,80,20]);
text41='M����ָ�� 1';text42='M����ָ�� 2';
h=uicontrol('Style','pushbutton','String','M����','Callback','subplot(2,2,3);o1=m_connect(o1);title(text41);subplot(2,2,4);o2=m_connect(o2);title(text42);','Position',[300,10,80,20]);
text51='ָ�ƶ˵� 1';text52='ָ�ƶ˵� 2';
h=uicontrol('Style','pushbutton','String','Ѱ�˵�','Callback','[end_list1,branch_list1]=find_list(o1);[end_list2,branch_list2]=find_list(o2);subplot(2,2,3);show_list(end_list1);title(text51);subplot(2,2,4);show_list(end_list2);title(text52);','Position',[400,10,100,20]);
text61='����ָ�ƶ˵� 1';text62='����ָ�ƶ˵� 2';
h=uicontrol('Style','pushbutton','String','����','Callback','[dummy,real_end1]=end_track(o1,end_list1,branch_list1);[dummy,real_end2]=end_track(o2,end_list2,branch_list2);subplot(2,2,3);show_list(real_end1);title(text61);subplot(2,2,4);show_list(real_end2);title(text62);','Position',[520,10,80,20]);
h=uicontrol('Style','pushbutton','String','�ȶ�','Callback','percent_match=match_end(o1,real_end1,o2,real_end2);','Position',[620,10,80,20]);

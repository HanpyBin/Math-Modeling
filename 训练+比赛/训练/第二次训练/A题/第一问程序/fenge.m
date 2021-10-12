function msk = fenge(img)
% hObject    handle to seg_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
msk=segment_print(img,0);
imshow(msk);
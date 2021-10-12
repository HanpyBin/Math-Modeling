function varargout = my_gui(varargin)
% MY_GUI M-file for my_gui.fig
%      MY_GUI, by itself, creates a new MY_GUI or raises the existing
%      singleton*.
%
%      H = MY_GUI returns the handle to a new MY_GUI or the handle to
%      the existing singleton*.
%
%      MY_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MY_GUI.M with the given input arguments.
%
%      MY_GUI('Property','Value',...) creates a new MY_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before my_gui_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to my_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Copyright 2002-2003 The MathWorks, Inc.

% Edit the above text to modify the response to help my_gui

% Last Modified by GUIDE v2.5 10-Dec-2009 17:01:34

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @my_gui_OpeningFcn, ...
    'gui_OutputFcn',  @my_gui_OutputFcn, ...
    'gui_LayoutFcn',  [] , ...
    'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before my_gui is made visible.
function my_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to my_gui (see VARARGIN)

% Choose default command line output for my_gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes my_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);

set(handles.axes1,'visible','off');
set(handles.axes2,'visible','off');
set(handles.axes3,'visible','off');
% --- Outputs from this function are returned to the command line.
function varargout = my_gui_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in orie_pushbutton.
function orie_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to orie_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img
global msk
global theta
theta=ori_finger(img,msk);


axes(handles.axes2);
imshow(uint8(theta));
set(handles.axes2,'visible','off');  %¨¨¨¨
title('方向场');
% --- Executes on button press in open_pushbutton.
function open_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to open_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[fname,pname]=uigetfile('*.bmp;*.gif;*.jpg;','Please Select Image');
global img
if pname == 0
    return;
end

img=imread(strcat(pname,fname));
axes(handles.axes1);
imshow(img);
set(handles.axes1,'visible','off');  %¨¨¨¨
title('原始图');
% --- Executes on button press in grad_pushbutton.
function grad_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to grad_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img
imgs=double(img);
[mf,nf]=size(imgs);
Mag=zeros(mf,nf);
gra_x=zeros(mf,nf);gra_y=zeros(mf,nf);
so_y=[-1,0,1;-2,0,2;-1,0,1];so_x=[1,2,1;0,0,0;-1,-2,-1];
for k1=2:mf-1
    for k2=2:nf-1
        gra_x(k1,k2)=sum(sum(so_x.*imgs(k1-1:k1+1,k2-1:k2+1)));
        gra_y(k1,k2)=sum(sum(so_y.*imgs(k1-1:k1+1,k2-1:k2+1)));
        Mag(k1,k2)=sqrt(gra_x(k1,k2).^2+gra_y(k1,k2).^2);
    end
end
axes(handles.axes2);
imshow(Mag);
set(handles.axes2,'visible','off');
title('梯 度');

% --- Executes on button press in seg_pushbutton.
function seg_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to seg_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img
global msk
msk=segment_print(img,0);

axes(handles.axes2);
imshow(msk);
set(handles.axes2,'visible','off');  %¨¨¨¨
title('分 割');
function enh_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to enh_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img
global msk
global yi
yi=prepro_1(img,msk);


axes(handles.axes2);
imshow(uint8(yi));
set(handles.axes2,'visible','off');  %¨¨¨¨
title('增 强');
% global i_thin
% --- Executes on button press in mark_pushbutton.
function mark_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to mark_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global term
global bif
global i_thin
global ht
global wt
global cha_m

% figure(33);imshow(i_thin)
i_thino=i_thin;
[ht,wt]=size(i_thin);     %
cha_m=zeros(ht,wt);
nterm=0;nbif=0;
for i=3:ht-3                %¨
    for j=3:wt-3
        if i_thino(i,j)==1
            if abs(i_thino(i-1,j)-i_thino(i-1,j+1))+abs(i_thino(i-1,j-1)-i_thino(i-1,j))+...
                    +abs(i_thino(i,j-1)-i_thino(i-1,j-1))+abs(i_thino(i+1,j-1)-i_thino(i,j-1))+...
                    +abs(i_thino(i+1,j)-i_thino(i+1,j-1))+abs(i_thino(i+1,j+1)-i_thino(i+1,j))+...
                    +abs(i_thino(i,j+1)-i_thino(i+1,j+1))+abs(i_thino(i-1,j+1)-i_thino(i,j+1))==2
                nterm=nterm+1;
                term(1,nterm)=i;
                term(2,nterm)=j;
                cha_m(i,j)=1;
            end
            if abs(i_thino(i-1,j)-i_thino(i-1,j+1))+abs(i_thino(i-1,j-1)-i_thino(i-1,j))+...
                    +abs(i_thino(i,j-1)-i_thino(i-1,j-1))+abs(i_thino(i+1,j-1)-i_thino(i,j-1))+...
                    +abs(i_thino(i+1,j)-i_thino(i+1,j-1))+abs(i_thino(i+1,j+1)-i_thino(i+1,j))+...
                    +abs(i_thino(i,j+1)-i_thino(i+1,j+1))+abs(i_thino(i-1,j+1)-i_thino(i,j+1))==6
                nbif=nbif+1;
                bif(1,nbif)=i;
                bif(2,nbif)=j;
                cha_m(i,j)=2;
            end
        end
    end
end

axes(handles.axes3);
% figure(66);
imshow(i_thino),hold on,plot(term(2,:),term(1,:),'bo'),
plot(bif(2,:),bif(1,:),'ro');
set(handles.axes3,'visible','off');  %¨¨¨¨
title('特征提取');

% --- Executes on button press in bina_pushbutton.
function bina_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to bina_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img
global yi
global msk
global iseg
N=16;
msk=pad_image(msk,N);
img  =  double(img);
y_img=img;
img = pad_image(img,N);
[ht,wt]=size(img);
nimg    =   normalize_image(img,0,100);
%---------------------------------------
%orientation image
%---------------------------------------
oimg            =   blk_orientation_image(img,N);
%---------------------------------------
%smoothen orientation image
%---------------------------------------
oimg            =   smoothen_orientation_field(oimg);
%¨
[x,y]           =   meshgrid(-8:7,-16:15);
[blkht,blkwt]   =   size(oimg);
[ht,wt]         =   size(img);
yidx = 1; %index of the row block
for i = 0:blkht-1
    row     = (i*N+N/2);%+N for the pad
    xidx    = 1; %index of the col block
    for j = 0:blkwt-1
        col = (j*N+N/2);
        %row,col indicate the index of the center pixel
        th  = oimg(yidx,xidx);
        u = x*cos(th)-y*sin(th);
        v = x*sin(th)+y*cos(th);
        u           =   round(u+col); u(u<1)  = 1; u(u>wt) = wt;
        v           =   round(v+row); v(v<1)  = 1; v(v>ht) = ht;
        %find oriented block
        idx         =   sub2ind(size(img),v,u);
        blk         =   img(idx);
        blk         =   reshape(blk,[32,16]);
        %find x signature
        xsig        =   sum(blk,2);
        f(yidx,xidx) = find_peak_distance(xsig);
        xidx = xidx +1;
    end;
    yidx = yidx +1;
end;
fimg=filter_frequency_image(f);
y = do_gabor_filtering(img,oimg,fimg);     %gobor§
yi=imscale(y);

yi(msk==0)=1;         % ¨¨°
%     figure(4);imshow(uint8(yi));           %
iseg=adapt(yi);       %
iseg(msk==0)=0;
iseg=1-iseg;
for k=1:3                    % §
    for i=2:ht-1
        for j=2:wt-1
            if iseg(i,j)==1
                sum1=sum(sum(iseg(i-1:i+1,j-1:j+1)));
                if sum1<5
                    iseg(i,j)=0;
                end
            else
                if(((iseg(i,j+1)*iseg(i-1,j+1)*iseg(i-1,j)+iseg(i,j-1)*iseg(i+1,j-1)*iseg(i+1,j))*(iseg(i-1,j)*iseg(i-1,j-1)*iseg(i,j-1)+iseg(i+1,j)*iseg(i+1,j+1)*iseg(i,j+1)))>=1)
                    iseg(i,j)=1;
                end
            end
        end
    end
end
iseg=1-iseg;

%
axes(handles.axes3);
% figure(11);
imshow(iseg);
set(handles.axes3,'visible','off');  %¨¨¨¨
title('二值化');
% --- Executes on button press in thin_pushbutton.


function thin_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to thin_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global img
global msk
global iseg
global c
global i_thin
%
c=bwmorph(iseg,'thin','inf');   %
fun=@minutie;
c = nlfilter(c,[3 3],fun);

i_thin=c(5:364,1:256);
msk=msk(5:364,1:256);  % ó
i_thin(i_thin>0)=1;

% figure(44);imshow(i_thin);
axes(handles.axes3);
% figure(22);
imshow(c);
set(handles.axes3,'visible','off');  %¨¨¨¨
% --- Executes on button press in save_pushbutton.
title('细 化');

function mark2_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to save_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global msk

global i_thin

[i_thin2,term,bif]=mark(i_thin,msk);
% figure(55);
axes(handles.axes3);
imshow(i_thin2),hold on,plot(term(2,:),term(1,:),'bo'),plot(bif(2,:),bif(1,:),'ro');
set(handles.axes3,'visible','off');
title('特征标记');
% --- Executes on button press in canc_pushbutton.
function canc_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to canc_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

selection=questdlg(['是否关闭',get(gcf,'Name'),'窗口？'],...
    ['Close ',get(gcf,'Name')],'是','否','是');
if strcmp(selection,'否')
    return;
else
    delete(handles.figure1);
end




% --- Executes on button press in pushbutton20.
function pushbutton20_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



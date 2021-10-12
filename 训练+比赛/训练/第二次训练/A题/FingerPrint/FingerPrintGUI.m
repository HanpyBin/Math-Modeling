function varargout = FingerPrintGUI(varargin)
% FINGERPRINTGUI M-file for FingerPrintGUI.fig
%      FINGERPRINTGUI, by itself, creates a new FINGERPRINTGUI or raises the existing
%      singleton*.
%
%      H = FINGERPRINTGUI returns the handle to a new FINGERPRINTGUI or the handle to
%      the existing singleton*.
%
%      FINGERPRINTGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FINGERPRINTGUI.M with the given input arguments.
%
%      FINGERPRINTGUI('Property','Value',...) creates a new FINGERPRINTGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before FingerPrintGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to FingerPrintGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help FingerPrintGUI

% Last Modified by GUIDE v2.5 29-May-2009 14:43:29

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @FingerPrintGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @FingerPrintGUI_OutputFcn, ...
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


% --- Executes just before FingerPrintGUI is made visible.
function FingerPrintGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to FingerPrintGUI (see VARARGIN)

% Choose default command line output for FingerPrintGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes FingerPrintGUI wait for user response (see UIRESUME)
% uiwait(handles.FingerPrintGUI);
set(handles.Binarize,'enable','off');
set(handles.AutomaticBW,'enable','off');
set(handles.ManualBW,'enable','off');
set(handles.Thining,'enable','off');
set(handles.FindMinutia,'enable','off');
set(handles.RemoveFalseMinutia,'enable','off');
set(handles.RegionOfInterest,'enable','off');
set(handles.ManualROI,'enable','off');
set(handles.AutomaticROI,'enable','off');
set(handles.Orientation,'enable','off');
set(handles.Validation,'enable','off');
set(handles.OriginalImage,'enable','off');
set(handles.Skeleton,'enable','off');
set(handles.Termination,'enable','off');
set(handles.Bifurcation,'enable','off');
set(handles.ExportMinutia,'enable','off');


% --- Outputs from this function are returned to the command line.
function varargout = FingerPrintGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Skeleton.
function Skeleton_Callback(hObject, eventdata, handles)
% hObject    handle to Skeleton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Skeleton
if get(hObject,'value')==1
    set(handles.OriginalImage,'value',0)
    set(handles.WhiteImage,'value',0)
end

% --- Executes on button press in OriginalImage.
function OriginalImage_Callback(hObject, eventdata, handles)
% hObject    handle to OriginalImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of OriginalImage
if get(hObject,'value')==1
    set(handles.WhiteImage,'value',0)
    set(handles.Skeleton,'value',0)
end

% --- Executes on button press in WhiteImage.
function WhiteImage_Callback(hObject, eventdata, handles)
% hObject    handle to WhiteImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of WhiteImage
if get(hObject,'value')==1
    set(handles.OriginalImage,'value',0)
    set(handles.Skeleton,'value',0)
end



% --- Executes on button press in radiobutton7.
function radiobutton7_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton7


% --- Executes on button press in Termination.
function Termination_Callback(hObject, eventdata, handles)
% hObject    handle to Termination (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Termination


% --- Executes on button press in Bifurcation.
function Bifurcation_Callback(hObject, eventdata, handles)
% hObject    handle to Bifurcation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Bifurcation


% --- Executes on button press in Binarize.
function Binarize_Callback(hObject, eventdata, handles)
% hObject    handle to Binarize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

I=getappdata(handles.FingerPrintGUI,'OriginalImage');
if get(handles.ManualBW,'value')==1
    Threshold=str2num(get(handles.Threshold,'string'));
    BinarizedImage=I(:,:,1)>Threshold;
else
    BinarizedImage=I(:,:,1)>160;
end

setappdata(handles.FingerPrintGUI,'BinarizedImage',BinarizedImage);

set(handles.Thining,'enable','on')

axes(handles.axes1)
image(255*BinarizedImage),colormap(gray)
set(gca,'tag','axes1')
function Threshold_Callback(hObject, eventdata, handles)
% hObject    handle to Threshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Threshold as text
%        str2double(get(hObject,'String')) returns contents of Threshold as a double


% --- Executes during object creation, after setting all properties.
function Threshold_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Threshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in RegionOfInterest.
function RegionOfInterest_Callback(hObject, eventdata, handles)
% hObject    handle to RegionOfInterest (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I=getappdata(handles.FingerPrintGUI,'OriginalImage');
K=getappdata(handles.FingerPrintGUI,'Skeleton');

if get(handles.AutomaticROI,'value')==1
Kopen=imclose(K,strel('square',7));

KopenClean= imfill(Kopen,'holes');
KopenClean=bwareaopen(KopenClean,5);

KopenClean([1 end],:)=0;
KopenClean(:,[1 end])=0;
ROI=imerode(KopenClean,strel('disk',10));
elseif get(handles.ManualROI,'value')==1
    f=figure;
    ROI=roipoly(I);
    close(f)
else
    errordlg('Please, Select a Method');
end



%% Suppress extrema minutiae
% Once we defined the ROI, we can suppress minutiae external to this ROI.
CentroidFinX=getappdata(handles.FingerPrintGUI,'CentroidFinX');
CentroidFinY=getappdata(handles.FingerPrintGUI,'CentroidFinY');
CentroidSepX=getappdata(handles.FingerPrintGUI,'CentroidSepX');
CentroidSepY=getappdata(handles.FingerPrintGUI,'CentroidSepY');
[m,n]=size(I(:,:,1));
indFin=sub2ind([m,n],CentroidFinX,CentroidFinY);
Z=zeros(m,n);
Z(indFin)=1;
ZFin=Z.*ROI';
[CentroidFinX,CentroidFinY]=find(ZFin);

indSep=sub2ind([m,n],CentroidSepX,CentroidSepY);
Z=zeros(m,n);
Z(indSep)=1;
ZSep=Z.*ROI';
[CentroidSepX,CentroidSepY]=find(ZSep);


axes(handles.axes1)
imshow(I)
hold on
image(255*ROI)
alpha(0.5)
plot(CentroidFinX,CentroidFinY,'ro','linewidth',2)
plot(CentroidSepX,CentroidSepY,'go','linewidth',2)
hold off

set(gca,'tag','axes1')

setappdata(handles.FingerPrintGUI,'CentroidFinX',CentroidFinX);
setappdata(handles.FingerPrintGUI,'CentroidFinY',CentroidFinY);
setappdata(handles.FingerPrintGUI,'CentroidSepX',CentroidSepX);
setappdata(handles.FingerPrintGUI,'CentroidSepY',CentroidSepY);

set(handles.Orientation,'enable','on')


% --- Executes on button press in Thining.
function Thining_Callback(hObject, eventdata, handles)
% hObject    handle to Thining (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I=getappdata(handles.FingerPrintGUI,'BinarizedImage');
Skeleton=bwmorph(~I,'thin','inf');

setappdata(handles.FingerPrintGUI,'Skeleton',Skeleton);

set(handles.Skeleton,'enable','on')
set(handles.FindMinutia,'enable','on')

axes(handles.axes1)
image(255*Skeleton)
set(gca,'tag','axes1')
% --- Executes on button press in FindMinutia.
function FindMinutia_Callback(hObject, eventdata, handles)
% hObject    handle to FindMinutia (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I=getappdata(handles.FingerPrintGUI,'Skeleton');
axes(handles.axes1)
imshow(255*I)

fun=@minutie;
L = nlfilter(I,[3 3],fun);

%% Termination
LFin=(L==1);
LFinLab=bwlabel(LFin);
propFin=regionprops(LFinLab,'Centroid');
CentroidFin=round(cat(1,propFin(:).Centroid));
CentroidFinX=CentroidFin(:,1);
CentroidFinY=CentroidFin(:,2);
axes(handles.axes1)
hold on
plot(CentroidFinX,CentroidFinY,'ro')

%% Bifurcation
LSep=(L==3);
LSepLab=bwlabel(LSep);
propSep=regionprops(LSepLab,'Centroid','Image');
CentroidSep=round(cat(1,propSep(:).Centroid));
CentroidSepX=CentroidSep(:,1);
CentroidSepY=CentroidSep(:,2);
plot(CentroidSepX,CentroidSepY,'go')
hold off
set(gca,'tag','axes1')



setappdata(handles.FingerPrintGUI,'CentroidFinX',CentroidFinX);
setappdata(handles.FingerPrintGUI,'CentroidFinY',CentroidFinY);
setappdata(handles.FingerPrintGUI,'CentroidSepX',CentroidSepX);
setappdata(handles.FingerPrintGUI,'CentroidSepY',CentroidSepY);
setappdata(handles.FingerPrintGUI,'OrientationFin',[]);
setappdata(handles.FingerPrintGUI,'OrientationSep',[]);
set(handles.RemoveFalseMinutia,'enable','on')
set(handles.Termination,'enable','on')
set(handles.Bifurcation,'enable','on')
set(handles.ExportMinutia,'enable','on');




% --- Executes on button press in RemoveFalseMinutia.
function RemoveFalseMinutia_Callback(hObject, eventdata, handles)
% hObject    handle to RemoveFalseMinutia (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
CentroidFinX=getappdata(handles.FingerPrintGUI,'CentroidFinX');
CentroidFinY=getappdata(handles.FingerPrintGUI,'CentroidFinY');
CentroidSepX=getappdata(handles.FingerPrintGUI,'CentroidSepX');
CentroidSepY=getappdata(handles.FingerPrintGUI,'CentroidSepY');
D=6;
%% Process 1
Distance=DistEuclidian([CentroidSepX CentroidSepY],[CentroidFinX CentroidFinY]);
SpuriousMinutae=Distance<D;
[i,j]=find(SpuriousMinutae);
CentroidSepX(i)=[];
CentroidSepY(i)=[];
CentroidFinX(j)=[];
CentroidFinY(j)=[];
%% Process 2
Distance=DistEuclidian([CentroidSepX CentroidSepY]);
SpuriousMinutae=Distance<D;
[i,j]=find(SpuriousMinutae);
CentroidSepX(i)=[];
CentroidSepY(i)=[];

%% Process 3
Distance=DistEuclidian([CentroidFinX CentroidFinY]);
SpuriousMinutae=Distance<D;
[i,j]=find(SpuriousMinutae);
CentroidFinX(i)=[];
CentroidFinY(i)=[];


I=getappdata(handles.FingerPrintGUI,'Skeleton');
axes(handles.axes1)
imshow(255*I)
hold on
plot(CentroidFinX,CentroidFinY,'ro')
plot(CentroidSepX,CentroidSepY,'go')
hold off
set(gca,'tag','axes1')

setappdata(handles.FingerPrintGUI,'CentroidFinX',CentroidFinX);
setappdata(handles.FingerPrintGUI,'CentroidFinY',CentroidFinY);
setappdata(handles.FingerPrintGUI,'CentroidSepX',CentroidSepX);
setappdata(handles.FingerPrintGUI,'CentroidSepY',CentroidSepY);

set(handles.ManualROI,'enable','on')
set(handles.AutomaticROI,'enable','on')
set(handles.RegionOfInterest,'enable','on')
% --- Executes on button press in Orientation.
function Orientation_Callback(hObject, eventdata, handles)
% hObject    handle to Orientation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Table=[3*pi/4 2*pi/3 pi/2 pi/3 pi/4 
       5*pi/6 0 0 0 pi/6
       pi 0 0 0 0
      -5*pi/6 0 0 0 -pi/6
      -3*pi/4 -2*pi/3 -pi/2 -pi/3 -pi/4];
CentroidFinX=getappdata(handles.FingerPrintGUI,'CentroidFinX');
CentroidFinY=getappdata(handles.FingerPrintGUI,'CentroidFinY');
CentroidSepX=getappdata(handles.FingerPrintGUI,'CentroidSepX');
CentroidSepY=getappdata(handles.FingerPrintGUI,'CentroidSepY');
K=getappdata(handles.FingerPrintGUI,'Skeleton');
%% Termination Orientation 
% We have to find the orientation of the termination. 
% For finding that, we analyze the position of the pixel on the boundary of
% a 5 x 5 bounding box of the termination. We compare this position to the
% Table variable. The Table variable gives the angle in radian.
for ind=1:length(CentroidFinX)
    Klocal=K(CentroidFinY(ind)-2:CentroidFinY(ind)+2,CentroidFinX(ind)-2:CentroidFinX(ind)+2);
    Klocal(2:end-1,2:end-1)=0;
    [i,j]=find(Klocal);
    if length(i)~=1
        CentroidFinY(ind)=NaN;
        CentroidFinX(ind)=NaN;
        OrientationFin(ind,1)=NaN;
    else
        OrientationFin(ind,1)=Table(i,j);
    end
end
dxFin=sin(OrientationFin)*5;
dyFin=cos(OrientationFin)*5;
axes(handles.axes1)
imshow(K)
hold on
plot(CentroidFinX,CentroidFinY,'ro','linewidth',2)
plot([CentroidFinX CentroidFinX+dyFin]',...
    [CentroidFinY CentroidFinY-dxFin]','r','linewidth',2)


%% Bifurcation Orientation
%  For each bifurcation, we have three lines. So we operate the same
%  process than in termination case three times.
for ind=1:length(CentroidSepX)
    Klocal=K(CentroidSepY(ind)-2:CentroidSepY(ind)+2,CentroidSepX(ind)-2:CentroidSepX(ind)+2);
    Klocal(2:end-1,2:end-1)=0;
    [i,j]=find(Klocal);
    if length(i)~=3
        CentroidSepY(ind)=NaN;
        CentroidSepX(ind)=NaN;
        OrientationSep(ind)=NaN;
    else
        for k=1:3
            OrientationSep(ind,k)=Table(i(k),j(k));
            dxSep(ind,k)=sin(OrientationSep(ind,k))*5;
            dySep(ind,k)=cos(OrientationSep(ind,k))*5;

        end
    end
end

plot(CentroidSepX,CentroidSepY,'go','linewidth',2)
OrientationLinesX=[CentroidSepX CentroidSepX+dySep(:,1);CentroidSepX CentroidSepX+dySep(:,2);CentroidSepX CentroidSepX+dySep(:,3)]';
OrientationLinesY=[CentroidSepY CentroidSepY-dxSep(:,1);CentroidSepY CentroidSepY-dxSep(:,2);CentroidSepY CentroidSepY-dxSep(:,3)]';
plot(OrientationLinesX,OrientationLinesY,'g','linewidth',2)
hold off
set(gca,'tag','axes1')
setappdata(handles.FingerPrintGUI,'CentroidFinX',CentroidFinX);
setappdata(handles.FingerPrintGUI,'CentroidFinY',CentroidFinY);
setappdata(handles.FingerPrintGUI,'CentroidSepX',CentroidSepX);
setappdata(handles.FingerPrintGUI,'CentroidSepY',CentroidSepY);
setappdata(handles.FingerPrintGUI,'OrientationFin',OrientationFin);
setappdata(handles.FingerPrintGUI,'OrientationSep',OrientationSep);

set(handles.Validation,'enable','on')
% --- Executes on button press in Validation.
function Validation_Callback(hObject, eventdata, handles)
% hObject    handle to Validation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

CentroidFinX=getappdata(handles.FingerPrintGUI,'CentroidFinX');
CentroidFinY=getappdata(handles.FingerPrintGUI,'CentroidFinY');
CentroidSepX=getappdata(handles.FingerPrintGUI,'CentroidSepX');
CentroidSepY=getappdata(handles.FingerPrintGUI,'CentroidSepY');
OrientationFin=getappdata(handles.FingerPrintGUI,'OrientationFin');
OrientationSep=getappdata(handles.FingerPrintGUI,'OrientationSep');
I=getappdata(handles.FingerPrintGUI,'OriginalImage');
ValidationGUI(I,CentroidFinX,CentroidFinY,OrientationFin,CentroidSepX,CentroidSepY,OrientationSep);

% --------------------------------------------------------------------
function LoadImage_Callback(hObject, eventdata, handles)
% hObject    handle to LoadImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[f,rep]=uigetfile('*.bmp');
OriginalImage=imread([rep,f]);
OriginalImage=imresize(OriginalImage,[300 300]);
set(handles.OriginalImage,'enable','on');
set(handles.Display,'enable','on');
set(handles.AutomaticBW,'enable','on');
set(handles.ManualBW,'enable','on');
set(handles.Binarize,'enable','on');
set(handles.OriginalImage,'value',1);
setappdata(handles.FingerPrintGUI,'OriginalImage',OriginalImage);

Display_Callback(handles.Display,eventdata,handles);

% --------------------------------------------------------------------
function ExportMinutia_Callback(hObject, eventdata, handles)
% hObject    handle to ExportMinutia (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
CentroidSepX=getappdata(handles.FingerPrintGUI,'CentroidSepX');
CentroidSepY=getappdata(handles.FingerPrintGUI,'CentroidSepY');
OrientationSep=getappdata(handles.FingerPrintGUI,'OrientationSep');
MinutiaSep=[CentroidSepX CentroidSepY OrientationSep];
CentroidFinX=getappdata(handles.FingerPrintGUI,'CentroidFinX');
CentroidFinY=getappdata(handles.FingerPrintGUI,'CentroidFinY');
OrientationFin=getappdata(handles.FingerPrintGUI,'OrientationFin');
MinutiaFin=[CentroidFinX CentroidFinY OrientationFin];
prompt = {'Enter file name:'};
dlg_title = 'Input for Minutia export';
num_lines = 1;
def = {'wangfeng'};
answer = inputdlg(prompt,dlg_title,num_lines,def);
saveMinutia(answer{1},MinutiaFin,MinutiaSep);

% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Display.
function Display_Callback(hObject, eventdata, handles)
% hObject    handle to Display (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes2)
g1=get(handles.OriginalImage,'value');
g3=get(handles.Skeleton,'value');
if g1==1
    image(getappdata(handles.FingerPrintGUI,'OriginalImage'));
elseif g3==1
    image(255*getappdata(handles.FingerPrintGUI,'Skeleton'));
else
    image(ones(200,200,3));
end


hold on
h1=get(handles.Termination,'value');
h2=get(handles.Bifurcation,'value');
if h1==1
    CentroidFinX=getappdata(handles.FingerPrintGUI,'CentroidFinX');
    CentroidFinY=getappdata(handles.FingerPrintGUI,'CentroidFinY');
    plot(CentroidFinX,CentroidFinY,'ro','linewidth',2)
    OrientationFin=getappdata(handles.FingerPrintGUI,'OrientationFin');
    length(OrientationFin)
    if ~isempty(OrientationFin)

        dxFin=sin(OrientationFin)*5;
        dyFin=cos(OrientationFin)*5;
        hold on

        plot([CentroidFinX CentroidFinX+dyFin]',...
            [CentroidFinY CentroidFinY-dxFin]','r','linewidth',2)
    end
end
if h2==1
    CentroidSepX=getappdata(handles.FingerPrintGUI,'CentroidSepX');
    CentroidSepY=getappdata(handles.FingerPrintGUI,'CentroidSepY');
    plot(CentroidSepX,CentroidSepY,'go','linewidth',2)
    OrientationSep=getappdata(handles.FingerPrintGUI,'OrientationSep');
    if ~isempty(OrientationSep)
        dxSep=sin(OrientationSep)*5;
        dySep=cos(OrientationSep)*5;
        OrientationLinesX=[CentroidSepX CentroidSepX+dySep(:,1);CentroidSepX CentroidSepX+dySep(:,2);CentroidSepX CentroidSepX+dySep(:,3)]';
        OrientationLinesY=[CentroidSepY CentroidSepY-dxSep(:,1);CentroidSepY CentroidSepY-dxSep(:,2);CentroidSepY CentroidSepY-dxSep(:,3)]';

        plot(OrientationLinesX,OrientationLinesY,'g','linewidth',2)
    end
end
hold off
set(gca,'tag','axes2')



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function ExportMinutia_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ExportMinutia (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object deletion, before destroying properties.
function ExportMinutia_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to ExportMinutia (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over ExportMinutia.
function ExportMinutia_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to ExportMinutia (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on key press over ExportMinutia with no controls selected.
function ExportMinutia_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to ExportMinutia (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton18.
function pushbutton18_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton19.
function pushbutton19_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



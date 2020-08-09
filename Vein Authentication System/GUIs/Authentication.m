function varargout = Authentication(varargin)
% AUTHENTICATION MATLAB code for Authentication.fig
%      AUTHENTICATION, by itself, creates a new AUTHENTICATION or raises the existing
%      singleton*.
%
%      H = AUTHENTICATION returns the handle to a new AUTHENTICATION or the handle to
%      the existing singleton*.
%
%      AUTHENTICATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in AUTHENTICATION.M with the given input arguments.
%
%      AUTHENTICATION('Property','Value',...) creates a new AUTHENTICATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Authentication_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Authentication_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Authentication

% Last Modified by GUIDE v2.5 12-Mar-2017 17:27:15

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Authentication_OpeningFcn, ...
                   'gui_OutputFcn',  @Authentication_OutputFcn, ...
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


% --- Executes just before Authentication is made visible.
function Authentication_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Authentication (see VARARGIN)

% Choose default command line output for Authentication
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Authentication wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Authentication_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


 path = get(handles.path,'String');
% NotBusy='C:\Users\mzafa\Desktop\NotBusy.PNG';
NotBusy=strcat(path,'\images\NotBusy.PNG');

axes(handles.axes1);
imshow(imread(NotBusy));

axes(handles.axes2);
imshow(imread(NotBusy));

% path=strcat('C:\Users\mzafa\Desktop\imagProcessing\ImagesSamples\Features\CombineSkel\');
totalImg=size(dir(strcat(path,'\CombineSkel\','/*.png')),1);
set(handles.PreSubject, 'String',num2str(totalImg) );




% --- Executes on button press in Register.
function Register_Callback(hObject, eventdata, handles)
% hObject    handle to Register (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


 path = get(handles.path,'String');
p= strcat(path,'\images\Busy_Icon.PNG');

BusyImg =p;
p=strcat(path,'\images\NotBusy.PNG');

NotBusy=p;

axes(handles.axes1);
imshow(imread(NotBusy));

axes(handles.axes2);
imshow(imread(BusyImg));

set(handles.Register, 'Enable', 'off');
set(handles.Verify, 'Enable', 'off');
set(handles.TakeImage, 'Enable', 'off');

 x = get(handles.Subject,'String');
 if isempty(x)
waitfor( errordlg('Invalid Value of Subjects',' Error'));
 axes(handles.axes2);
 imshow(NotBusy);
 else
   % Write code for computation you want to do 
   
   
exposure= get(handles.slider1,'Value');
fol=get(handles.Subject,'string');
Mmin=zeros(25,20);
Mmax=zeros(25,20);
img=zeros(211,211);

progressbar('Registration');

for i=1:25
    progressbar(i/25) ;
    [adjImg,imgPat,imgPat5,splitPat1,thin1]=TakeandProc(exposure);
    img1=thin1;
    [min,max]=mini_max_dist( img1 );
    Mmin(i,:)=min;
    Mmax(i,:)=max;
    img=img1|img;
    pause(.05);
end

axes(handles.axes2);
imshow(img);
% path='..\ImagesSamples\Features\CombineSkel\';
p=strcat(path,'\min\Subject',num2str(fol),'.csv');

dlmwrite(p,Mmin, ',')
p=strcat(path,'\max\Subject',num2str(fol),'.csv');

dlmwrite(p,Mmax, ',')
p=strcat(path,'\CombineSkel\Subject',num2str(fol),'.png');

imwrite(img,p);

set(handles.result, 'String', '');
set(handles.Subject, 'String', '');

name= get(handles.name,'String'); %edit1 being Tag of ur edit box

if(size(name,2)==0)
    name= strcat('Subject',num2str(fol));
end
SaveName(name,str2double(fol),strcat(path, '\SubjectName.csv'));

% path=strcat('C:\Users\mzafa\Desktop\imagProcessing\ImagesSamples\Features\CombineSkel\');
totalImg=size(dir(strcat(path,'\CombineSkel\','/*.png')),1);
set(handles.PreSubject, 'String',num2str(totalImg));

 end

set(handles.Register, 'Enable', 'on');
set(handles.Verify, 'Enable', 'on');
set(handles.TakeImage, 'Enable', 'on');




% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function Subject_Callback(hObject, eventdata, handles)
% hObject    handle to Subject (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Subject as text
%        str2double(get(hObject,'String')) returns contents of Subject as a double


% --- Executes during object creation, after setting all properties.
function Subject_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Subject (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in TakeImage.
function TakeImage_Callback(hObject, eventdata, handles)
% hObject    handle to TakeImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

exposure= get(handles.slider1,'Value');
cam=ReadyCam(exposure);
adjImg=takeimage(cam);

axes(handles.axes2);
imshow(adjImg);

set(handles.result, 'String', '');

% --- Executes on button press in Verify.
function Verify_Callback(hObject, eventdata, handles)
% hObject    handle to Verify (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


 path = get(handles.path,'String');
BusyImg = strcat(path,'\images\Busy_Icon.PNG');
NotBusy=strcat(path,'\images\NotBusy.PNG');

axes(handles.axes2);
imshow(imread( NotBusy));
axes(handles.axes1);
imshow(imread(BusyImg));

set(handles.Register, 'Enable', 'off');
set(handles.Verify, 'Enable', 'off');
set(handles.TakeImage, 'Enable', 'off');

exposure= get(handles.slider1,'Value');
result='';

totalImg=size(dir(strcat(path,'\CombineSkel\','/*.png')),1);

[adjImg,imgPat,imgPat5,splitPat1,thin1]=TakeandProc(exposure);

axes(handles.axes1);

imshowpair(adjImg,thin1,'montage');
p=strcat(path,'\SubjectName.csv');

names=cell2mat(importdata(p));
names= strsplit(names,',');
names = names(:,1:end-1);

progressbar('Verification');
for i=1:totalImg
    
    progressbar(i/totalImg) ;
    p=strcat(path,'\CombineSkel\Subject',num2str(i),'.png');
    
    mimg=imread(p);
    %  Rotate Image 
    for Pics=1:3
        
        if(Pics==2)
            splitPat1= RotateImg(splitPat1,-5);
            thin1=thinLines(splitPat1);
        else if(Pics==3)
                splitPat1= RotateImg(splitPat1,5);
                thin1=thinLines(splitPat1);
                
            end
        end  
        CompImg=mimg&thin1;
        numberOfTruePixels = sum(thin1(:));
        N_of=sum(CompImg(:));
        Perc=(N_of/numberOfTruePixels)*100;
        
        if(Perc>65)
%             result=strcat(result,num2str( i),' ');
            result=names(i);
        else
            p=strcat(path,'\min\Subject',num2str(i),'.csv');
            
            Mmin=importdata(p);
            p=strcat(path,'\max\Subject',num2str(i),'.csv');
            
            Mmax=importdata(p);
            % Compute feature
            [minToMatch,maxToMatch]=mini_max_dist(thin1);
            
            for row=1:25
                min=Mmin(i,:);
                max=Mmax(i,:);
                [minAvg,maxAvg]=MatchMinMax(minToMatch,min,maxToMatch,max);
                if(minAvg<.20&&maxAvg<.50)
                    break;
                end
                
                if((minAvg+maxAvg)>(.55+.70))
                      result=names(i);
                    break;
                end
            end
        end
    end
end
if(~isempty(result))
    
    set(handles.result, 'String', strcat('Match with : ',result));
    
else
    set(handles.result, 'String', 'Does not Match with Subject');
    
end

set(handles.Register, 'Enable', 'on');
set(handles.Verify, 'Enable', 'on');
set(handles.TakeImage, 'Enable', 'on');



function name_Callback(hObject, eventdata, handles)
% hObject    handle to name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of name as text
%        str2double(get(hObject,'String')) returns contents of name as a double


% --- Executes during object creation, after setting all properties.
function name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

folder_name = uigetdir('C:/','Select Folder');
if(folder_name~=0)
    
    set(handles.path, 'String',num2str(folder_name));

end

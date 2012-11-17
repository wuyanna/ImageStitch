function varargout = stitch(varargin)
% STITCH M-file for stitch.fig
%      STITCH, by itself, creates a new STITCH or raises the existing
%      singleton*.
%
%      H = STITCH returns the handle to a new STITCH or the handle to
%      the existing singleton*.
%
%      STITCH('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in STITCH.M with the given input arguments.
%
%      STITCH('Property','Value',...) creates a new STITCH or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before stitch_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to stitch_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Copyright 2002-2003 The MathWorks, Inc.

% Edit the above text to modify the response to help stitch

% Last Modified by GUIDE v2.5 14-Nov-2012 11:33:27

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @stitch_OpeningFcn, ...
                   'gui_OutputFcn',  @stitch_OutputFcn, ...
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


% --- Executes just before stitch is made visible.
function stitch_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to stitch (see VARARGIN)

% Choose default command line output for stitch
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes stitch wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = stitch_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in OpenPic1.
function OpenPic1_Callback(hObject, eventdata, handles)
% hObject    handle to OpenPic1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    global pic_1;
    global pic_1_back;
    global file1name;
    global path1name;
    
   [file1name,path1name]=uigetfile('*.jpg','*.bmp');
   if exist(strcat(path1name,file1name))
   pic_1=imread(strcat(path1name,file1name));
   pic_1_back = pic_1;
   axes(handles.axes2);
   imshow(pic_1);
   else 
       return;
   end;


% --- Executes on button press in OpenPic2.
function OpenPic2_Callback(hObject, eventdata, handles)
% hObject    handle to OpenPic2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    global pic_2;
    global pic_2_back;
    global file2name;
    global path2name;
    
   [file2name,path2name]=uigetfile('*.jpg','*.bmp');
   if exist(strcat(path2name,file2name))
   pic_2=imread(strcat(path2name,file2name));
   pic_2_back = pic_2;
   axes(handles.axes3);  
   imshow(pic_2);
   else 
       return;
   end;


% --- Executes on button press in Stitch0.
function Stitch0_Callback(hObject, eventdata, handles)
% hObject    handle to Stitch0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pic_1;
global pic_2;
global d;

[pic_1,pic_2,d] = retdist(pic_1,pic_2);
pic=nolimscolor(pic_1,pic_2,d);
axes(handles.axes6);   % ¡ì¡§
imshow(pic);

pic=imscolor(pic_1,pic_2,d);
axes(handles.axes4);  
imshow(pic);

pic=imswrcolor(pic_1,pic_2,d);
axes(handles.axes10);   % ¡ì¡§
imshow(pic);






% --- Executes on button press in cylin.
function cylin_Callback(hObject, eventdata, handles)
% hObject    handle to cylin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pic_1;
global pic_2;
global pic_1_back;
global pic_2_back;
global focus;
pic_1 = pic_1_back;
pic_2 = pic_2_back;
focus = str2double(get(handles.edit2,'String'));
if (isnan(focus))
    focus = 400;
    set(handles.edit2,'String',focus);
end
pic_1 = CylinPro(pic_1,focus);
pic_2 = CylinPro(pic_2,focus);
axes(handles.axes8);
imshow(pic_1);
axes(handles.axes9);
imshow(pic_2);



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

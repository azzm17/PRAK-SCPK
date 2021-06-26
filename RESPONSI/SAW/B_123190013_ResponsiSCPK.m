function varargout = B_123190013_ResponsiSCPK(varargin)
% B_123190013_RESPONSISCPK MATLAB code for B_123190013_ResponsiSCPK.fig
%      B_123190013_RESPONSISCPK, by itself, creates a new B_123190013_RESPONSISCPK or raises the existing
%      singleton*.
%
%      H = B_123190013_RESPONSISCPK returns the handle to a new B_123190013_RESPONSISCPK or the handle to
%      the existing singleton*.
%
%      B_123190013_RESPONSISCPK('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in B_123190013_RESPONSISCPK.M with the given input arguments.
%
%      B_123190013_RESPONSISCPK('Property','Value',...) creates a new B_123190013_RESPONSISCPK or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before B_123190013_ResponsiSCPK_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to B_123190013_ResponsiSCPK_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help B_123190013_ResponsiSCPK

% Last Modified by GUIDE v2.5 26-Jun-2021 11:47:16

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @B_123190013_ResponsiSCPK_OpeningFcn, ...
                   'gui_OutputFcn',  @B_123190013_ResponsiSCPK_OutputFcn, ...
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


% --- Executes just before B_123190013_ResponsiSCPK is made visible.
function B_123190013_ResponsiSCPK_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to B_123190013_ResponsiSCPK (see VARARGIN)

% Choose default command line output for B_123190013_ResponsiSCPK
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes B_123190013_ResponsiSCPK wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = B_123190013_ResponsiSCPK_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

opts = detectImportOptions('DATA_RUMAH.xlsx');
opts.SelectedVariableNames = (1:7);
data = readmatrix('DATA_RUMAH.xlsx', opts);%membaca file DATA_RUMAH.xlsx
set(handles.uitable1,'data',data,'visible','on'); %menampilkan data dari file DATA_RUMAH.xlsx kedalam uitable1


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

opts = detectImportOptions('DATA_RUMAH.xlsx');
opts.SelectedVariableNames = (2:7);
data = readmatrix('DATA_RUMAH.xlsx', opts); %membaca file DATA_RUMAH.xlsx

k=[0,1,1,1,1,1]; %merupakan cost/benefit
w=[0.3,0.2,0.23,0.1,0.07,0.1]; %merupakan bobot per kriteria

%tahap 1
[m n]=size (data);%menginisialisasi ukuran data
R=zeros (m,n); %membuat matriks kosong R 
Y=zeros (m,n); %membuat matriks kosong Y
 
%tahap 2
for j=1:n,
    if k(j)==1, 
        R(:,j)=data(:,j)./max(data(:,j));
    else 
        R(:,j)=min(data(:,j))./data(:,j);
    end;
end;
for i=1:m,
    V(i)= sum(w.*R(i,:)) %proses perhitungan   
end;

opts = detectImportOptions('DATA_RUMAH.xlsx');
opts.SelectedVariableNames = (1);
baru = readmatrix('DATA_RUMAH.xlsx', opts);%membaca file DATA_RUMAH.xlsx
xlswrite('dta_hasil.xlsx', baru, 'Sheet1', 'B1'); %membuat file xlsx baru dan menulis data hasil di kolom B1
V=V'; %data hasil diubah dari horizontal ke vertikal
xlswrite('dta_hasil.xlsx', V, 'Sheet1', 'C1'); %membuat file xlsx baru dan menulis data hasil di kolom C1

opts = detectImportOptions('dta_hasil.xlsx');
opts.SelectedVariableNames = (1:2);
data = readmatrix('dta_hasil.xlsx', opts); %membaca file dta_hasil.xlsx

X=sortrows(data,2,'descend'); %data diurut dari yg besar ke kecil berdasarkan kolom 2
X=X(1:20,1:2); %dipilih 20 data teratas pada data
set(handles.uitable2,'data',X,'visible','on'); %data hasil ditampilkan pada uitable2 pada GUI

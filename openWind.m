function varargout = openWind(varargin)
% OPENWIND MATLAB code for openWind.fig
%      OPENWIND, by itself, creates a new OPENWIND or raises the existing
%      singleton*.
%
%      H = OPENWIND returns the handle to a new OPENWIND or the handle to
%      the existing singleton*.
%
%      OPENWIND('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in OPENWIND.M with the given input arguments.
%
%      OPENWIND('Property','Value',...) creates a new OPENWIND or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before openWind_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to openWind_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help openWind

% Last Modified by GUIDE v2.5 01-Sep-2019 21:34:25

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @openWind_OpeningFcn, ...
                   'gui_OutputFcn',  @openWind_OutputFcn, ...
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


% --- Executes just before openWind is made visible.
function openWind_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to openWind (see VARARGIN)

% Choose default command line output for openWind
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);


actualData = varargin{1};
nn_6_h3n8_4_outputs = varargin{2};

x = 2:30; % the days being predicted

% start plotting wind
axes(handles.axes1)
plot(x,actualData(3,:),'g--*');
hold on;
plot(x,nn_6_h3n8_4_outputs(2,:),'b--o');
hold off;
xlabel('Days');
xlim([2 30]);
ylabel('Wind Speed (km/h)');
title('Wind Speed over June');
legend('Actual','Predicted');

% UIWAIT makes openWind wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = openWind_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

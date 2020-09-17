function varargout = openRainfall(varargin)
% OPENRAINFALL MATLAB code for openRainfall.fig
%      OPENRAINFALL, by itself, creates a new OPENRAINFALL or raises the existing
%      singleton*.
%
%      H = OPENRAINFALL returns the handle to a new OPENRAINFALL or the handle to
%      the existing singleton*.
%
%      OPENRAINFALL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in OPENRAINFALL.M with the given input arguments.
%
%      OPENRAINFALL('Property','Value',...) creates a new OPENRAINFALL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before openRainfall_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to openRainfall_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help openRainfall

% Last Modified by GUIDE v2.5 01-Sep-2019 21:33:51

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @openRainfall_OpeningFcn, ...
                   'gui_OutputFcn',  @openRainfall_OutputFcn, ...
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


% --- Executes just before openRainfall is made visible.
function openRainfall_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to openRainfall (see VARARGIN)

% Choose default command line output for openRainfall
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);


actualData = varargin{1};
nn_6_h3n8_4_outputs = varargin{2};

x = 2:30; % the days being predicted

% start plotting rainfall
axes(handles.axes1)
plot(x,actualData(5,:),'g--*');
hold on;
plot(x,nn_6_h3n8_4_outputs(4,:),'b--o');
hold off;
xlabel('Days');
xlim([2 30]);
xlabel('Days');
ylabel('Rainfall (mm)');
title('Rainfall over June');
legend('Actual','Predicted');

% UIWAIT makes openRainfall wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = openRainfall_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

function varargout = openHumid(varargin)
% OPENHUMID MATLAB code for openHumid.fig
%      OPENHUMID, by itself, creates a new OPENHUMID or raises the existing
%      singleton*.
%
%      H = OPENHUMID returns the handle to a new OPENHUMID or the handle to
%      the existing singleton*.
%
%      OPENHUMID('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in OPENHUMID.M with the given input arguments.
%
%      OPENHUMID('Property','Value',...) creates a new OPENHUMID or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before openHumid_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to openHumid_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help openHumid

% Last Modified by GUIDE v2.5 01-Sep-2019 21:32:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @openHumid_OpeningFcn, ...
                   'gui_OutputFcn',  @openHumid_OutputFcn, ...
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


% --- Executes just before openHumid is made visible.
function openHumid_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to openHumid (see VARARGIN)

% Choose default command line output for openHumid
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);


actualData = varargin{1};
nn_6_h3n8_4_outputs = varargin{2};

x = 2:30; % the days being predicted

% start plotting humidity
axes(handles.axes1)
plot(x,actualData(4,:),'g--*');
hold on;
plot(x,nn_6_h3n8_4_outputs(3,:),'b--o');
hold off;
xlabel('Days');
xlim([2 30]);
ylabel('Humidity (%)');
title('Humidity over June');
legend('Actual','Predicted');

% UIWAIT makes openHumid wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = openHumid_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

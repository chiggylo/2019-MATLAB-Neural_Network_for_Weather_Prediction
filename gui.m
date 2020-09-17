function varargout = gui(varargin)
% GUI MATLAB code for gui.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui

% Last Modified by GUIDE v2.5 02-Sep-2019 18:45:00

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_OutputFcn, ...
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


load('trainednn2.mat', 'actualData', 'nn_6_h3n8_4_outputs','nn_6_h3n8_4');

% --- Executes just before gui is made visible.
function gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui (see VARARGIN)

% Choose default command line output for gui
handles.output = hObject;

% create an axes that spans the whole gui
ah = axes('unit', 'normalized', 'position', [0 0 1 1]); 
% import the background image and show it on the axes
bg = imread('background.jpg'); imagesc(bg);
% prevent plotting over the background and turn the axis off
set(ah,'handlevisibility','off','visible','off')
% making sure the background is behind all the other uicontrols
uistack(ah, 'bottom');


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% load result from nn
load('trainednn2.mat', 'actualData', 'nn_6_h3n8_4_outputs','nn_6_h3n8_4');
handles.nn_6_h3n8_4_outputs = nn_6_h3n8_4_outputs;
handles.actualData = actualData;
handles.nn_6_h3n8_4 = nn_6_h3n8_4;
x = 2:30; % the days being predicted

% start plotting temperature
axes(handles.axes-1)
plot(x,actualData(1,:),'g--*');
hold on;
plot(x,nn_6_h3n8_4_outputs(1,:),'b--o');
hold off;
xlabel('Days');
xlim([2 30]);
yticks(25:0.5:30);
ylabel('Celcius');
title('Temperature over June');
legend('Actual','Predicted');

% start plotting wind
axes(handles.axes2)
plot(x,actualData(3,:),'g--*');
hold on;
plot(x,nn_6_h3n8_4_outputs(2,:),'b--o');
hold off;
xlabel('Days');
xlim([2 30]);
ylabel('Wind Speed (km/h)');
title('Wind Speed over June');
legend('Actual','Predicted');



% start plotting humidity
axes(handles.axes3)
plot(x,actualData(4,:),'g--*');
hold on;
plot(x,nn_6_h3n8_4_outputs(3,:),'b--o');
hold off;
xlabel('Days');
xlim([2 30]);
ylabel('Humidity (%)');
title('Humidity over June');
legend('Actual','Predicted');


% start plotting rainfall
axes(handles.axes4)
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

% start plotting watering
% send to fuzzy logic
% load fuzzy
fis = readfis('sprinkler2');
evaluate = [nn_6_h3n8_4_outputs(1,:).' nn_6_h3n8_4_outputs(2,:).' nn_6_h3n8_4_outputs(3,:).'*100 nn_6_h3n8_4_outputs(4,:).'];
result = evalfis(fis, evaluate);

axes(handles.axes5)
plot(x, result)
xlabel('Days');
xlim([2 30]);
xlabel('Days');
ylabel('Water Amount (mm)');
title('Watering over June');


handles.result = result;
guidata(hObject,handles);





% --- Outputs from this function are returned to the command line.
function varargout = gui_OutputFcn(hObject, eventdata, handles) 
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
% get parameters
temp = get(handles.tempValue, 'String');
humid = get(handles.humidValue, 'String');
rainfall = get(handles.rainfallValue, 'String');
windspeed = get(handles.windValue, 'String');
contents = get(handles.dayValue,'String');
day = contents{get(handles.dayValue,'Value')};

% error checking values
[temp, status1] = str2num(temp);
[humid, status2] = str2num(humid);
[rainfall, status3] = str2num(rainfall);
[windspeed, status4] = str2num(windspeed);
day = str2num(day);

endEvent = 0;

if ~status1 
    set(handles.tempValue,'String','numbers only')
    endEvent = 1;
end

if ~status2
    set(handles.humidValue,'String','numbers only')
    endEvent = 1;
end

if ~status3 
    set(handles.rainfallValue,'String','numbers only')
    endEvent = 1;
end

if ~status4
    set(handles.windspeedValue,'String','numbers only')
    endEvent = 1;
end

if endEvent
    return
else
    set(handles.tempRate, 'String', 'Predicting...');
    set(handles.windRate, 'String', 'Predicting...');
    set(handles.humidRate, 'String', 'Predicting...');
    set(handles.rainfallRate, 'String', 'Predicting...');
    set(handles.waterRate, 'String', 'Predicting...');
    % load data
    actualData = handles.actualData;
    nn_6_h3n8_4 = handles.nn_6_h3n8_4;
  	nn_6_h3n8_4_outputs = handles.nn_6_h3n8_4_outputs;
    result = handles.result;
    
    %send to nn
    x = 2:30;
    prediction = nn_6_h3n8_4([2019;day;temp;windspeed;humid;rainfall]);
    
    % display change rate
    tempTxt = sprintf('%.2f -> %.2f', nn_6_h3n8_4_outputs(1,day+1), prediction(1));
    
    windTxt = sprintf('%.2f -> %.2f', nn_6_h3n8_4_outputs(2,day+1), prediction(2));
    
    humidTxt = sprintf('%.2f -> %.2f', nn_6_h3n8_4_outputs(3,day+1), prediction(3));
    
    rainfallTxt = sprintf('%.2f -> %.2f', nn_6_h3n8_4_outputs(4,day+1), prediction(4));
    
    % change values to be regraph
    nn_6_h3n8_4_outputs(1,day+1) = prediction(1);
    nn_6_h3n8_4_outputs(2,day+1) = prediction(2);
    nn_6_h3n8_4_outputs(3,day+1) = prediction(3);
    nn_6_h3n8_4_outputs(4,day+1) = prediction(4);
    
    % start plotting temperature
    axes(handles.axes1)
    refresh;
    plot(x,actualData(1,:),'g--*');
    hold on;
    plot(x,nn_6_h3n8_4_outputs(1,:),'b--o');
    hold off;
    xlabel('Days');
    xlim([2 30]);
    yticks(25:0.5:30);
    ylabel('Celcius');
    title('Temperature over June');
    legend('Actual','Predicted');
    set(handles.tempRate, 'String', tempTxt);
    
    % start plotting wind
    axes(handles.axes2)
    plot(x,actualData(3,:),'g--*');
    hold on;
    plot(x,nn_6_h3n8_4_outputs(2,:),'b--o');
    hold off;
    xlabel('Days');
    xlim([2 30]);
    ylabel('Wind Speed (km/h)');
    title('Wind Speed over June');
    legend('Actual','Predicted');
    set(handles.windRate, 'String', windTxt);

    % start plotting humidity
    axes(handles.axes3)
    plot(x,actualData(4,:),'g--*');
    hold on;
    plot(x,nn_6_h3n8_4_outputs(3,:),'b--o');
    hold off;
    xlabel('Days');
    xlim([2 30]);
    ylabel('Humidity (%)');
    title('Humidity over June');
    legend('Actual','Predicted');
    set(handles.humidRate, 'String', humidTxt);
    
    
    % start plotting rainfall
    axes(handles.axes4)
    plot(x,actualData(5,:),'g--*');
    hold on;
    plot(x,nn_6_h3n8_4_outputs(4,:),'b--o');
    hold off;
    xlabel('Days');
    xlim([2 30]);
    ylabel('Rainfall (mm)');
    title('Rainfall over June');
    legend('Actual','Predicted');
    set(handles.rainfallRate, 'String', rainfallTxt);
    
    % save new change values
    handles.nn_6_h3n8_4_outputs = nn_6_h3n8_4_outputs;
  
    
    
    %send to fuzzy logic
    %load fuzzy
    fis = readfis('sprinkler2');
    evaluate = [nn_6_h3n8_4_outputs(1,:).' nn_6_h3n8_4_outputs(2,:).' nn_6_h3n8_4_outputs(3,:).'*100 nn_6_h3n8_4_outputs(4,:).'];
    results = evalfis(fis, evaluate);
    
    axes(handles.axes5)
    plot(x, results)
    xlabel('Days');
    xlim([2 30]);
    xlabel('Days');
    ylabel('Water Amount (mm)');
    title('Watering over June');
    
    
    waterTxt = sprintf('%.2f -> %.2f', result(day+1), results(day+1));
    set(handles.waterRate, 'String', waterTxt);
    handles.result = results;
    guidata(hObject,handles);
end



function tempValue_Callback(hObject, eventdata, handles)
% hObject    handle to tempValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tempValue as text
%        str2double(get(hObject,'String')) returns contents of tempValue as a double


% --- Executes during object creation, after setting all properties.
function tempValue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tempValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function windValue_Callback(hObject, eventdata, handles)
% hObject    handle to windValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of windValue as text
%        str2double(get(hObject,'String')) returns contents of windValue as a double


% --- Executes during object creation, after setting all properties.
function windValue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to windValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function humidValue_Callback(hObject, eventdata, handles)
% hObject    handle to humidValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of humidValue as text
%        str2double(get(hObject,'String')) returns contents of humidValue as a double


% --- Executes during object creation, after setting all properties.
function humidValue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to humidValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function rainfallValue_Callback(hObject, eventdata, handles)
% hObject    handle to rainfallValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of rainfallValue as text
%        str2double(get(hObject,'String')) returns contents of rainfallValue as a double


% --- Executes during object creation, after setting all properties.
function rainfallValue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rainfallValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in dayValue.
function dayValue_Callback(hObject, eventdata, handles)
% hObject    handle to dayValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns dayValue contents as cell array
%        contents{get(hObject,'Value')} returns selected item from dayValue


% --- Executes during object creation, after setting all properties.
function dayValue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dayValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function tempValueMin_Callback(hObject, eventdata, handles)
% hObject    handle to tempValueMin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tempValueMin as text
%        str2double(get(hObject,'String')) returns contents of tempValueMin as a double


% --- Executes during object creation, after setting all properties.
function tempValueMin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tempValueMin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.tempRate, 'String', 'Resetting...');
set(handles.windRate, 'String', 'Resetting...');
set(handles.humidRate, 'String', 'Resetting...');
set(handles.rainfallRate, 'String', 'Resetting...');
set(handles.waterRate, 'String', 'Resetting...');

load('trainednn2.mat', 'nn_6_h3n8_4_outputs');
handles.nn_6_h3n8_4_outputs = nn_6_h3n8_4_outputs;


actualData = handles.actualData;
x = 2:30; % the days being predicted

% start plotting temperature
axes(handles.axes1)
plot(x,actualData(1,:),'g--*');
hold on;
plot(x,nn_6_h3n8_4_outputs(1,:),'b--o');
hold off;
xlabel('Days');
xlim([2 30]);
yticks(25:0.5:30);
ylabel('Celcius');
title('Temperature over June');
legend('Actual','Predicted');
set(handles.tempRate, 'String', 'Completed');


% start plotting wind
axes(handles.axes2)
plot(x,actualData(3,:),'g--*');
hold on;
plot(x,nn_6_h3n8_4_outputs(2,:),'b--o');
hold off;
xlabel('Days');
xlim([2 30]);
ylabel('Wind Speed (km/h)');
title('Wind Speed over June');
legend('Actual','Predicted');
set(handles.windRate, 'String', 'Completed');


% start plotting humidity
axes(handles.axes3)
plot(x,actualData(4,:),'g--*');
hold on;
plot(x,nn_6_h3n8_4_outputs(3,:),'b--o');
hold off;
xlabel('Days');
xlim([2 30]);
ylabel('Humidity (%)');
title('Humidity over June');
legend('Actual','Predicted');
set(handles.humidRate, 'String', 'Completed');

% start plotting rainfall
axes(handles.axes4)
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
set(handles.rainfallRate, 'String', 'Completed');

% start plotting watering
% send to fuzzy logic
% load fuzzy
fis = readfis('sprinkler2');
evaluate = [nn_6_h3n8_4_outputs(1,:).' nn_6_h3n8_4_outputs(2,:).' nn_6_h3n8_4_outputs(3,:).'*100 nn_6_h3n8_4_outputs(4,:).'];
result = evalfis(fis, evaluate);

axes(handles.axes5)
plot(x, result)
xlabel('Days');
xlim([2 30]);
xlabel('Days');
ylabel('Water Amount (mm)');
title('Watering over June');
set(handles.waterRate, 'String', 'Completed');
handles.result = result;
guidata(hObject,handles);



% --- Executes on button press in tempGraph.
function tempGraph_Callback(hObject, eventdata, handles)
% load data to be sent
actualData = handles.actualData;
nn_6_h3n8_4_outputs = handles.nn_6_h3n8_4_outputs;
openTemp(actualData, nn_6_h3n8_4_outputs);
% hObject    handle to tempGraph (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in windGraph.
function windGraph_Callback(hObject, eventdata, handles)
% load data to be sent
actualData = handles.actualData;
nn_6_h3n8_4_outputs = handles.nn_6_h3n8_4_outputs;
openWind(actualData, nn_6_h3n8_4_outputs);
% hObject    handle to windGraph (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in humidGraph.
function humidGraph_Callback(hObject, eventdata, handles)
% load data to be sent
actualData = handles.actualData;
nn_6_h3n8_4_outputs = handles.nn_6_h3n8_4_outputs;
openHumid(actualData, nn_6_h3n8_4_outputs);
% hObject    handle to humidGraph (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in rainfallGraph.
function rainfallGraph_Callback(hObject, eventdata, handles)
% load data to be sent
actualData = handles.actualData;
nn_6_h3n8_4_outputs = handles.nn_6_h3n8_4_outputs;
openRainfall(actualData, nn_6_h3n8_4_outputs);
% hObject    handle to rainfallGraph (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function axes6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes6
axes(hObject)
imshow('background.jpg');

function varargout = realtime_acc_gui(varargin)
% REALTIME_ACC_GUI MATLAB code for realtime_acc_gui.fig
%      REALTIME_ACC_GUI, by itself, creates a new REALTIME_ACC_GUI or raises the existing
%      singleton*.
%
%      H = REALTIME_ACC_GUI returns the handle to a new REALTIME_ACC_GUI or the handle to
%      the existing singleton*.
%
%      REALTIME_ACC_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in REALTIME_ACC_GUI.M with the given input arguments.
%
%      REALTIME_ACC_GUI('Property','Value',...) creates a new REALTIME_ACC_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before realtime_acc_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to realtime_acc_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help realtime_acc_gui

% Last Modified by GUIDE v2.5 11-Mar-2018 17:30:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @realtime_acc_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @realtime_acc_gui_OutputFcn, ...
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


% --- Executes just before realtime_acc_gui is made visible.
function realtime_acc_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to realtime_acc_gui (see VARARGIN)

% Choose default command line output for realtime_acc_gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes realtime_acc_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = realtime_acc_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in push_start.
function push_start_Callback(hObject, eventdata, handles)
% hObject    handle to push_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
IP=get(handles.edit_IP,'String');
num_sensors=get(handles.popup_sensors,'Value');
indicador=get(handles.popup_alarm,'Value')-1;
modulo=get(handles.radio_module,'Value');

name1=get(handles.edit_sensor1,'String');
name2=get(handles.edit_sensor2,'String');
name3=get(handles.edit_sensor3,'String');
name4=get(handles.edit_sensor4,'String');
name_sensors=[name1;name2;name3;name4];

lim1=str2num(get(handles.edit_limit1,'String'));
lim2=str2num(get(handles.edit_limit2,'String'));
lim3=str2num(get(handles.edit_limit3,'String'));
lim4=str2num(get(handles.edit_limit4,'String'));
limiteacc=[lim1;lim2;lim3;lim4];

guardar=get(handles.radio_save,'Value');
namefile=get(handles.edit_namefile,'String');

real_time_data_stream_plotting(IP,num_sensors,indicador,modulo,limiteacc,name_sensors,guardar,namefile)

% --- Executes on selection change in popup_sensors.
function popup_sensors_Callback(hObject, eventdata, handles)
% hObject    handle to popup_sensors (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popup_sensors contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popup_sensors


% --- Executes during object creation, after setting all properties.
function popup_sensors_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popup_sensors (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popup_alarm.
function popup_alarm_Callback(hObject, eventdata, handles)
% hObject    handle to popup_alarm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popup_alarm contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popup_alarm


% --- Executes during object creation, after setting all properties.
function popup_alarm_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popup_alarm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_IP_Callback(hObject, eventdata, handles)
% hObject    handle to edit_IP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_IP as text
%        str2double(get(hObject,'String')) returns contents of edit_IP as a double


% --- Executes during object creation, after setting all properties.
function edit_IP_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_IP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_limit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit_limit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_limit4 as text
%        str2double(get(hObject,'String')) returns contents of edit_limit4 as a double


% --- Executes during object creation, after setting all properties.
function edit_limit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_limit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_limit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_limit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_limit2 as text
%        str2double(get(hObject,'String')) returns contents of edit_limit2 as a double


% --- Executes during object creation, after setting all properties.
function edit_limit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_limit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_limit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit_limit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_limit3 as text
%        str2double(get(hObject,'String')) returns contents of edit_limit3 as a double


% --- Executes during object creation, after setting all properties.
function edit_limit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_limit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_limit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_limit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_limit1 as text
%        str2double(get(hObject,'String')) returns contents of edit_limit1 as a double


% --- Executes during object creation, after setting all properties.
function edit_limit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_limit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_sensor1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_sensor1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_sensor1 as text
%        str2double(get(hObject,'String')) returns contents of edit_sensor1 as a double


% --- Executes during object creation, after setting all properties.
function edit_sensor1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_sensor1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_sensor3_Callback(hObject, eventdata, handles)
% hObject    handle to edit_sensor3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_sensor3 as text
%        str2double(get(hObject,'String')) returns contents of edit_sensor3 as a double


% --- Executes during object creation, after setting all properties.
function edit_sensor3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_sensor3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_sensor2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_sensor2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_sensor2 as text
%        str2double(get(hObject,'String')) returns contents of edit_sensor2 as a double


% --- Executes during object creation, after setting all properties.
function edit_sensor2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_sensor2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_sensor4_Callback(hObject, eventdata, handles)
% hObject    handle to edit_sensor4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_sensor4 as text
%        str2double(get(hObject,'String')) returns contents of edit_sensor4 as a double


% --- Executes during object creation, after setting all properties.
function edit_sensor4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_sensor4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in radio_module.
function radio_module_Callback(hObject, eventdata, handles)
% hObject    handle to radio_module (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radio_module


% --- Executes on button press in radio_3axes.
function radio_3axes_Callback(hObject, eventdata, handles)
% hObject    handle to radio_3axes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radio_3axes


% --- Executes on button press in radio_save.
function radio_save_Callback(hObject, eventdata, handles)
% hObject    handle to radio_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radio_save



function edit_namefile_Callback(hObject, eventdata, handles)
% hObject    handle to edit_namefile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_namefile as text
%        str2double(get(hObject,'String')) returns contents of edit_namefile as a double


% --- Executes during object creation, after setting all properties.
function edit_namefile_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_namefile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function real_time_data_stream_plotting(IP,num_sensors,indicador,modulo,limiteacc,name_sensors,guardar,namefile)

% CHANGE THIS TO THE IP OF THE COMPUTER RUNNING THE TRIGNO CONTROL UTILITY
HOST_IP =IP;
%%
%This example program communicates with the Delsys SDK to stream 48 channels of ACC data.
global NUM_SENSORS
NUM_SENSORS = num_sensors; %numero de sensores trabajando, maximo 4

global INDICATOR %cuando INDICATOR= 1 suena solamente el sensor 1, si el INDICATOR=2 suena solamente el sensor 2
INDICATOR=indicador;     %si el INDICATOR=3 suena solamente el sensor 3, si el INDICATOR=4 suena solamente el sensor 4
                 %si el INDICATOR=5 suenan todos los sensores; con INDICATOR=0 no suena ninguno

global MODULO 
MODULO= modulo; %Si MODULO=true se grafica el MODULO (o magnitud) de la aceleracion resultante (suma de los 3 ejes)
                     %Si MODULO=false se grafica cada eje de aceleracion por separado (x,y,z del sensor) 
                 
global limiteACC
limiteACC=limiteacc;   %rango en el cual se quiere trabajar, si se sobrepasa para arriba o hacia abajo suena la alarma


marcadorACC=5;  %para mayores de 10, es necesario ajustar usando el zoom de la ventana


global NAME_SENSOR %Puede modificar el nombre que muestra cada plot de sensor
% NAME_SENSOR= ['Sensor 1';'Sensor 2';'Sensor 3';'Sensor 4'];
NAME_SENSOR= name_sensors;

global SAVE %si SAVE=true se activa la funcion para guardar datos a un .csv
SAVE=guardar;

global FILENAME %entrega el nombre del archivo .csv al que se guardara (si ya existe, se sobre-escribe)
FILENAME=namefile;

global PICKS %%%%activa la funcion de deteccion de picks (no finalizada)
PICKS=false;

global TiempoACC
TiempoACC=3;  %intervalo de tiempo en segundos de ploteo de señal ACC

global time %lleva el tiempo en segundos de los datos, para guardar .csv
time=0;

global conts %contador para sonido
conts=20;

%%%% variables para deteccion de picks, comentadas ya que no se finalizó, y gastan recursos
% global T %vector tiempo 
% T=0:0.00675:TiempoACC*153*0.00675;
% global cont %contador
% cont=0;
% global cont2 %otro contador
% cont2=0;
% global step %se detectó o no un paso
% step=false;
% global buff %está activado el buffer
% buff=false;
% global E %vector de eventos E(1,:) contiene los picks, E(2,:) contiene los tiempos en los que ocurrieron
% E=[];
% global changearray %guarda el largo data_arrayACC para saber cuando es constante
% changearray=0;
%%%%



%% Create the required objects

global beep
global bleep
beep= audioread('beep.wav'); %abre un sonido determinado, este archivo debe estar en la misma carpeta que el codigo matlab
beep=beep(1:end)';
bleep=audioread('bleep.wav');
bleep=bleep(1:end)';

%matriz de ploteo en la ventana a*b siendo a el numero de graficos por linea y b la cantidad de filas
if (NUM_SENSORS == 1)
    a=1;
    b=1;
end

if (NUM_SENSORS == 2)
    a=1;    %a=2 y b=1 plotea un grafico arriba de otro
    b=2;    %a=1 y b=2 plotea ambos graficos uno al lado del otro
end

if (NUM_SENSORS == 3 || NUM_SENSORS == 4)
    a=2;    %plotea graficos en cuadricula 2x2
    b=2;    
end

%handles to all plots
global plotHandlesACC;
plotHandlesACC = zeros(NUM_SENSORS*3, 1);

%TCPIP Connection to stream ACC Data
interfaceObjectACC = tcpip(HOST_IP,50042);
interfaceObjectACC.InputBufferSize = 6400;

%TCPIP Connection to communicate with SDK, send/receive commands
commObject = tcpip(HOST_IP,50040);

%Timer object for drawing plots.   timer llama @updatePlots cada 0,1 segundos
t = timer('Period', 0.001 , 'ExecutionMode', 'fixedSpacing', 'TimerFcn', {@updatePlots});%0.1
global data_arrayACC
data_arrayACC = [];

%% Set up the plots

axesHandlesACC = zeros(NUM_SENSORS,1);

%initiate the ACC figure
figureHandleACC = figure('Name', 'ACC Real Time', 'Numbertitle', 'off', 'CloseRequestFcn', {@localCloseFigure, interfaceObjectACC, commObject, t});
set(figureHandleACC, 'position', [0 0 2000 750]);

% Hace mas ancho los plots cambiando la posicion y tamaño
if NUM_SENSORS==1
    pos=[0.02 0.01 1/b-0.05 1/a-0.05];
elseif NUM_SENSORS==2
    pos=[0.02 0.01 1/b-0.05 1/a-0.05; 1/b+0.01 0.01 1/b-0.05 1/a-0.05];
else
    pos=[0.02 1/a 1/b-0.05 1/a-0.05; 1/b+0.01 1/a 1/b-0.05 1/a-0.05; 0.02 0.01 1/b-0.05 1/a-0.05; 1/b+0.01 0.01 1/b-0.05 1/a-0.05];
end

color='gbgb'; %colores para MODULO activado

for i= 1:NUM_SENSORS
    axesHandlesACC(i) = subplot('position', pos(i,:));
    hold on
    plotHandlesACC(i*3-2) = plot(axesHandlesACC(i), 0, '-y', 'LineWidth', 2);  
    plotHandlesACC(i*3-1) = plot(axesHandlesACC(i), 0, '-y', 'LineWidth', 2);   
    plotHandlesACC(i*3) = plot(axesHandlesACC(i), 0, '-y', 'LineWidth', 2);
    hold off     
    if MODULO
        set(plotHandlesACC(i*3-2), 'Color', color(i))
    else
        set(plotHandlesACC(i*3-2), 'Color', 'r')% eje X respecto del trigno
        set(plotHandlesACC(i*3-1), 'Color', 'b')% eje Y respecto del trigno
        set(plotHandlesACC(i*3), 'Color', 'g')  % eje Z respecto del trigno
        legend(axesHandlesACC(i),'eje x','eje y','eje z','autoupdate','off');
    end
    set(axesHandlesACC(i),'YGrid','on');
    set(axesHandlesACC(i),'GridColor',[1 1 1]);
    set(axesHandlesACC(i),'XGrid','off');
    set(axesHandlesACC(i),'YMinorGrid','on');
    set(axesHandlesACC(i),'MinorGridColor',[1 1 1]);
    set(axesHandlesACC(i),'YColor',[0 0 0]);
    
    set(axesHandlesACC(i),'XColor','none');
    set(axesHandlesACC(i),'Color',[.15 .15 .15]);
    if MODULO
        set(axesHandlesACC(i),'YLim', [-1 marcadorACC+0.5]);%-9 a 9
    else
        set(axesHandlesACC(i),'YLim', [-marcadorACC-0.5 marcadorACC+0.5]);%-9 a 9
    end
    set(axesHandlesACC(i),'YLimMode', 'manual');
    set(axesHandlesACC(i),'XLim', [0 150*TiempoACC]);%-50 a 2000
    set(axesHandlesACC(i),'XLimMode', 'manual');
    hline=refline(axesHandlesACC(i),[0 limiteACC(i)]);     
    yline=refline(axesHandlesACC(i),[0 -limiteACC(i)]);    
    set(hline,'color','w', 'LineWidth',2);
    set(yline,'color','w','LineWidth',2); 
    
    title(sprintf(NAME_SENSOR(i,:))) 

end

%Si SAVE=true, crea un archivo .csv para luego guardar los datos
if SAVE
    cHeader = {'Time'};
    if MODULO
        for i= 1:NUM_SENSORS
            cHeader = [cHeader {['Sensor' num2str(i) 'ACCModule']}];
        end
    else
        for i= 1:NUM_SENSORS
            cHeader = [cHeader {['Sensor' num2str(i) 'ACCX']} {['Sensor' num2str(i) 'ACCY']} {['Sensor' num2str(i) 'ACCZ']}];
        end
    end
    commaHeader = [cHeader;repmat({','},1,numel(cHeader))]; 
    commaHeader = commaHeader(:)';
    textHeader = cell2mat(commaHeader); 
    
    %write header to file
    fid = fopen([FILENAME '.csv'],'w');
    fprintf(fid,'%s\n',textHeader);
    fclose(fid);
end




%%Open the COM interface, determine RATE

fopen(commObject);

pause(1);
fread(commObject,commObject.BytesAvailable);
fprintf(commObject, sprintf(['RATE 2000\r\n\r']));
pause(1);
fread(commObject,commObject.BytesAvailable);
fprintf(commObject, sprintf(['RATE?\r\n\r']));
pause(1);
data = fread(commObject,commObject.BytesAvailable);

%% Setup interface object to read chunks of data
% Define a callback function to be executed when desired number of bytes
% are available in the input buffer
 
 bytesToReadACC = 384;%384 para 16 canales
interfaceObjectACC.BytesAvailableFcn = {@localReadAnPlotMultiplexedACC, plotHandlesACC, bytesToReadACC};
interfaceObjectACC.BytesAvailableFcnMode = 'byte';
interfaceObjectACC.BytesAvailableFcnCount = bytesToReadACC;

drawnow
start(t);

%pause(1);
%% 
% Open the interface object
try
    fopen(interfaceObjectACC);
catch
    localCloseFigure(figureHandleACC,1 ,interfaceObjectACC, commObject, t);
    error('CONNECTION ERROR: Please start the Delsys Trigno Control Application and try again');
end



%%
% Send the commands to start data streaming
fprintf(commObject, sprintf(['START\r\n\r']));


%%
% Display the plot

%snapnow;

%% Implement the bytes available callback
%The localReadandPlotMultiplexed functions check the input buffers for the
%amount of available data, mod this amount to be a suitable multiple.

%Because of differences in sampling frequency between EMG and ACC data, the
%ratio of EMG samples to ACC samples is 13.5:1

%We use a ratio of 27:2 in order to keep a whole number of samples.  
%The EMG buffer is read in numbers of bytes that are divisible by 1728 by the
%formula (27 samples)*(4 bytes/sample)*(16 channels)
%The ACC buffer is read in numbers of bytes that are divisible by 384 by
%the formula (2 samples)*(4 bytes/sample)*(48 channels)
%Reading data in these amounts ensures that full packets are read.  The 
%size limits on the dataArray buffers is to ensure that there is always one second of
%data for all 16 sensors (EMG and ACC) in the dataArray buffers

function localReadAnPlotMultiplexedACC(interfaceObjectACC, ~, ~, ~, ~)
global beep
global bleep
global NUM_SENSORS
global MODULO

bytesReady = interfaceObjectACC.BytesAvailable;
bytesReady = bytesReady - mod(bytesReady, 384);

if(bytesReady == 0)
    return
end
global data_arrayACC
global limiteACC
data = cast(fread(interfaceObjectACC, bytesReady), 'uint8');
data= typecast(data, 'single');

%si MODULO=true reemplaza los datos del eje x por el MODULO
if (MODULO)
    for i= 1:length(data)/3
        asd=abs(sqrt(data(i*3-2)*data(i*3-2) + data(i*3-1)*data(i*3-1) + data(i*3)*data(i*3))-1); %-1 para restarle la gravedad (aprox)
        if asd<0.1 %elimina el ruido
            data(i*3-2)=0;
        else
            data(i*3-2)=asd;
        end
    end
end

global SAVE
global time
global FILENAME
%global PICKS

%si SAVE=true guarda los datos en el archivo, a medida que los recibe
if SAVE
    nd=length(data)/48;
    for i=1:nd
        time=time+0.00675;
        wdata=zeros(nd,NUM_SENSORS+1);
        if ~MODULO
            wdata=zeros(nd,NUM_SENSORS*3+1);            
        end
        wdata(i,1)=time;
        for j=1:NUM_SENSORS
            if MODULO
                wdata(i,j+1)=data((j*3-2)+(i-1)*48);
            else
                wdata(i,j*3-2+1:j*3+1)=[data((j*3-2)+(i-1)*48) data((j*3-1)+(i-1)*48) data((j*3)+(i-1)*48)];
            end
        end
    end
    dlmwrite([FILENAME '.csv'],wdata,'-append')
end

global INDICATOR

%dependiendo del valor de INDICATOR, ejecuta el "beep o bleep" cuando corresponde
%para sensores 1 y 3 ejecuta beep, para 2 y 4, bleep
global conts
conts=conts+1;
if conts>5 %contador para sonido
    if INDICATOR==0
    elseif INDICATOR==1 || INDICATOR==3
        if data(INDICATOR*3-2)>limiteACC(INDICATOR) || data(INDICATOR*3-2)<-limiteACC(INDICATOR)     
            soundsc(beep,100000,8); 
            conts=0;
        end
        if ~MODULO      %si se plotean todos los ejes (x,y,z) , se ejecuta el sonido en todos ellos
            if data(INDICATOR*3-1)>limiteACC(INDICATOR) || data(INDICATOR*3-1)<-limiteACC(INDICATOR)     
                soundsc(beep,100000,8);  
                conts=0;
            end
            if data(INDICATOR*3)>limiteACC(INDICATOR) || data(INDICATOR*3)<-limiteACC(INDICATOR)
                soundsc(beep,100000,8);
                conts=0;
            end
        end
    elseif INDICATOR==2 || INDICATOR==4
        if data(INDICATOR*3-2)>limiteACC(INDICATOR) || data(INDICATOR*3-2)<-limiteACC(INDICATOR)     
            soundsc(bleep,100000,8); 
            conts=0;
        end
        if ~MODULO      %si se plotean todos los ejes (x,y,z) , se ejecuta el sonido en todos ellos
            if data(INDICATOR*3-1)>limiteACC(INDICATOR) || data(INDICATOR*3-1)<-limiteACC(INDICATOR)     
                soundsc(bleep,100000,8);  
                conts=0;
            end
            if data(INDICATOR*3)>limiteACC(INDICATOR) || data(INDICATOR*3)<-limiteACC(INDICATOR)
                soundsc(bleep,100000,8);
                conts=0;
            end
        end
    elseif INDICATOR==5
        for i=1:NUM_SENSORS
            if i==1 ||i==3
                if data(i*3-2)>limiteACC(i) || data(i*3-2)<-limiteACC(i)     
                soundsc(beep,100000,8);
                conts=0; 
                end
            end
            if i==2 ||i==4
                if data(i*3-2)>limiteACC(i) || data(i*3-2)<-limiteACC(i)     
                soundsc(bleep,100000,8);
                conts=0; 
                end
            end
        end
        if ~MODULO     
            if i==1 || i==3
                if data(i*3-1)>limiteACC(i) || data(i*3-1)<-limiteACC(i)     
                    soundsc(beep,100000,8);    
                    conts=0;
                end
                if data(i*3)>limiteACC(i) || data(i*3)<-limiteACC(i)
                    soundsc(beep,100000,8);
                    conts=0;
                end
            end
            if i==2 || i==4
                if data(i*3-1)>limiteACC(i) || data(i*3-1)<-limiteACC(i)     
                    soundsc(bleep,100000,8);    
                    conts=0;
                end
                if data(i*3)>limiteACC(i) || data(i*3)<-limiteACC(i)
                    soundsc(bleep,100000,8);
                    conts=0;
                end
            end
        end
    end
end

global TiempoACC %cantidad de segundos de la muestra ACC


if(size(data_arrayACC, 1) < 7296*TiempoACC) %si el tamaño de muestra es menor a la cantidad de muestras aceptadas por periodo (en este casi 7296datos/segundos*4segundos)
    data_arrayACC = [data_arrayACC; data];  % se le agregan los nuevos datos recibidos hasta compeletar el periodo indicado 
else                                        %si el tamaño de datos guardados supera el periodo:
    data_arrayACC = [data_arrayACC(size(data, 1) + 1:size(data_arrayACC, 1)); data];
end                                         %reemplaza los datos mas viejos por datos nuevos (concatenndo matrices)

%%%% seccion de codigo que detecta picks, no está completamente funcionando
%%%% por lo que está comentada, para no gastar recursos innecesarios
%%%% hay un prototipo funcional en 'heeltest.m', el cual simula un flujo de
%%%% datos real y detecta picks, es simple y entendible que este 
% global E
% global changearray
% dt=TiempoACC*152-1; %148 datos/seg aprox
% global cont
% global cont2
% global step
% global buff
% global periodo
% global amplitud
% global T
% 
% %fix en caso de que el largo de data_arrayACC(1:48:end) no concuerde con el de T
% if changearray==length(data_arrayACC(1:48:end))
%     T=0:0.00675:0.00675*(length(data_arrayACC(1:48:end))-1);
% end
% 
% %%Seccion de codigo que detecta picks en la señal, e identifica como pasos
% %funciona con una mezcla de deteccion de heel-strike "offline" y "online"(no usa internet)
% %OFFLINE: toma la ultima muestra de datos guardada (data_arrayACC(x:48:end))
% %y busca picks en señal, si cumplen con condiciones para un "paso constante"
% %el programa los reconoce, agrega a eventos (E) y calcula amplitud promedio y periodo
% %una vez hecho pasa a "online", para reducir costo en tiempo de calculos
% %ONLINE: teniendo una amplitud promedio y periodo de paso, el programa predice 
% %la posicion del siguiente paso con una holgura de periodo/3, si encuentra un valor cercano
% %a la amplitud promedio, usa una pequeña vecindad para buscar el mayor pick
% %el cual agrega a eventos, para luego recalcular amplitud y periodo, de acuerdo al nuevo pick.
% %Si no logra encontrar un pick aceptable, pasa nuevamente a OFFLINE
% if length(T)<=length(data_arrayACC(1:48:end)) && MODULO && PICKS
%     T=[T(2:end) T(end)+0.00675];
%     M=data_arrayACC(1:48:end);
%     cont=cont+1;
%     if ~step && cont>=60 %x seg aprox
%         [~,~,~,proms] = findpeaks(M,T);
%         mx=max(proms);
%         [pks, locs] = findpeaks(M,T,'MinPeakProminence',mx*0.75,'MinPeakDistance',0.15);
%         df=diff(locs);
%         if length(pks)<2 || std(pks)/mean(pks)>0.1 || std(df)/mean(df)>0.4  || max(M)-min(M)<0.5 || length(pks)>12 %si hay mas de 3 pisadas en un pie por segundo, descartar
%             cont=0;
%         else
%             periodo=mean(df);
%             amplitud=mean(pks);
%             for j=1:length(pks)
%                 E(:,end+1)=[pks(j);locs(j)];
%             end
%             step=true;
%             disp('amplitud de pasos')
%             disp(pks')
%             disp('tiempo de pasos')
%             disp(locs)
%         end
%     end
%     if step 
%         lasttime=E(2,end);
%         if T(end)>lasttime+2*periodo/3
%             disp('aaaaaaaaaa')
%             if M(end)>amplitud*0.9
%                 buff=true;
%             end
%             if buff
%                 cont2=cont2+1;
%                 disp('bbbbb')
%             end
%             if cont2>=8 
%                 disp('ccccccc')
%                 [pks, locs] = findpeaks(M(end-16:end),T(end-16:end),'NPeaks',1,'SortStr','descend');
%                 E(:,end+1)=[pks;locs];
%                 amplitud=mean(E(1,end-1:end));
%                 periodo=mean([periodo diff(E(2,end-1:end))]);
%                 cont2=0;
%                 buff=false;
%                 disp('amplitud de paso')
%                 disp(pks')
%                 disp('tiempo de paso')
%                 disp(locs)
%             end
%             if T(end)>lasttime+4*periodo/3 && ~buff
%                 step=false
%                 cont=-dt;
%             end
%         end
%     end
% end
% changearray=length(data_arrayACC(1:48:end));

%% Update the plots
%This timer callback function is called on every tick of the timer t.  It
%demuxes the dataArray buffers and assigns that channel to its respective
%plot
function updatePlots(obj, Event,  tmp)

global data_arrayACC
global plotHandlesACC
global MODULO
global NUM_SENSORS

%se hace update al MODULO (o eje x si corresponde) para cada plot 
for i= 1:NUM_SENSORS
    data_ch = data_arrayACC((i*3-2):48:end);       
    set(plotHandlesACC(i*3-2), 'Ydata', data_ch);
end
if ~MODULO  %si se estan graficando todos los ejes (x,y,z), se hace update a y,z tambien
    for i= 1:NUM_SENSORS
        data_ch = data_arrayACC((i*3-1):48:end);       
        set(plotHandlesACC(i*3-1), 'Ydata', data_ch);
        data_ch = data_arrayACC((i*3):48:end);    
        set(plotHandlesACC(i*3), 'Ydata', data_ch);
    end
end

drawnow
%% Implement the close figure callback
%This function is called whenever either figure is closed in order to close
%off all open connections.  It will close the ACC interface,
%commands interface, and timer object
function localCloseFigure(figureHandle,~,interfaceObject1, commObject, t)

%% 
% Clean up the network objects
if isvalid(interfaceObject1)
    fclose(interfaceObject1);
    delete(interfaceObject1);
    clear interfaceObject1;
end

if isvalid(t)
   stop(t);
   delete(t);
end

if isvalid(commObject)
    fclose(commObject);
    delete(commObject);
    clear commObject;
end

%% 
% Close the figure window
delete(figureHandle);

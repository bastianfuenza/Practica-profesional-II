%%RealTime Data Streaming with Delsys SDK


% Copyright (C) 2011 Delsys, Inc.
% 
% Permission is hereby granted, free of charge, to any person obtaining a 
% copy of this software and associated documentation files (the "Software"), 
% to deal in the Software without restriction, including without limitation 
% the rights to use, copy, modify, merge, publish, and distribute the 
% Software, and to permit persons to whom the Software is furnished to do so, 
% subject to the following conditions:
% 
% The above copyright notice and this permission notice shall be included in 
% all copies or substantial portions of the Software.
% 
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR 
% IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
% FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE 
% AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER 
% LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING 
% FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER 
% DEALINGS IN THE SOFTWARE.

function real_time_data_stream_plotting

% CHANGE THIS TO THE IP OF THE COMPUTER RUNNING THE TRIGNO CONTROL UTILITY
HOST_IP ='192.168.1.45';
%%
%This example program communicates with the Delsys SDK to stream 16
%channels of EMG data and 48 channels of ACC data.
global NUM_SENSORS
NUM_SENSORS = 2; %numero de sensores trabajando

global indicador %cuando indicador= 1 suena solamente el sensor 1, si el indicador=2 suena solamente el sensor 2
indicador=3;     %para que suenen ambos sensores, indicador=3

global limiteACC
limiteACC=7;   %rango en el cual se quiere trabajar, si se sobrepasa para arriba o hacia abajo suena la alarma


marcadorACC=13;  %para mayores de 10, es necesario ajustar usando el zoom de la ventana
marcadorEMG=7; %a partir de 8 es necsario ajusar usando el zoom de la ventana

global TiempoEMG
TiempoEMG=1;  %intervalo de tiempo en segundos de ploteo de señal EMG
global TiempoACC
TiempoACC=3;  %intervalo de tiempo en segundos de ploteo de señal ACC





%% Create the required objects
a=4; %matriz de ploteo en la ventana a*b siendo a el numero de graficos por linea y b la cantidad de filas
b=4; % notar que 4X4 permite 4 graficos por fila y cuatro filas, es decir 16 graficos, se debe tomar en cuenta esto si se desea graficar n cantidades de graficos axb>n
global s
beep= audioread('bleep.wav'); %abre un sonido determinado, este archivo debe estar en la misma carpeta que el codigo matlab
s=beep(1:148)';

if (NUM_SENSORS == 1)
    a=1;
    b=1;
end

if (NUM_SENSORS == 2)
    a=1;    %a=2 y b=1 plotea un grafico arriba de otro
    b=2;    %a=1 y b=2 plotea ambos graficos uno al lado del otro
end
%handles to all plots
global plotHandlesEMG;
plotHandlesEMG = zeros(NUM_SENSORS,1);
global plotHandlesACC;
plotHandlesACC = zeros(NUM_SENSORS*3, 1);
global rateAdjustedEmgBytesToRead;

%TCPIP Connection to stream EMG Data
interfaceObjectEMG = tcpip(HOST_IP,50041);
interfaceObjectEMG.InputBufferSize = 6400;

%TCPIP Connection to stream ACC Data
interfaceObjectACC = tcpip(HOST_IP,50042);
interfaceObjectACC.InputBufferSize = 6400;

%TCPIP Connection to communicate with SDK, send/receive commands
commObject = tcpip(HOST_IP,50040);

%Timer object for drawing plots.   timer llama @updatePlots cada 0,1
%segundo con plotHandlesEMG como argumento
t = timer('Period', 0.001 , 'ExecutionMode', 'fixedSpacing', 'TimerFcn', {@updatePlots, plotHandlesEMG});%0.1
global data_arrayEMG
data_arrayEMG = [];
global data_arrayACC
data_arrayACC = [];

%% Set up the plots

axesHandlesEMG = zeros(NUM_SENSORS,1);
axesHandlesACC = zeros(NUM_SENSORS,1);

%initiate the EMG figure
figureHandleEMG = figure('Name', 'EMG Data','Numbertitle', 'off',  'CloseRequestFcn', {@localCloseFigure, interfaceObjectEMG, interfaceObjectACC, commObject, t});
set(figureHandleEMG, 'position', [50 10 750 750])

for i = 1:NUM_SENSORS
    axesHandlesEMG(i) = subplot(a,b,i);
    plotHandlesEMG(i) = plot(axesHandlesEMG(i),0,'-y','LineWidth',1);

    set(axesHandlesEMG(i),'YGrid','on');
    %set(axesHandlesEMG(i),'YColor',[0.9725 0.9725 0.9725]);
    set(axesHandlesEMG(i),'XGrid','on');
    %set(axesHandlesEMG(i),'XColor',[0.9725 0.9725 0.9725]);
    set(axesHandlesEMG(i),'Color',[.15 .15 .15]);
    set(axesHandlesEMG(i),'YLim', [-marcadorEMG*0.001-0.0005 marcadorEMG*0.001+0.0005]);
    set(axesHandlesEMG(i),'YLimMode', 'manual');
    set(axesHandlesEMG(i),'XLim', [0 2000*TiempoEMG]);
    set(axesHandlesEMG(i),'XLimMode', 'manual');
      
    title(sprintf('EMG %i', i)) 
end

%initiate the ACC figure
figureHandleACC = figure('Name', 'ACC Data', 'Numbertitle', 'off', 'CloseRequestFcn', {@localCloseFigure, interfaceObjectEMG, interfaceObjectACC, commObject, t});
set(figureHandleACC, 'position', [0 0 2000 750]);

for i= 1:NUM_SENSORS
    axesHandlesACC(i) = subplot(a, b, i);
    hold on
    plotHandlesACC(i*3-2) = plot(axesHandlesACC(i), 0, '-y', 'LineWidth', 3);  
    plotHandlesACC(i*3-1) = plot(axesHandlesACC(i), 0, '-y', 'LineWidth', 3);   
    plotHandlesACC(i*3) = plot(axesHandlesACC(i), 0, '-y', 'LineWidth', 3);    
    hold off     
    set(plotHandlesACC(i*3-2), 'Color', 'r')% eje X respecto del trigno
    set(plotHandlesACC(i*3-1), 'Color', 'b')% eje Y respecto del trigno
    set(plotHandlesACC(i*3), 'Color', 'g')  % eje Z respecto del trigno
    set(axesHandlesACC(i),'YGrid','on');
    set(axesHandlesACC(i),'YColor',[0 0 0]);
    set(axesHandlesACC(i),'XGrid','on');
    
    %set(axesHandlesACC(i),'XColor',[0.9725 0.9725 0.9725]);
    set(axesHandlesACC(i),'Color',[.15 .15 .15]);
    set(axesHandlesACC(i),'YLim', [-marcadorACC-0.5 marcadorACC+0.5]);%-9 a 9
    set(axesHandlesACC(i),'YLimMode', 'manual');
    set(axesHandlesACC(i),'XLim', [0 150*TiempoACC]);%-50 a 2000
    set(axesHandlesACC(i),'XLimMode', 'manual');
    hline=refline([0 limiteACC]);     
    yline=refline([0 -limiteACC]);    
    set(hline,'color','w');
    set(yline,'color','w'); 
    
    title(sprintf('ACC %i', i)) 

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

emgRate = strtrim(char(data'));
if(strcmp(emgRate, '1925.926'))
    rateAdjustedEmgBytesToRead=1664;
else 
    rateAdjustedEmgBytesToRead=1728;
end


%% Setup interface object to read chunks of data
% Define a callback function to be executed when desired number of bytes
% are available in the input buffer
 bytesToReadEMG = rateAdjustedEmgBytesToRead;
 interfaceObjectEMG.BytesAvailableFcn = {@localReadAndPlotMultiplexedEMG,plotHandlesEMG,bytesToReadEMG};
 interfaceObjectEMG.BytesAvailableFcnMode = 'byte';
 interfaceObjectEMG.BytesAvailableFcnCount = bytesToReadEMG;
 
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
    fopen(interfaceObjectEMG);
    fopen(interfaceObjectACC);
catch
    localCloseFigure(figureHandleACC,1 ,interfaceObjectACC, interfaceObjectEMG, commObject, t);
    delete(figureHandleEMG);
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
function localReadAndPlotMultiplexedEMG(interfaceObjectEMG, ~,~,~, ~)
global rateAdjustedEmgBytesToRead;
bytesReady = interfaceObjectEMG.BytesAvailable;
bytesReady = bytesReady - mod(bytesReady, rateAdjustedEmgBytesToRead);%%1664

if (bytesReady == 0)
    return
end
global data_arrayEMG
data = cast(fread(interfaceObjectEMG,bytesReady), 'uint8');
data = typecast(data, 'single');

global TiempoEMG

% Modificar arreglo para almacenar una ventana mas grande
if(size(data_arrayEMG, 1) < rateAdjustedEmgBytesToRead*19*TiempoEMG)
    data_arrayEMG = [data_arrayEMG; data];
else
    data_arrayEMG = [data_arrayEMG(size(data,1) + 1:size(data_arrayEMG, 1));data];
end

function localReadAnPlotMultiplexedACC(interfaceObjectACC, ~, ~, ~, ~)
global s;

bytesReady = interfaceObjectACC.BytesAvailable;
bytesReady = bytesReady - mod(bytesReady, 384);

if(bytesReady == 0)
    return
end
global data_arrayACC
global limiteACC
data = cast(fread(interfaceObjectACC, bytesReady), 'uint8');
data = typecast(data, 'single');


global indicador
if (data(1)>limiteACC || data(1)<-limiteACC) && indicador~=2   %si se desea cambiar el eje, basta utilizar data(i*3-1) o data(i*3)
    soundsc(s,1500,8);                                 %emite un sonido "s" cuando se sobrepasa el limite
    %disp('sensor 1'),disp(data(1)) ;
end
if (data(4)>limiteACC || data(4)<-limiteACC) && indicador~=1
    soundsc(s,1000,8); 
    %disp('sensor 2'),disp(data(4)) ;
end

global TiempoACC %cantidad de segundos de la muestra ACC


if(size(data_arrayACC, 1) < 7296*TiempoACC) %si el tamaño de muestra es menor a la cantidad de muestras aceptadas por periodo (en este casi 7296datos/segundos*4segundos)
    data_arrayACC = [data_arrayACC; data];  % se le agregan los nuevos datos recibidos hasta compeletar el periodo indicado 
else                                        %si el tamaño de datos guardados supera el periodo:
    data_arrayACC = [data_arrayACC(size(data, 1) + 1:size(data_arrayACC, 1)); data];
end                                         %reemplaza los datos mas viejos por datos nuevos (concatenndo matrices)




%% Update the plots
%This timer callback function is called on every tick of the timer t.  It
%demuxes the dataArray buffers and assigns that channel to its respective
%plot.
function updatePlots(obj, Event,  tmp)
global data_arrayEMG
global plotHandlesEMG

data_ch = data_arrayEMG(1:16:end);     
set(plotHandlesEMG(1), 'Ydata', data_ch)   
data_ch = data_arrayEMG(2:16:end);     
set(plotHandlesEMG(2), 'Ydata', data_ch) 


global data_arrayACC
global plotHandlesACC

%si se desea plotear los 3 ejes al mismo tiempo: 
%multiplicar NUM_SENSORS*3
%reemplazar el "i*3-2" por "i" en ambas lineas del for

data_ch = data_arrayACC(1:48:end);   %(i:48:end)    
set(plotHandlesACC(1), 'Ydata', data_ch)
data_ch = data_arrayACC(4:48:end);      
set(plotHandlesACC(4), 'Ydata', data_ch)   

%si se desea plotear los 3 ejes  multiplicar NUM_SENSORS*3
%reemplazar "i*3-2" por "i" en ambas lineas dentro del for

%notar que si se desea graficar otro eje, habria que poner:
%"i*3-1" para plotear de color azul el ACC del eje Y respecto del trigno
%o bien "i*3" para plotear de color verde el eje Z respecto del trigno
drawnow
%% Implement the close figure callback
%This function is called whenever either figure is closed in order to close
%off all open connections.  It will close the EMG interface, ACC interface,
%commands interface, and timer object
function localCloseFigure(figureHandle,~,interfaceObject1, interfaceObject2, commObject, t)

%% 
% Clean up the network objects
if isvalid(interfaceObject1)
    fclose(interfaceObject1);
    delete(interfaceObject1);
    clear interfaceObject1;
end
if isvalid(interfaceObject2)
    fclose(interfaceObject2);
    delete(interfaceObject2);
    clear interfaceObject2;
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

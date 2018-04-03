%%Este codigo detecta picks en la señal, e identifica como pasos

%basicamente abre un archivo con datos y empieza a llenar de a poco
%vectores con datos de x,y,z, simulando el recibimiento de datos del SDK

%funciona con una mezcla de deteccion de heel-strike "offline" y "online"(no usa internet)
%OFFLINE: toma la ultima muestra de datos guardada (data_arrayACC(x:48:end))
%y busca picks en señal, si cumplen con condiciones para un "paso constante"
%el programa los reconoce, agrega a eventos (E) y calcula amplitud promedio y periodo
%una vez hecho pasa a "online", para reducir costo en tiempo de calculos
%ONLINE: teniendo una amplitud promedio y periodo de paso, el programa predice 
%la posicion del siguiente paso con una holgura de periodo/3, si encuentra un valor cercano
%a la amplitud promedio, usa una pequeña vecindad para buscar el mayor pick
%el cual agrega a eventos, para luego recalcular amplitud y periodo, de acuerdo al nuevo pick.
%Si no logra encontrar un pick aceptable, pasa nuevamente a OFFLINE

%abre el archivo y extrae los datos
M=csvread('Ivan.csv',1,0);
x=M(1:end-floor((length(M(:,4))-1)/1.2),4);
y=M(1:end-floor((length(M(:,4))-1)/1.2),6);
z=M(1:end-floor((length(M(:,4))-1)/1.2),8);
t=M(1:end-floor((length(M(:,4))-1)/1.2),7);

X=[];
Y=[];
Z=[];
T=[];
M=[];

Event=[];

ts=4; %tiempo que abarcan los vectores (analogo a TiempoACC)
dt=ts*148; %148 datos/seg aprox 
cont=0; %contador
cont2=0; %otro contador
step=false; %si se encontró pasos o no
buff=false; %si se activó el buffer(pequeño tiempo en el que recibe datos para buscar picks)

figure
for i=1:length(t)
    cont=cont+1;
    time=(i-1)*0.00675;
    m=sqrt(x(i)*x(i)+y(i)*y(i)+z(i)*z(i));
    %los vectores se van llenando "a medida que llegan datos" si el largo
    %es mayor al numero, elimina dato antiguo y agrega nuevo, si no es
    %mayor al numero, solo agrega al final
    if length(T)>=700  %n° debe ser mayor a dt
        T=[T(2:end) time];
        X=[X(2:end) x(i)];
        Y=[Y(2:end) y(i)];
        Z=[Z(2:end) z(i)];
        M=[M(2:end) m];
    else
        T(end+1)=time;
        X(end+1)=x(i);
        Y(end+1)=y(i);
        Z(end+1)=z(i);
        M(end+1)=m;
    end
    plot(T,M)
    %si aun no se encuentra un paso, ejecula la parte "OFFLINE"
    if ~step && i>dt && cont>=30 %0.2seg aprox
        [~,~,~,proms] = findpeaks(M(end-dt:end),T(end-dt:end)); %encuentra todos los picks
        mx=max(proms);%saca la "prominencia" maxima
        [pks, locs] = findpeaks(M(end-dt:end),T(end-dt:end),'MinPeakProminence',mx*0.75); %busca picks de ese calibre
        df=diff(locs);
        %condiciones: descartar si son pocos picks
        if length(pks)<2 || std(pks)/mean(pks)>0.1 || std(df)/mean(df)>0.4 || length(pks)>ts*3 
            cont=0;
        else
            periodo=mean(df);
            amplitud=mean(pks);
            for j=1:length(pks)
                Event(:,end+1)=[pks(j);locs(j)];
            end
            step=true;
        end
    end
    if step
        lastpeak=Event(1,end); 
        lasttime=Event(2,end);
        if time>lasttime+2*periodo/3
            if M(end)>amplitud*0.9
                buff=true;
            end
            if buff
                cont2=cont2+1;
            end
            if cont2==10 %0.135seg aprox
                [pks, locs] = findpeaks(M(end-20:end),T(end-20:end),'NPeaks',1,'SortStr','descend');
                Event(:,end+1)=[pks;locs]  %%%fix
                amplitud=mean(Event(1,end-1:end));
                periodo=mean([periodo diff(Event(2,end-1:end))]);
                cont2=0;
                buff=false;
            end
            if time>lasttime+4*periodo/3 && ~buff
                step=false;
                cont=-dt;
            end
        end
    end
    pause(0.00675)
end
disp(Event)


% figure 
% plot(t,x,'Color','r')
% xlim([0 3])
% hold on
% plot(t,y,'Color','b')
% plot(t,z,'Color','g')
% hold off
% 
% figure
% m=sqrt(x.*x+y.*y+z.*z);
% plot(t,m,'Color','r')


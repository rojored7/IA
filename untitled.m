function varargout = untitled(varargin)
% UNTITLED MATLAB code for untitled.fig
%      UNTITLED, by itself, creates a new UNTITLED or raises the existing
%      singleton*.
%
%      H = UNTITLED returns the handle to a new UNTITLED or the handle to
%      the existing singleton*.
%
%      UNTITLED('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in UNTITLED.M with the given input arguments.
%
%      UNTITLED('Property','Value',...) creates a new UNTITLED or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before untitled_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to untitled_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help untitled

% Last Modified by GUIDE v2.5 27-Nov-2018 22:48:43

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @untitled_OpeningFcn, ...
                   'gui_OutputFcn',  @untitled_OutputFcn, ...
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


% --- Executes just before untitled is made visible.
function untitled_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to untitled (see VARARGIN)

% Choose default command line output for untitled
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes untitled wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = untitled_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% -------IDENTIFICAR PATRONES----------------%
function pushbutton1_Callback(hObject, eventdata, handles)
global pos propiedades caja imag vx vy
pos=get(handles.edit1,'String');
pos=str2double(pos)+1;
if pos>10
    msgbox(sprintf('Error'),'Error','Error');
    return
end
 for k=1 : length(propiedades)
    caja = propiedades(k).BoundingBox;
    rectangle('Position', [caja(1), caja(2), caja(3), caja(4)],...
        'EdgeColor','r','LineWidth',1)
 end
vx=[];
vy=[];
% %recortar
for k=1 : length(propiedades)
    caja = propiedades(k).BoundingBox;
   
    L=(imag(caja(2):caja(2)+caja(4),caja(1):caja(1)+caja(3),:));
    Iz = im2bw(imresize(imag(caja(2):caja(2)+caja(4),caja(1):caja(1)+caja(3),:),[25 20]));
    i0=Iz(:);
    load('red2erro.mat');
    l=round(red4(i0));

    if l(pos) == 1
      
         
    if  (round(propiedades(k).Centroid(1)))==0
        vx=vx;
    else
        vx=[vx round(propiedades(k).Centroid(1))];
        vy=[vy round(propiedades(k).Centroid(2))];
    end
    end
end

imshow(imag)
vx=[vx]
vy=[vy]
hold on 
plot (vx,vy,'*')




function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%%---------------------INGRESAR PISTA-----------------------------%%

function pushbutton3_Callback(hObject, eventdata, handles)
global imag  propiedades caja
[pista,cancel]=imgetfile();
if cancel
    msgbox(sprintf('Error'),'Error','Error');
    return
end
imag = imread(pista);
[M,N] = size(imag);
imshow(imag);
umbral = graythresh (imag);
img_bw = not(im2bw(imag, umbral));
img_bw_label = bwlabel(img_bw);
propiedades = regionprops(img_bw_label);


% --- PUNTO DE INICIO-----%
function pushbutton4_Callback(hObject, eventdata, handles)
global PuntoInicialX PuntoInicialY
[PuntoInicialX,PuntoInicialY] =ginput(1)


% --- PUNTO DE LLEGADAAAA-----%
function pushbutton5_Callback(hObject, eventdata, handles)
global PuntoLLEGADAX PuntoLLEGADAY PuntoInicialX PuntoInicialY 
[PuntoLLEGADAX,PuntoLLEGADAY]=ginput(1)
hold on 
plot(PuntoInicialX,PuntoInicialY,'*');
hold on 
plot(PuntoLLEGADAX,PuntoLLEGADAY,'*')


% ----------KOHONEN------------------%
function pushbutton6_Callback(hObject, eventdata, handles)
global NumPuntos vx vy PuntoLLEGADAX imag PuntoLLEGADAY PuntoInicialX PuntoInicialY Orden Orden2
global Puntos2 Puntos
Orden=[];
Puntos=0;
Orden2=[];
Puntos2=[];
NumPuntos=size(vx,2);
NumNeuronas=40;
NumNeuronas=NumNeuronas*NumPuntos;
Muestras = 1000+10*NumNeuronas;

m0 = 0.1;
s0 = NumNeuronas;
k = 1;
t1 = 1000/log10(s0);

x1=vx;
x2=vy;
for j = 1:NumNeuronas
    W1(1,j) = rand;
    W2(1,j) = rand;
end
x1=[PuntoInicialX x1 PuntoLLEGADAX];
x2=[PuntoInicialY x2 PuntoLLEGADAY];

Distancia = zeros(1,NumNeuronas);
cla;
axes(handles.axes1)
 
plot(x1,x2,'.b')
hold on
grid on
plot(W1,W2,'or')
plot(W1,W2,'g','linewidth',2)
hold off
title('N° Muestra = 0');
drawnow
pause(2);
while k <= Muestras
    m = m0*exp(-k/1000);
    sigma = s0*exp(-k/t1);
    for i = 1:NumPuntos+2
        for j = 1:NumNeuronas
            Distancia(1,j) = (x1(1,i) - W1(1,j))^2 + (x2(1,i) - W2(1,j))^2;
        end
        Menor = Distancia(1,1);
        for j = 1:NumNeuronas
            if Distancia(1,j) <= Menor
                Menor = Distancia(1,j);
                Pos = j;
            end
            PosWin = Pos;
        end
        for j = 1:NumNeuronas 
            d = PosWin - j;
            h = exp(-d^2/(2*sigma^2));
            if j == 1
                W1(1,1) = x1(1,1);
                W2(1,1) = x2(1,1);
            elseif j == NumNeuronas
                W1(1,NumNeuronas) = x1(1,NumPuntos+2);
                W2(1,NumNeuronas) = x2(1,NumPuntos+2);
            else
                W1(1,j) = W1(1,j) + m*h*(x1(1,i) - W1(1,j));
                W2(1,j) = W2(1,j) + m*h*(x2(1,i) - W2(1,j));
            end
        end
    end
    if mod(k,100) == 0
        %figure(1);
        hold off
        imshow(imag);
        hold on 
        axes(handles.axes1);
        plot(x1,x2,'.b')
        hold on
        grid on
        plot(W1,W2,'or') 
        plot(W1,W2,'g','linewidth',2)
        
        hold off
        title(['N° Muestra = ' num2str(k)]);
%         axes(handles.axes3);
%         plot(d)
%         hold on
%         grid on
        drawnow
    end
     k = k + 1;
     
end

W1=round(W1);
W2=round(W2);
x1=round(x1)
x2=round(x2);
% W1=W1
% x1(1,2)
Puntos2=0;
Puntos3=[];
Puntos4=[];
for O=1:NumPuntos
    Puntos=0;
    Puntos2=0;
    Orden=find(W1==x1(1,O+1))
    Orden2=find(W2==x2(1,O+1))
    for P=1:size(Orden,2)
    Puntos=Puntos+W1(Orden(P));
    end
    for Po=1:size(Orden2,2)
    Puntos2=Puntos2+W2(Orden2(Po));
    end
    Puntos3=[Puntos3 Puntos/(size(Orden,2))]
    Puntos4=[Puntos4 Puntos2/(size(Orden2,2))]
end
x1
x2




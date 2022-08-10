function varargout = Red_de_Hopfield(varargin)
% RED_DE_HOPFIELD MATLAB code for Red_de_Hopfield.fig
%      RED_DE_HOPFIELD, by itself, creates a new RED_DE_HOPFIELD or raises the existing
%      singleton*.
%
%      H = RED_DE_HOPFIELD returns the handle to a new RED_DE_HOPFIELD or the handle to
%      the existing singleton*.
%
%      RED_DE_HOPFIELD('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RED_DE_HOPFIELD.M with the given input arguments.
%
%      RED_DE_HOPFIELD('Property','Value',...) creates a new RED_DE_HOPFIELD or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Red_de_Hopfield_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Red_de_Hopfield_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Red_de_Hopfield

% Last Modified by GUIDE v2.5 13-Nov-2018 20:59:53

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Red_de_Hopfield_OpeningFcn, ...
                   'gui_OutputFcn',  @Red_de_Hopfield_OutputFcn, ...
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


% --- Executes just before Red_de_Hopfield is made visible.
function Red_de_Hopfield_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Red_de_Hopfield (see VARARGIN)

% Choose default command line output for Red_de_Hopfield
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Red_de_Hopfield wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Red_de_Hopfield_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in cargarimagen.
function cargarimagen_Callback(hObject, eventdata, handles)
% hObject    handle to cargarimagen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Caracter_Ing=zeros(9,7); %Crea matriz de ceros
caracter = (get(handles.matrizcaracter,'data')); %Lee los datos ingresados en la tabla

for k=1:7
    for l=1:9
        if(cell2mat(caracter(l,k))==1)
          Caracter_Ing(l,k)=1;
        else
            Caracter_Ing(l,k)=0;
        end
    end
end % 1 0 %Realiza un recorrido en la tabla para identificar 

axes(handles.axes1);
imshow(~Caracter_Ing) % mostrar imagen de la seleccion

% --- Executes on button press in entrenar.
function entrenar_Callback(hObject, eventdata, handles)
% hObject    handle to entrenar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
C=Caracteres();
[f,c]=size(C);
W=zeros(f,f);
% for i=1:f
%     for j=1:f
%         Aux=0;
%         for k=1:c
%             Aux=P(i,k)*P(j,k)+Aux;  
%         end
%         W(i,j)=Aux;
%         if (i==j)
%                 W(i,j)=0;
%         end
%     end      
% end
W=C*pinv(C);
assignin('base','W',W);
assignin('base','f',f);
disp ('...Red Entrenada')

function itera_Callback(hObject, eventdata, handles)
% hObject    handle to itera (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of itera as text
%        str2double(get(hObject,'String')) returns contents of itera as a double


% --- Executes during object creation, after setting all properties.
function itera_CreateFcn(hObject, eventdata, handles)
% hObject    handle to itera (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in encontrar.
function encontrar_Callback(hObject, eventdata, handles)
% hObject    handle to encontrar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
W=evalin('base','W');
f=evalin('base','f');
itera=str2double(get(handles.itera,'String'));
y=zeros(f,itera+1);

Caracter_Ing=zeros(9,7); %Crea matriz de ceros
caracter = (get(handles.matrizcaracter,'data')); %Lee los datos ingresados en la tabla

for k=1:7
    for l=1:9
        if(cell2mat(caracter(l,k))==1)
          Caracter_Ing(l,k)=1;
        else
            Caracter_Ing(l,k)=0;
        end
    end
end % 1 0 %Realiza un recorrido en la tabla para identificar 

for k=1:7
    for l=1:9
        if(Caracter_Ing(l,k)==1)
            Caracter_Ing(l,k)=1;
        else
            Caracter_Ing(l,k)=-1;
        end
    end
end %  1 -1


for m=0:8
        caracterr((m*7)+1:(m+1)*7,1)= Caracter_Ing(m+1,1:7); 
end %Pasar matriz logica a un vector columna
caracter=caracterr;

y(:,1)=caracter;

for m=0:8
        ima(m+1,1:7)= y((m*7)+1:(m+1)*7,1); 
end   

 for m=1:7
    for l=1:9
        if(ima(l,m)==1)
            ima(l,m)=1;
        else
            ima(l,m)=0;
        end
    end
 end
 
 axes(handles.axes2);
 imshow(~ima);
 
 pause(0.5);

s=W*y(:,1);

for k=2:itera+1    % iteraciones
 s
 for i=1:f     
         if(s(i)>0)
            y(i,k)=1;
         elseif (s(i)<0)
             y(i,k)=-1;
         elseif (s(i)==0)
             y(i,k)=y(i,k-1);
         end 
 end
 y;
 s=W*y(:,k)

 
    for m=0:8
        ima(m+1,1:7)= y((m*7)+1:(m+1)*7,k); 
    end    
ima;

 for m=1:7
    for l=1:9
        if(ima(l,m)==1)
            ima(l,m)=1;
        else
            ima(l,m)=0;
        end
    end
 end
ima
 axes(handles.axes2);
 imshow(~ima)
 
  k
 pause(0.5);


end


% --- Executes on button press in limpiar.
function limpiar_Callback(hObject, eventdata, handles)
% hObject    handle to limpiar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.matrizcaracter,'Data',cell(size(get(handles.matrizcaracter,'Data'))))
set(handles.itera,'String','')
axes(handles.axes2)
cla reset
axes(handles.axes1)
cla reset
axes(handles.axes3)
cla reset
set(handles.dis,'String','')
clc;


% --- Executes on button press in cargarimagen1.
function cargarimagen1_Callback(hObject, eventdata, handles)
% hObject    handle to cargarimagen1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global dim prueba im
[im,~,~]=uigetfile('*.png'); %Busca el archivo de la imagen de prueba.
prueba=imread(im); %Procesamiento de la imagen de prueba.
prueba=im2bw(prueba);
prueba=imcomplement(prueba);
s=regionprops(prueba);
prueba=imcrop(prueba,s.BoundingBox);
prueba=imcomplement(prueba);
prueba=imresize(prueba,[dim dim]);
imshow(prueba,'Parent',handles.axes1,'InitialMagnification','fit');
imshow(prueba,'Parent',handles.axes3,'InitialMagnification','fit');


% --- Executes on button press in modificar.
function modificar_Callback(hObject, eventdata, handles)
% hObject    handle to modificar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global prueba dim 
prueba=prueba(:);
n=length(prueba);
porc=str2double(get(handles.dis,'String'))/100;%Adquiere el porcentaje de distorcion 
nu=round(porc*n);
ran=randperm(n,nu);
%Se determinan los pixeles que entran en el porcentaje de distorcion y se normalizan:
for i=1:nu
    prueba(ran(i),1)=(prueba(ran(i))*-1)+1;
end
cont=0;
pruebaaux=zeros(dim,dim);
for i=1:dim
    for j=1:dim
       cont=cont+1;
       pruebaaux(j,i)=prueba(cont);
    end
end
prueba=pruebaaux;
prueba=(prueba.*2)-1;
imshow(prueba,'Parent',handles.axes1,'InitialMagnification','fit');



function dis_Callback(hObject, eventdata, handles)
% hObject    handle to dis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dis as text
%        str2double(get(hObject,'String')) returns contents of dis as a double


% --- Executes during object creation, after setting all properties.
function dis_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in encontrar1.
function encontrar1_Callback(hObject, eventdata, handles)
% hObject    handle to encontrar1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global prueba dim W S
prueba=prueba(:);
c=0;
rep=0;
pruebaaux=zeros(dim,dim);
while true
    c=c+1
    cont=0;
    for i=1:dim
        for j=1:dim
           cont=cont+1;
           pruebaaux(j,i)=prueba(cont);
        end
    end
    imshow(pruebaaux,'InitialMagnification','fit','Parent',handles.axes2);
    drawnow
    pruebaant=prueba;
    S=W*prueba;
    for i=1:length(S)
        if S(i)==0
            S(i)==pruebaant(i)
        end
    end
    prueba=S>0;
    prueba=(prueba.*2)-1;
    if pruebaant==prueba
        rep=rep+1;
        if rep>15
            break
        end
    end
    pause(1)
end

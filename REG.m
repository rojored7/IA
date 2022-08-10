clc;
close all;
clear all;

imag = imread('PIS2.png');
[M,N] = size(imag);
imshow(imag);

umbral = graythresh (imag);
img_bw = not(im2bw(imag, umbral));
% imshow(img_bw);

img_bw_label = bwlabel(img_bw);
%%figure
% imshow(label2rgb(img_bw_label));
% imshow((img_bw_label));
propiedades = regionprops(img_bw_label);

 %cajas
 for k=1 : length(propiedades)
    caja = propiedades(k).BoundingBox;
    rectangle('Position', [caja(1), caja(2), caja(3), caja(4)],...
        'EdgeColor','r','LineWidth',1)
end

pos=6;
vx=[];
vy=[];
% %recortar
for k=1 : length(propiedades)
    caja = propiedades(k).BoundingBox;
   
    L=(imag(caja(2):caja(2)+caja(4),caja(1):caja(1)+caja(3),:));
    Iz = im2bw(imresize(imag(caja(2):caja(2)+caja(4),caja(1):caja(1)+caja(3),:),[25 20]));
    i0=Iz(:);
    figure
%     imshow(i0)
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
  close all;
end




% vx=[0 vx 8083]
% vy=[0 vy 0]
vx=[vx]
vy=[vy]
hold on 
plot (vx,vy)




close all;
clear all;
clc;

paso = 0.01;

%error

e = -20:paso:20;
ENG = trapmf(e,[-20 -20 -10 -5]);
ENP = trimf (e,[-10 -5 0]);
EC  = trimf (e,[-5 0 5]);
EPP = trimf (e,[0 5 10]);
EPG = trapmf(e,[5 10 20 20]);

subplot(3,1,1),plot(e,ENG,e,ENP,e,EC,e,EPP,e,EPG,'LineWidth',3)
set(gca,'FontSize',10),legend('ENG','ENP','EC','EPP','EPG')
xlabel('Error'),ylabel('\mu(Error)')

%control

v = -12:paso:12;
VNG = trapmf(v,[-12 -12 -6 -3]);
VNP = trimf (v,[-6 -3 0]);
VC  = trimf (v,[-3 0 3]);
VPP = trimf (v,[0 3 6]);
VPG = trapmf(v,[3 6 12 12]);

subplot(3,1,2),plot(v,VNG,v,VNP,v,VC,v,VPP,v,VPG,'LineWidth',3)
set(gca,'FontSize',10),legend('VNG','VNP','VD','VPP','VPG')
xlabel('VOLTAJE'),ylabel('\mu(voltaje)')


e0=9; %Error
n = find(e==e0);
subplot(3,1,1),hold on,plot(e0,ENG(n),'*',e0,ENP(n),e0,EC(n),...
        '*',e0,EPP(n),'*',e0,EPG(n),'*','LineWidth',5), hold off
    
   %FUSIFICAR E INFERENCIA DE MANDANI
   
B1 = min(VNG,ENG(n));    
B2 = min(VNP,ENP(n));    
B3 = min(VC,EC(n));    
B4 = min(VPP,EPP(n));    
B5 = min(VPG,EPG(n));

B = max(B1,max(B2,max(B3,max(B4,B5))));
subplot(3,1,3),plot(v,B,'LineWidth',3)
set(gca,'FontSize',10),legend('V')
axis([-12 12 0 1])

    %Defusificacion
    
    
vo = defuzz(v,B,'centroid')
hold on, plot(vo*ones(1,3),[0 0.5 1],'r','LineWidth',3)
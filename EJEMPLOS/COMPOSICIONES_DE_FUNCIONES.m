close all;
clear all;
clc;

x=0:0.01:1;
mA=sigmf(x,[15 0.5]);%funcion sigmoide

mA1=gaussmf(x,[0.04 0.5]);%funcion gaussiana

y=0:0.01:5;
mB=sigmf(y,[-3 2.5]);%funcion sigmoide

%producto carteciano mA y mB
for i=1:length(mA)
    for j=1:length(mB)
        mR(i,j) = min(mA(i),mB(j));
    end
end

[X, Y]=meshgrid(y,x);
mesh(X,Y,mR)
set(gca,'FontSize',18)

%composicion 
for j=1:length(mB)
    for i=1:length(mA)
        aux(i) = min(mA1(i),mR(i,j));
    end
    Bp(j) = max(aux);
end

figure, plot(x,mA1,'LineWidth',5),set(gca,'FontSize',18),legend('mB')
figure, plot(y,Bp,'LineWidth',5),set(gca,'FontSize',18),legend('Bp')

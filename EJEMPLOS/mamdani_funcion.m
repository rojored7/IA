close all;
clear all;
clc;

paso = 0.01;
e0 = -20:paso:20;
vo = control(e0,paso);
plot(e0,vo,'LineWidth',3)
set(gca,'FontSize',10)
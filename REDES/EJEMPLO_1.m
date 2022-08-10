clc;
close all;
clear all;


%   a b c d e f g 

P =[1 1 1 1 1 1 0; %0
    0 1 1 0 0 0 0; %1
    1 1 0 1 1 0 1; %2
    1 1 1 1 0 0 1; %3
    0 1 1 0 0 1 1; %4
    1 0 1 1 0 1 1; %5
    1 0 1 1 1 1 1; %6
    1 1 1 0 0 0 0; %7
    1 1 1 1 1 1 1; %8
    1 1 1 1 0 1 1]; %9
    
P=P';

tpar   = [1 0 1 0 1 0 1 0 1 0];
tmay5  = [0 0 0 0 0 0 1 1 1 1];
tprim  = [0 0 1 1 0 1 0 1 0 0];

t = tpar;

w = 2*rand(1,7)-1;
b = 2*rand(1)-1;
for Epocas = 1:500
    for q = 1:10
        e(q) = t(q) - hardlim(w*P(:,q) + b);
        w = w + e(q)*P(:,q)';
        b = b + e(q);
    end 
end 
e
w
b
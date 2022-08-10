clc,clear ,close all;

P=[0.7 1.5 2.0 0.9 4.2 2.2 3.6 4.5;
     3   5   9  11   0   1   7   6];
 z=[P;1 1 1 1 1 1 1 1];

 T=[-1 -1 -1 -1 1 1 1 1;
    -1 -1 1 1 -1 -1 1 1];

%regal de W-H

R = z*z'/8;
H = z*T'/8;
X = inv(R)*H;
w = X(1:2,:)'
b = X(3,:)'

for q=1:8
    e(:,q) = T(:,q) - hardlims(w*P(:,q) +b);
end
e
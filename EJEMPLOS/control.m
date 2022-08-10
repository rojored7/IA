function vo = control(e0,paso)
%error

e = -20:paso:20;
ENG = trapmf(e,[-20 -20 -10 -5]);
ENP = trimf (e,[-10 -5 0]);
EC  = trimf (e,[-5 0 5]);
EPP = trimf (e,[0 5 10]);
EPG = trapmf(e,[5 10 20 20]);

%control

v = -12:paso:12;
VNG = trapmf(v,[-12 -12 -6 -3]);
VNP = trimf (v,[-6 -3 0]);
VC  = trimf (v,[-3 0 3]);
VPP = trimf (v,[0 3 6]);
VPG = trapmf(v,[3 6 12 12]);



for k=1:length(e0)
    n = find(e==e0(k));
   %FUSIFICAR E INFERENCIA DE MANDANI
   
B1 = min(VNG,ENG(n));    
B2 = min(VNP,ENP(n));    
B3 = min(VC,EC(n));    
B4 = min(VPP,EPP(n));    
B5 = min(VPG,EPG(n));

B = max(B1,max(B2,max(B3,max(B4,B5))));
    %Defusificacion
        
vo(k) = defuzz(v,B,'centroid')
end

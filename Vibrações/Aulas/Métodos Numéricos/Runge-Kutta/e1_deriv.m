function f=e1_deriv(x)
% equações diferenciais de primeira ordem EDO movimento linear
% e1_deriv.m 25/10/2020
m=1125;
k=125000;
csi=0.05;
p0 = 500;
W = 105;
omega=sqrt(k/m);
f(1,1)=x(2);
f(2,1)=p0/m*sin(W*x(3))-2*csi*omega*x(2)-omega*omega*x(1);
f(3,1)=1;
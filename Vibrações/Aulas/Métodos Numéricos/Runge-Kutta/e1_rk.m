% integração equação do movimento
% runge-kutta 4a ordem
% e1_rk.m 25/10/2020
% número de equações diferenciais de primeira ordem
% a última é a variável independente (tempo, p. ex.) cuja derivada é 1
ne=3;
ti=5; %tempo deintegração em segundos
h=0.00005; % valor do passo
np=ti/h; %numero de passos de integração
%
% dimensionamento das matrizes
x=zeros(ne,np);
%
% condições iniciais
%
x(:,1)=e1_ci;
%
% loop principal
%
for n=1:np
    xarg=x(:,n);
    k1=e1_deriv(xarg);
    xarg=x(:,n)+0.5*h*k1;
    k2=e1_deriv(xarg);
    xarg=x(:,n)+0.5*h*k2;
    k3=e1_deriv(xarg);
    xarg=x(:,n)+h*k3;
    k4=e1_deriv(xarg);
    x(:,n+1)=x(:,n)+h*(k1+2*k2+2*k3+k4)/6;
end
%
% plotagem
%tempo * deslocamento
plot(x(3,:),x(1,:))
%pause
%plano de fase
%plot(x(1,:),x(2,:))
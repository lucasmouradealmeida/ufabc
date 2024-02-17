%Integração Numérica no Tempo
%Método de Newmark
%Carga Harmônica
clc;
clear;
%Entrada de dados
%Dados da EDO
m=1125;
k=125000;
csi=0.05;
%Carga Harmônica
p0=500;
W=105;
%Cálculos preliminares
w=sqrt(k/m);
c=2*m*w*csi;
%Dados sobre o tempo
t(1)=0;
dt=0.00005;
n=100000;
t(2)=t(1)+dt;
%Constantes
b0=2/dt;
b1=4/dt/dt;
b2=1;
b3=0;
b4=4/dt;
b5=1;
Kc=(b1*m+b0*c+k);
a1=(b4*m+b2*c);
a2=(b5*m+b3*c);
%Condições iniciais
u(1)=100e-6;
up(1)=2e-3;
upp(1)=-2*csi*w*up(1)-w^2*u(1);
%Loop do carregamento
for k=1:n
    t(k+1)=t(k)+dt;
    P(k)=p0*sin(W*t(k));
end
du(1)=(P(k)+up(1)*(b4*m+b2*c)+upp(1)*(b5*m+b3*c)-u(1)*k)/Kc;
%Equações
u(2)=u(1)+du(1);
up(2)=b0*du(1)-b2*up(1)-b3*upp(1);
upp(2)=b1*du(1)-b4*up(1)-b5*upp(1);
%Loop Principal
for i=2:n
    t(i+1)=t(i)+dt;
    du(i)=(P(k-i+1)+up(i)*(b4*m+b2*c)+upp(i)*(b5*m+b3*c)-u(i)*k)/Kc;
    u(i+1)=u(i)+du(i);
    up(i+1)=b0*du(i)-b2*up(i)-b3*upp(i);
    upp(i+1)=b1*du(i)-b4*up(i)-b5*upp(i);
end
%Deslocamento no Tempo
plot(t,u)
pause
%Velocidade no tempo
plot(t,up)
pause
%Plano de fase
plot(u,up)
pause
%arquivo diferencas_finitas_asa.m
%novembro 2021 - Baseado em rotinas desenvolvidas pelo Prof. Reyolando Brasil
%integra��o no tempo por diferen�as finitas
%v�rios graus de liberdade
%Exemplo: trelica modal
clear all
close all
clc
%
nn=2;
M=[40.0 7.5;
   7.5  40.0] %kg

K=1e6*[2.33  -1.25;
       -1.25  2.33]  %N/m
       
QSI =   [0.05;
        0.05]
    
IMK = inv(M)*K;
[LBV LB] = eig(IMK);
LBV
OM = LB.^0.5;
w1 = OM(1,1)
w2 = OM(2,2)
MOM = 1/2*[1/w1 w1;
         1/w2  w2]
IMOM = inv(MOM);
AA = IMOM*QSI;
a0 = AA(1)
a1 = AA(2)

C = a0*M + a1*K

M = LBV'*M*LBV
C = LBV'*C*LBV
K = LBV'*K*LBV

tf=0.6; %tempo final em segundos
h=0.001;% passo de integra��o em segundos
np=tf/h; % n�mero de passos de integra��o
p=zeros(nn,np);%vetor de carregamento
u=zeros(nn,np);%vetor de deslocamentos
up=zeros(nn,np);%vetor de velocidades
t=zeros(np);
dp=zeros(np,1);

%constantes do m�todo
%
KC=M/h/h+C/2/h;A1=2*M/h/h-K;A2=C/2/h-M/h/h;
%

% condi��es inciais
p(:,1)=cargasa(t(1));%chamar fun��o carregamento%
p(:,1)=LBV'*p(:,1);
upp=M\(p(:,1)-C*up(:,1)-K*u(:,1));%acelera��o incial
u(:,2)=upp*h*h/2+h*up(:,1)+u(:,1);%deslocamento no in�cio do segundo passo
%
%loop principal
%
for n=2:np
    t(n)=t(n-1)+h;
    
    p(:,n)=cargasa(t(n)); %chamar fun��o carregamento
    p(:,n)=LBV'*p(:,n);
    
    pc=p(:,n)+A1*u(:,n)+A2*u(:,n-1);
    u(:,n+1)=KC\pc;
    up(:,n)=(u(:,n+1)-u(:,n-1))/(2*h);
end

%
%plotagem de deslocamentos
%
% dire��o 1
%
u = LBV*u;

for i=1:np
    dp(i,1)=u(1,i);
end
plot(t,dp)
xlabel('t (s)')
ylabel('Deslocamentos dira��o 1 (m)')
grid
pause

%plotagem de deslocamentos
%
% dire��o 2
%
for i=1:np
    dp(i,1)=u(2,i);
end
plot(t,dp)
xlabel('t (s)')
ylabel('Deslocamentos dira��o 2 (m)')
grid
pause
%
%plotagem de deslocamentos
%
% dire��o 1 primeiro modo
%
u = LBV'*u;

for i=1:np
    dp(i,1)=LBV(1,1)*u(1,i);
end
plot(t,dp)
xlabel('t (s)')
ylabel('Deslocamentos dira��o 1 (m) PRIMEIRO MODO')
grid
pause

% dire��o 2 primeiro modo
%

for i=1:np
    dp(i,1)=LBV(2,1)*u(1,i);
end
plot(t,dp)
xlabel('t (s)')
ylabel('Deslocamentos dira��o 2 (m) PRIMEIRO MODO')
grid
pause

%plotagem de deslocamentos
%
% dire��o 1 segundo modo
%

for i=1:np
    dp(i,1)=LBV(1,2)*u(2,i);
end
plot(t,dp)
xlabel('t (s)')
ylabel('Deslocamentos dira��o 1 (m) SEGUNDO MODO')
grid
pause

% dire��o 2 primeiro modo
%

for i=1:np
    dp(i,1)=LBV(2,2)*u(2,i);
end
plot(t,dp)
xlabel('t (s)')
ylabel('Deslocamentos dira��o 2 (m) SEGUNDO MODO')
grid




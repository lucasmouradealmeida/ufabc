%arquivo diferencas_finitas_asa.m
%outubro 2020 - Baseado rotinas desenvolvida por Prof. Reyolando Brasil
%integração no tempo por diferenças finitas
%vários graus de liberdade
%Exemplo: asa
clear all
close all
clc
%
nn=4;
M=[1.0   0.0   0.0  0.0;
   0.0   1.0   0.0  0.0;
   0.0   0.0   1.0  0.0;
   0.0   0.0   0.0  1125];
C=[1.0   0.0   0.0  0.0;
   0.0   1.0   0.0  0.0;
   0.0   0.0   1.0  0.0;
   0.0   0.0   0.0  1185.85];
K=[1.0   0.0   0.0  0.0;
   0.0   1.0   0.0  0.0;
   0.0   0.0   1.0  0.0;
   0.0   0.0   0.0  125000];

%
tf=6.0; %tempo final em segundos
h=0.00060;% passo de integração em segundos
np=tf/h; % número de passos de integração
p=zeros(nn,np);%vetor de carregamento
u=zeros(nn,np);%vetor de deslocamentos
up=zeros(nn,np);%vetor de velocidades
t=zeros(np);
dp=zeros(np,1);

%constantes do método
%
KC=M/h/h+C/2/h;A1=2*M/h/h-K;A2=C/2/h-M/h/h;
%
% condições inciais
u(4) = 0.0;
up(4) = 0.0;
t(1)=0;
p(:,1)=cargasa(t(1));%chamar função carregamento
%
upp=M\(p(:,1)-C*up(:,1)-K*u(:,1));%aceleração incial
u(:,2)=upp*h*h/2+h*up(:,1)+u(:,1);%deslocamento no início do segundo passo
%
%loop principal
%
for n=2:np
    t(n)=t(n-1)+h;
    p(:,n)=cargasa(t(n)); %chamar função carregamento
    pc=p(:,n)+A1*u(:,n)+A2*u(:,n-1);
    u(:,n+1)=KC\pc;
    up(:,n)=(u(:,n+1)-u(:,n-1))/(2*h);
end
%
%plotagem de deslocamentos
%
% direção 1
%
for i=1:np
    dp(i,1)=u(4,i);
end
plot(t,dp)
xlabel('t (s)')
ylabel('Deslocamentos diração 4 (m)')
grid



    
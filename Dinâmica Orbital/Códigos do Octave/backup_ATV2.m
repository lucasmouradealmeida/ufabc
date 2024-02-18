#Sistema Dinâmico Sol-Júpiter-Partícula
clear all;
clc;
clf;

tic;
#Unidades de medidas: SI


#Localização dos pontos Lagrangeanos


#Massa do Sol
m1 = 1.989*10^30; %no SI
#Massa de Júpiter
m2 = 1.898*10^27;
#Distância entre a Sol e Júpiter
r12 = 748.41*10^9;


#Exemplo da Aulas !!!!!! Para conferir valores obtidos

#Massa de Terra
m1 = 5.972*10^24;
#Massa da Lua
m2 = 7.348*10^22;
#Distância entre a Terra e Lua
r12 = 3.844*10^5;


mi = (m2)/(m1+m2);

#https://www.youtube.com/watch?v=7MviJPvTM_Y

#Pontos L4 e L5
L4 = [-mi+0.5 sqrt(3)/2];
L5 = [L4(1,1) -L4(1,2)];

#Pontos L1, L2 & L3
rt = zeros(5,1);
x = -100;
k = 1;
c = 6;

#Teorema de Bolzano

while k < c
    f0 =  x - (((1-mi)/((abs(x+mi))^3))*(x+mi)) - ((mi/((abs(x-1+mi))^3))*(x-1+mi));
    x = x + 0.005;
    f1 =  x - (((1-mi)/((abs(x+mi))^3))*(x+mi)) - ((mi/((abs(x-1+mi))^3))*(x-1+mi));
    
    if f0>0 && f1<0
        rt(k,1) = x - 0.005;
        k = k + 1;
    elseif f1>0 && f0<0
        rt(k,1) = x - 0.005;
        k = k + 1;
    end
end


#Valores Iniciais rt(1,1)//rt(3,1)//rt(5,1)


Er = 10^-8;
z = 1;
Lx = ones(3,1);
j = 0;

#Método de Newton-Raphson
for i=1:2:5
    
    x0 = rt(i,1);
    Erx = 1;

    while Erx > Er
        
        fx =  x0 - (((1-mi)/((abs(x0+mi))^3))*(x0+mi)) - ((mi/((abs(x0-1+mi))^3))*(x0-1+mi));
        
        fx_d = ((3*mi*((mi+x0-1)^2))/((abs(mi+x0-1))^5))-((mi)/((abs(mi+x0-1))^3))-((1-mi)/((abs(mi+x0))^3))+((3*(1-mi)*((mi+x0)^2))/((abs(mi+x0))^5))+(1);      
        
        x = x0 - (fx/fx_d);
        Erx = (abs(x0-x))/(abs(x));
        x0 = x;
    end
    
    Lx(z,1) = x;
    z = z + 1;
end

disp(rt);
disp("----");
disp(Lx);





#Curvas de Velocidade Zero
G = 6.674*10^-11; %SI
%Sol
mi_1 = G*m1;
%Jupiter
mi_2 = G*m2;

% Cj - chutes 
CL1 = (3) + (3^(3/4))*(mi_2^(2/3))-((10*mi_2)/3); 
CL2 = (3) + (3^(3/4))*(mi_2^(2/3))-((14*mi_2)/3); 
CL3 = 3 + mi_2;
CL4 = 3 - mi_2;
CL5 = CL4;

Cj = -1.66;
%Cj = -1.6735;

j = 0.1*r12;
k= 1.5*r12;

disp(mi_1);
disp(mi_2);
disp(Cj);

x = -k:j:k;
y = -k:j:k;
[X,Y] = meshgrid(x,y);

Z= X.^2 + Y.^2 + 2.*((mi_1./(sqrt(X.^2 + Y.^2))) + (mi_2./sqrt((X-1).^2 + (Y).^2))) - Cj;
        
%VER DISTANCIA L4 E L5
#GRAFICO
x1 = mi*r12
L = [L4*r12; L5*r12; Lx(1,1)*r12+x1 0; Lx(2,1)*r12+x1 0; Lx(3,1)*r12+x1 0];
scatter(L(:,1),L(:,2),'filled')
hold on
contour(X,Y,Z) %contour(X,Y,Z,15)
grid on
        

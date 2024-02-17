function [y_Euler,y_RK2,y_RK4] = edonumerica(h)

clc;

% PVI
function [resp]=f(x,y)
resp=x+y;
end
x_inicio=0 ; y_inicio=2;
x_fim=1;

% Solução Exata
function [resp]=y(x)
resp=-x-1+3*exp(x);
end

% Inicialização
x=x_inicio:h:x_fim;
y_Euler=zeros(1,length(x)); y_Euler(1)=y_inicio;
y_RK2=zeros(1,length(x));   y_RK2(1)=y_inicio;
y_RK4=zeros(1,length(x));   y_RK4(1)=y_inicio;
y_exato=y(x);


% Tabela
fprintf('    x       Euler       R-K 2       R-K 4       Exato \n')  
fprintf ('  %1.2f  %10.4f  %10.4f  %10.4f  %10.4f \n',x(1),y_Euler(1),y_RK2(1),y_RK4(1),y_exato(1));

% Cálculo dos Métodos
for i=1:length(x)-1
    
    % Euler
    y_Euler(i+1)= y_Euler(i)+h*f(x(i),y_Euler(i));
    
    % RK de segunda ordem (Euler Modificado)
    k1=f(x(i),y_RK2(i));
    k2=f(x(i)+h/2,y_RK2(i)+(h/2)*k1);
    y_RK2(i+1)=y_RK2(i)+h*k2;
    
    % RK de quarta ordem 
    k1=f(x(i),y_RK4(i));
    k2=f(x(i)+h/2,y_RK4(i)+(h/2)*k1);
    k3=f(x(i)+h/2,y_RK4(i)+(h/2)*k2);  
    k4=f(x(i)+h,y_RK4(i)+h*k3);
    y_RK4(i+1)=y_RK4(i)+(h/6)*(k1+2*k2+2*k3+k4);
    
    fprintf ('  %1.2f  %10.4f  %10.4f  %10.4f  %10.4f\n',x(i+1),y_Euler(i+1),y_RK2(i+1),y_RK4(i+1),y_exato(i+1));
    
end 
    
end

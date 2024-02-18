#Matriz de Rotação
#Código que recebe os elementos keplerianos e retorna a matriz de rotação em conjunto com os vetores de posição e velocidade caso queira ser calculado

clc;
w = input("s: orbital / S: Inercial \n -------- Lembrando: s = Moi*S e S = Mio*s \n--------------------w?");
i = input('i?');
omega = input('omega?');

Mz_w = [cos(w) sin(w) 0; -sin(w) cos(w) 0; 0 0 1];
Mx_i = [1 0 0; 0 cos(i) sin(i); 0 -sin(i) cos(i)];
Mz_omega = [cos(omega) sin(omega) 0; -sin(omega) cos(omega) 0; 0 0 1];

Moi = Mz_w * Mx_i * Mz_omega;
Mio = inv(Moi);

disp('orbital: s ou s_ponto // Inercial: S ou S_ponto');

option = input('Deseja calcular os vetores? s ou n','s''n');

if option == 's'
    caso = input('Qual sistema deseja obter? i (inercial) ou o (orbital)','i''o');
    
        if caso == 'i'
        disp('Vetores de posição no sistema orbital');
        sx = input('Componente i?');
        sy = input('Componente j?');
        sz = input('Componente k?');
        s = [sx; sy; sz];
        
        disp('Vetores de velocidade no sistema orbital');
        sx_ponto = input('Componente i?');
        sy_ponto = input('Componente j?');
        sz_ponto = input('Componente k?');
        s_ponto = [sx_ponto; sy_ponto; sz_ponto];
        
        disp('Vetor posição no sistema Inercial');
        S = Mio* s
        
        disp('Vetor velocidade no sistema Inercial');
        S_ponto = Mio* s_ponto
        
        else
        disp('Vetores de posição no sistema inercial');
        sx = input('Componente i?');
        sy = input('Componente j?');
        sz = input('Componente k?');
        s = [sx; sy; sz];
        
        disp('Vetores de velocidade no sistema inercial');
        sx_ponto = input('Componente i?');
        sy_ponto = input('Componente j?');
        sz_ponto = input('Componente k?');
        s_ponto = [sx_ponto; sy_ponto; sz_ponto];
        
        disp('Vetor posição no sistema orbital');
        S = Moi* s
        
        disp('Vetor velocidade no sistema orbital');
        S_ponto = Moi* s_ponto
            
        end
    
elseif option == 'n'
    disp('Ok');
end

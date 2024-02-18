%% Din�mica de Gases - Atividade 02 - Grupo 01 - Vapo
%% Descri��o: O presente script tem como prop�sito a resolu��o dos problemas propostos na segunda atividade de grupos da disciplina de Din�mica de Gases


%% Comandos iniciais

clear all         % Apaga todas as vari�veis
close all         % Fecha todas as figuras
clc               % Limpa a janela de comandos

%% Par�metros atmosf�ricos

pe = [0.10132,0.08988,0.07950,0.07012];   % Leque de press�es de sa�da para o bocal [MPa]
h = 0:1000:3000;                          % Altitude de opera��o [m]


%% Par�metros iniciais para o Motor

gamma = 1.1207;                % Raz�o de calores espec�ficos (Coeficiente de Poisson)
E = 16;                        % Raz�o de expans�o de �rea para o bocal
pc = 0.7;                      % Press�o no interior da c�mara de combust�o [MPa]
Ra = zeros(1,size(pe)(2));     % Raz�es de �reas para cada posi��o da OCN


%% In�cio do procedimento de c�lculo descrito no relat�rio

for k = 1:size(pe)(2)
    
    %% Passo 1: C�lculo do n�mero de Mach na sa�da do bocal

    Me = sqrt(-1/(gamma - 1) + sqrt(1/((gamma - 1)^2) + (2/(gamma - 1))*((2/(gamma + 1))^((gamma + 1)/(gamma - 1)))*(pc/(pe(k)*E))^2)); 


    %% Passo 2: C�lculo da raz�o entre as press�es total e est�tica a jusante da OCN

    Rpe = (1 + ((gamma - 1)/2)*Me^2)^(gamma/(gamma - 1));


    %% Passo 3: C�lculo da raz�o entre as press�es totais a jusante e a montante da OCN

    Rp0 = Rpe*(pe(k)/pc);


    %% Passo 4: C�lculo do n�mero de Mach a montante da OCN
    
    function y = f(M,gamma,Rp0)

      y = ((((gamma + 1)/(2 + (gamma - 1)*M^2))*M^2)^(gamma/(gamma - 1)))*((gamma + 1)/(2*gamma*M^2 - (gamma - 1)))^(1/(gamma - 1)) - Rp0;

    endfunction

    f = @(M) f(M,gamma,Rp0);
    M1 = fzero(f, [1,10]);     % N�mero de Mach a montante da OCN


    %% Passo 5: Determina��o da localiza��o da OCN

    Ra(k) = sqrt((1/M1^2)*((2/(gamma + 1))*(1 + ((gamma - 1)/2)*M1^2))^((gamma + 1)/(gamma - 1)));
    
endfor


%% Constru��o do gr�fico

Ra_max = E*ones(1,size(pe)(2));  % Vetor correspondente �raz�o de expans�o de �rea do motor
figure, plot(Ra,h,'-*b',Ra_max,h,'r'), grid on, title('Altitude vs Raz�o de Expans�o'), xlabel('Raz�o de �reas'), ylabel('Altitude (m)'), legend('OCN com altitude','Sa�da do bocal','location','northwest');               % Posi��o de forma��o da OCN em fun��o da altitude
%% Dinâmica de Gases - Atividade 02 - Grupo 01 - Vapo
%% Descrição: O presente script tem como propósito a resolução dos problemas propostos na segunda atividade de grupos da disciplina de Dinâmica de Gases


%% Comandos iniciais

clear all         % Apaga todas as variáveis
close all         % Fecha todas as figuras
clc               % Limpa a janela de comandos

%% Parâmetros atmosféricos

pe = [0.10132,0.08988,0.07950,0.07012];   % Leque de pressões de saída para o bocal [MPa]
h = 0:1000:3000;                          % Altitude de operação [m]


%% Parâmetros iniciais para o Motor

gamma = 1.1207;                % Razão de calores específicos (Coeficiente de Poisson)
E = 16;                        % Razão de expansão de área para o bocal
pc = 0.7;                      % Pressão no interior da câmara de combustão [MPa]
Ra = zeros(1,size(pe)(2));     % Razões de áreas para cada posição da OCN


%% Início do procedimento de cálculo descrito no relatório

for k = 1:size(pe)(2)
    
    %% Passo 1: Cálculo do número de Mach na saí­da do bocal

    Me = sqrt(-1/(gamma - 1) + sqrt(1/((gamma - 1)^2) + (2/(gamma - 1))*((2/(gamma + 1))^((gamma + 1)/(gamma - 1)))*(pc/(pe(k)*E))^2)); 


    %% Passo 2: Cálculo da razão entre as pressões total e estática a jusante da OCN

    Rpe = (1 + ((gamma - 1)/2)*Me^2)^(gamma/(gamma - 1));


    %% Passo 3: Cálculo da razão entre as pressões totais a jusante e a montante da OCN

    Rp0 = Rpe*(pe(k)/pc);


    %% Passo 4: Cálculo do número de Mach a montante da OCN
    
    function y = f(M,gamma,Rp0)

      y = ((((gamma + 1)/(2 + (gamma - 1)*M^2))*M^2)^(gamma/(gamma - 1)))*((gamma + 1)/(2*gamma*M^2 - (gamma - 1)))^(1/(gamma - 1)) - Rp0;

    endfunction

    f = @(M) f(M,gamma,Rp0);
    M1 = fzero(f, [1,10]);     % Número de Mach a montante da OCN


    %% Passo 5: Determinação da localização da OCN

    Ra(k) = sqrt((1/M1^2)*((2/(gamma + 1))*(1 + ((gamma - 1)/2)*M1^2))^((gamma + 1)/(gamma - 1)));
    
endfor


%% Construção do gráfico

Ra_max = E*ones(1,size(pe)(2));  % Vetor correspondente à razão de expansão de área do motor
figure, plot(Ra,h,'-*b',Ra_max,h,'r'), grid on, title('Altitude vs Razão de Expansão'), xlabel('Razão de Áreas'), ylabel('Altitude (m)'), legend('OCN com altitude','Saída do bocal','location','northwest');               % Posição de formação da OCN em função da altitude
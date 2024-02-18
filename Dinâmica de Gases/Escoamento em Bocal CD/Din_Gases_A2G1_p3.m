%%% Dinâmica de Gases - Atividade 02 - Grupo 01 - Vapo
%%% Descrição: O presente script tem como propósito a resolução do problema propostos na
%%% terceira parte da segunda atividade de grupos da disciplina de Dinâmica de Gases

%% Comandos iniciais

clear all         % Apaga todas as variáveis
close all         % Fecha todas as figuras
clc               % Limpa a janela de comandos

%% Parâmetros iniciais para o motor

gamma = 1.1207;                % Razão de calores específicos (Coeficiente de Poisson)
E = 16;                        % Razão de expansão de área para o bocal
pc1 = 7;                       % Pressão no interior da câmara de combustão (sem falhas) [MPa]
pc2 = 0.7;                     % Pressão no interior da câmara de combustão (com falhas) [MPa]

%% Cálculo das pressões atmosféricas nas quais o escoamento é isentrópico no bocal

f1 = @(pe) f(E,gamma,pc1,pe);
pe1 = fzero(f1,0.05)

f2 = @(pe) f(E,gamma,pc2,pe);
pe2 = fzero(f2,0.05)

%% Definição da função auxiliar

function y = f(E,gamma,pc,pe)
  
  y = (((gamma + 1)/2)^(1/(gamma - 1)))*((pe/pc)^(1/gamma))*sqrt(((gamma + 1)/(gamma - 1))*(1 - (pe/pc)^((gamma - 1)/gamma))) - 1/E;
  
end
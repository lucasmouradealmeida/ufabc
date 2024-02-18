%%% Din�mica de Gases - Atividade 02 - Grupo 01 - Vapo
%%% Descri��o: O presente script tem como prop�sito a resolu��o do problema propostos na
%%% terceira parte da segunda atividade de grupos da disciplina de Din�mica de Gases

%% Comandos iniciais

clear all         % Apaga todas as vari�veis
close all         % Fecha todas as figuras
clc               % Limpa a janela de comandos

%% Par�metros iniciais para o motor

gamma = 1.1207;                % Raz�o de calores espec�ficos (Coeficiente de Poisson)
E = 16;                        % Raz�o de expans�o de �rea para o bocal
pc1 = 7;                       % Press�o no interior da c�mara de combust�o (sem falhas) [MPa]
pc2 = 0.7;                     % Press�o no interior da c�mara de combust�o (com falhas) [MPa]

%% C�lculo das press�es atmosf�ricas nas quais o escoamento � isentr�pico no bocal

f1 = @(pe) f(E,gamma,pc1,pe);
pe1 = fzero(f1,0.05)

f2 = @(pe) f(E,gamma,pc2,pe);
pe2 = fzero(f2,0.05)

%% Defini��o da fun��o auxiliar

function y = f(E,gamma,pc,pe)
  
  y = (((gamma + 1)/2)^(1/(gamma - 1)))*((pe/pc)^(1/gamma))*sqrt(((gamma + 1)/(gamma - 1))*(1 - (pe/pc)^((gamma - 1)/gamma))) - 1/E;
  
end
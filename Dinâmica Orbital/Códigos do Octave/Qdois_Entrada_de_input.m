# Entrada de dados, validação e cabeçalho

# Declaração de Variaveis
i = 1;
u = 1;


while i > 0 

    M0 = input(" Primeira atividade da disciplica Dinamica Orbital em Octave dos alunos: \n - Lucas Moura de Almeida \n ---- RA:11201811415 \n - Gabriel Moraes de Souza \n ---- RA:11201811286 \n\n----------------------------\nObs.: Não se esqueça de usar ponto ao invez de virgula e inputar a anomalia média em graus\n----------------------------\nQual a anomalia média?");
    e = input("Qual a excentricidade?");
    
    if e < 0 | e == 1
        disp("\n\ndigite valores válidos de excentricidade \n Parabolas não estão contempladas nesta rotina");
        i ++;
        pause(3);
        clc
    else
        i = -1;
    
    end
end

while u > -1;
    g = input("\nGostaria de escolher o valor de parada do calculo? (s/n)",'s''n');

    if g == "s";
        i = input("diga o valor");
        u = -2;
     
    elseif g == "n";
        u = -2;    
        i = 10^-8; # erro relativo do metodo numerico por padrão
    else
        u++;
    end
end

M = deg2rad(M0); 

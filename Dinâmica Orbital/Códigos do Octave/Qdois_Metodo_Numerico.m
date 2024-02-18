# metodo numerico de Newton Raphson

# declaração de varaiveis
Erx = 100;
u = 0;
j = 1;
teta0 = 0;



# calculo para o valor inicial
if M < pi
    u0 = M + (e/2);

else
    u0 = M - (e/2);

end

# Segmentação da cônicas 
if e > 1 # equacao para hiperbóle
    Qdois_hiperbole;
        
else # equação para a Elipse  
    Qdois_elipse;
        
end


#relatorio do método computacional
fprintf('valor do erro: %d\n',Erx); 
fprintf('Iteracoes: %d\n',j);

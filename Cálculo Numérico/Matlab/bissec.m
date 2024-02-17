% function [saída] = nome (entrada)
function [x] = bissec (a,b,n)
% INPUT
% a,b : extremos do intervalo que contém a raiz
% n: número de interações

domx=a:0.001:b;

if f(a)*f(b)<0
    fprintf('   %s         %s        %s \n', 'a','x','b');
    cont=1;
    while cont<=n
        x=(a+b)/2;
        fprintf('%2.5f %2.5f %2.5f \n',a,x,b);
        if f(a)*f(x)<0
            b=x;
        else
            a=x;
        end
        cont=cont+1;
    end
    
    plot(domx,f(domx));
    hold on;
    plot(x,f(x),'or');
    plot(domx,zeros(length(domx)),'k');


else
    disp('Porra meu ! Chama o Bolzano');
end


function [y] = f(x)
   y=x.^2-sin(x)-1;
end


end
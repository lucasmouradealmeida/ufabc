function [resposta] = simpson1_3 (a,b,n)

if (n>=3) && mod (n,2)==1

    h=(b-a)/(n-1);
    
    pesos=ones(1,n);
    func=zeros(n,1);
    func(1)=f(a);
    func(n)=f(b);
    
    
    for i=2:n-1
        func(i)=f(a+(i-1)*h);
        if mod(i,2)==0
            pesos(i)=4;
        else
            pesos(i)=2;
        end
    end
    
    resposta=(h/3)*pesos*func;
    fprintf('%s %5.10f\n','A integral pelo método 1/3 Simpson é: ',resposta);
    
    
else
    disp ('n tem que ser maior ou igual à 3 e ímpar !');
end
    





    function [y]= f(x)
       y=exp(x)*cos(x);
    end


end
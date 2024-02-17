function [resposta] = simpson3_8 (a,b,n)

if (n>=4) && mod (n,3)==1

    h=(b-a)/(n-1);
    
    pesos=ones(1,n);
    func=zeros(n,1);
    func(1)=f(a);
    func(n)=f(b);
    
    
    for i=2:n-1
        func(i)=f(a+(i-1)*h);
        if mod(i,3)==1
            pesos(i)=2;
        else
            pesos(i)=3;
        end
    end
    
    resposta=(3*h/8)*pesos*func;
    fprintf('%s %5.10f\n','A integral pelo método 3/8 Simpson é: ',resposta);
    
    
else
    disp ('n tem que ser maior ou igual à 4 da forma 3k+1 !');
end
    





    function [y]= f(x)
       y=exp(x)*cos(x);
    end


end
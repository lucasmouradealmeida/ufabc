function [resp] = trap(a,b,n)

h=(b-a)/(n-1);

x=a:h:b;
y=f(x);

resp=(y(1)+y(end))*(h/2);
for i=2:n-1
    resp=resp+(h/2)*2*y(i);
end




function [y] = f(x)
   y=log(x);
end

end
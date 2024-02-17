% Este programa resolve um sistema linear Ax=b
% através do método de eliminação de Gauss
function [x] = gauss (A,b)

[lin,col]=size(A);

if (lin<col) || (lin>col)
    error('Porra meu !');
else
   for c=1:col-1;
       for l=c+1:lin;
           b(l)=(A(l,c)/A(c,c))*b(c)-b(l);
           for ind=c+1:col
               A(l,ind)=(A(l,c)/A(c,c))*A(c,ind)-A(l,ind);
           end
           A(l,c)=0;
       end
   end
   
   x=zeros(lin,1);
   for l=lin:-1:1
       x(l)=(b(l)-(A(l,:)*x))/A(l,l);
   end
   
end


end
        
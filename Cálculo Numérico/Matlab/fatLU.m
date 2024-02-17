function [ L,U ] = fatLU( A )

n=length(A);
L=eye(n);
U=A;

for j=1:n-1
    for i=j+1:n
        L(i,j) = U(i,j)/U(j,j);
        for k=j+1:n
            U(i,k) = U(i,k) - L(i,j)*U(j,k);
            U(i,j) = 0;
        end
    end
end


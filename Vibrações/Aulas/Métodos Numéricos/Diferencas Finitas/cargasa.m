function f=cargasa(t)
%calcula o carregamento em cada instante de tempo
%carga de impacto
%Prof. Marcelo Araujo da Silva
%Baseado em rotinas desenvolvida pelo Prof. Reyolando Brasil
p0=2000;    %impacto de 200 kgf
Dt=0.1;     %duracao do impacto
f(1)=0;
f(2)=0;
f(3)=0;
if t<Dt
 f(4) = p0*(1-t/Dt);
else
 f(4) = 0.0;
end


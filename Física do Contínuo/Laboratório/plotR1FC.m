%%
%PARTE 1
clc
clf
y = [42.21 30.06 20.35 13.63 8.25 5.12];
x = [0.09 0.0625 0.04 0.0225 0.01 0.0025];
erry = [13 11 9 0.4 0.4 0.3];
errx = [0.0003 0.0003 0.0002 0.0002 0.0001 0.00005];
errorbar(x,y,erry,erry,errx,errx)
hold on
s = scatter(x,y,230,'k')
m = s.Marker;
s.Marker = '.';
hold on
coef = polyfit(x,y,1);
y = polyval(coef,x);
plot(x,y,'Color','k')
ylabel('Período ao quadrado [s^2]')
xlabel('Raio ao quadrado [m^2]')
%title('T^2 vs R^2')
grid on
%%
%PARTE 2
clc
clf
y = [0.0137 0.0142 0.0191 0.0231 0.0295];
x = [0 0.0016 0.0064 0.0144 0.0256];
erry = [0.0002 0.0002 0.0004 0.0002 0.0001];
errx = [0 0.00004 0.00008 0.0001 0.0002];
errorbar(x,y,erry,erry,errx,errx,'LineStyle','none')
hold on
s = scatter(x,y,230,'k')
m = s.Marker;
s.Marker = '.';
hold on
coef = polyfit(x,y,1);
y = polyval(coef,x);
plot(x,y,'Color','k')
ylabel('Momento de Inércia [kg.m^2]')
xlabel('Distância do eixo ao quadrado [m^2]')
%title('Ja vs a^2')
grid on
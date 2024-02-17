clc
clf
y = [0.840 0.800 0.730 0.640 0.610 0.530 0.500 0.420];
x = [0.000 0.002 0.012 0.022 0.032 0.042 0.052 0.062];
erry = [0.003 0.003 0.003 0.003 0.003 0.003 0.003 0.003];
errx = [0.0005 0.0005 0.0005 0.0005 0.0005 0.0005 0.0005 0.0005];
errorbar(x,y,erry,erry,errx,errx)
hold on
s = scatter(x,y,230,'k')
m = s.Marker;
s.Marker = '.';
hold on
coef = polyfit(x,y,1);
y = polyval(coef,x);
plot(x,y,'Color','k')
ylabel('Peso Aparente [N]','FontWeight', 'bold')
xlabel('Altura [m]','FontWeight', 'bold')
%title('Title')
grid on
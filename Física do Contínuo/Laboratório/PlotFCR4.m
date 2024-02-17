clc
clf
%x = [0.00 0.01 0.02 0.03 0.04 0.05 0.06 0.07 0.08 0.09 0.10];
x = [0.00 0.0060 0.0130 0.0250 0.0370 0.0470 0.0570 0.0690 0.0810 0.0880 0.10];
y = [0 98 196 294 392 490 588 686 784 882 980];
erry = [5 5 5 5 5 5 5 5 5 5 5];
errx = [0.0005 0.0005 0.0005 0.0005 0.0005 0.0005 0.0005 0.0005 0.0005 0.0005 0.0005];
errorbar(x,y,erry,erry,errx,errx)
hold on
s = scatter(x,y,230,'k');
m = s.Marker;
s.Marker = '.';
hold on
coef = polyfit(x,y,1);
y = polyval(coef,x);
plot(x,y,'Color','k')
ylabel('Pressão manométrica [N/m^2]','FontWeight', 'bold')
xlabel('Variação de altura no manômetro  [m]','FontWeight', 'bold')
grid on



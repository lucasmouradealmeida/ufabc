#Anomalia Excêntrica
x = -pi:(5*pi/180):pi;
#Anomalia Média
y1 = x - (0.01*sin(x)); #e=0.01
y2 = x - (0.3*sin(x));#e=0.3
y3 = x - (0.6*sin(x));#e=0.6
y4 = x - (0.9*sin(x));#e=0.9
#Geração dos gráficos
plot(x,y1,'LineWidth',2,'color','blue');
hold on
plot(x,y2,'LineWidth',2,'color','red');
hold on
plot(x,y3,'LineWidth',2,'color','black');
hold on
plot(x,y4,'LineWidth',2,'color','yellow');
title('Anomalia Média vs Anomalia Excêntrica','fontweight','bold','fontsize',15);
xlabel('Anomalia Excêntrica','fontweight','bold','fontsize',12);
ylabel('Anomalia Média','fontweight','bold','fontsize',12);
hold off
grid on
set(gca,'XTick',(-4:1:4));
set(gca,'YTick',(-4:1:4));
legend({'e=0,01','e=0,3','e=0,6','e=0,9'},'Location','northwest');
set(gca,'TickLength',[0.002, 0.002]);
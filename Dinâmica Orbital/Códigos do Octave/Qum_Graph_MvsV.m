%Anomalia Verdadeira
t = -pi:(5*pi/180):pi;
%Anomalia Média
y1 = (2*(atan((tan(t/2))/(sqrt((1+0.01)/(1-0.01)))))) - (0.01*sin(2*(atan((tan(t/2))/(sqrt((1+0.01)/(1-0.01))))))); %e=0.01
y2 = (2*(atan((tan(t/2))/(sqrt((1+0.3)/(1-0.3)))))) - (0.3*sin(2*(atan((tan(t/2))/(sqrt((1+0.3)/(1-0.3)))))));%e=0.3
y3 = (2*(atan((tan(t/2))/(sqrt((1+0.6)/(1-0.6)))))) - (0.6*sin(2*(atan((tan(t/2))/(sqrt((1+0.6)/(1-0.6)))))));%e=0.6
y4 = (2*(atan((tan(t/2))/(sqrt((1+0.9)/(1-0.9)))))) - (0.9*sin(2*(atan((tan(t/2))/(sqrt((1+0.9)/(1-0.9)))))));%e=0.9
%Geração dos gráficos
plot(x,y1,'LineWidth',2,'color','blue');
hold on
plot(x,y2,'LineWidth',2,'color','red');
hold on
plot(x,y3,'LineWidth',2,'color','black');
hold on
plot(x,y4,'LineWidth',2,'color','yellow');
title('Anomalia Média vs Anomalia Verdadeira','fontweight','bold','fontsize',15);
xlabel('Anomalia Verdadeira','fontweight','bold','fontsize',12);
ylabel('Anomalia Média','fontweight','bold','fontsize',12);
hold off
grid on
set(gca,'XTick',(-4:1:4));
set(gca,'YTick',(-4:1:4));
legend({'e=0,01','e=0,3','e=0,6','e=0,9'},'Location','northwest');
set(gca,'TickLength',[0.002, 0.002]);
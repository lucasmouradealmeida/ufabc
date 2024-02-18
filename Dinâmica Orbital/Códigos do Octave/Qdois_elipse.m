#Anomalia media para excêntrica para elipse (M = u - e senu) -> (u - esenu - M = 0)


while i <= Erx
    u = u0 - ((u0 - e*sin(u0) - M)/(1 - e*cos(u0)));
    Erx = abs((u0-u)/(u));
    u0 = u;
    j++;
        
end
      
#Anomalia Verdadeira
teta0 = 2*atan((sqrt( ((1+e)/(1-e)))*tan(u/2)));
    
    
# Conversão de valores
u = rad2deg(u0);
teta = rad2deg(teta0);
        
        
#Caso as anomalias ultrapassem 360graus
#Anomalia Excentrica (u)
if u > 360 | u < -360
    u = u - (360*fix(u/360));
end

#Anomalia Verdadeira (Theta)
if teta > 360 | teta < -360
    teta = teta - (360*fix(teta/360));
end
    
# prints
fprintf('A anomalia excentrica é: %d graus\n',u); 
fprintf('A anomalia verdadeira é: %d graus\n',teta);
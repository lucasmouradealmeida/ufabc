#Manobra Orbital: Hohmann & Bi-Elíptica - processo simplificado (tangente)
clc;

r1 = input(" Coloque os valores no SI \n\n Raio da orbita inicial? ");
r2 = input('Raio da orbita final?');

m = input('Qual método deseja utilizar (1-H 2-B)?');

#váriaveis para serem utilizadas
mi = 3.986*(10^14);

if m == 1
    #deltaV1 = Ve1 - Vc1
    at = ((r1+r2)/2);
    Vc1 = sqrt(2*((mi/r1)-(mi/(2*r1))));
    Ve1 = sqrt(2*((mi/r1)-(mi/(2*at))));
    delta_v1 = Ve1 - Vc1;
    #deltaV2 = Vc2 - Ve2
    Ve2 = sqrt(2*((mi/r2)-(mi/(2*at))));
    Vc2 = sqrt(2*((mi/r2)-(mi/(2*r2))));
    delta_v2 = Vc2 - Ve2;
    delta_vtotal = abs(delta_v1)+abs(delta_v2);
    
    t_manobra = pi*sqrt((at^3)/(mi));
    fprintf('A velocidade total é %d m/s\n',delta_vtotal);
    fprintf('O tempo de manobra é %d segundos\n', t_manobra);
elseif m == 2
    ra = input('Raio do apogeu para a elipse 1?');
    a1 = ((r1+ra)/2);
    a2 = ((ra+r2)/2);
    
    #deltaV0 = Ve1 - Vc1
    Vc1 = sqrt(2*((mi/r1)-(mi/(2*r1))));
    Ve1 = sqrt(2*((mi/r1)-(mi/(2*a1))));
    delta_v0 = Ve1 - Vc1;
    
    #deltaV1 = Ve2 - Ve1_a
    Ve2 = sqrt(2*((mi/ra)-(mi/(2*a2))));
    Ve1_a = sqrt(2*((mi/ra)-(mi/(2*a1))));
    delta_v1 = Ve2 - Ve1_a;

    #deltaV2 = Vc2 - Ve2_p
    Ve2_p = sqrt(2*((mi/r2)-(mi/(2*a2))));
    Vc2 = sqrt(2*((mi/r2)-(mi/(2*r2))));
    delta_v2 = Vc2 - Ve2_p;
    
    delta_vtotal = abs(delta_v0)+abs(delta_v1)+abs(delta_v2);
    
    t_manobra = pi*sqrt((a1^3)/(mi)) + pi*sqrt((a2^3)/(mi));
    fprintf('A velocidade total é %d m/s\n',delta_vtotal);
    fprintf('O tempo de manobra é %d segundos\n', t_manobra);

else
    disp('Digite valor válido');    
end


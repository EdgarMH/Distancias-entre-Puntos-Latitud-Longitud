% Distancia ortodrómica entre dos puntos

% Introduzca las coordenadas en los cuadros de texto para probar los cálculos.
% Se acepta el formato de grados grados decimales con signo sin dirección de la brújula,
% donde el negativo indica el oeste/sur (por ejemplo, 40,7486, -73,9864):

printf('\nDistancia ortodrómica entre dos puntos\n')
printf('introduzca las coordenadas.\n')
printf('Se acepta el formato de grados decimales, con signo positivo para N y E y negativo para S y O\n\n')

#phi es latitud, lambda es longitud, R el radio de la tierra
#Los angulos serán en radianes
%lat1 = 50.06;
%lat2 = 58.64;
%lon1 = 5.71;
%lon2 = 3.07;

lat1 = input('Introduce la latitud del punto 1: ');
lon1 = input('Introduce la longitud del punto 1: ');
lat2 = input('Introduce la latitud del punto 2: ');
lon2 = input('Introduce la longitud del punto 2: ');

R = 6371000; #metros

#Las operaciones van a ser en radianes, así que transformamos los datos dados en grados decimales.
phi1 = lat1*pi/180;
phi2 = lat2*pi/180;
Dphi = phi2 - phi1;
Dlambda = (lon2 - lon1)*pi/180;

#a es Haversine
a = sin(Dphi/2)^2 + cos(phi1)*cos(phi2)*sin(Dlambda/2)^2;

#formula
c = 2* atan2(sqrt(a),sqrt(1-a));
d = R*c; #en metros

sprintf('\nLa distancia en kilometros es %.2f Km\n', d/1000)
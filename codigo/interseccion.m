# Intersección de dos trayectorias dados los puntos de partida y Bearings
clear all
close all
clc

% Introduzca las coordenadas en los cuadros de texto para probar los cálculos.
% Se acepta el formato de grados decimales con signo sin dirección de la brújula,
% donde el negativo indica el oeste/sur.

printf('\nIntersección de dos trayectorias dados los puntos de partida y Bearings\n')
printf('\nIntroduzca los datos del punto inicial.\n')
printf('Se acepta el formato de grados decimales, con signo positivo (o sin signo) para N y E y negativo para S y O.\n\n')

# Introducimos los datos
lat1 = input('Introduce la latitud del punto 1: ');
lon1 = input('Introduce la longitud del punto 1: ');
brng1 = input('Introduce el Bearing del punto 1: ');
lat2 = input('Introduce la latitud del punto 2: ');
lon2 = input('Introduce la longitud del punto 2: ');
brng2 = input('Introduce el Bearing del punto 2: ');

# Las operaciones van a ser en radianes, así que transformamos los datos dados en grados decimales.
# phi es latitud, lambda es longitud, R el radio de la tierra
phi1 = lat1*pi/180;
lambda1 = lon1*pi/180;
bearing_1_3 = brng1*pi/180;
phi2 = lat2*pi/180;
lambda2 = lon2*pi/180;
bearing_2_3 = brng2*pi/180;
R = 6371000; #metros
Dphi = phi2 - phi1;
Dlambda = lambda2 - lambda1;

# Procedimiento

# Haversine
hav = sin(Dphi/2)^2 + cos(phi1)*cos(phi2)*sin(Dlambda/2)^2;

# distancia angular entre los puntos 1 y 2
ang_dist_1_2 = 2* asin(sqrt(hav));

# Bearing inicial y final entre los puntos 1 y 2
bearing_i_12 = acos((sin(phi2) - sin(phi1)*cos(ang_dist_1_2)) / (sin(ang_dist_1_2) * cos(phi1)));
bearing_f_12 = acos((sin(phi1) - sin(phi2)*cos(ang_dist_1_2)) / (sin(ang_dist_1_2) * cos(phi2)));

# Ajustar la orientación en el círculo trigonométrico
if (sin(lambda2 - lambda1) > 0)
    bearing_1_2 = bearing_i_12;
    bearing_2_1 = (2*pi) - bearing_f_12;

else
    bearing_1_2 = (2*pi) - bearing_i_12;
    bearing_2_1 = bearing_f_12;
endif

# Angulos entre puntos
ang_1 = bearing_1_3 - bearing_1_2;   # angulo p2-p1-p3
ang_2 = bearing_2_1 - bearing_2_3;   # angulo p1-p2-p3
ang_3 = acos(-cos(ang_1) * cos(ang_2) + sin(ang_1) * sin(ang_2) * cos(ang_dist_1_2));  # angulo p1-p3-p2

# Distancia angular entre el punto 1 y el punto de intersección (punto 3)
ang_dist_1_3 = atan2(sin(ang_dist_1_2) * sin(ang_1) * sin(ang_2), cos(ang_2) + cos(ang_1) * cos(ang_3));

# Latitud del punto 3
phi3 = asin(sin(phi1) * cos(ang_dist_1_3) + cos(phi1) * sin(ang_dist_1_3) * cos(bearing_1_3));
lat3 = phi3*180/pi;

# Longitud del punto 3
delta_long_1_3 = atan2(sin(bearing_1_3) * sin(ang_dist_1_3) * cos(phi1), cos(ang_dist_1_3) - sin(phi1) * sin(phi3));
lambda3 = lambda1 + delta_long_1_3;
lon3 = lambda3*180/pi;

# Mostramos los resultados
sprintf('\n\nEl punto de intersección es el punto con latitud %.2f y longitug %.2f \n', lat3, lon3)
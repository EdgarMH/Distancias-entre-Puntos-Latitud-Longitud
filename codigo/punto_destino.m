# Punto de destino dada la distancia y Bearing desde el punto inicial
clear all
close all
clc

% Introduzca las coordenadas en los cuadros de texto para probar los cálculos.
% Se acepta el formato de grados decimales con signo sin dirección de la brújula,
% donde el negativo indica el oeste/sur.

printf('\nPunto de destino dada la distancia y Bearing desde el punto inicial\n')
printf('\nIntroduzca los datos del punto inicial.\n')
printf('Se acepta el formato de grados decimales, con signo positivo (o sin signo) para N y E y negativo para S y O.\n\n')



lat1 = input('Introduce la latitud del punto inicial: ');
lon1 = input('Introduce la longitud del punto inicial: ');
brng = input('Introduce el ángulo Bearing: ');
d = input('Introduce la distancia en kilómetros : ');


# Las operaciones van a ser en radianes, así que transformamos los datos dados en grados decimales.
# phi es latitud, lambda es longitud, R el radio de la tierra
phi1 = lat1*pi/180;
lambda1 = lon1*pi/180;
R = 6371000; #metros
angdis = d*1000/R;

phi2 = asin(sin(phi1)*cos(angdis) + 
        cos(phi1)*sin(angdis)*cos(brng));

lambda2 = lambda1 + atan2(sin(brng)*sin(angdis)*cos(phi1),
        cos(angdis) - sin(phi1)*sin(phi2));

lat2 = phi1*180/pi;
lon2 = lambda2*180/pi;

sprintf('\n\nEl punto de destino es el punto con latitud %.2f y longitug %.2f \n', lat2, lon2)

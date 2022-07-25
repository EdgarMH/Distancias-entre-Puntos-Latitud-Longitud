#This is the half-way point along a great circle path between the two points.
clear all
close all
clc

#phi es latitud, lambda es longitud, R el radio de la tierra
#Los angulos serán en radianes

#ejemplo
#lat1 = 50.07;
#lat2 = 58.64;
#lon1 = 5.71;
#lon2 = 3.07;

printf('\nPunto medio de una trayectoria de círculo máximo entre dos puntos.\n\n')

printf('Introduzca las coordenadas.\n')
printf('Se acepta el formato de grados decimales, congno negativo para Sur y Oeste\n\n')

#Ingresamos los datos de los puntos
lat1 = input('Ingrese la latitud del punto 1: ');
lon1 = input('Ingrese la longitud del punto 1: ');
lat2 = input('Ingrese la latitud del punto 2: ');
lon2 = input('Ingrese la longitud del punto 2: ');

#vamos a operar con radianes
phi1 = lat1*pi/180;
phi2 = lat2*pi/180;
Dphi = phi2 - phi1;
lambda1 = lon1*pi/180;
lambda2 = lon2*pi/180;
Dlambda = (lon2 - lon1)*pi/180;
R = 6371000; #metros

Bx = cos(phi2) * cos(Dlambda);
By = cos(phi2) * sin(Dlambda);
x = sin(phi1) + sin(phi2);
y = sqrt((cos(phi1)+Bx)^2 + By^2);
phim = atan2(x,y);
lambdam = lambda1 + atan2(By, cos(phi1) + Bx);

#pasamos los resultados a latitud y longitud
latm = phim*180/pi;
lonm = lambdam*180/pi;

sprintf('\n\nEl punto medio es el punto con latitud %.2f y longitug %.2f \n', latm, lonm)

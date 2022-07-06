# Bearing
# Un angulo Bearing es un ángulo,
# medido en el sentido de las agujas del reloj desde la dirección norte.

#Ejemplo
#lat1 = 50.03;
#lat2 = 58.38;
#lon1 = 5.42;
#lon2 = 3.04;

printf('\nUn angulo Bearing es un ángulo, medido en el sentido de las agujas del reloj\ndesde la dirección norte.\n\n')

#Ingresamos los datos de los puntos
lat1 = input('Ingrese la latitud del punto 1: ');
lon1 = input('Ingrese la longitud del punto 1: ');
lat2 = input('Ingrese la latitud del punto 2: ');
lon2 = input('Ingrese la longitud del punto 2: ');

#Transformamos a radianes
phi1 = lat1*pi/180;
phi2 = lat2*pi/180;
Dlambda = (lon2-lon1)*pi/180;
R = 6371000; #metros

x = sin(Dlambda) * cos(phi2);
y = cos(phi1)*sin(phi2) - sin(phi1)*cos(phi2)*cos(Dlambda);
theta1 = atan2(x, y);
brng = mod((theta1*180/pi + 360), 360); %en grados decimales

printf('\nEl ángulo Bearing es %.2f \n\n', brng)
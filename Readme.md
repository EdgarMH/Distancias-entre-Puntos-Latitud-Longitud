# Calcular distancia entre puntos de Latitud/Longitud

El propósito es poder realizar una variedad de cálculos para puntos de latitud/longitud, con las fórmulas y fragmentos de código para implementarlos.

Todas estas fórmulas son para cálculos sobre la base de una tierra esférica (ignorando los efectos elipsoidales) - lo cual es suficientemente preciso para la mayoría de los propósitos... [De hecho, la tierra es muy ligeramente elipsoidal; el uso de un modelo esférico da errores típicamente de hasta 0.3%].

El código está escrito en Octave.



## Great-circle distance between two points
para el cáculo de Great-circle distance between two points (Distancia ortodrómica entre dos puntos) se deben introducir las coordenadas de los dos puntos.
Se acepta el formato de grados decimales con signo sin dirección de la brújula, donde el negativo indica el oeste/sur (por ejemplo, 40,7486, -73,9864):

### Distancia

La fórmula del Semiverseno (Haversine formula) determina la distancia ortodrómica entre dos puntos de una esfera dadas sus longitudes y latitudes. Es un caso especial de una fórmula más general de la trigonometría esférica, la ley del semiverseno, que relaciona los lados y los ángulos de los triángulos esféricos.


Aquí utilizaremos la fórmula del "Semiverseno" para calcular la distancia ortodrómica entre dos puntos, es decir, la distancia más corta sobre la superficie de la Tierra, lo que da una distancia "al vuelo" entre los puntos (sin tener en cuenta las colinas).

Fórmula del Haversino:
$$a = \sin^{2}(\Delta \phi/2) + \cos \phi_{1}\cdot \cos\phi_{2}\cdot\sin^2(\Delta\lambda/2)$$
$$c = 2\cdot atan 2 (\sqrt{a},\sqrt{1-a})$$
$$ d = R\cdot c$$

donde $ \phi $ es latitud, $\lambda$ es longitus, $R$ es el radio de la tierra ($radio medio = 6.371 Km$), $c$ es la distancia angular en radianes y $a$ es el cuadrado de la mitad de la longitud de la cuerda entre los puntos.

La fórmula del haversino "sigue siendo válida para el cálculo numérico incluso a pequeñas distancias".



## Bearing

Un angulo Bearing es un ángulo, medido en el sentido de las agujas del reloj desde la dirección norte.

En general, el ángulo Bearing variará a medida que siga una trayectoria de círculo máximo (ortodromo); el Bearing final diferirá del Bearing inicial en varios grados según la distancia y la latitud.

Esta fórmula es para el Bearing inicial.

$$ \theta = atan2(\sin\Delta\lambda\cdot\cos\phi_2,\ \cos\phi_1 \cdot \sin\phi_2 - \sin\phi_1 \cdot \cos\phi_2 \cdot \cos\Delta\lambda) $$

donde $\phi_1$, $\lambda_1$ es el punto inicial, $\phi_2$, $\lambda_2$ es el punto final y $\Delta\lambda$ es la diferencia de longitud.

Para el Bearing final, basta con tomar el Bearing inicial desde el punto final hasta el punto inicial e invertirlo (utilizando $\theta = (\theta+180)$ ).


## Punto medio

Es el punto medio de una trayectoria de círculo máximo entre dos puntos.

Fórmula
$$B_x = \cos\phi_2 \cdot \cos\Delta\lambda$$
$$B_y = \cos\phi_2 \cdot \sin\Delta\lambda$$
$$\phi_m = atan2\left(\sin\phi_1 + \sin\phi_2,\ \sqrt{(\cos\phi_1 + B_x)^2 + B_y^2}\right)$$
$$\lambda_m = \lambda_1 + atan2(B_y,\ \cos(\phi_1) + B_x )$$

Al igual que el Bearing inicial puede variar del Bearing final, el punto medio puede no estar situado a mitad de camino entre latitudes/longitudes.

## Punto de destino dada la distancia y Bearing desde el punto inicial

Dado un punto de partida, un rumbo inicial y una distancia, se calculará el punto de destino y el rumbo final viajando a lo largo de un arco de círculo máximo (distancia más corta).


Fórmula

$$\phi_2 = asin(\sin\phi_1\cdot \cos\delta + \cos\phi_1\cdot\sin\delta\cdot\cos\theta)$$
$$\lambda_2 = \lambda_1 + atan2(\sin\theta\cdot\sin\delta\cdot\cos\phi_1, \cos\delta - sin\phi_1\cdot\sin\phi_2 )$$

donde $\phi$ es latitud, $\lambda$ es longitud, $\theta$ es el Bearing (en sentido del reloj desde el norte) y  $\delta$ es la distancia angular $d/R$.

 ## **Intersección de dos trayectorias dados los puntos de partida y Bearings**

Fórmula:

$$\delta_{12} = 2\cdot asin(\sqrt{(\sin^2(\Delta\phi/2) + \cos\phi_1\cdot\cos\phi_2\cdot\sin^2(\Delta\lambda/2))})$$ 

$$\theta_a = acos((\sin\phi_2 - \sin\phi_1\cdot\cos\delta_{12}) / (\sin\delta_{12}\cdot\cos\phi_1))$$

$$\theta_b = acos((\sin\phi_1 - \sin\phi_2\cdot\cos\delta_{12}) / (\sin\delta_{12}\cdot\cos\phi_2))$$

$$\theta_{12} = \left\{
	       \begin{array}{ll}
		 \theta_a      & \mathrm{si\ } \sin(\lambda_2 - \lambda_1)  > 0 \\
		 2\pi - \theta_a & \mathrm{si\ } \sin(\lambda_2 - \lambda_1)  \le 0 \\
	       \end{array}
	     \right.$$

$$\theta_{21} = \left\{
	       \begin{array}{ll}
		 2\pi - \theta_b      & \mathrm{si\ } \sin(\lambda_2 - \lambda_1)  > 0 \\
		 \theta_b & \mathrm{si\ } \sin(\lambda_2 - \lambda_1)  \le 0 \\
	       \end{array}
	     \right.$$

$$\alpha_1 = \theta_{12} - \theta_{12}$$
$$\alpha_2 = \theta_{21} - \theta_{23}$$

$$\alpha_3 = acos(-\cos\alpha_1\cdot\cos\alpha_2 + \sin\alpha_1\cdot\sin\alpha_2\cdot\cos\delta_{12})$$

$$\delta_{13} = atan2(\sin\delta_{12}\cdot\sin\alpha_1\cdot\sin\alpha_2, \cos\alpha_2 + \cos\alpha_1\cdot\cos\alpha_3)$$

$$\phi_{3} = asin(\sin\phi_{1}\cdot\cos\delta_{13} + \cos\phi_1\cdot\sin\delta_{13}\cos\theta_{13})$$

$$\Delta\lambda_{13} = atan2(\sin\theta_{13}\cdot\sin\delta_{13}\cdot\cos\phi_1, \cos\delta_{13} - \sin\phi_1\cdot\sin\phi_3)$$

$$\lambda_3 = \lambda_1 + \Delta\lambda_{13}$$

donde  
$\phi_1$, $\lambda_1$, $theta_{13}$ son la latitud, longitud y bearing inicial del primer punto hacia el punto de intersección.
$\phi_2$, $\lambda_2$, $theta_{23}$ son la latitud, longitud y bearing inicial del segundo punto hacia el punto de intersección.
$\phi_3$, $\lambda_3$ es el punto de intersección.
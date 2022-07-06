# Calcular distancia entre puntos de Latitud/Longitud

El propósito es poder realizar una variedad de cálculos para puntos de latitud/longitud, con las fórmulas y fragmentos de código para implementarlos.

Todas estas fórmulas son para cálculos sobre la base de una tierra esférica (ignorando los efectos elipsoidales) - lo cual es suficientemente preciso para la mayoría de los propósitos... [De hecho, la tierra es muy ligeramente elipsoidal; el uso de un modelo esférico da errores típicamente de hasta 0.3%].

El código está escrito en Octave.



## Great-circle distance between two points
para el Great-circle distance between two points (Distancia ortodrómica entre dos puntos) introduzca las coordenadas para probar los cálculos.
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

Para el Bearing final, basta con tomar el Bearing inicial desde el punto final hasta el punto inicial e invertirlo (utilizando $\theta = (\theta+180)$).


## Punto medio

Es el punto medio de una trayectoria de círculo máximo entre dos puntos.

Fórmula
$$B_x = \cos\phi_2 \cdot \cos\Delta\lambda$$
$$B_y = \cos\phi_2 \cdot \sin\Delta\lambda$$
$$\phi_m = atan2\left(\sin\phi_1 + \sin\phi_2,\ \sqrt{(\cos\phi_1 + B_x)^2 + B_y^2}\right)$$
$$\lambda_m = \lambda_1 + atan2(B_y,\ \cos(\phi_1) + B_x )$$

Al igual que el Bearing inicial puede variar del Bearing final, el punto medio puede no estar situado a mitad de camino entre latitudes/longitudes.
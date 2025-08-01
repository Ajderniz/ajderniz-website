Algoritmo ejerzizio1
	
	definir edad_conductor Como Entero
	definir cantidad_gasolina como entero
	definir estado_llantas Como Entero
	definir puede_participar Como Logico
	
	escribir sin saltar "Ingrese la edad del conductor "
	leer edad_conductor
	escribir sin saltar "Ingrese la cantidad de gasolina disponible (litros) "
	leer cantidad_gasolina
	escribir sin saltar "Ingrese el estado de las llantas (1-10) "
	leer estado_llantas
	
	puede_participar = Verdadero
	
	si edad_conductor < 18 Entonces
		puede_participar = falso
		escribir "No puede participar porque es menor de edad"
	FinSi
	
	si cantidad_gasolina < 10 Entonces
		puede_participar = Falso
		escribir "No puede participar porque no tiene suficiente gasolina"
	FinSi
	
	si estado_llantas < 7 Entonces
		puede_participar = falso
		escribir "No puede participar porque las llantas están en mal estado"
	FinSi
	
	si verdadero == puede_participar Entonces
		escribir "¡Puedes participar en la carrera!"
	FinSi
	
FinAlgoritmo
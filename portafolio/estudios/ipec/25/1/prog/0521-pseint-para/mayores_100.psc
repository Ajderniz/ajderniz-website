Algoritmo mayores_100
	
	definir i Como Entero
	definir actual Como Real
	definir cantidad_mayores_100 Como Entero
	
	cantidad_mayores_100 = 0
	para i = 1 hasta 8 Hacer
		escribir sin saltar "Ingrese un valor "
		leer actual
		si 100 < actual Entonces
			escribir "El número ingresado es mayor a 100"
			cantidad_mayores_100 = cantidad_mayores_100 + 1
		FinSi
	FinPara
	
	escribir "La cantidad de números ingresados mayores a 100 es de " cantidad_mayores_100
	
FinAlgoritmo

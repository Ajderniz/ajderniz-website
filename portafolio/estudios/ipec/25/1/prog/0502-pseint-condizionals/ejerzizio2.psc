Algoritmo ejerzizio2
	
	definir CANTIDAD_VALORES Como Entero
	CANTIDAD_VALORES = 3
	
	definir valores Como Entero
	definir mayor_valor Como Entero
	definir indice como entero
	
	dimensionar valores[3]
	
	Para indice = 1 Hasta CANTIDAD_VALORES Con Paso 1 Hacer
		Escribir sin saltar "Ingrese un entero para el valor " indice " "
		leer valores[indice]
	Fin Para
	
	mayor_valor = valores[1]
	para indice = 2 hasta CANTIDAD_VALORES con paso 1 Hacer
		si mayor_valor < valores[indice] Entonces
			mayor_valor = valores[indice]
		FinSi
	FinPara
	
	Escribir "El mayor valor entre los ingresados es " mayor_valor
	
FinAlgoritmo

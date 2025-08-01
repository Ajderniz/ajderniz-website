Algoritmo PP1_IC_AxelLopez
	
	definir index como entero
	
	definir invalidos Como Entero
	definir criticos como entero
	definir bajos Como Entero
	definir aceptables Como Entero
	definir altos Como Entero
	criticos = 0
	invalidos = 0
	bajos = 0
	aceptables = 0
	altos = 0
	
	definir cantidad_motores como entero
	definir potencia_generada Como Real
	definir consumo_combustible Como Real
	definir eficiencia Como Real
	
	escribir sin saltar "Ingrese la cantidad de motores "
	leer cantidad_motores
	
	escribir ""
	para index = 1 hasta cantidad_motores Hacer
		escribir sin saltar "Ingrese la potencia generada (kW) del motor #" + ConvertirATexto(index) + " "
		leer potencia_generada
		
		escribir sin saltar "Ingrese el consumo de combustible (L/h) del motor #" + ConvertirATexto(index) + " "
		leer consumo_combustible
		si consumo_combustible <= 0 Entonces
			escribir "Consumo inválido"
			invalidos = invalidos + 1
		SiNo
			eficiencia = potencia_generada / consumo_combustible
			escribir "Índice de eficiencia: " + ConvertirATexto(eficiencia)
			si eficiencia <= 1.9 Entonces
				escribir "Eficiencia crítica"
				criticos = criticos + 1
			SiNo
				si 2 <= eficiencia & eficiencia <= 4.9 Entonces
					escribir "Baja eficiencia"
					bajos = bajos + 1
				SiNo
					si 5 <= eficiencia & eficiencia <= 9.9 Entonces
						escribir "Eficiencia aceptables"
						aceptables = aceptables + 1
					SiNo
						escribir "Alta eficiencia"
						altos = altos + 1
					FinSi
				FinSi
			FinSi
		FinSi
	FinPara
	
	escribir ""
	escribir "Motores con alta eficiencia: " + convertiratexto(altos)
	escribir "Motores con eficiencia aceptable: " + convertiratexto(aceptables)
	escribir "Motores con baja eficiencia: " + convertiratexto(bajos)
	escribir "Motores con eficiencia crítica: " ConvertirATexto(criticos)
	escribir "Errores de entrada: " + convertiratexto(invalidos)
	
FinAlgoritmo
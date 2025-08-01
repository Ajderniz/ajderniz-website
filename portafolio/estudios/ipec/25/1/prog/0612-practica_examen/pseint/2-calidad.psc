Algoritmo calidad
	
	definir i como entero
	
	definir cantidad_piezas Como real
	definir cantidad_piezas_valida como logico
	
	definir peso como real
	definir peso_valido Como Logico
	
	definir aceptadas Como Entero
	definir toleradas Como Entero
	definir rechazadas Como Entero
	
	repetir
		cantidad_piezas_valida = Verdadero
		escribir sin saltar "Ingrese la cantidad de piezas "
		leer cantidad_piezas
		
		si cantidad_piezas <= 0 Entonces
			escribir "La cantidad debe ser mayor que cero"
			cantidad_piezas_valida = Falso
		SiNo
			si 0 < (cantidad_piezas - Trunc(cantidad_piezas)) Entonces
				escribir "La cantidad debe ser un entero"
				cantidad_piezas_valida = Falso
			FinSi
		FinSi
	Hasta Que Verdadero == cantidad_piezas_valida
	
	escribir ""
	para i = 1 hasta cantidad_piezas Hacer
		Repetir
			peso_valido = Verdadero
			Escribir sin saltar "Ingrese el peso de la pieza #" + ConvertirATexto(i) + " "
			leer peso
			Si peso < 0 | 1000 < peso Entonces
				escribir "Peso invalido"
				peso_valido = Falso
			FinSi
		Hasta Que Verdadero == peso_valido
	FinPara
	
	escribir peso
	si peso < 80 | 120 < peso Entonces
		escribir "Rechazada"
		rechazadas = rechazadas + 1
	SiNo
		si peso < 95 | 105 < peso Entonces
			escribir "Tolerada"
			toleradas = toleradas + 1
		sino 
			escribir "Aceptada"
			aceptadas = aceptadas + 1
		FinSi
	FinSi
	
	escribir ""
	escribir "Aceptadas: " + ConvertirATexto(aceptadas)
	escribir "Toleradas: " + ConvertirATexto(toleradas)
	escribir "Rechazadas: " + ConvertirATexto(rechazadas)
	
	si 3 < rechazadas Entonces
		escribir "Atención: revisar la calibración de la máquina."
	FinSi
	
FinAlgoritmo
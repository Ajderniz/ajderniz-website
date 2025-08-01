Algoritmo muestras
	
	definir i como entero
	
	definir cantidad_muestras como entero
	
	definir ph como real
	
	definir total_invalidas Como Entero
	definir total_inadecuadas Como Entero
	definir total_alteradas Como Entero
	definir total_adecuadas Como Entero
	
	cantidad_muestras = 0
	Mientras cantidad_muestras <= 0
		Escribir sin saltar "Ingrese la cantidad de muestras "
		Leer cantidad_muestras
		si cantidad_muestras <= 0 Entonces
			escribir "La cantidad debe de ser mayor a 0"
		FinSi
	FinMientras
	
	escribir ""
	Para i = 1 hasta cantidad_muestras Hacer
		Escribir sin saltar "Ingrese el nivel de pH para la muestra #" + ConvertirATexto(i) + " "
		Leer ph
		si ph < 0 O 14 < ph Entonces
			escribir "Invalida"
			total_invalidas = total_invalidas + 1
		SiNo
			si ph < 4.5 O 10.5 < ph Entonces
				escribir "Inadecuada"
				total_inadecuadas = total_inadecuadas + 1
			SiNo
				si ph < 6.5 O 8.5 < ph Entonces
					escribir "Alterada"
					total_alteradas = total_alteradas + 1
				sino 
					escribir "Adecuada"
					total_adecuadas = total_adecuadas + 1
				FinSi
			FinSi
		FinSi
	FinPara
	
	escribir ""
	escribir "Muestras adecuadas: " + ConvertirATexto(total_adecuadas)
	escribir "Muestras alteradas: " + ConvertirATexto(total_alteradas)
	escribir "Muestras inadecuadas: " + ConvertirATexto(total_inadecuadas)
	escribir "Muestras invalidas: " + ConvertirATexto(total_invalidas)
	
FinAlgoritmo

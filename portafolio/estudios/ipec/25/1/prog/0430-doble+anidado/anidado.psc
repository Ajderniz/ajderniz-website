Algoritmo anidado
	
	definir PORZ_1 Como Real
	definir PORZ_2 Como Real
	definir PORZ_3 Como Real
	definir PORZ_4 Como Real
	PORZ_1 = 0.10
	PORZ_2 = 0.12
	PORZ_3 = 0.15
	PORZ_4 = 0.20
	
	definir salario_base Como Real
	definir categoria como entero
	definir incremento como real
	definir salario_incrementado como real
	
	Escribir sin saltar "Ingrese su salario base "
	Leer salario_base
	Escribir sin saltar "Increse su categoría (1-4) "
	Leer categoria
	
	Segun categoria Hacer
		1:
			incremento = salario_base * PORZ_1
		2:
			incremento = salario_base * PORZ_2
		3:
			incremento = salario_base * PORZ_3
		4:
			incremento = salario_base * PORZ_4
		De Otro Modo:
			Escribir "La categoría ingresada no es válida"
			Escribir "No sé como escapar del programa"
			Escribir "_         _"
			Escribir " \/(._.)\/"
	Fin Segun
	salario_incrementado = salario_base + incremento
	
	Escribir "Su salario (después del incremento) es de " salario_incrementado
	
FinAlgoritmo

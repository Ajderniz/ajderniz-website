Algoritmo doble
	
	definir LIMITE como entero
	definir PORZ_SUB_LIMITE Como real
	definir PORZ_SUP_LIMITE como real
	LIMITE = 1000
	PORZ_SUB_LIMITE = 0.20
	PORZ_SUP_LIMITE = 0.15
	
	definir salario_base Como Real
	definir incremento Como Real
	definir salario_incrementado Como Real
	
	Escribir sin saltar "Ingrese su salario base "
	Leer salario_base
	
	Si salario < 1000 Entonces
		incremento = salario_base * PORZ_SUB_LIMITE
	SiNo
		incremento = salario_base * PORZ_SUP_LIMITE
	FinSi
	salario_incrementado = salario_base + incremento
	
	Escribir "Su salario (después del incremento) es de " salario_incrementado
	
FinAlgoritmo

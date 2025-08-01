Algoritmo ejerzizio4
	
	definir CANTIDAD_NOTAS Como Entero
	definir MINIMO_APROBAR Como real
	CANTIDAD_NOTAS = 3
	MINIMO_APROBAR = 70
	
	definir nota como real
	definir sumatoria Como Real
	definir promedio como real
	definir indice Como Entero
	
	sumatoria = 0
	para indice = 1 hasta CANTIDAD_NOTAS con paso 1 Hacer
		Escribir sin saltar "Ingrese la nota del trabajo " indice " "
		leer nota
		sumatoria = sumatoria + nota
	FinPara
	
	promedio = sumatoria / CANTIDAD_NOTAS
	
	escribir "Nota promedio: " promedio
	si MINIMO_APROBAR < promedio Entonces
		escribir "El estudiante evaluado aprobó el curso"
	SiNo
		escribir "El estudiante evaluado NO aprobó el curso"
	FinSi
	
FinAlgoritmo

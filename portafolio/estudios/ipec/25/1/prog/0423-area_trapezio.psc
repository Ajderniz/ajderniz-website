Algoritmo area_trapecio
	Definir ancho_cusp Como Real
	Definir ancho_base Como Real
	Definir altura Como Real
	Definir area Como Real
	
	Escribir Sin Saltar "Ingrese el ancho de la base "
	Leer ancho_base
	Escribir Sin Saltar "Ingrese el ancho de la cúspide "
	Leer ancho_cusp
	Escribir Sin Saltar "Ingrese la altura "
	Leer altura
	
	area = ((ancho_base + ancho_cusp) * altura) / 2
	
	Escribir "El área del trapecio es de ((" ancho_base " + " ancho_cusp ") * " altura ") / 2 = " area
	
FinAlgoritmo
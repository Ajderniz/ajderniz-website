Algoritmo ejerzizio2
	
	// Me hice bolas con este, honestamente
	
	definir distancia_total Como Entero
	definir consumo_promedio Como Real
	definir precio_litro_gasolina Como Real
	definir numero_pasajeros como entero
	definir edad_vehiculo Como entero
	definir presupuesto como real
	definir litros_disponibles como real
	
	definir litros_necesarios Como Real
	definir costo_combustible como real
	definir porz_adicional como real
	
	definir costo_adicional como real
	
	definir costo_total como real
	definir puede_viajar Como Logico
	
	escribir "Ingrese los siguientes datos:"
	escribir sin saltar "Distancia total del viaje "
	leer distancia_total
	escribir sin saltar "Consumo promedio del vehículo "
	leer consumo_promedio
	escribir sin saltar "Precio por litro de la gasolina "
	leer precio_litro_gasolina
	escribir sin saltar "Número de pasajeros "
	leer numero_pasajeros
	escribir sin saltar "Edad del vehículo "
	leer edad_vehiculo
	escribir sin saltar "Presupuesto disponible para el viaje: "
	leer presupuesto
	escribir sin saltar "Litros disponibles "
	leer litros_disponibles
	
	litros_necesarios = (distancia_total * consumo_promedio) / 100
	costo_combustible = litros_necesarios * precio_litro_gasolina
	
	si 5 < edad_vehiculo Entonces
		costo_combustible = costo_combustible + (costo_combustible * 0.2)
	FinSi
	costo_total = costo_combustible
	
	si 4 < numero_pasajeros Entonces
		costo_total = costo_total + (costo_total * 0.05)
	FinSi
	
	puede_viajar = Verdadero
	si presupuesto < costo_total Entonces
		puede_viajar = falso
		escribir "No puede realizar el viaje, no tiene suficiente dinero."
	FinSi
	
	si litros_disponibles < litros_necesarios Entonces
		puede_viajar = falso
		escribir "No puede realiar el viaje, no tiene suficiente gasolina."
	FinSi
	
	si Verdadero == puede_viajar Entonces
		escribir "¡Puede realizar el viaje! El costo total es de: " costo_total
	FinSi
	
FinAlgoritmo

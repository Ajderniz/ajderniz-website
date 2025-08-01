Algoritmo bateria
	
	definir nivel_inicial como real
	definir porcentaje_descarga Como Real
	definir porcentaje_recarga Como Real
	
	definir bateria_perdida Como Real
	definir nivel_despues_descarga Como Real
	definir bateria_recargada como real
	definir nivel_final como real
	
	escribir sin saltar "Ingrese el nivel inicial de la batería "
	leer nivel_inicial
	escribir sin saltar "Ingrese el porcentaje de descarga diaria "
	leer porcentaje_descarga
	escribir sin saltar "Ingrese el porcentaje de recarga parcial "
	leer porcentaje_recarga
	
	bateria_perdida = (nivel_inicial * porcentaje_descarga) / 100
	nivel_despues_descarga = nivel_inicial - bateria_perdida
	bateria_recargada = (nivel_despues_descarga * porcentaje_recarga) / 100
	nivel_final = Trunc((nivel_despues_descarga + bateria_recargada)) % 101
	
	Escribir ""
	Escribir "Porcentaje de batería perdida: " bateria_perdida "%"
	Escribir "Nivel de batería después de la descarga: " nivel_despues_descarga "%"
	Escribir "Porcentaje de batería recargada: " bateria_recargada "%"
	Escribir "Nivel final de batería del vehículo: " nivel_final "%"
	
FinAlgoritmo

Algoritmo rendimiento
	
	definir consumo_diario como real
	definir solar_generada como real
	definir eolica_generada como real
	definir eficiencia_sistema como real
	definir penalizacion_exceso como real
	
	definir rendimiento_total como real
	
	Escribir sin saltar "Ingrese la cantidad de energía consumida por el sistema (kWh) "
	Leer consumo_diario
	Escribir sin saltar "Ingrese la energía generada por los paneles solares (kWh) "
	Leer solar_generada
	Escribir sin saltar "Ingrese la energía generada por las turbinas eólicas (kWh) "
	Leer eolica_generada
	Escribir sin saltar "Ingrese el porcentaje de eficiencia global del sistema (%) "
	Leer eficiencia_sistema
	Escribir sin saltar "Ingrese el factor de penalización por exceso de consumo (1.1-2.0) "
	Leer penalizacion_exceso
	Si penalizacion_exceso < 1.1 Entonces
		penalizacion_exceso = 1.1
	FinSi
	Si 2.0 < penalizacion_exceso Entonces
		penalizacion_exceso = 2.0
	FinSi
	
	rendimiento_total = ((solar_generada + eolica_generada) * (eficiencia_sistema / 100) - consumo_diario) * penalizacion_exceso + ((solar_generada * 0.1) / (eolica_generada + 1))
	
	pos_net = "positivo"
	Si rendimiento_total < 0 Entonces
		pos_neg = "negativo"
	FinSi
	
	Escribir ""
	Escribir sin saltar "El rendimiento total del sistema es de " rendimiento_total
	Si rendimiento_total < 0 Entonces
		Escribir " (negativo)"
	SiNo
		Escribir " (positivo)"
	FinSi
	
FinAlgoritmo

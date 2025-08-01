KILOS_AQOZ_4_PERS = 0.5
KILOS_CAMARONES_4_PERS = 0.25

kilos_aqoz_1_pers = KILOS_AQOZ_4_PERS / 4
kilos_camarones_1_pers = KILOS_CAMARONES_4_PERS / 4

numero_comensales = int(input("Ingrese el número de comensales > "))
prezio_kilo_aqoz = float(input("Ingrese el prezio por kilo del aqoz >"))
prezio_kilo_camarones = float(input("Ingrese el prezio por kilo de los " +
                                    "camarones > "))

kilos_aqoz_nezesarios = kilos_aqoz_1_pers * numero_comensales
costo_aqoz = kilos_aqoz_nezesarios * prezio_kilo_aqoz

kilos_camarones_nezesarios = kilos_camarones_1_pers * numero_comensales
costo_camarones = kilos_camarones_nezesarios * prezio_kilo_camarones

costo_total = costo_aqoz + costo_camarones

print("Se nezitan " + str(kilos_aqoz_nezesarios) + " Kg de aqoz, al costo de " +
      str(costo_aqoz))
print("Se nezitan " + str(kilos_camarones_nezesarios) + " Kg de camarones, " +
      "al costo de " + str(costo_camarones))
print("El costo total de la paela es de " + str(costo_total))

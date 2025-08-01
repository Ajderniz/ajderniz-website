total_piezas_aceptadas = 0
total_piezas_toleradas = 0
total_piezas_rechazadas = 0

while True:
    cantidad_piezas = input("Ingrese la cantidad de piezas a analizar > ")
    if not cantidad_piezas.isdigit():
        print("El valor ingresado no es valido")
        continue
    cantidad_piezas = int(cantidad_piezas)
    break

print()
for i in range(1, cantidad_piezas + 1):
    while True:
        peso = float(input("Ingrese el peso (g) de la pieza " + str(i) + " > "))
        if peso <= 0 or 1000 < peso:
            print("El peso ingresado no es válido")
            continue
        break

    if peso <= 79 or 121 <= peso:
        print("Rechazada")
        total_piezas_rechazadas += 1
    elif peso <= 94 or 106 <= peso:
        print("Aceptable con tolerancia")
        total_piezas_toleradas += 1
    else:
        print("Aceptada")
        total_piezas_aceptadas += 1

print()
print("Piezas ingresadas: " + str(cantidad_piezas))
print("Piezas aceptadas: " + str(total_piezas_aceptadas))
print("Piezas aceptables con tolerancia: " + str(total_piezas_toleradas))
print("Piezas rechazadas: " + str(total_piezas_rechazadas))

if 3 < total_piezas_rechazadas:
    print("\nATENCIÓN: Revisar la calibración de la máquina.")

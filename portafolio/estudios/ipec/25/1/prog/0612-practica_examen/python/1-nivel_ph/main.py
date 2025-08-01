total_errores_entrada = 0

total_muestras_adecuadas = 0
total_muestras_alteradas = 0
total_muestras_inadecuadas = 0

cantidad_muestras = 0
while cantidad_muestras <= 0:
    cantidad_muestras = int(input("Ingrese la cantidad de muestras > "))
    if cantidad_muestras <= 0:
        print("ERROR: La cantidad de muestras debe de ser mayor a 0")
        total_errores_entrada += 1

print()
for i in range(1, cantidad_muestras + 1):
    ph = float(input("Ingrese el nivel de la muestra " + str(i) + " > "))
    if ph < 0 or 14 < ph:
        print("ERROR: Valor de pH invalido")
        total_errores_entrada += 1
    elif ph <= 4.4 or 10.6 <= ph:
        print("Muestra inadecuada")
        total_muestras_inadecuadas += 1
    elif ph <= 6.5 or 8.6 <= ph:
        print("Muestra ligeramente alterada")
        total_muestras_alteradas += 1
    else: # 6.5 <= ph <= 8.5
        print("Muestra adecuada")
        total_muestras_adecuadas += 1

print()
print("Muestras adecuadas: " + str(total_muestras_adecuadas))
print("Muestras ligeramente alteradas: " + str(total_muestras_alteradas))
print("Muestras inadecuadas: " + str(total_muestras_inadecuadas))

print("Total errores de entrada: " + str(total_errores_entrada))

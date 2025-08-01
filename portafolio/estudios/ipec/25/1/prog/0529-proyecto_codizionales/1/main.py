NUM_NOTAS = 3

sumatoria = 0
for i in range(NUM_NOTAS):
    sumatoria += float(input("Ingrese una nota tre 0 y 100 > "))

promedio = sumatoria / NUM_NOTAS

print("La nota promedio es de " + str(int(promedio)))
if promedio < 60:
    print("El estudiante reprobó")
else:
    print("El estudiante aprobó")

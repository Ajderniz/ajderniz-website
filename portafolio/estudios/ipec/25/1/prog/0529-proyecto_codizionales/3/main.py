peso = float(input("Ingrese el peso (Kg) > "))
estatura = float(input("Ingrese la estatura (m) > "))

imc = peso / estatura * 2

print("El IMC es de " + str(imc))
if imc < 25:
    print("El estado nutricional es normal")
else:
    print("¡Cuidado! Está en estado de sobrepeso")

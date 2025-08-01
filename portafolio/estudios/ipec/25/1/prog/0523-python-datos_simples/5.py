print("Ingrese su peso (Kg)")
peso = float(input())
print("Ingrese su estatura (m)")
estatura = float(input())

imc = peso / (estatura * estatura)

print("Su índice de masa corporal es de " + str(imc))

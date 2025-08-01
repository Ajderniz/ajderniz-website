import random

print("Está usted a punto de experimentar una vida entera, gastada en estupideces.")
edad = int(input("Ingrese el número de sus años actual > "))
for i in range(1, edad + 1):
    print("¡Feliz cumpleaños! Acaba de cumplir " + str(i) + " años.")
print("Usted va a morir a los " + str(random.randint(edad, 100)) + " años.")
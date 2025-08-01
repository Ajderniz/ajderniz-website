puntajes = [ 150, 300, 275, 400, 320, 300, 500, 300, 200 ]
print(puntajes)

puntajes.append(350)
print(puntajes)

puntajes.insert(0, 450)
print(puntajes)

print("'Numero de puntajes: " + str(len(puntajes)))

print("'Indize de primera instanzia de 500: " + str(puntajes.index(500)))

print("'Masimo valor en lista: " + str(max(puntajes)))

print("'Minimo valor en lista: " + str(min(puntajes)))

print("Instanzias de 300: " + str(puntajes.count(300)))

puntajes.reverse()
print(puntajes)

puntajes.pop(puntajes.index(200))
print(puntajes)

medicamentos = [ "Parazetamol", "Amocsizilina", "Ibuprofeno", "Omeprazol",
                "Salbutamol", "Parazetamol" ]

print("1. Adi'zion normal")
print("=" * 80)
nuevo_medicamento = input("Ingrese el nombre de un nuevo medicamento > ")
medicamentos.append(nuevo_medicamento)
print(medicamentos)

print("")
print("2. Inser'zion urjente")
print("=" * 80)
posizion = int(input("Ingrese la posi'zion del medicamento a insertar > "))
nuevo_medicamento = input("Ingrese el nombre del medicamento > ")
medicamentos.insert(posizion, nuevo_medicamento)
print(medicamentos)

print("")
print("Cantidad de medicamentos: " + str(len(medicamentos)))
print("'Indize del Ibuprofeno: " + str(medicamentos.index("Ibuprofeno")))
print("Primer medicamento en la lista: " + medicamentos[0])
print("'Ultimo medicamento en la lista: " + medicamentos[-1])
print("Vezes ce se abe rezetado Parazetamol: " +
      str(medicamentos.count("Parazetamol")))
medicamentos.reverse()
print("Lista invertida: " + str(medicamentos))
medicamentos.remove("Salbutamol")
print("Des'pues de eliminar Salbutamol: " + str(medicamentos))

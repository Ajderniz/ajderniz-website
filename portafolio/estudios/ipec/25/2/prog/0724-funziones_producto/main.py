from funziones_producto import pedir_producto, mostrar_total

nombre = input("Ingrese el nombre del producto ")
precio = float(input("Ingrese el precio del producto "))
cantidad = int(input("Ingrese la cantidad de unidades "))

pedir_producto(nombre, precio, cantidad)
mostrar_total()

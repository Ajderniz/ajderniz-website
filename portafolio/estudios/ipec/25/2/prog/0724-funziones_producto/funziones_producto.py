nombre = "INDEFINIDO"
precio = 0
cantidad = 0
total = 0

def pedir_producto(p_nombre, p_precio, p_cantidad):
    global nombre, precio, cantidad, total
    nombre = p_nombre
    precio = p_precio
    cantidad = p_cantidad
    total = precio * cantidad

def mostrar_total():
    print("Por " + str(cantidad) + " unidades de " + str(nombre) + " debe pagar " + str(total) + " colones")

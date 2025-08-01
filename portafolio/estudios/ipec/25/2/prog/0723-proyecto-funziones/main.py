from figuras import triangulo_equilatero_area as area, triangulo_equilatero_perimetro as perimetro

lado = float(input("Ingrese el lado de un triángulo equilátero: "))
altura = float(input("Ingrese la altura de un triángulo equilátero: "))
print("El área del triángulo es: " + str(area(lado, altura)))
print("El perímetro del triángulo es: " + str(perimetro(lado)))

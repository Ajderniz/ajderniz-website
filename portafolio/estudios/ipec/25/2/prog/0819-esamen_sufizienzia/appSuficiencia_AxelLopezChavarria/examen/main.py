from tienda import Prendas

fin = False
while False == fin:
    
    print("\n==== Programa de tienda =====")
    print("Elija una opción:")
    print("\t(I)ngresar datos")
    print("\t(C)alcular costo")
    print("\t(S)alir")
    opcion = input("Opción > ")

    if opcion in "Ii":
        nombre_cliente = input("\nIngrese el nombre del cliente >")
        num_prendas = int(input("Ingrese el número de prendas adquiridas >"))
        costo_promedio = float(input("Ingrese el costo promedio por prenda >"))
        porz_descuento = float(input("Ingrese el porcentaje de descuento >"))
        prendas = Prendas(nombre_cliente, num_prendas, costo_promedio,
                          porz_descuento)

    elif opcion in "Cc":
        try:
            prendas.calcular_costo_prenda()
            prendas.calcular_descuento()
            prendas.calcular_costo_total()

            prendas.guardar_resultado()
            prendas.mostrar_resultado()

        except NameError:
            print("ERROR: No se han ingresado los datos necesarios para " +
                  "calcular el costo.")
        
    elif opcion in "Ss":
        fin = True

    else:
        print("\nOpción inválida")


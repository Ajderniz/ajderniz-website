COSTO_PRIMER_HORA = 4
COSTO_DEMAS_HORAS = 8

cantidad_horas = int(input("Ingrese la cantidad de horas a pagar > "))

monto = 0
if cantidad_horas == 1:
    monto = COSTO_PRIMER_HORA
else:
    monto = COSTO_PRIMER_HORA + (COSTO_DEMAS_HORAS * (cantidad_horas - 1))

print("Monto a pagar: " + str(monto))

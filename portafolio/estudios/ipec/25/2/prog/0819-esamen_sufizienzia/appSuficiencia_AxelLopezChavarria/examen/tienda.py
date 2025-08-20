
class Prendas:
    
    def __init__(self, nombre_cliente, num_prendas, costo_promedio,
                 porz_descuento):
        self.nombre_cliente = nombre_cliente
        self.num_prendas = num_prendas
        self.costo_promedio = costo_promedio
        self.porz_descuento = porz_descuento

    def calcular_costo_prenda(self):
        self.costo_prenda = self.num_prendas * self.costo_promedio

    def calcular_descuento(self):
        self.descuento = self.costo_prenda * self.porz_descuento

    def calcular_costo_total(self):
        self.costo_total = self.costo_prenda - self.descuento

    def guardar_resultado(self):
        archivo = open("./datos.txt", "at")
        self.cadena_datos = f"Nombre del cliente: {self.nombre_cliente}\nNúmero de prendas: {self.num_prendas}\nCosto promedio: {self.costo_promedio}\nPorcentaje de descuento: {self.porz_descuento}\nCosto total: {self.costo_prenda}\nMonto de descuento: {self.descuento}\n\nCosto final: {self.costo_total}"
        archivo.write(self.cadena_datos)

    def mostrar_resultado(self):
        print("\nResultado:\n\n" + self.cadena_datos)
        pass

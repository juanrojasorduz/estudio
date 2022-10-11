### Definiendo una clase
### Defino la clase Hotel con su estado inicial,atributos y metodos, vemos que el estado inicial de esta clase parte 
### de un numero de huespedes = 0, y un numero definido de maximo numero maximo de huespedes y tambien de lugares de 
### estacionamiento, tengo la posibilidad de incrementar el numero de huespedes si uso el metodo añadir huespedes, tambien
### puedo disminuir el numero de huespedes si aplico checkout y por ultimo la ocupacion total variara en funcion del numero
### de huespedes

class Hotel:
    
    def __init__(self, numero_maximo_de_huespedes, lugares_de_estacionamiento):
        self.numero_maximo_de_huespedes = numero_maximo_de_huespedes
        self.lugares_de_estacionamiento = lugares_de_estacionamiento
        self.huespedes = 0
    def anadir_huespedes(self, cantidad_de_huespedes):
        self.huespedes += cantidad_de_huespedes

    def checkout(self, cantidad_de_huespedes):
        self.huespedes -= cantidad_de_huespedes

    def ocupacion_total(self):
        return self.huespedes


### Asignando una instancia

### Estado inicial
hotel = Hotel(50, 20) ### defino una instancia 'hotel' dentro de la clase Hotel con estado inicial de 0 huespedes,50 como numero
                      ### maximo de huespedes y 20 lugares de estacionamiento
print(hotel.huespedes) ### imprimo el numero de huespedes inicial que en este caso parte de 0
print(hotel.numero_maximo_de_huespedes) ### imprimo el numero maximo de huespedes que en este caso es 50
print(hotel.lugares_de_estacionamiento) ### imprimo los lugares de estacionamiento que en este caso es 20
#### Estado despues de aplicar metodos
hotel.anadir_huespedes(3)  ### añado 3 huespedes
hotel.checkout(1)  ### resto 1 huesped
print(hotel.ocupacion_total())  ### imprimo este metodo que me devuelve la ocupacion total en este caso 3-1 = 2

### Imprimo el valor final de los atributos
print(hotel.numero_maximo_de_huespedes) ### imprimo el valor del atributo numero maximo de huespedes que en este caso es 50
print(hotel.lugares_de_estacionamiento) ### imprimo el valor del atributo lugares de estacionamiento que en este caso es 20
print(hotel.huespedes) ### imprimo el numero de huespedes que en este caso es 2
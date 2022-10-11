## Estructura tradicional:

cuartos_de_hotel = [101, 102, 103, 201, 202, 203]
cuarto_ocupado = [True, False, False, True, True, False]


## estructura -> clase
#clase -> Humanos
#metodos-> Correr,caminar
#atributos-> ojos,color de piel,edad,estatura etc

## instancia-> "marcos"
#un objeto que pertenece a esa clase "Humanos" podria ser Marcos, una persona
#que cuenta con atributos y metodos identicos a la clase "Humanos"


### defino la clase
class Hotel:
    pass


### defino una instancia dentro de esta clase
hotel = Hotel()


### atributos de la instancia Hotel -> __init__: estado inicial de nuestra instancia; Self: referencia a la instancia
class Hotel:
    
    def __init__(self, numero_maximo_de_huespedes, lugares_de_estacionamiento):
        self.numero_maximo_de_huespedes = numero_maximo_de_huespedes
        self.lugares_de_estacionamiento = lugares_de_estacionamiento
        self.huespedes = 0


hotel = Hotel(numero_maximo_de_huespedes=50, lugares_de_estacionamiento=20)
print(hotel.lugares_de_estacionamiento) # 20



#### metodos de la instancia
class Hotel:

    ...

    def anadir_huespedes(self, cantidad_de_huespedes):
        self.huespedes += cantidad_de_huespedes

    def checkout(self, cantidad_de_huespedes):
        self.huespedes -= cantidad_de_huespedes

    def ocupacion_total(self):
        return self.huespedes


hotel = Hotel(50, 20)
hotel.anadir_huespedes(3)
hotel.checkout(1)
hotel.ocupacion_total() # 2








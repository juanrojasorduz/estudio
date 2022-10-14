## Un decorador es una funcion que recibe como parametro otra funcion,le añade cosas y retorna una funcion diferente


### EJEMPLO 1
def decorador(func):
    def envoltura():
        print('Esto se añade a mi funcion original')
        func()
    return envoltura
def saludo():
    print('Hola')
    
saludo = decorador(saludo)
saludo()


### EJEMPLO 1 - con sintaxis mas estetica
def decorador(func):
    def envoltura():
        print('Esto se añade a mi funcion original')
        func()
    return envoltura

@decorador
def saludo():
    print('Hola')
        
saludo()


### EJEMPLO 2 - con sintaxis mas estetica
def mayusculas(func):
    def envoltura(texto):
        return func(texto.upper())
    return envoltura

@mayusculas
def mensaje(nombre):
    return f'{nombre}, recibiste un mensaje'

print(mensaje('Cesar'))


### EJEMPLO 3 - con sintaxis
from datetime import datetime

def execution_time(func):
    def wrapper(*args, **kwargs):
        initial_time = datetime.now()
        func(*args, **kwargs)
        final_time = datetime.now()
        time_elapsed = final_time - initial_time
        print('Pasaron ' + str(time_elapsed.total_seconds()) + ' segundos')
    return wrapper

@execution_time
def random_func():
    for _ in range(1,1000000):
        pass
    
@execution_time
def suma(a: int, b:int) -> int:
    return a+b
        
@execution_time
def saludo(nombre='Cesar'):
    print('Hola ' + nombre)

random_func()    
suma(5,5)
saludo('Facundo')

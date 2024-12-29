
import random

def generar_contrasenas():
    mayusculas = ['A','B','C','D','E','F','G']
    minusculas = ['a','b','c','d','e','f','g']
    simbolos = ['!','#','$','&','/','(',')']
    numeros = ['1','2','3','4','5','6','7','8','9','0']
    caracteres = mayusculas + minusculas + simbolos + numeros
    contraseña = []

    for i in range(15):
        caracter_random = random.choice(caracteres)
        contraseña.append(caracter_random)
    contraseña = ''.join(contraseña)
    return contraseña

def run():
    contraseña = generar_contrasenas()
    print('Tu nueva contraseña es: ' + contraseña)   

if __name__ == '__main__':
    run()

import random
def run():
    numero_participantes = int(input('Define el numero de participantes: '))    
    lista_nombres = []
    for i in range(numero_participantes):
        print('Introduce el nombre del jugador numero ' + str(i+1))
        nombre = input(': ')
        lista_nombres.append(nombre)
    numero_ganador = random.randint(1,100)
    condicion = True
    while condicion == True:
        for nombre in  lista_nombres:
            print(str(nombre) + ' introduce un numero por favor')
            numero_elegido = int(input(' :'))
            if numero_elegido == numero_ganador:
                condicion = False
                break
            else:
                condicion = True
                if numero_elegido < numero_ganador:
                    print('Elige un numero mas grande en el próximo intento')
                else: 
                    print('Elige un numero mas pequeño en el proximo intento')
            nombre = nombre
    print('Felicidades ' + str(nombre) + ' eres el ganador del juego')

if __name__ == '__main__':
    run()

### Listas - son objetos dinamicos
# numeros = [1,2,3,4,5]
# numeros.append('Hola')
# print(numeros)
# numeros.pop(5)  ##elimino un dato
# print(numeros)
# numeros_2 = [6,7,8,9]
# lista_final = numeros+numeros_2
# print(lista_final)


###tuplas - son objetos estaticos y es conveniente usarlos por ejemplo en para bucles
# mi_tupla = (1,2,3,4,5)
# print(mi_tupla)
# for tupla in mi_tupla:
#     print(tupla)

###diccionarios - estructura de datos con llaves y valores

##caso1
def run():
    mi_diccionario = {
        'llave1' : 1,
        'llave2' : 2,
        'llave3' : 3
    }
    print(mi_diccionario)
    print(mi_diccionario['llave1'])
    print(mi_diccionario['llave2'])
    print(mi_diccionario['llave3'])

if __name__ == '__main__':
    run()

##caso 2
def run():
    poblacion_paises = {
        'Argentina' : 44938712,
        'Brasil' : 210147125,
        'Colombia' : 50372424
    }
    print(poblacion_paises['Argentina'])
    print(poblacion_paises['Brasil'])
    print(poblacion_paises['Colombia'])
    for pais in poblacion_paises.keys():
        print(pais)
    for pais in poblacion_paises.values():
        print(pais)
    for pais,poblacion in poblacion_paises.items():
        print(str(pais) + ' tiene ' + str(poblacion) + ' habitantes')        

if __name__ == '__main__':
    run()
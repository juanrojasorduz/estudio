## programa con defecto:

# def divisors(num):
#     divisors = []
#     for i in range(1, num + 1):
#         if num % i == 1:
#             divisors.append(i)
#     return divisors


# def run():
#     num = int(input('Ingresa un número: '))
#     print(divisors(num))
#     print("Terminó mi programa")


# if __name__ == '__main__':
#     run()

## programa corregido:
# def divisors(num):
#     divisors = []
#     for i in range(1, num + 1):
#         if num % i == 0:
#             divisors.append(i)
#     return divisors


# def run():
#     num = int(input('Ingresa un número: '))
#     print(divisors(num))
#     print("Terminó mi programa")


# if __name__ == '__main__':
#     run()  
# 



### programa con defecto:
# def palindromo(string):
#     return string == string[::-1]
# print(palindromo(1))


### programa corregido - opcion 2:

# def palindromo(string):
#     return string == string[::-1]

# try:
#     print(palindromo(1))
# except TypeError:
#     print('Solo se pueden ingresar strings')


### programa corregido - opcion 3:

# def palindromo(string):
#     try:
#         if len(string) == 0:
#             raise ValueError("No se puede ingresar una cadena vacia")
#         return string == string[::-1]
#     except ValueError as ve:
#         print(ve)
#         return False

# try:
#     print(palindromo(""))
# except TypeError:
#     print("Solo se pueden ingresar strings")


### programa para finally

# try:
#     f = open("archivo.txt")
#     ## hacer cualquier cosa con nuestro archivo
# finally:
#     f.close()



#### aplicacion final 

# def divisors(num):
#     divisors = []
#     for i in range(1, num + 1):
#         if num % i == 0:
#             divisors.append(i)
#     return divisors


# def run():
#     while True:
#         try:
#             num = int(input('Ingresa un número: '))
#             if num <= 0:
#                 raise ValueError
#             print(divisors(num))
#             print("Terminó mi programa")
#             break
#         except ValueError:
#             print("Debes ingresar un entero positivo")


# if __name__ == '__main__':
#     run()



### asserts statements
# def divisors(num):
#     divisors = []
#     for i in range(1, num + 1):
#         if num % i == 0:
#             divisors.append(i)
#     return divisors


# def run():
#     num = input('Ingresa un número: ')
#     assert num.isnumeric(), "Debes ingresar un número"
#     print(divisors(int(num)))
#     print("Terminó mi programa")


# if __name__ == '__main__':
#     run()




### asserts statements challenge:
def divisors(num):
    assert num >= 0, "Debes ingresar un número positivo"
    divisors = []
    for i in range(1, num + 1):
        if num % i == 0:
            divisors.append(i)
    return divisors


def run():
    num = input('Ingresa un número: ')
    assert num.replace("-", "").isnumeric(), "Debes ingresar un número"
    print(divisors(int(num)))
    print("Terminó mi programa")


if __name__ == '__main__':
    run()

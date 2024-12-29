
## opcion 1 - metodo tradicional

# def run():
#     squares = []
#     for i in range(1,101):
#         if i % 3 != 0:
#             squares.append(i**2)
#     print(squares)

# if __name__ == "__main__":
#     run()


## opcion 2 - metodo list comprehensions:
# def run():
#     squares = [i**2 for i in range(1,101) if i % 3 != 0]
#     print(squares)

# if __name__ == "__main__":
#     run()    

## opcion 2 - metodo list comprehensions caso 2:
def run():
    squares = [i for i in range(1,500) if i % 4 == 0 and i % 6 == 0 and i % 9 == 0]
    print(squares)

if __name__ == "__main__":
    run()       
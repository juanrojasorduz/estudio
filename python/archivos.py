### lectura
# def read():
#     numbers = []
#     with open("./archivos/numbers.txt", "r") as f: 
#         for line in f:
#             numbers.append(int(line))
#     print(numbers)


# def run():
#     read()


# if __name__ == "__main__":
#     run()


### escritura    

# def write():
#     names = ["Facundo", "Gregorio", "Marta", "Susana", "Jose"]
#     with open("./archivos/names.txt", "w") as f:
#         for name in names: 
#             f.write(name)
#             f.write("\n")

# def run():
#     write()


# if __name__ == '__main__':
#     run()


### agregar    

def write_append():
    names = ["Carolina", "Pedro", "Diego", "Yayo", "Martin"]
    with open("./archivos/names.txt", "a") as f:
        for name in names: 
            f.write(name)
            f.write("\n")

def run():
    write_append()


if __name__ == '__main__':
    run()    
## set -> estructura de datos sin orden es decir sin indexado y con elementos unicos, es decir no se pueden repetir
my_set = {3, 4, 5}
print(my_set) # {3, 4, 5}

my_set2 = {"Hola", 23.3, False, True}
print(my_set2) # {False, True, "Hola", 23.3}

my_set3 = {3, 3, 2}
print(my_set3) # {3, 2}

## my_set4 = {[1, 2, 3], 4} # ERROR!!!

empty_set = {} # Esto es dict por defecto
print(type(empty_set)) # <class 'dict'>

empty_set = set()
print(type(empty_set)) # <class 'set'>

## convirtiendo listas y tuplas en sets
my_list = [1, 1, 2, 3, 4, 4, 5]
my_set = set(my_list)
print(my_set)

my_tuple = ('hola','hola','hola',1)
my_set2 = set(my_tuple)
print(my_set2)


## añadiendo elementos al set
my_set = {1, 2, 3}
print(my_set)

my_set.add(4)
print(my_set)

my_set.update([1, 2, 5])
print(my_set)

my_set.update((1, 7, 2), {6, 8})
print(my_set)


## eliminando elementos
my_set = {1, 2, 3, 4, 5, 6, 7}
print(my_set)

my_set.discard(1)
print(my_set)

my_set.remove(2)
print(my_set)

my_set.discard(10)
print(my_set)

my_set = {1, 2, 3, 4, 5, 6, 7}
my_set.pop() ## borrar elemento aleatorio
print(my_set) 

my_set.clear() ## dejar set vacio
print(my_set)


## operaciones sobre sets
my_set1 = {3, 4, 5}
my_set2 = {5, 6, 7}

my_set3 = my_set1 | my_set2  ## accedo a la union y elimino elementos repetidos
print(my_set3)


my_set1 = {3, 4, 5}
my_set2 = {5, 6, 7}

my_set3 = my_set1 & my_set2  ## accedo a los elementos comunes entre los dos sets
print(my_set3)


my_set1 = {3, 4, 5}
my_set2 = {5, 6, 7}

my_set3 = my_set1 - my_set2  ## quito elementos que esten en el set 2 al set 1
print(my_set3)

my_set3 = my_set2 - my_set1  ## quito elementos que esten en el set 1 al set 2
print(my_set3)


my_set1 = {3, 4, 5}
my_set2 = {5, 6, 7}

my_set3 = my_set1 ^ my_set2  ## dejo los elementos que no sean comunes
print(my_set3)



### ELIMINANDO DUPLICADOS DE UNA LISTA
def remove_duplicates(some_list):
    without_duplicates = []
    for element in some_list:
        if element not in without_duplicates:
            without_duplicates.append(element)
    return without_duplicates

def remove_duplicates_with_sets(some_list):
    return list(set(some_list))

def run():
    random_list = [1, 2, 2, 2, 3, "Platzi", "Platzi", True, 4.6, False]
    print(remove_duplicates(random_list))


if __name__ == '__main__':
    run()
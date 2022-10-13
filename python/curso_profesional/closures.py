## reglas para encontrar un closure
## debemos tener una nested function
## la nested function debe referenciar un valor de un scope superior
## la función que envuelve la nested debe retornarla también
## cuando tenemos una clase que tiene solo un método
## cuando trabajamos con decoradores

## CASO 1
def main():

    a = 1

    def nested():
        print(a)

    return nested

my_func = main()

print(type(my_func))

print(my_func())


### CASO 2

def make_multiplier(x):

    def multiplier(n):
        return x * n

    return multiplier

times10 = make_multiplier(10)
times4 = make_multiplier(4)

print(times10(3))
print(times4(5))
print(times10(times4(2)))


### CASO 3

def make_repeater_of(n):
    def repeater(string):
        assert type(string) == str, 'Solo puedes repetir cadenas'
        return string * n
    return repeater


def run():
    repeat_5 = make_repeater_of(5)
    print(repeat_5('Hola'))
    repeat_10 = make_repeater_of(10)
    print(repeat_10('Platzi'))


if __name__ == '__main__':
    run()




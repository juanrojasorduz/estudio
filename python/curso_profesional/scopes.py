z = 5

def my_func():
    z = 3

    def my_other_func():
        z = 2
        print(z)

    my_other_func()

    print(z)

my_func()

print(z)
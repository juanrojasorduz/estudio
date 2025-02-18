from os import getenv


if name := getenv('NAME'):
    print(f"Hola {name}!")
else:
    print("Hola")

def run():
    my_list = [1,"Hello",True,4.5]
    my_dict = {"first_name": "Facundo", "last_name": "Garcia"}

    super_list = [
        {"first_name": "Facundo", "last_name": "Garcia"},
        {"first_name": "Miguel", "last_name": "Torres"},
        {"first_name": "Pepe", "last_name": "Rodelo"},
        {"first_name": "Susana", "last_name": "Martinez"},
        {"first_name": "Jose", "last_name": "Garcia"},
    ]

    super_dict = {
        "natural_nums": [1, 2, 3, 4, 5],
        "integer_nums": [-1, -2, 0, 1, 2],
        "floating_nums": [1.1, 4.5, 6.43]
    }

    for key, value in super_dict.items():
        print(key, "-", value)

if __name__ == "__main__":
    run()


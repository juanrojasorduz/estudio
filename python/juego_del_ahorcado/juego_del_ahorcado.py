#### PROGRAMA DE JUEGO DEL AHORCADO

###### INICIO

## PRIMERA INSTRUCCIÓN - IMPORTAR LAS LIBRERIAS NECESARIAS PARA DESARROLLAR EL PROGRAMA

import numbers
import random
from getpass import getpass

## SEGUNDA INSTRUCCIÓN - SELECCIONAR EL METODO DE JUEGO

menu = """
Welcome to Hangman Game
1- random word
2- defined word
3- random word from a list

Please chooice a game methodology: """


while True:
    try:
        selected_option = int(input(menu))
        option_list = [1,2,3]
        if selected_option not in option_list:
            raise ValueError("You must select a number between 1,2 y 3")
        else:
            break
    except ValueError:
        print("You must select a number between 1,2 y 3")

## TERCERA INSTRUCCION - DEFINIR LA FUNCION PARA INTRODUCIR NUEVAS PALABRAS

def word_input(type):
    while True:
        try:
            symbols = ['!','#','$','&','/','(',')',' ']
            numbers = ['1','2','3','4','5','6','7','8','9','0']
            print('')
            if type == 'not_show':
                word_input = getpass(prompt='Write the word for the game: ')
            else:
                word_input = input('Write the letter for the game: ') 
            contador = 0
            for letter in word_input:
                if letter in symbols or letter in numbers:
                    contador += 1
            if contador != 0:
                raise ValueError("The word cannot contain a symbol or a number,please try again")
            else:
                break
        except ValueError:
            print("The word cannot contain a symbol or a number,please try again")
    return word_input

## CUARTA INSTRUCCIÓN - DEFINIR LA FUNCION PARA TRAER LISTA ALEATORIA

def random_word_list():
    words_list = [] 
    with open("./archivo/words.txt","r") as f:
        f = f.read().split("\n")
        for line in f:
            words_list.append(line)
            words_list = list(filter(lambda x: len(x) >= 7,words_list))
    return words_list

## QUINTA INSTRUCCION - DEFINIR LA FUNCION PARA TRAER LISTA DE PALABRA DEFINIDA

def defined_word_list():
    words_list = []
    word = word_input('not_show')
    words_list.append(word)
    return words_list

## SEXTA INSTRUCCIÓN - DEFINIR LA FUNCION PARA TRAER LISTA DE PALABRAS INGRESADAS

def random_defined_word_list():
    print('')
    options_number = int(input("Select the number of possible words for the game: "))
    words_list = []
    for i in range(options_number):
        word = word_input('not_show')
        words_list.append(word)
    return words_list

## SEPTIMA INSTRUCCION - DEFINIR METODO DE JUEGO
if selected_option == 1:
    words_list = random_word_list()
elif selected_option == 2:
    words_list = defined_word_list()
else:
    words_list = random_defined_word_list()

## OCTAVA INSTRUCCIÓN - SELECCIONAR UNA PALABRA ALEATORIA DENTRO DE LA LISTA DE STRINGS SELECCIONADA
 
def key_word():
    choice_list = words_list
    key_word = random.choice(choice_list)
    key_word = key_word.upper()
    return key_word

## NOVENA INSTRUCCIÓN - DEFINIR FUNCION DE DIBUJO DEL JUEGO

def error(attemps):
    if attemps == 1:
        print(" ____")
        print(" |   |")
        print(" | ")
        print(" | ")
        print(" | ")
        print(" | ")	
        print("_|_")
        print("¡Be careful, you have 3 attempts left!")
    elif attemps == 2:
        print(" ____")
        print(" |   |")
        print(" |   0")
        print(" | ")
        print(" | ")
        print(" | ")	
        print("_|_")
        print("¡Be careful, you have 2 attempts left!")
    elif attemps == 3:
        print(" ____")
        print(" |   |")
        print(" |   0")
        print(" |   |")
        print(" | ")
        print(" |")	
        print("_|_")
        print("¡Be careful, you have 1 attempts left!")
    elif attemps == 4:
        print(" ____")
        print(" |   |")
        print(" |   0")
        print(" |  /|\ ")
        print(" | ")
        print(" |")	
        print("_|_")
        print("¡Be careful, you don't have attempts!")
    else:
        print(" ____")
        print(" |   |")
        print(" |   0")
        print(" |  /|\ ")
        print(" |  / \ ")
        print(" |")	
        print("_|_")
        print("¡You've been hanged, try again next time!")

## DECIMA INSTRUCCION - FORMAR UNA LISTA DE DICCIONARIOS INDIVIDUALES POR CADA LETRA

def validation_list():
    key_word_validation = key_word()
    letter_list = []
    counter = 0
    for letter in key_word_validation:
        letter_dict = {}
        counter += 1
        letter_dict['key'] = counter 
        letter_dict['value'] = letter
        letter_dict['hidden_value'] = '_'
        letter_dict['final_value'] = '_'
        letter_list.append(letter_dict)
    return letter_list

# ONCEAVA INSTRUCCION

attemps = 0
letter_list = validation_list()
hanged_flag = True
# for letter in letter_list:
#     print(letter['value'],end='')

while True:
    print('')
    selected_letter = word_input('show').upper()
    print('')
    final_string = '' 
    for letter_dict in letter_list:
        if letter_dict['value'] == selected_letter or letter_dict['final_value'] == letter_dict['value']:
            letter_dict['final_value'] = letter_dict['value']
        else:
            letter_dict['final_value'] = letter_dict['hidden_value']            
        final_string += letter_dict['final_value']

    if final_string.find('_') == -1:
        print(final_string)
        print('¡Congratulations, you have been the winner!')
        break
    else:
        print(final_string)
        if selected_letter not in final_string:
            attemps += 1
            error(attemps)
    if attemps >= 5:
        break
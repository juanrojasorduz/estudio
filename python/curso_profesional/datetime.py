import datetime

my_time = datetime.datetime.now() ## trae fecha y hora

print(my_time)

my_day = datetime.date.today() ## me trae unicamente la fecha
print(my_day)
print(f'Year: {my_day.year}')
print(f'Month: {my_day.month}')
print(f'Day: {my_day.day}')

my_datetime = datetime.datetime.now()
print(my_datetime)

my_str = my_datetime.strftime('%d/%m/%Y')
print(f'Formato LATAM: {my_str}')

my_str = my_datetime.strftime('%m/%d/%Y')
print(f'Formato USA: {my_str}')

my_str = my_datetime.strftime('Estamos en el año %Y')
print(f'Formato Random: {my_str}')


## PARA TIMEZONES -> Instalar py -m pip install pytz

import pytz

my_city_timezone = pytz.timezone('America/Bogota')
my_city_time = datetime.datetime.now(my_city_timezone)
print("Bogotá:", my_city_time.strftime("%d/%m/%Y, %H:%M:%S"))

my_city_timezone = pytz.timezone('America/Mexico_City')
my_city_time = datetime.datetime.now(my_city_timezone)
print("Ciudad de México:", my_city_time.strftime("%d/%m/%Y, %H:%M:%S"))

my_city_timezone = pytz.timezone('America/Caracas')
my_city_time = datetime.datetime.now(my_city_timezone)
print("Caracas:", my_city_time.strftime("%d/%m/%Y, %H:%M:%S"))






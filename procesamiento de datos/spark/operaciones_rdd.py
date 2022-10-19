## importamos libreria para poder iniciar contexto
from pyspark import SparkContext  
## seteamos variables de entorno para configurar el driver y ejecutor
import os
os.environ['PYSPARK_PYTHON'] = '/usr/bin/python3'
os.environ['PYSPARK_DRIVER_PYTHON'] = '/usr/bin/python3'

## creamos nuestro inicializador
sc = SparkContext(master='local',appName='transformacionesyacciones')

rdd1 = sc.parallelize([1,2,3]) ## creamos un rdd
print(type(rdd1))  ## imprimimos el tipo de dato que es rdd1
print(rdd1.collect()) ## imprimimos la visualizacion de este tipo de dato

## Hacemos git clone en documentos: juandiegorojas@Diego:/mnt/c/users/juandiego/documents$ git clone https://github.com/terranigmark/curso-apache-spark-platzi.git

##!ls curso-apache-spark-platzi/files ## visualizamos los archivos de la carpeta de archivos

path = 'curso-apache-spark-platzi/files/' ## definimos ruta donde se encuentran nuestro archivos

equiposOlimpicosRDD = sc.textFile(path+'paises.csv') \
    .map(lambda line : line.split(','))
print(type(equiposOlimpicosRDD)) ## imprimimos el tipo de dato de este rdd
print(equiposOlimpicosRDD.take(5)) ## imprimimos 5 registros del rdd

## imprimimos las variables de entorno
# print(os.environ['PYSPARK_PYTHON'])
# print(os.environ['PYSPARK_DRIVER_PYTHON'])
# print(os.environ['SPARK_HOME'])
# print(os.environ['PYTHONPATH'])

print(equiposOlimpicosRDD.map(lambda x: x[2]).distinct().count())  ## obtener el numero de siglas usado en el rdd

print(equiposOlimpicosRDD.map(lambda x: (x[2],x[1])).groupByKey() \
    .mapValues(len).take(5))  ## obtener el numero de equipos en el rdd

print(equiposOlimpicosRDD.map(lambda x: (x[2],x[1])).groupByKey() \
    .mapValues(list).take(5))  ## obtener el numero de equipos en el rdd

print(equiposOlimpicosRDD.filter(lambda l : 'ARG' in l).take(5))

deportistaOlimpicoRDD = sc.textFile(path+'deportista.csv') \
    .map(lambda l : l.split(','))
deportistaOlimpicoRDD2 = sc.textFile(path+'deportista2.csv') \
    .map(lambda l : l.split(','))
deportistaOlimpicoRDD = deportistaOlimpicoRDD \
    .union(deportistaOlimpicoRDD2)

print(deportistaOlimpicoRDD.count())

print(deportistaOlimpicoRDD.top(2))

print(deportistaOlimpicoRDD.map(lambda l: [l[-1],l[:-1]]) \
    .join(equiposOlimpicosRDD.map(lambda x : [x[0],x[2]])) \
    .take(6))

print(deportistaOlimpicoRDD.map(lambda l: [l[-1],l[:-1]]) \
    .join(equiposOlimpicosRDD.map(lambda x : [x[0],x[2]])) \
    .takeSample(False,6,25))

resultado = sc.textFile(path+'resultados.csv') \
    .map(lambda l : l.split(','))

resultadoGanador = resultado.filter(lambda l : 'NA' not in l[1])
print(resultadoGanador.take(2))

deportistaPaises = deportistaOlimpicoRDD \
    .map(lambda l :[ l[-1],l[:-1]]) \
    .join(equiposOlimpicosRDD.map(lambda x:[ x[0],x[2] ]))

print(deportistaPaises.join(resultadoGanador).take(6))

valoresMedallas = {'Gold' : 7, 'Silver': 5, 'Bronze': 4}

paisesMedallas = deportistaPaises.join(resultadoGanador)

print(paisesMedallas \
    .map(lambda x: (x[1][0][-1], valoresMedallas[x[1][1]])).take(4))

from operator import add
conclusion = paisesMedallas.reduceByKey((add)) \
    .sortBy(lambda x : x[1],ascending=False)

print(conclusion.take(10))

print(type(conclusion))

sc.stop()

#!/usr/bin/env python
# coding: utf-8

# # Particionado

# ## Creamos una sesión de spark 

# In[ ]:


from pyspark.sql import SparkSession


# Spark permite desde la creación de la sesión o contexto, indicar la cantidad de particiones que tendremos
# 
# Para esto debemos de indicar con '[ ]'  en la indicación de master la cantidad total de particiones

# In[ ]:


spark = SparkSession.builder.appName("Particionado").master( "local[5]").getOrCreate()


# In[ ]:


df = spark.range(0,20)
df.rdd.getNumPartitions()


# El método 'parallelize', permite la asignar manualmente la cantidad de particiones.

# In[ ]:


rdd1 = spark.sparkContext.parallelize((0,20),6)
rdd1.getNumPartitions()


# Del mismo modo cuandore creamos un RDD o DF, podemos hacer esto.
# 
# En el caso de los RDD se realiza de la siguiente forma

# In[ ]:


rddDesdeArchivo = spark \
    .sparkContext \
    .textFile("/home/spark/Downloads/curso-apache-spark-platzi-master/files/deporte.csv",10)


# In[ ]:


rddDesdeArchivo.getNumPartitions()


# Es una buena practica tener los archivos de datos particionados para una carga mas rápida y mejor administración.
# 
# El método 'saveAsTextFile' permite almacenar los archivos, particionados o no, en un ruta.

# In[ ]:


rddDesdeArchivo.saveAsTextFile("/home/spark/Downloads/salidastexto")


# In[ ]:


get_ipython().system('ls /home/spark/Downloads/salidastexto/')


# A continuación se muestra como cargar los multiples archivos en un mismo RDD.
# 
# Esta operación tambien se puede realizar para DF

# In[ ]:


rdd = spark.sparkContext.wholeTextFiles("/home/spark/Downloads/salidastexto/*")


# In[ ]:


lista = rdd.mapValues(lambda x : x.split()).collect()


# In[ ]:


l = [l[0] for l in lista]
l.sort()


# In[ ]:


rddDesdeArchivo = spark \
    .sparkContext \
    .textFile(','.join(l),
              10).map(lambda l : l.split(","))


# In[ ]:


rddDesdeArchivo.take(7)


# In[ ]:


get_ipython().system('pwd')


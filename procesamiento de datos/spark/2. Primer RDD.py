#!/usr/bin/env python
# coding: utf-8

# #  RDDs 

# # Creamos un contexto para crear RDDs

# In[ ]:


from pyspark import SparkContext


# In[ ]:


sc = SparkContext(master = "local", appName="TransformacionesyAcciones")


# # Un RDD es una colección inmutable y distribuida de elementos
# 
# ### Spark automaticamente distribute los datos y paraleliza las operaciones
# 
# ### Los RDD realmente cargan colecciones de datos

# In[ ]:


rdd1 = sc.parallelize([1,2,3])


# ### Debido a la propiedad de distribución que tienen los RDD, en su creación, podemos particionar los datos

# In[ ]:


import numpy as np
rdd2 = sc.parallelize(np.array(range(100)),2)


# ### Verificamos el tipo de dato

# In[ ]:


type(rdd1)


# ### Vemos el contenido
# 
# A lo largo del curso se verán tecnicas apropiadas para ver el contenido de los RDDs y Dataframes

# In[ ]:


rdd1.collect()


# # Carga de un arhivo CSV

# ### Revisamos la carpeta y su contenido
# 
# Cambia esto para que apunte a la ruta donde tienes los datos 

# In[ ]:


get_ipython().system('ls ../proyecto/paises.csv')
get_ipython().system('wc ../proyecto/paises.csv')


# ### Cargamos un RDDs
# 
# El método textFile busca el archivo en la ruta indicada
# 
# Cambia el valor de la ruta para que apunte a la ruta donde tienes los datos

# In[ ]:


path = "../proyecto/"

equiposOlimpicosRDD = sc.textFile(path+"paises.csv",2).map(lambda line : line.split(","))


# ### Vemos el contenido
# 
# El método take es otro método existnte para poder visualizar el contenido de los RDDs

# In[ ]:


equiposOlimpicosRDD.take(10)


# In[ ]:


sc.stop()


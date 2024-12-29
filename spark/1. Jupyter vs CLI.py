#!/usr/bin/env python
# coding: utf-8

# # Jupyter vs CLI

# ## Importamos SparkContext y SparkSession

# In[ ]:


from pyspark import SparkContext
from pyspark.sql import SparkSession


# ## Creamos nuestra primer sesion

# In[ ]:


spark = SparkSession.builder \
        .master("local") \
        .appName("miPrimerApplicacion") \
        .getOrCreate()


# ## Terminamos la sesión actual
# 
# No podemos tener mas de una sesión a la vez en nuestro notebook, por lo cual con el método 'stop' terminaremos la applicación.
# 
# De la misma forma, al terminar una applicación, debemos de indicar explicitamente que termine. De otra forma no liberará los recursos asignados.

# In[ ]:


spark.stop()


# ## Creamos una sesión heredando los atributos de un contexto

# In[ ]:


spark = SparkContext(master="local",appName = "miPrimerContexto")
spark2 = SparkSession(spark)


# ## Creamos una sesión múltiple

# In[ ]:


sparkSession2 = spark2.newSession()


# ## Revisamos que los tres objetos apuntan a la misma aplicación
# 
# Aprovechando la salida que nos ofrece, conocemos SparkUI, el monitor por excelencia para Spark

# In[ ]:


spark2


# In[ ]:


spark


# In[ ]:


sparkSession2


# In[ ]:


spark2.stop()


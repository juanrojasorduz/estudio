#!/usr/bin/env python
# coding: utf-8

# # Dataframes y replicación

# # Creamos un contexto de Spark y otro de SQL
# 
# Nota: Cargo desde el inicio todos los métodos/modulos que se usarán a lo largo del notebook.

# In[ ]:


from pyspark import SparkContext
from pyspark.sql import SparkSession
from pyspark.storagelevel import StorageLevel
import pyspark.sql 
from pyspark.sql import SQLContext
from pyspark.sql.functions import * 
from pyspark.sql.types import StructType, StructField, IntegerType, StringType,FloatType
from pyspark.sql.types import Row


# In[ ]:


spark = SparkContext(master="local", appName="DF y replicación")
sqlContext = SQLContext(spark)


# ## Función para eliminar encabezados

# In[ ]:


def dropFirstRow(index,iterator):
     return iter(list(iterator)[1:]) 


# ## Creación del primer DataFrame
# 
# Las tres cosas que debes recordar al crear un Dataframe desde un RDDs son:
# 1. En caso de tener encabezado, eliminarlo
# 2. Seleccionar y hacer explícita la seperación de las columnas. Si es necesario castear valores
# 3. Crear el esquema a usarse con los tipos de datos de Spark
# 
# Cambia el valor de la ruta para que apunte a la ruta donde tienes los datos

# In[ ]:


path = "/home/spark/Downloads/curso-apache-spark-platzi-master/files/"

deportistaOlimpicoRDD =  spark.textFile(path+"deportista.csv").map(lambda line : line.split(","))
deportistaOlimpico2RDD = spark.textFile(path+"deportista2.csv").map(lambda line : line.split(","))
deportistaOlimpicoRDD = deportistaOlimpicoRDD.union(deportistaOlimpico2RDD)

deportistaOlimpicoRDD=deportistaOlimpicoRDD.mapPartitionsWithIndex(dropFirstRow)

deportistaOlimpicoRDD = deportistaOlimpicoRDD.map(lambda l : (
int(l[0]),
l[1],
int(l[2]),
int(l[3]),
int(l[4]),
float(l[5]),
int(l[6])
))

schema = StructType([
StructField("deportista_id",IntegerType(),False)     ,
StructField("nombre",StringType(),False)        ,
StructField("genero",IntegerType(),False)        ,
StructField("edad",IntegerType(),True)      ,
StructField("altura",IntegerType(),True)        ,
StructField("peso",FloatType(),True)      ,
StructField("equipo_id",IntegerType(),True)     
])

deportistaOlimpicoDF = sqlContext.createDataFrame(deportistaOlimpicoRDD,schema)


# ## Creación de DF desde archivo
# 
# En el caso de la creación de un DF desde cero, solo debemos de indicar la estructura, nombre del archivo y opcionalmente si posee o no encabezado.

# In[ ]:


deportesOlimpicosRDDSchema = StructType(
    [StructField("deporte_id",IntegerType(),False),
     StructField("deporte",StringType(),False)
    ])

deportesDF = sqlContext.read.schema(deportesOlimpicosRDDSchema).option("header","true").csv(path+"deporte.csv")


# ### UDF
# 
# Nota: Este apartado en el curso se pone al final.
# 
# Para ejemplificar la función creada por el usuario, cargamos deportistaError el cual tiene ausencia de valores.
# 
# Con la UDF solucionamos el error. Esta no es una solución definitiva, solo es demostrativa para explicar como crear una UDF.

# In[ ]:


deportistaOlimpicoRDD =  spark.textFile(path+"deportistaError.csv").map(lambda line : line.split(","))
deportistaOlimpicoRDD=deportistaOlimpicoRDD.mapPartitionsWithIndex(dropFirstRow)

deportistaOlimpicoRDD = deportistaOlimpicoRDD.map(lambda l : (
l[0],
l[1],
l[2],
l[3],
l[4],
l[5],
l[6]
))

schema = StructType([
StructField("deportista_id",StringType(),False)     ,
StructField("nombre",StringType(),False)        ,
StructField("genero",StringType(),False)        ,
StructField("edad",StringType(),True)      ,
StructField("altura",StringType(),True)        ,
StructField("peso",StringType(),True)      ,
StructField("equipo_id",StringType(),True)     
])

deportistaError = sqlContext.createDataFrame(deportistaOlimpicoRDD,schema)


# In[ ]:


deportistaError.show()


# ### Creación de UDF
# 
# Los pasos para crear la udf son:
# 
# 1. Crear la función base
# 2. Registrarla como udf
# 3. Indicar al sqlContext que la usaremos como función nativa en sqlContext (opcional)

# In[ ]:


def ci(value: str) -> int:
    return int(value) if len(value) > 0 else None

ci_udf = udf(lambda z : ci(z), IntegerType())

sqlContext.udf.register("ci_udf", ci_udf)

deportistaError.select(ci_udf("altura").alias("altura")).show()


# In[ ]:


deportistaError.show()


# ## Reto
# 
# Dar vida a todos los archivos como Dataframes.
# 
# Se anexa una solución probable.

# In[ ]:


paisesRDD = spark.textFile(path+"paises.csv").map(lambda line : line.split(","))
paisesRDD = paisesRDD.mapPartitionsWithIndex(dropFirstRow)

paisesRDD = paisesRDD.map(lambda l : (
int(l[0]),
l[1],
l[2]
))

schema = StructType([
StructField("id",IntegerType(),False),
StructField("equipo",StringType(),False),
StructField("sigla",StringType(),False)
])

paisesDF = sqlContext.createDataFrame(paisesRDD,schema)


# In[ ]:


eventoSchema= StructType([
    StructField("evento_id",IntegerType(),False),
    StructField("nombre",StringType(),False),
    StructField("deporte_id",IntegerType(),False)
])

deportesOlimpicosDF = sqlContext.read.schema(eventoSchema).option("header","true").csv(path+"evento.csv")


# In[ ]:


juegoSchema = StructType([
    StructField("juego_id",IntegerType(),False),
    StructField("anio",StringType(),False),
    StructField("temporada",StringType(),False),
    StructField("ciudad",StringType(),False),
])
juegoDF = sqlContext.read.schema(juegoSchema).option("header","true").csv(path+"juegos.csv")

resultadoSchema = StructType([
    StructField("resultado_id",IntegerType(),False),
    StructField("medalla",StringType(),False),
    StructField("deportista_id",IntegerType(),False),
    StructField("juego_id",IntegerType(),False),
    StructField("evento_id",IntegerType(),False),
])
resultadoDF = sqlContext.read.schema(resultadoSchema).option("header","true").csv(path+"resultados.csv")


# In[ ]:


deportesDF.take(5)


# In[ ]:


deportesOlimpicosDF.take(5)


# In[ ]:


paisesDF.take(5)


# In[ ]:


juegoDF.take(5)


# In[ ]:


deportistaOlimpicoDF.take(5)


# In[ ]:


resultadoDF.take(5)


# ## Revisión de esquema
# 
# En ocasiones nosotros no creamos los Dataframes y la estrucutra es desconocida para nosotros. con ayuda del método 'printSchema' podemos conocer el esquema del DataFrame

# In[ ]:


deportesDF.printSchema()


# In[ ]:


deportistaOlimpicoDF.printSchema()


# # Operaciones de renombrado y eliminación
# 
# Para renombrar una columna de un DF, podemos usar el método 'withColumnRenamed' o 'alias'.
# 
# Para eliminar columnas, podemos usar el método 'drop' o simplemente selecionar las columnas que deseamos y sobreesciribr el DF

# In[ ]:


deportistaOlimpicoDF = deportistaOlimpicoDF.withColumnRenamed("genero","sexo").drop("altura")


# In[ ]:


deportistaOlimpicoDF.printSchema()


# In[ ]:


from pyspark.sql.functions import *
deportistaOlimpicoDF = deportistaOlimpicoDF.select("deportista_id","nombre",
                            col("edad").alias("edadAlJugar"),"equipo_id")


# In[ ]:


deportistaOlimpicoDF.show(5)


# ## Filtrado de valores
# 
# Como con el uso de RDDs, podemos usar el método 'filter' para selecionar subconjuntos.
# 
# filter permite usar operaciones lógicas y de comparación como <,>,>=,!= , &,| 

# In[ ]:


deportistaOlimpicoDF = deportistaOlimpicoDF.filter( (deportistaOlimpicoDF.edadAlJugar != 0))


# In[ ]:


deportistaOlimpicoDF.sort("edadAlJugar").show()


# ## Unión de DF
# 
# Las operaciones conocidas como Join en SQL, tienen una impementación similar, ya que  el método 'join' recibe tres componentes:
# 
# | Orden | Argumento | Descripción |
# |-------|--------|-----|
# |1|dataFrame|dataFrame con el que queremos realizar el cruce|
# |2|Cruze|Operación lógica a realizar para poder unir los Dataframes|
# |3|Tipo|El tipo de join a realizar: "Left", "Right",etc|
# 
# No olvides que un join es una operación binaria. Por lo que si deseas unir mas DF, deberás realizar multiples joins
# 
# Posterior a los joins realizados, debemos de realizar una operación select para indicar que valores queremos. 
# 
# En el caso de campos repetidos, podemos hacer explícito el dataframe de origen y para evitar confusón, utilizar alias.

# In[ ]:


deportistaOlimpicoDF.join(resultadoDF, deportistaOlimpicoDF.deportista_id == resultadoDF.deporitsta_id,"left") \
    .join(juegoDF,juegoDF.juego_id == resultadoDF.juego_id,"left") \
    .join(deportesOlimpicosDF, deportesOlimpicosDF.evento_id == resultadoDF.evento_id,"left") \
    .select(deportistaOlimpicoDF.nombre,col("edad").alias("Edad el jugar"),
           "medalla",col("anio").alias("Año de juego"),
           deportesOlimpicosDF.nombre.alias("Nombre de disciplina")).show()


# De la misma forma que una instrucción SQL posee una jerarquía para poder funcionar y retornar correctamente los valores que deseamos. Los DF estan reguidos por las mismas reglas, es decir la misma jerarquía

# In[ ]:


resultadoDF.filter(resultadoDF.medalla != "NA") \
    .join(deportistaOlimpicoDF,deportistaOlimpicoDF.deportista_id == resultadoDF.deportista_id,"left") \
    .join(paisesDF,paisesDF.id == deportistaOlimpicoDF.equipo_id, "left") \
    .select("medalla", "equipo","sigla").sort( col("sigla").desc() ).show()


# ## Funciones escalares
# 
# De la misma forma que SQL posee funciones para poder obtener estadísticas. DF hereda el mismo concepto apoyandose de los métodos 'groupBy', "agg" y los ya conocidos de sql "count","sum","avg" etc.

# Para el ejercicio, buscaremos conocer cuantas medallas ha ganado un pais en cada juego olimpico.
# 
# Primero realizamos la batería de joins que nos permitan identificar todos los valores que necesitamos.

# In[ ]:


medallistaXAnio = deportistaOlimpicoDF.join(resultadoDF, deportistaOlimpicoDF.deportista_id ==resultadoDF.deportista_id,"left") \
        .join(juegoDF, juegoDF.juego_id == resultadoDF.juego_id,"left") \
        .join(paisesDF,deportistaOlimpicoDF.equipo_id == paisesDF.id,"left") \
        .join(deportesOlimpicosDF, deportesOlimpicosDF.evento_id == resultadoDF.evento_id,"left") \
        .join(deportesDF,deportesOlimpicosDF.deporte_id == deportesDF.deporte_id,"left") \
        .select("sigla",
                "anio",
                "medalla",
                deportesOlimpicosDF.nombre.alias("Nombre subdisciplina"),
                deportesDF.deporte.alias("Nombre disciplina"),
                deportistaOlimpicoDF.nombre,   
                )


# In[ ]:


medallistaXAnio.show()


# Previo, identificamos el uso del método "like".
# 
# El cual es util cuando no sabemos el nombre completo o correcto de una columna deseada. 
# 
# En este ejemplo, apartir de todos los juegos de Ski Aplino Femenino, obtenemos la competencias en las que participó el pais. Recuerda que la columna medalla aun posee valores NA.

# In[ ]:


medallistaXAnio.where( col("Nombre subdisciplina").like("Alpine Skiing Wo%")) \
    .sort("anio") \
    .groupBy("Sigla","anio").count() \
    .show()


# En este paso nos quedamos solo con medallas

# In[ ]:


medallistaXAnio2 = medallistaXAnio.filter(medallistaXAnio.medalla != "NA") \
    .sort("anio") \
    .groupBy("Sigla","anio","Nombre subdisciplina") \
    .count()


# ## Forma recomendada para agrupar
# 
# El método 'agg' es la forma recomendada para hacer agrupaciones ya que brinda la oportunidad de escalar la cantidad de operaciones escalares a realizar en un mismo DF.
# 
# Es claro que si solo realizamos una operación de agrupación, el uso de 'agg' es excesivo, esta es la recomendación oficial de uso.

# In[ ]:


medallistaXAnio2.groupBy("Sigla","anio") \
    .agg(sum("count").alias("Total de medallas"), \
         avg("count").alias("Medallas promedio")) \
    .show()


# ## Funciones escalares

# El ejempo realizado para obtener las medallas ganadas por un pais se migará para poder visualizar como sería integrar SQL a un proceso de Spark

# In[ ]:


resultadoDF.filter(resultadoDF.medalla != "NA") \
    .join(deportistaOlimpicoDF,deportistaOlimpicoDF.deportista_id == resultadoDF.deportista_id,"left") \
    .join(paisesDF,paisesDF.id == deportistaOlimpicoDF.equipo_id, "left") \
    .select("medalla", "equipo","sigla").sort( col("sigla").desc() ).show()


# El uso de DF como SQL, se usa registrando un DF como tabla temportal.
# 
# En el caso de realizar la conexión a una base de datos, este paso puede llegar a ser omitido. Ya que spark estará configurado para poder hacer las conexiones implicitamente

# In[ ]:


resultadoDF.registerTempTable("resultado")
deportistaOlimpicoDF.registerTempTable("deportista")
paisesDF.registerTempTable("paises")


# El alias asignado, será la forma en la cual sqlContext conocerá el DF internamente, ahora podemos hacer operaciones de forma tradicional.

# In[ ]:


sqlContext.sql("SELECT * FROM deportista").show(5)


# In[ ]:


sqlContext.sql("""
                SELECT medalla, equipo, sigla FROM resultado r
                JOIN deportista d
                ON r.deportista_id = d.deportista_id
                JOIN paises p
                ON p.id = d.equipo_id
                WHERE medalla <> "NA"
                ORDER BY sigla DESC
                """).show()


# # Persistencia

# La persistencia de datos no ocurre por defecto en un DF o RDD de Spark, por lo cual debemos de indicar con el método 'cache', por otro lado, para poder verificar si esta almacenado o no, con el método 'is_cached' verificamos su estatus

# In[ ]:


medallistaXAnio.is_cached


# In[ ]:


medallistaXAnio.rdd.cache()


# Para poder verificar el tipo de almacenamiento asignado, debemos de conocer el valor de códigos que nos regresa getStorageLevel
# 
# Para esto, podemos verificar en la documentación de spark:
# https://spark.apache.org/docs/2.4.6/api/python/_modules/pyspark/storagelevel.html

# In[ ]:


medallistaXAnio.rdd.getStorageLevel()


# Para poder cambiar el tipo de persistencia debemos de primero retirarla y posterior a eso asignarle la que deseamos.
# 
# Con el método persist, asignaremos la persistencia que nosotros deseamos.

# In[ ]:


medallistaXAnio.rdd.unpersist()


# In[ ]:


medallistaXAnio.rdd.persist(StorageLevel.MEMORY_AND_DISK_2)


# In[ ]:


medallistaXAnio.rdd.getStorageLevel()


# In[ ]:


medallistaXAnio.rdd.getStorageLevel()


# Finalmente, podemos crear nuestros propios esquemas de persistencia según las reglas y restricciones de negocio que tengamos en el proyecto.

# In[ ]:


#def __init__(self, useDisk, useMemory, useOffHeap, deserialized, replication=1):
StorageLevel.MEMORY_AND_DISK_3 = StorageLevel(True,True,False,False,3)


# In[ ]:


medallistaXAnio.rdd.unpersist()
medallistaXAnio.rdd.persist(StorageLevel.MEMORY_AND_DISK_3)


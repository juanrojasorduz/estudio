#!/usr/bin/env python
# coding: utf-8

# # Pandas


##
import pandas as pd  ##importar libreria de pandas
import numpy as np ##importa libreria de numpy
##


##
psg_players = pd.Series(['Navas','Mbappe','Neymar','Messi'],
            index=[1,7,10,30]            
            )   ### definir una serie en python
print(psg_players) ## imprimir serie
##



##
dict = {1:'Navas',7:'Mbappe',10:'Neymar',30:'Messi'}  ##declaro un diccionario
print(pd.Series(dict))  ##imprimo diccionario
##




##
psg_players = pd.Series(['Navas','Mbappe','Neymar','Messi']) ## declaro una serie
print(psg_players) ## imprimo serie con indice por default
##



##
dict = { 'Jugador': ['Navas','Mbappe','Neymar','Messi'],
  'Altura': [183.0, 170.0, 170.0, 165.0],
  'Goles': [2, 200, 200, 200]    
} ## declaro diccionario con multiple dimension
df_players = pd.DataFrame(dict) ## convierto diccionario en dataframe
print(df_players) ## imprimo dataframe
print(df_players.columns) ## imprimo columnas del data frame
print(df_players.index) ## imprimo formato de indices del data frame
print(type(df_players)) ## imprimo tipo de estructura de datos declarada
##




print(df_players[0:2])
print(df_players[:1])
print(df_players[2:])




##
df_players = pd.DataFrame(dict,index=[1,7,10,20]) ## defino data frame con indice definido
print(df_players) ## imprimo data frame
##


# ## importando datos




##
df_books = pd.read_csv('archivos_python/bestsellers-with-categories.csv') ## importar archivo csv en formato data frame
print(df_books.head()) ## ver primeras columnas
print(df_books.columns) ## ver columnas
##





##
df_harry_potter = pd.read_json('archivos_python/hpcharactersdataraw.json') ## importar archivo json
print(df_harry_potter.head()) ## importar primeras filas
print(df_harry_potter.columns) ## mostrar las columnas del dataframe
##





##
print(df_books[0:4]) ## imprime los primeros 4 registros
##




##
print(df_books[['Name','Author']]) ## imprime todos los registros para las columnas name y autor
##




##
print(df_books.loc[0:4,['Name','Author']]) ## me trae los primeros 5 registros dado que empieza en 0 para las columnas name y author
##




print(df_books.loc[:,['Reviews']]*-1) ## me trae todos los reviews multiplicados por -1




print(df_books.loc[:,['Author']] == 'JJ Smith')




print(df_books.iloc[:])





print(df_books.iloc[:,0:3])




print(df_books.iloc[:2,2:])


# ## agregar o eliminar datos



df_books = df_books.drop('Genre',axis=1) ## elimino columna
print(df_books)




df_books = pd.read_csv('archivos_python/bestsellers-with-categories.csv') ## importar archivo csv en formato data frame
df_books = df_books.drop(0,axis=0).head(2)
print(df_books)




df_books = pd.read_csv('archivos_python/bestsellers-with-categories.csv') ## importar archivo csv en formato data frame
print(df_books.drop([0,1,2], axis=0)) ## elimina primeras 10 filas del data frame





df_books['nueva_columna'] = np.nan ## crea nueva columna con valores tipo nan
print(df_books.head())





data = np.arange(0, df_books.shape[0]) ## crear un array a partir de los indices del data frame
print(data)





print(df_books.shape[0]) ## muestra el numero de registros del data frame





df_books['Rango'] = data ## creo una nueva columna llamada rango a partir de los datos del data frame
print(df_books.head())  ## imprimo los primeros registros del data frame


# ## valores nulos




dict = {'Col1': [1,2,3,np.nan],
 'Col2': [4,np.nan,6,7],
 'Col3': ['a','b','c',None]}  ## declaro diccionario con algunos valores nulos
df = pd.DataFrame(dict) ## convierto diccionario en data frame
print(df) ##imprimo data frame





print(df.isnull()*1) ## llevar valores nulos a 1 y no nulos a 0





print(df.fillna('Missing')) ## completar valores nulos con missing





print(df.fillna(df.mean())) ## aplicar metodo de media para completar valores nulos





print(df.interpolate())  ## interpolar para completar valores nulos




print(df.dropna()) ## eliminar registros con valores nulos


# ## Filtrado por condiciones



df_books = pd.read_csv('archivos_python/bestsellers-with-categories.csv') ## importar archivo csv en formato data frame
print(df_books.head(2)) ## imprimir primeros dos registros del data frame





mayor_a_2016 = df_books['Year'] > 2016  ## verificar que registros cumplen la condicion con logica booleana
print(df_books[mayor_a_2016]) ## imprimir registros del data frame que cumplan la condicion





genrer_fiction = df_books['Genre'] == 'Fiction' ## defino una condicion 
print(df_books[genrer_fiction]) ## traigo registros del data frame que cumplan la condicion





print(df_books[mayor_a_2016&genrer_fiction]) ## traigo los registros del data frame que cumplan la condicion




print(df_books[~mayor_a_2016]) ## traigo los registros que no cumplan la condicion


# ## Funciones principales 




print(df_books.info())  ## me trae una descripcion general de las columnas del data frame





print(df_books.describe())  ## hacer una descripcion general estadistica de los campos numericos del data frame





print(df_books.head(2)) ## me trae las dos primeras columnas del data frame
print(df_books.tail(2)) ## me trae las dos ultimas columnas del data frame





print(df_books.memory_usage(deep=True)) ## me trae cuanto estoy usando en memoria en cada uno de los campos del df  





print(df_books['Author'].value_counts()) ## me trae el numero de registros por cada tipo de autor





df_books = df_books.append(df_books.iloc[0])  ## añadimos de nuevo el registro 0 para generar un duplicado
df_books = df_books.drop_duplicates() ## eliminamos los duplicados
print(df_books.tail(2))





print(df_books.sort_values('Year',ascending = False)) ## ordena los registros del df basado en una columna en orden descendiente


# ## Agrupamientos




print(df_books.groupby('Author').count().reset_index()) ## me trae las frecuencias por autor





print(df_books.groupby('Author').agg(['min','max'])) ## me trae los valores min y max para cada acolumna agrupada por autor





print(df_books.groupby('Author').agg({'Reviews':['min','max'], 'User Rating':'sum'}).reset_index()) ## agrupar por autor


# ## Combinando dataframes




df1 = pd.DataFrame({'A':['A0', 'A1', 'A2','A3'],
        'B':['B0', 'B1', 'B2','B3'],
    'C':['C0', 'C1', 'C2','C3'],
    'D':['D0', 'D1', 'D2','D3']})  ## declaramos el data frame 1


df2 = pd.DataFrame({'A':['A4', 'A5', 'A6','A7'],
    'B':['B4', 'B5', 'B6','B7'],
    'C':['C4', 'C5', 'C6','C7'],
    'D':['D4', 'D5', 'D6','D7']}) ## declaramos el data frame 2
print(df1) ## imprimimos data frame numero 1
print(df2) ## imprimimos data frame numero 2





print(pd.concat([df1,df2])) ## imprimimos la concatenacion de los dos data frames por columnas





print(pd.concat([df1,df2], ignore_index= True)) ## imprimimos la concatenación de los dos df resetiando el indice, axis 0 por default   





print(pd.concat([df1,df2],axis=1)) ## hace la concatenacion usando axis = 1,es decir basaado en columnas


# ## Merge




izq = pd.DataFrame({'key' : ['k0', 'k1', 'k2','k3'],
 'A' : ['A0', 'A1', 'A2','A3'],
'B': ['B0', 'B1', 'B2','B3']})  ## declaramos un data frame

der = pd.DataFrame({'key' : ['k0', 'k1', 'k2','k3'],
 'C' : ['C0', 'C1', 'C2','C3'],
'D': ['D0', 'D1', 'D2','D3']})  ## declaramos un data frame
print(izq) ## imprimimos el df de izq
print(der) ## imprimimos el df de der





print(izq.merge(der, on='key')) ## hacemos un merge de los dos data frames





izq = pd.DataFrame({'key' : ['k0', 'k1', 'k2','k3'],
 'A' : ['A0', 'A1', 'A2','A3'],
 'B': ['B0', 'B1', 'B2','B3']}) ## declaramos de nuevo el data frame izq modificado

der = pd.DataFrame({'key_2' : ['k0', 'k1', 'k2','k3'],
 'C' : ['C0', 'C1', 'C2','C3'],
 'D': ['D0', 'D1', 'D2','D3']}) ## declaramos de nuevo el data frame der modificado
print(izq) ## imprimimos el data frame de la derecha
print(der) ## imprimimos el data frame de la izquierda





print(izq.merge(der, left_on = 'key', right_on='key_2')) ## imprimimos el merge con llaves de valor diferentes





izq = pd.DataFrame({'key' : ['k0', 'k1', 'k2','k3'],
 'A' : ['A0', 'A1', 'A2','A3'],
'B': ['B0', 'B1', 'B2','B3']})  ## declaramos el data frame de la izquierda

der = pd.DataFrame({'key_2' : ['k0', 'k1', 'k2',np.nan],
 'C' : ['C0', 'C1', 'C2','C3'],
'D': ['D0', 'D1', 'D2','D3']})  ## declaramos el data frame de la derecha
print(izq) ## imprimimos el data frame de la izquierda
print(der) ## imprimimos el data frame de la derecha





print(izq.merge(der, left_on='key',right_on='key_2',how='left')) ## aplicamos un left join en lugar del inner que viene por default


# ## JOIN




izq = pd.DataFrame({'A': ['A0','A1','A2'],
  'B':['B0','B1','B2']},
  index=['k0','k1','k2']) ## declaramos el df izq,basado en una columna indice

der =pd.DataFrame({'C': ['C0','C1','C2'],
  'D':['D0','D1','D2']},
  index=['k0','k2','k3']) ## declaramos el df der,basado en una columna indice
print(izq) ## imprimimos el df izq
print(der) ## imprimimos el df der





print(izq.join(der)) ## aplicamos un inner join entre los dos data frames





print(izq.join(der, how = 'outer')) ## aplicamos un full outer join entre los dos df


# ## PIVOT




df_books = pd.read_csv('archivos_python/bestsellers-with-categories.csv') ## importar archivo csv en formato data frame
print(df_books.pivot_table(index='Author',columns='Genre',values='User Rating')) ## me pivotea la tabla, es un estilo tabla dinamica





print(df_books.pivot_table(index='Genre',columns='Year', values='User Rating',aggfunc='sum')) ## manera de pivotear el df





print(df_books[['Name','Genre']].head(5).melt()) ## pasar columnas a filas usando el metodo melt





print(df_books.melt(id_vars='Year',value_vars='Genre')) ## cada resultado de las dos columnas pasa a una fila de este modo a tipo llave:valor.


# ## apply




def two_times(value):
    return value * 2  ## defino una funcion para multiplicar un valor x 2





print(df_books['User Rating'].head().apply(two_times))  ## aplicamos funcion sobre la columna rating





df_books['User Rating2'] = df_books['User Rating'].apply(two_times)  ## creo un nuevo campo sobre el df basado en una funcion sobre otro campo
print(df_books.head()) ## imprimo primeros 5 registros del df





df_books['User Rating2'] =df_books['User Rating'].apply(lambda x: x* 3)  ## sobreescribo la accion anterior pero usando una lambda
print(df_books.head())  ## imprimo el df





print(df_books.apply(lambda x: x['User Rating'] * 2 if x['Genre'] == 'Fiction' else x['User Rating'], axis = 1)) ## imprimo una funcion acplicada usando mas campos dentro de la funcion 








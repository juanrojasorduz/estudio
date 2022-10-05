### Libreria Numpy


##
import numpy as np  ## importar libreria
##


##
lista = [1,2,3,4,5,6,7,8,9]   ## creo una lista
print(lista) ## imprimo la lista
##


##
array = np.array(lista) ## creo un array basado en la lista
print(array) ## imprimo el array
print(type(array)) ## determino el tipo de estructura de datos
##


##
matriz = [[1,2,3],[4,5,6],[7,8,9]] ### declaro una matriz basado en el metodo de lista
print(matriz)  ## imprimo la matriz creada
print(type(matriz)) ## imprimo el tipo de matriz
matriz_array = np.array(matriz) ## convierto la matriz a un array de numpy
print(matriz_array) ## imprimo la matriz en modo de arreglo
print(type(matriz_array)) ## imprimo el tipo de matriz
##


##
print(array[0]+array[5]) ## imprimo una operacion sobre dos elementos del array creado
print(matriz_array[0,2]) ## traigo un elemento de la matriz
print(array[0:3]) ## traer elementos del array
print(array[::-1]) ## traer elementos del array
print(matriz_array[1:,0:2]) ## traer elementos de la matriz
##


# ## tipos de datos


##
print(array) ## imprimo el array
print(array.dtype) ## imprimo el tipo de dato en el array
##


##
array_2 = np.array([1,2,3,4], dtype='float32') ## declaro un array con tipo float 32
print(array_2) ##imprimo el array creado
print(array_2.dtype) ## imprimo el tipo de array
##


##
array_3 = np.array([1,2,3,4]) ## creo un array de 1 dimension
print(array_3)  ## imprimo el array
print(array_3.dtype) ## imprimo el tipo de dato del array
array_3 = array_3.astype(np.float64) ## convierto array a uno con tipo float64
print(array_3) ## imprimo el array convertido
print(array_3.dtype) ## imprimo el tipo de array
##


## 
array = np.array([0,1,2,3,4,5])  ## declaro un array
print(array) ## imprimo array
print(array.dtype) ## imprimo tipo de array
array = array.astype(np.bool_) ## convierto array a tipo booleano
print(array) ## imprimo array convertido
print(array.dtype) ## imprimo tipo de array convertido
## 


##
array = np.array([0,1,2,3,4,5]) ##declaro array
print(array) ## imprimo array
print(array.dtype) ## imprimo tipo de array convertido
array = array.astype(np.string_) ## convierto array a un tipo string
print(array) ## imprimo array convertido
print(array.dtype) ## imprimo tipo de array convertido
##


# ## dimensiones


##
scalar = np.array(42)  ## declaro array en forma de scalar con dimension de 0
print(scalar)  ## imprimo scalar
print(scalar.ndim) ## imprimo numero de dimensiones del scalar
##


##
vector = np.array([1,2,3]) ## declaro array en forma de vector de dimension 1
print(vector) ## imprimo vector creado
print(vector.ndim) ## imprimo numero de dimensiones del vector
##


##
matriz = np.array([[1,2,3],[4,5,6]]) ## declaro array en forma de matriz de dimension 2
print(matriz) ## imprimo matriz creada
print(matriz.ndim) ## imprimo numero de dimensiones de la matriz
##


##
tensor = np.array([[[1,2,3],[4,5,6]],[[1,2,3],[4,5,6]]])  ## declaro array en forma de tensor con dimension 3
print(tensor) ## imprimo tensor
print(tensor.ndim) ## imprimo numero de dimensiones del tensor
##


# ## agregar o eliminar dimensiones


##
vector = np.array([1,2,3],ndmin=10) ## declaro un array con dimension de 10
print(vector) ## imprimo resultado
print(vector.ndim) ## imprimo el numero de dimensiones
##


##
expand = np.expand_dims(np.array([1,2,3]),axis=0)  ## declaro array con expansion de una dimension
print(expand) ## imprimo array
print(expand.ndim) ## imprimo numero de dimensiones
##


##
print(vector,vector.ndim)  ## imprimo vector de dimension 10
vector_2 = np.squeeze(vector) ## ejecuto una compresion de dimensiones
print(vector_2,vector_2.ndim) ## imprimo vector comprimido
##


# ## creando arrays


##
print(list(range(0,10)))  ## creo una lista de numeros de 0 hasta 9
print(np.arange(0,10)) ## creo un array de numeros de 0 hasta 9
##


##
array = np.arange(0,20,2) ## crear arreglo con valores en salto de 2
print(array)
##


##
zeros = np.zeros(3) ## crear array de zeros
print(zeros)  ## imprimo array de zeros
print(zeros.ndim) ## imprimo numero de dimensiones
zeros = np.zeros((10,10)) ## crear array de zeros 10x10
print(zeros) ## imprimo array de zeros
print(zeros.ndim) ##imprimo numero de dimensiones
##


##
ones = np.ones(3) ## crear array de ones
print(ones)  ## imprimo array de ones
print(ones.ndim) ## imprimo numero de dimensiones
ones = np.ones((10,10)) ## crear array de ones 10x10
print(ones) ## imprimo array de ones
print(ones.ndim) ##imprimo numero de dimensiones
##


##
array = np.linspace(0,10,10) ## crear un array de 10 elementos con valores distribuidos
print(array) ## imprime array
##


##
array = np.eye(4) # declaro matriz con valores de 1 en diagonal
print(array) ## imprimo array
##


##
print(np.random.rand()) ## genera un escalar aleatorio entre 0 y 1
print(np.random.rand(4)) ## genera un vector aleatorio compuesto de 4 numeros
print(np.random.rand(4,4)) ## genera un array 4x4 compuesto por numeros entre 0 y 1
print(np.random.randint(1,15)) ## genera un numero aleatorio entre 1 y 15
print(np.random.randint(1,100,(10,10))) ## genera una matriz aleatoria 10x10 con numeros entre 1 y 100
##


# ## Shape y Reshape


##
array = np.random.randint(1,10,(3,2))  ## creando array aleatorio
print(array) ## imprimiendo array
print(array.shape) ## imprimiendo el shape del array
array = array.reshape(1,6) ## modificando el shape del array
print(array) ## imprimiento array
print(array.shape) ## imprimiendo shape del array
array = array.reshape(2,3) ## modificando el shape del array
print(array) ## imprimiendo array
print(array.shape) ### imprimiendo el shape
##


##
array = np.random.randint(1,10,(3,2)) ## declaro array aleatorio
print(array) ## imprimento array
print(np.reshape(array,(1,6))) ## modificando shape del array a un shape (1,6)
print(np.reshape(array,(1,6),'C')) ## modificando shape del array a un shape (1,6) con el lenguaje C
print(np.reshape(array,(1,6),'F')) ## modificando shape del array a un shape (1,6) con el lenguaje F
##


# ## Funciones principales de python


##
array = np.random.randint(1,20,10) ## declaro array aleatorio
matriz = array.reshape(2,5) ## hago un reshape
print(matriz) ## imprimo el resultado
##


##
print(array)
print(matriz)
print(array.max())
print(matriz.max(0))
print(matriz.max(1))
print(matriz.max())
print(array.argmax())
print(matriz.argmax(0))
print(array.min())
print(matriz.min())
print(matriz.min(0))
print(matriz.min(1))
print(array.argmin())
print(matriz.argmin(0))
##


##
print(array) ## array
print(array.ptp()) ## diferencia entre los dos picos del array
print(matriz) ## matriz
print(matriz.ptp(0)) ## diferencia entre los dos picos del eje 0
##


##
array.sort() ## ordeno de menor a mayor
print(array) ## array 
print(np.percentile(array,50)) ## percentil 50 del array
##


##
print(np.median(array)) ## mediana del array
print(np.std(array)) ## desviacion estandar
print(np.var(array)) ## varianza
print(np.mean(array)) ## varianza
##


##
a = np.array([[1,2],[3,4]]) ## creamos array
b = np.array([4,6]) ## creamos arrey
b = np.expand_dims(b,axis=0) ## expandimos dimension de 1 a 2 para poder efecturar la concatenacion
c = np.concatenate((a,b),axis=0) ##concatenamos a y b
d = np.concatenate((a,b.T),axis=1) ##concatenamos a y b
print(a)
print(b)
print(c)
print(d)
##


# ## copy


## array = np.arange(0,11)
array_copy = array.copy()  ## uso comando para no alterar el array padre si efectuo cambios
array_copy[:] = 100 ## guardo en nuevo espacio en memoria
print(array)
print(array_copy)
##


# ## condiciones


## 
array = np.linspace(1,10,10, dtype= 'int8') ## declaro un arreglo
condicion = array > 5 ## declaro condicion
print(array) ## imprimo arreglo
print(condicion) ## imprimo condicion
print(array[condicion]) ## imprimo arreglo con condicion aplicada
print(array[(array>5)&(array<9)]) ## imprimo arreglo con dos condicones
##


## 
array = np.linspace(1,10,10, dtype= 'int8') ## declaro un arreglo
print(array) ## imprimo arreglo
array[array>5] = 99 ## aplico condicion al arreglo
print(array) ## imprimo arreglo con condicion aplicada
##


# ## operaciones


##
array = np.arange(0,10) ## creo un vector con valores de 0 a 10
array2 = array.copy() ## hago copia de vector
print(array) ## imprimo vector
print(array2 * 2) ## imprimo la multiplicacion del vector x 2
print(array2 + 2) ## imprimo la suma del vector con el numero 2
print(1/array2) ## divido 1 entre los valores del arreglo
print(array+array2) ## imprimo la suma de dos arreglos
##


##
matriz = array.reshape(2,5) ## creo matriz
matriz2 = matriz.copy() ## hago copia de matriz 1
print(matriz) ## imprimo matriz creada
print(matriz2) ## imprimo matriz 2 copiada
print(matriz+matriz2) ## efectuo suma entre dos matrices
print(matriz-matriz2) ## efectuo resta entre dos matrices
print(matriz*matriz2) ## efectuo multiplicacion entre dos matrices
print(np.matmul(matriz,matriz2.T)) ## efectuo producto punto entre dos matrices
##

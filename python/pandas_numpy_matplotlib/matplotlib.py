import matplotlib.pyplot as plt
import numpy as np


##### graficas sencillas:

x = np.linspace(0,5,11)  ## creo un array de 11 elementos con valores entre 0 y 5
y = x ** 2 ## guardo el cuadrado de los valores del array x

print(type(x)) ## imprimo el tipo de estructura de datos
print(x)  ## imprimo el array x
print(type(y)) ## imprimo el tipo de estructura de datos
print(y) ## imprimo el array y

## grafica lineal de x contra y
plt.plot(x,y)
plt.show()  

## grafica lineal de x contra y usando color morado
plt.plot(x,y, 'm')
plt.show() 

# grafica lineal de color amarillo, con diamantes y puntos consecutivos
plt.plot(x,y, 'yD:') 
plt.show()

## grafica de histograma de valores de y
plt.hist(y)  
plt.show()

## grafico de torta de valores de y
plt.pie(y)  
plt.show()

## grafico de dispersion de y contra x
plt.scatter(x,y) 
plt.show()

## grafico de caja de x
plt.boxplot(x)
plt.show()


#### subplots

## subplots con 1 fila, dos columnas
plt.subplot(1,2,1) ## subplot para grafica lineal - indice 1
plt.plot(x,y, 'r--')  

plt.subplot(1,2,2)  # subplot para grafica de torta - indice 2
plt.pie(y)
plt.show()


## subplot con 1 fila,2 columnas y en el indice 1 dos plots
plt.subplot(1,2,1)
plt.plot(x,y, 'r--') # Plot 1 - x contra y
plt.plot(y,x, 'b:') #Plot 2 - y contra x

plt.subplot(1,2,2)
plt.pie(y) ## subplot para grafica de torta - indice 2
plt.show()

## subplot con 2 filas,1 columna y en el indice 1 dos plots
plt.subplot(2,1,1) #Grafico 1
plt.plot(x,y,'r--') #Plot 1 - x contra y
plt.plot(y,x,'b:')  #Plot 2 - y contra x

plt.subplot(2,1,2) #Grafico 2
plt.pie(y)         #Plot 1  
plt.show()




##### metodo para graficar basado en objetos
fig = plt.figure()   ## creo el figure "lienzo"
axes = fig.add_axes([0.1,0.1,0.8,0.9]) ## creo el primer axes, configurando posicion,ejes y tamaño
axes2 = fig.add_axes([0.17,0.55,0.4,0.3]) ## creo el primer axes, configurando posicion,ejes y tamaño 
axes.plot(x,y, 'b') ## imprimo la grafica lineal de x contra y de color azul sobre el axes 1
axes2.plot(y,x, 'r:') ## imprimo la grafica lineal de y contra x de color rojo sobre el axes 2
axes2.set_facecolor('grey') ## genero fondo gris sobre el axes2 
plt.show()



## grafica orientada a objetos con subplots
x = np.linspace(1,6,11)  ## defino array de 11 elementos con valores entre 1 y 6
y = np.sin(x) ## defino array con operacion de seno sobre el array anterior
fig, ((ax1, ax2, ax3, ax4), (ax5, ax6, ax7, ax8)) = plt.subplots(nrows=2,ncols=4) ## defino el lienzo para la grafica usando 2 filas y 4 columnas
ax1.plot(x, np.sin(x), 'b') ## imprimo sobre la posicion [0,1] la grafica de seno
ax2.plot(y, np.cos(x), 'purple') ## imprimo sobre la posicion [0,2] la grafica de coseno
ax3.plot(x, np.tan(y), 'orange') ## imprimo sobre la posicion [0,3] la grafica de tangente
ax4.plot(y, np.cos(y)**2, 'black') ## imprimo sobre la posicion [0,4] la grafica de coseno al cuadrado
ax5.plot(x, np.exp(x), 'b', linestyle=":") ## imprimo sobre la posicion [1,1] la grafica de exponencial
ax6.plot(y, np.log(y), 'purple',linestyle="-.") ## imprimo sobre la posicion [1,2] la grafica de logaritmo
ax7.plot(x, np.sqrt(x), 'orange') ## imprimo sobre la posicion [1,3] la grafica de raiz cuadrada de x
ax8.plot(y, x/3+2, '^g') ## imprimo sobre la posicion [1,4] la grafica de x/3+2
fig.tight_layout() #mejorar la visualización de las figuras
plt.show()



## grafica orientada a objetos con compenentes adicionales como titulos, etiquetas etc
x = np.linspace(0,5,11) ## defino array de 11 elementos con valores entre 0 y 5
y = np.sin(x) ## ejecuto un seno sobre los valores de x


fig, axes = plt.subplots(1,2,figsize=(10,5)) ## defino el lienzo basado en 1 fila 2 columnas con tamaño (10,5)
axes[0].plot(x,y,label="$sin(x)$")  ## imprimo sobre el lienzo la grafica de x contra y y adiciono una etiqueta de guia sobre la grafica para un legend
axes[0].set_title('Relacion X - Y') ## adiciono titulo a la grafica de la posicion 1 del indice 0
axes[0].set_xlabel('X') ## adiciono una etiqueta al eje x de la grafica 1
axes[0].set_ylabel('Y') ## adiciono una etiqueta al eje y de la grafica 1
axes[0].legend() ## incluyo el legend previamente definido como "$sin(x)$"
axes[1].plot(y,x,'r',label="$sin(y)$") ## imprimo sobre el lienzo en la posicion 2 del indice 0 la grafica de y contra x ademas de definir un leyend
axes[1].set_title('Relacion Y - X') ## adiciono un titulo sobre la grafica
axes[1].set_xlabel('Y') ## adiciono una etiqueta sobre el eje y
axes[1].set_ylabel('X') ## adiciono una etiqueta sobre el eje x 
axes[1].legend(loc = 'lower left') ## incluyo el leyend previamente definido
plt.show() ## muestro la grafica con todas las caracteristicas


plt.plot(x,y,label='sin(x)') ## hago un plot sencillo de x contra y usando un label de legend
plt.title('Grafica de x contra y') ## adiciono un titulo
plt.xlabel('x') ## adiciono una etiqueta al eje x
plt.ylabel('y') ## adiciono una etiqueta al eje y
plt.legend() ## adiciono el leyend previamente definido
plt.show() ## muestro la grafica con todos sus componentes



### Grafica con estilos nro 1
x = np.linspace(0,5,11)
print(plt.style.available) ## imprimo diferentes estilos predefinidos
plt.style.use('dark_background') ## selecciono un estilo a usar
fig, ax = plt.subplots(figsize=(8,8)) ## defino el lienzo
ax.plot(x,x+1,'r--') ## efectuo una grafica sobre el axes
ax.plot(x,x+2,'b-') ## efectuo una grafica sobre el axes
ax.plot(x,x+3,'y.-') ## efectuo una grafica sobre el axes
ax.plot(x,x+4,'go:') ## efectuo una grafica sobre el axes
plt.show() ## imprimo la grafica con todos los compenentes predefinidos


### Grafica con estilos nro 2
x = np.linspace(0,5,11)
print(plt.style.available) ## imprimo diferentes estilos predefinidos
plt.style.use('dark_background') ## selecciono un estilo a usar
fig, ax = plt.subplots(figsize=(8,8)) ## defino el lienzo
ax.plot(x,x+1,color='green',alpha=0.8,linewidth=5,linestyle='-',marker='o',markersize=10,markerfacecolor='#CCFFCC') ## efectuo una grafica sobre el axes
ax.plot(x,x+2,color='blue',linewidth=8,linestyle='--',marker='8') ## efectuo una grafica sobre el axes
ax.plot(x,x+3,color='#66FF66',linewidth=3,linestyle='dashed',marker='v') ## efectuo una grafica sobre el axes
ax.plot(x,x+4,color='#CCFFCC',linewidth=2,linestyle=':',marker='P') ## efectuo una grafica sobre el axes
plt.show() ## imprimo la grafica con todos los compenentes predefinidos


## Grafica de barras 
country = ['INDIA','JAPON','MEXICO','COLOMBIA','GERMANY']
population = [1000,800,900,1000,300]

plt.bar(country,population,width=0.5,color=['red','blue'])
plt.xticks(np.arange(5),('India','Japon','Mexico','Colombia','Alemania'),rotation=45)
plt.show()

plt.barh(country,population)
plt.show()



## Graficas de histogramas
data = np.random.randint(1,50,100) ## creo un array con 100 datos con valores aleatorios entre 1 y 50
plt.style.use('classic')
plt.hist(data,bins=10,histtype='bar')
plt.show()

plt.hist(data,bins=10,histtype='step')
plt.show()


## Graficas de box plot
data = np.random.randint(1,50,100) ## creo un array con 100 datos con valores aleatorios entre 1 y 50
data = np.append(data,200)
plt.boxplot(data,vert=False,patch_artist=True,notch=True,showfliers=True) ## puedo mostrar los valores atipicos con showfliers
plt.show()


## Graficas de scatter
N = 50
x = np.random.rand(N)
y = np.random.rand(N)
area = (30 * np.random.rand(N)) ** 2
colors = np.random.rand(N)

plt.scatter(x,y,s=area,c=colors,marker='o',alpha=0.5)
plt.show()



#!/usr/bin/env python
# coding: utf-8


import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import seaborn as sns


## grafica de barras
sns.barplot(x=['A','B','C'],y=[1,3,2])
plt.show()


## grafica de barras con estilos y paletas
sns.set(style='darkgrid',palette='dark',font='Verdana',font_scale=1)  ## para setear un estilo y paletas
sns.barplot(x=['A','B','C'],y=[1,3,2])
plt.show()



## importando set de datos de tips
tips = sns.load_dataset('tips')
print(tips)


## grafico de distribucion tipo histograma
sns.displot(data=tips, x='total_bill')
plt.show()



## grafico tipo scatter
sns.displot(data=tips, x='total_bill',y='tip')
plt.show()


## grafico tipo scatter con diferenciacion de variable sexo
sns.displot(data=tips, x='total_bill',y='tip',hue='sex')
plt.show()


## grafico tipo histograma con diferenciacion de variable sexo
sns.displot(data=tips, x='total_bill',hue='sex')
plt.show()


## grafico de densidad diferenciando por sexo
sns.displot(data=tips, x='total_bill',hue='sex',kind='kde',legend=True,alpha=0.25)
plt.show()


## grafico de histograma diferenciando por sexo
sns.histplot(data=tips,x='tip',bins=15,cumulative=False,hue='sex',stat='count',multiple='dodge')
plt.show()


## grafico de densidad diferenciando por sexo
sns.kdeplot(data=tips,x='tip',hue='sex')
plt.show()


## grafico de densidad diferenciando por sexo
sns.kdeplot(data=tips,x='tip',hue='sex',cumulative=False,fill=True,bw_adjust=1)
plt.show()


## grafico de fracuencia de propinas por sexo
sns.ecdfplot(data=tips,x='tip',hue='sex',stat='count')
plt.show()


## grafico de densidad diferenciando por sexo
sns.displot(data=tips,x='tip',hue='sex',kind='kde',multiple='stack')
plt.show()


## grafico de barras diferenciando por sexo entre el numero de dias
sns.countplot(data=tips,x='day',hue='sex')
plt.show()


### grafico de dispersion vertical para todos los dias segun el sexo
plt.figure(figsize=(6,6))
sns.stripplot(data=tips,x='day',y='total_bill',hue='sex',dodge=True)
plt.show()


### grafico de dispersion vertical para todos los dias segun el sexo
plt.figure(figsize=(6,6))
sns.swarmplot(data=tips,x='day',y='total_bill',hue='sex',dodge=True)
plt.show()


### grafico de caja para todos los dias segun el sexo
plt.figure(figsize=(6,6))
sns.boxplot(data=tips,x='day',y='total_bill',hue='sex',dodge=True)
plt.show()


### grafico de caja vertical para todos los dias segun el sexo
plt.figure(figsize=(6,6))
sns.boxplot(data=tips,x='day',y='total_bill',hue='sex',dodge=True)
sns.swarmplot(data=tips,x='day',y='total_bill',hue='sex',dodge=True,marker='<')
plt.show()


### grafico de caja tipo violin vertical para todos los dias segun el sexo
plt.figure(figsize=(6,6))
sns.violinplot(data=tips,x='day',y='total_bill',hue='sex',dodge=True,palette='pastel')
plt.show()


### grafico de caja vertical para todos los dias segun el sexo
plt.figure(figsize=(6,6))
sns.catplot(data=tips,x='day',y='total_bill',hue='sex',dodge=True,kind='box')
plt.show()


### grafico de caja vertical para todos los dias segun el sexo y hora de la comida
plt.figure(figsize=(6,6))
sns.catplot(data=tips,x='day',y='total_bill',hue='sex',dodge=True,kind='box',col='time')
plt.show()


### grafico de dispersion vertical para todos los dias segun la hora de la comida
sns.scatterplot(data=tips,x='total_bill',y='tip',hue='day',style='time')
plt.show()


### grafico de dispersion vertical para todos los dias segun la hora de la comida
sns.scatterplot(data=tips,x='total_bill',y='tip',hue='day',style='time',size='size')
plt.legend(loc='center',bbox_to_anchor=(1.12,0.5))
plt.show()


### grafico de dispersion vertical para todos los dias segun el dia y la hora de la comida
plt.figure(figsize=(8,8))
markers = {"Lunch":'D' ,"Dinner":'s'}
sns.scatterplot(data=tips,x='total_bill',y='tip',hue='day',style='time',size='size',markers=markers)
plt.legend(loc='center',bbox_to_anchor=(1.12,0.5))
plt.show()


### grafico de dispersion vertical para todos los dias segun el sexo y usando lineas
sns.lineplot(data=tips,x='total_bill',y='tip',hue='day',style='time',size='size')
plt.show()


### grafico de dispersion para todos los dias segun el sexo y hora de la comida
sns.relplot(data=tips,x='total_bill',y='tip',hue='day',style='time',size='size',col='time')
plt.show()


### grafico compuesto de graficas anexas de orientacion de histograma
sns.jointplot(data=tips, x='total_bill',y='tip',hue='sex',kind='hist',marginal_ticks=True,marginal_kws=dict(bins=25,fill=False,multiple='dodge'))
plt.show()


### multigrafico de relaciones entre variables
sns.pairplot(data=tips)
plt.show()


##multigrafico de relaciones entre variables
sns.pairplot(data=tips,hue='sex',palette='coolwarm',corner=True)
plt.show()


print(tips.corr()) ## correlaciones entre variables numericas


## grafico de correlaciones entre variables usando escalas
sns.heatmap(tips.corr())
plt.show()


## grafico de correlaciones usando escalas
sns.heatmap(tips.corr(),annot=True,cmap='coolwarm',linewidths=5,linecolor='black',vmin=0.5,vmax=1,cbar=True)
plt.show()


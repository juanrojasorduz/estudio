# -*- coding: utf-8 -*-
"""
Created on Sun May 23 17:33:17 2021

@author: Usuario
"""

while True:
    try:
        tmt = float(input("Ingrese el valor de la temperatura: "))
    except ValueError:
        print(" \nERROR. Recuerda que debes ingresar un numero tipo float o int ")
        continue
    if isinstance(tmt,(float,int))==True:
        tmt
        break   
   
while True:
    umi = input("Ingrese la unidad de temperatura inicial entre las siguientes medidas: 'F','C','K','RA','RE' : ")
    lista_unidades = ['F','C','K','RA','RE']
    if umi in lista_unidades:
       break
    else:
        print(" \nERROR. Recuerda que sólo puedes ingresar una unidad entre 'F','C','K','RA','RE' ")
 
while True:
    umf = input("Ingrese la unidad de temperatura final entre las siguientes medidas: 'F','C','K','RA','RE' : ")
    lista_unidades = ['F','C','K','RA','RE']
    if umf in lista_unidades:
       break
    else:
        print(" \nERROR. Recuerda que sólo puedes ingresar una unidad entre 'F','C','K','RA','RE' ")
        
  
def temperatura(tmt,umi,umf): 
    if umi=='F' and umf=='C':     
        print(str(tmt)+' '+str(umi)+' son: '+str(round(((5*(tmt-32))/9),3))+' '+str(umf))
    elif umi=='C' and umf=='F': 
        print(str(tmt)+' '+str(umi)+' son: '+str(round((((9*tmt)/5)+32),3))+' '+str(umf))
    elif umi=='K' and umf=='C': 
        print(str(tmt)+' '+str(umi)+' son: '+str(round((tmt-273.15),3))+' '+str(umf))
    elif umi=='C' and umf=='K': 
        print(str(tmt)+' '+str(umi)+' son: '+str(round((tmt+273.15),3))+' '+str(umf))
    elif umi=='K' and umf=='F': 
        print(str(tmt)+' '+str(umi)+' son: '+str(round((((9*(tmt-273.15))/5)+32),3))+' '+str(umf))
    elif umi=='F' and umf=='K': 
        print(str(tmt)+' '+str(umi)+' son: '+str(round((((5*(tmt-32))/9)+273.15),3))+' '+str(umf))
    elif umi=='RA' and umf=='F': 
        print(str(tmt)+' '+str(umi)+' son: '+str(round((tmt-459.67),3))+' '+str(umf))
    elif umi=='F' and umf=='RA': 
        print(str(tmt)+' '+str(umi)+' son: '+str(round((tmt+459.67),3))+' '+str(umf))
    elif umi=='RE' and umf=='C': 
        print(str(tmt)+' '+str(umi)+' son: '+str(round((5*tmt/4),3))+' '+str(umf))
    elif umi=='RA' and umf=='K': 
        print(str(tmt)+' '+str(umi)+' son: '+str(round((((5*(tmt-491.67))/9)+273.15),3))+' '+str(umf))
    elif umi=='RA' and umf=='C': 
        print(str(tmt)+' '+str(umi)+' son: '+str(round(((5*(tmt-491.67))/9),3))+' '+str(umf))
    elif umi=='C' and umf=='RA': 
        print(str(tmt)+' '+str(umi)+' son: '+str(round((((9*tmt)/5)+491.67),3))+' '+str(umf))
    elif umi=='C' and umf=='RE': 
        print(str(tmt)+' '+str(umi)+' son: '+str(round((4*tmt/5),3))+' '+str(umf))
    elif umi=='K' and umf=='RA': 
        print(str(tmt)+' '+str(umi)+' son: '+str(round((((9*(tmt-273.15))/5)+491.67),3))+' '+str(umf))
    elif umi=='F' and umf=='RE': 
        print(str(tmt)+' '+str(umi)+' son: '+str(round((4*(tmt-32)/9),3))+' '+str(umf))
    elif umi=='RE' and umf=='F': 
        print(str(tmt)+' '+str(umi)+' son: '+str(round(((9*tmt/4)+32),3))+' '+str(umf))
    elif umi==umf:
        print(str(tmt)+' '+str(umi)+' son: '+str(tmt)+' '+str(umf))
        
print('Teniendo en cuenta los parámetros ingresados:')
temperatura(tmt,umi,umf)
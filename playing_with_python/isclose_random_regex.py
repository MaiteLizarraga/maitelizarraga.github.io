# -*- coding: utf-8 -*-
"""
Created on Wed Apr 10 18:36:33 2024

@author: maite
"""

# ISCLOSE() -------------------------------------------------------------------

valores = [3,9,10,21,17,14,34,67,98,13]

# import math
import math

# 15 más menos 5
for valor in valores:
    resultado = math.isclose(valor, 15, abs_tol=5)
    print(valor, resultado)

# 20% de 15
for valor in valores:
    resultado = math.isclose(valor, 15, rel_tol=0.2)
    print(valor, resultado)

# RANDOM ----------------------------------------------------------------------

# Encontrad qué función puede ser utilizada para mezclar los elementos de una lista,
# es decir, cambiar su orden aleatoriamente. 

# Python Random shuffle() Method

import random

mylist = [1, 2, 3]
random.shuffle(mylist)
print(mylist)

import random
var = random.seed(253674)
print(var)

# Buscad una función de la librería random que devuelva un número entero aleatorio
# dentro de una secuencia determinada por un incremento. Es decir, para una secuencia
# de valores entre 0 y 100 dicha función solo podrá devolver
# los números [0, 10, 20, 30, 40, 50, 60, 70, 80, 90].

import random

random.randrange(0, 100, 10)

# Encontrad una función que tome elementos aleatorios de una lista sin reemplazo,
# es decir, sin escoger más de una vez el mismo elemento. Encontrad también aquella
# que lo hace con reemplazo.

import random

lista = [1,2,3,4]

# SIN REEMPLAZO (los números no se repiten)
random.sample(lista, 4)

# CON REEMPLAZO (los números sí se repiten)
random.choice(lista)

# EXPRESIONES REGULARES (REGEX) -----------------------------------------------

# Construid un patrón capaz de reemplazar todas las letras 'a' por un '4': 'atleta cacahuete a '

import re

patron = r'a'
string = 'atleta cacahuete a '
re.sub(patron, '4', string)

# Crea un patrón capaz de encontrar todos los números de un string seguidos de una 'a'. '32 numero32 32atleta' 

import re

patron = r'(\d)+a'
string = '32 numero32 32atleta'
# re.sub(patron, '4', string)
a = re.search(patron, string)
print(a.start())

# Construid un patrón capaz de splitear un string por sus ',' y '.' 

import re

patron = r'[,.]'
string = 'cuándo, digo cuándo, pero no. Si cuando, digo cuándo, o cuando no, es cuándo.'
re.split(patron, string)

# Crea un patrón capaz de reemplazar palabras que contienen solo letras del string: "123 a2bc 456 LETRAS"

import re

patron = r'\b[a-zA-Z]+\b'
string = "123 a2bc 456 LETRAS"
re.sub(patron, 'Z',string)

# Cread un patrón que sustituya por "FECHA" todas las fechas en formato DD/MM/AAAA de un string:
#     "Estamos en 01/02/2024".

import re

patron = r'../../....'
string = "Estamos en 01/02/2024"
re.sub(patron, 'FECHA', string)

import re

patron = r'\d{2}/\d{2}/\d{4}'
string = "Estamos en 01/02/2024"
re.sub(patron, 'FECHA', string)

# Cread un patrón capaz de encontrar palabras separadas por guiones: 'palabra1-palabra2 palabra3'.

import re

patron = r'\S'
string = 'palabra1-palabra2 palabra3'
y = re.search(patron, string)
print(y.group())

import re

patron = r'\b\w+-w+\b'
string = 'palabra1-palabra2 palabra3'
re.findall(patron, string)





# -*- coding: utf-8 -*-
"""
Created on Thu Apr 11 18:53:18 2024

@author: maite
"""

# DATETIME() ------------------------------------------------------------------

# Escribid una función que tome dos fechas y calcule el número de días transcurridos
# entre esas dos fechas.

import datetime

fecha1 = datetime.date(1991, 1, 18)
fecha2 = datetime.date(1985, 9, 14)

dias_transcurridos = fecha1 - fecha2
dias_transcurridos.days
# print(dias_transcurridos)

# Escribid una función que tome una fecha y que genere a partir de ésta un
# número n de fechas con un incremento de 7 días. Ayudaros de la clase timedelta.

import datetime

fecha1 = datetime.date(1991, 1, 18)
incremento = datetime.timedelta(days=7)
new_fecha = []
for n in range(10):
    mas = fecha1 + (incremento * n)
    new_fecha.append(mas)

hoy = datetime.date.today()
incremento = datetime.timedelta(days=5)
fechas_incrementadas = []
for n in range(10):
    fecha_final = hoy + incremento * n
    fechas_incrementadas.append(fecha_final)

# Buscad el especificador de formato que, a partir de una fecha os ayude a
# calcular el día de la semana (lunes, martes, miércoles… etc) correspondiente a dicha fecha.
# Ayudaros del método .strftime().

fechas_incrementadas = [i.strftime('%d/%m/%Y')for i in fechas_incrementadas]
hoy.strftime('%a')

# ISINSTANCE() ----------------------------------------------------------------

# The isinstance() function returns True if the specified object is of the
# specified type, otherwise False.

# TIME ------------------------------------------------------------------------

# Cuando los tiempos de ejecución son muy cortos la precisión de time.time()
# resulta insuficiente. Encontrad una función alternativa que os permita capturar
# estos tiempos dentro de esta librería.

    # Hay que usar la función timeit() para medir el tiempo con mayor precisión
    # Se puede usar también time.clock()

import time
start = time.perf_counter()
[n for n in range(100)]
finish = time.perf_counter()
print(finish-start)

#  Encontrad en la documentación la función que transforma los segundos desde
#  epoch en la hora actual.

    # Hay que usar la función datetime.fromtimestamp() para ello
    # (in order to convert the epoch time into DateTime)

time.localtime(time.time())

# OS, SYS y SHUTIL ------------------------------------------------------------

# Cread manualmente una carpeta (en el escritorio) y guardad los archivos generados
# en el bloque 2 (tsv, csv y pdb).

# Una vez tengáis dicha carpeta creada, utilizad la librería os para cread otra
# carpeta dentro de ésta y copiad solo los archivos .csv a esta segunda carpeta
# (esta vez desde Python). Pensad el programa de forma que, si hubiese 100 archivos,
# pudiese funcionar también en este escenario. 

import os
import shutil

# directorio_actual = os.getcwd()
# os.mkdir('C:/Users/maite/Desktop/andres')
# os.rename("C:/Users/maite/Desktop/andres/dummy.csv", "C:/Users/maite/Desktop/andres/inside_andres/dummy_new.csv")
# os.replace("C:/Users/maite/Desktop/andres/dummy.csv", "C:/Users/maite/Desktop/andres/inside_andres/dummy_new.csv")

path = "C:/Users/maite/Desktop/andres"
os.listdir(path)

# shutil.move("path/to/current/file.foo", "path/to/new/destination/for/file.foo")
shutil.move("C:/Users/maite/Desktop/andres/dummy.csv", "C:/Users/maite/Desktop/andres/inside_andres/dummy_moved.csv")

for element in path:
    if element.endswith('.csv'):
        shutil.move(f'pathorigen{element}', f'pathdestino{element}')
        
for n, element in enumerate(os.listdir(path_destino)):
    os.rename(path_destino + element, path_destino + f'{n}archivo.csv')

# Ayudándoos de la librería os, cambiad el nombre de los archivos csv de esta
# segunda carpeta. 
os.rename("C:/Users/maite/Desktop/andres/inside_andres/dummy_moved.csv", "C:/Users/maite/Desktop/andres/inside_andres/dummy_renamed.csv")

# Cread una carpeta en el escritorio y guardad un script .py que contenga 3-5 de
# las funciones que hemos creado. Añadid a sys.path el path de dicha carpeta e
# importad las funciones que habéis guardado en el script .py.

import sys

sys.path.append('C:/Users/maite/Desktop/andres/') 
sys.path

import opening















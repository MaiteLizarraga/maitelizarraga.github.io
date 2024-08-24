# -*- coding: utf-8 -*-
"""
Spyder Editor
"""

import pandas as pd
import math
import numpy as np

vector = [178, 82]

distancia = []

df = {
    'Altura': [175, 180, 161, 192],
    'Peso': [80, 75, 92, 95],
    'Diabetes': [True, False, True, False]
}

df = pd.DataFrame(df)

for fila in df.index:
    primer_factor = (df.iloc[fila,0] - vector[0])**2
    segundo_factor = (df.iloc[fila,1] - vector[1])**2
    raiz_cuadrada = math.sqrt(primer_factor + segundo_factor)
    distancia.append(raiz_cuadrada)

df['Distancia'] = distancia

df_sorted = df.sort_values(by='Distancia', ascending=0)
print(df_sorted)

def algoritmo_knn(k):
    resultado = df_sorted.iloc[:k,2].mode()
    return resultado
algoritmo_knn(3)

# OTRA FORMA DE HACERLO
df['distancia'] = np.sqrt((df['Altura'] - 178)**2 + (df['Peso'] - 82)**2)

## This is just the KNN algorithm broken down into python code.


# import ollama
# print(ollama.__version__)


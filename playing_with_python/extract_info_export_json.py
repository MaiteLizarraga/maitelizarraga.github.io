# -*- coding: utf-8 -*-
"""
Created on Mon Apr 15 19:32:07 2024

@author: maite
"""

import requests
uniprot_id = "P68871"
url = f"https://www.uniprot.org/uniprot/{uniprot_id}.json"
response = requests.get(url)
dict_from_json = response.json()

# Cread un diccionario nuevo y añadidle solo las claves de 'organism'.
# Aseguraos de que no añadís el diccionario de 'organism' directamente al nuevo diccionario.


new_dict = {}
new_dict.update(dict_from_json['organism'])
print(new_dict)

# Añadid el contenido de la clave 'extraAttributes' al nuevo diccionario.

dict_from_json['extraAttributes']
new_dict.update(dict_from_json['extraAttributes'])
print(new_dict)

# En la clave 'uniProtKBCrossReferences' se encuentran todas las bases de datos
# que contienen alguna entrada de la hemoglobina. Tomad solo los diccionarios
# que incluyan información del 'PDB', guardadlos en una lista y añadidlos al diccionario nuevo.

lineas = dict_from_json['uniProtKBCrossReferences']
# print(lineas)
lista_pdb = []

for linea in lineas:
    if linea['database'] == 'PDB':
        lista_pdb.append(linea)
    
new_dict['solo_pdb'] = lista_pdb
print(new_dict)

# Extraed información sobre el id del taxón
new_dict['taxonId']

# Extraed el string Chordata
new_dict['lineage'][2]

# Extraed el id
new_dict['solo_pdb'][0]['id']

import json
with open('C:/Users/andres.sanchez/Desktop/mi_primer_json.json', mode = 'w', encoding = 'utf-8') as json_file:
    json.dump(new_dict, json_file)

    
    


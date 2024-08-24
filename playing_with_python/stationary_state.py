# -*- coding: utf-8 -*-
"""
Created on Wed Jul  3 12:03:15 2024

@author: maite
"""

# Definir la matriz de transición
P <- matrix(c(0, 0.5, 0.5,
              0.25, 0.5, 0.25,
              0.5, 1/6, 1/3), byrow = TRUE, nrow = 3)

# Función para encontrar la distribución estacionaria
find_stationary_distribution <- function(P) {
  eig <- eigen(t(P))
  stationary_vector <- eig$vectors[, which.max(eig$values)]
  stationary_distribution <- stationary_vector / sum(stationary_vector)
  return(stationary_distribution)
}

# Calcular la distribución estacionaria
stationary_distribution <- find_stationary_distribution(P)

# Mostrar la distribución estacionaria
print(stationary_distribution)

# Ejercicio 1: representación gráfica de la Cadena de Markov.

# install.packages("shape")
# install.packages("heemod")
# install.packages("mvnfast")
# install.packages("diagram")

library('heemod')
library('diagram')
mat_dim <- define_transition(
  state_names = c('SOL', 'LLUVIA', 'NIEVE'),
  0, .5, .5, 
  .25, .5, .25,
  .5, p, 2*p);
plot(mat_dim)

# Como las filas deben sumar 1, y conociendo el Teorema de Probabilidad Total
# podemos sacar el valor de p resolviendo la siguiente ecuación de la tercera
# fila:
# 0.5 + p + 2p = 1 -> 0.5 + 3p = 1 -> p = 1/6
# Por tanto, 2p = 1/3

# Ejercicio 2: Generamos la cadena de markov, la matriz P, por filas, teniendo
# en cuenta el valor de alpha que se nos da en nuestro intento (en este caso es 2).

p = 1/6
alpha = 2
x = c(0,0.5,0.5,0.25,0.5,0.25,0.5,p,alpha*p)
labels <- c("S", "L", "N")
byRow <- TRUE
P <- matrix(data=x, byrow=byRow, nrow=3, dimnames=list(labels,labels))

# Comprobamos que la suma de las filas de P = 1.
suma_filas <- rowSums(P)
print(suma_filas)

# Calculamos también la suma de las columnas:
suma_columnas <- colSums(P)
print(suma_columnas)

# Ejercicio 3: ¿Cuál es la probabilidad de que el próximo domingo también haga
# sol?
# Para saber qué tiempo hará el domingo, vamos a calcular la probabilidad
# condicionadas de que haga sol el domingo dado que el lunes hizo sol. 
# Para ello utilizaremos nuestra matriz de transiciones P, que indica la 
# probabilidad de que la cadena pase de un estado a otro en una unidad de
# tiempo y Pi el vector de probabilidades de estado para nuestro estado inicial
# (soleado).

# Vector del día actual Pi0 - hace soleado:
Pi0 <- c(1,0,0) 

# Vector que queremos encontrar: dentro de 6 días - domingo: Pi6
  
# Sabemos por la teoría que podemos calcular los estados futuros a partir de la
# fórmula de Chapman-Kolmogorov, ya que, Vector de probabilidad del estado n futuro
# será el producto del vector de probabilidades del estado actual, nuestro Pi0, 
# y la matriz de transición P elevada al n futuro. Realizamos pues ese cálculo:

# install.packages("expm")
# install.packages("Matrix")
library(expm)
library(Matrix)
n <- 7-1
P6 <- P %^% 6

Pi6 <- Pi0 %*% P6
print(Pi6)

# Vemos que la probabilidad de que el domingo haga sol es del 27.15%, menor que
# el 33%, por lo tanto Dorothy NO se inscribirá en la carrera.

# Ejercicio 4:
# De la misma manera que en el ejercicio 3, calculamos la probabilidad condicio-
# nada de que el domingo haga sol dado que el lunes nevó. Para ello vamos a sacar
# el producto de la matriz P elevada a n para el vector de probabilidades del día
# actual.

# Vector del día actual Pi0nieve - hace nieve:
Pi0nieve <- c(0,0,1)

# Vector que queremos encontrar: dentro de 6 días - domingo: Pi6nieve

# Y realizamos el cálculo:
Pi6nieve <- Pi0nieve %*% P6
print(Pi6nieve)

# Vemos que la probabilidad de que el domingo haga sol habiendo nevado el lunes
# es del 26.77%, algo menor que en el caso anterior.

# Ejercicio 5: Si hoy hace sol, ¿cuál es la probabilidad de que hubiera llovido
# ayer? ¿Y cuál es la probabilidad de que hubiera nevado ayer?
# Teorema de Bayes y Teorema de la Probabilidad Total

# p(n=L|n+1=S) = p(n+1=S|n=L) * p(n=L) / p(n+1=S):

# LLUVIA:

# Probabilidad de que mañana haga sol sabiendo que hoy llueve:
prob_n_mas_1_igual_S_si_n_igual_L <- 0.25

# Probabilidad de que hoy esté lloviendo:
prob_n_igual_L <- 1

# Probabilidad total de que mañana haga sol:
prob_n_mas_1_igual_S <- suma_columnas[1]

prob_n_igual_L_si_n_mas_1_igual_S <- (prob_n_mas_1_igual_S_si_n_igual_L * prob_n_igual_L) / prob_n_mas_1_igual_S
print(prob_n_igual_L_si_n_mas_1_igual_S)

# NIEVE:

# Probabilidad de que mañana haga sol sabiendo que hoy nieva:
prob_n_mas_1_igual_S_si_n_igual_L <- 0.5

# Probabilidad de que hoy esté nevando:
prob_n_igual_L <- 1

# Probabilidad total de que mañana haga sol:
prob_n_mas_1_igual_S <- suma_columnas[1]

prob_n_igual_L_si_n_mas_1_igual_S <- (prob_n_mas_1_igual_S_si_n_igual_L * prob_n_igual_L) / prob_n_mas_1_igual_S
print(prob_n_igual_L_si_n_mas_1_igual_S)

# Ejercicio 6: esta cadena es regular o irregular?
# La cadena es regular ya que al elevar P a varios números enteros vemos que 
# todos los pij son positivos.


# Ejercicio 7: Calcular la distribución estacionaria.
# Estado estacionario = distribución límite de estados

# Comprobamos que P y Pt tienen vap = 1
V <- eigen(P)
V
vaps_V <- V$values
print(abs(vaps_V))

Vt <- eigen(t(P))
Vt
vaps_Vt <- Vt$values
print(abs(vaps_Vt))

veps <- V$vectors
steadystate_V <- abs(veps[,1])
(steadystate_V <- 100*steadystate_V/sum(steadystate_V))

veps <- Vt$vectors
steadystate_Vt <- abs(veps[,1])
(steadystate_Vt <- 100*steadystate_Vt/sum(steadystate_Vt))

# 1a condición: Todos los elementos de Pi son positivos y su sumatorio es Pi = 1
# Para V
print(sum(steadystate_V))

# Para Vt
print(sum(steadystate_Vt))

# 2a condición: Pi*P = Pi y Pi resultado tiene que ser > o = 0.
# Para V
print(steadystate_V)
print(steadystate_V %*% P)

# Para Vt
print(steadystate_Vt)
print(steadystate_Vt %*% P)





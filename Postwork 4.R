
#Importa los datos de soccer de las temporadas 2017/2018, 2018/2019 y 2019/2020 de la primera división de la liga española a R

datos <- lapply(dir(), read.csv) 

#selecciona únicamente las columnas Date, HomeTeam, AwayTeam, FTHG, FTAG y FTR
library(dplyr)
datos <- lapply(datos, select, Date, HomeTeam, AwayTeam, FTHG, FTAG, FTR)

head(datos[[1]])
str(datos[[2]])
head(datos[[3]])

#Hacer un solo dataframe 
Futbol_España <- do.call(rbind, datos)

#Corregir fechas
str(Futbol_España)
Futbol_España <- mutate(Futbol_España, Date=(as.Date(Date,"%d/%m/%Y")))

#Separar las columnas de goles en casa y goles de visita
Goles_casa <- Futbol_España$FTHG
Goles_visitante <- Futbol_España$FTAG

#Tablas de frecuencia relativa
Freq_goles_casa <- table(Goles_casa)

Freq_goles_visita <- table(Goles_visitante)

#probabilidad (marginal) de que el equipo que juega en casa anote x goles 
Prob_goles_casa <- prop.table(Freq_goles_casa)

#probabilidad (marginal) de que el equipo que juega como visitante anote y goles 
Prob_goles_visita <- prop.table(Freq_goles_visita)

#probabilidad (conjunta) de que el equipo que juega en casa anote x goles 
#y el equipo que juega como visitante anote y goles

Freq_conjunta <- table(Goles_casa, Goles_visitante)
Prob_conjunta <- prop.table(Freq_conjunta)


#### PW 4
#Obtén una tabla de cocientes al dividir estas probabilidades conjuntas por el producto de las probabilidades marginales correspondientes.

Prob_goles_casa <- as.data.frame(Prob_goles_casa)
Prob_conjunta<- as.data.frame(Prob_conjunta)
Prob_goles_visita <- as.data.frame(Prob_goles_visita)

#add <- data.frame(Goles_visitante= c(7,8),
                  #Freq = c(0,0))

#Prob_goles_visita <- rbind(Prob_goles_visita, add)

#Prob_goles_casa*Prob_goles_visita

r1 <- (Prob_goles_casa[1,2]* Prob_goles_visita[,2])
r2 <- (Prob_goles_casa[2,2]* Prob_goles_visita[,2])
r3 <- (Prob_goles_casa[3,2]* Prob_goles_visita[,2])
r4 <- (Prob_goles_casa[4,2]* Prob_goles_visita[,2])
r5 <- (Prob_goles_casa[5,2]* Prob_goles_visita[,2])
r6 <- (Prob_goles_casa[6,2]* Prob_goles_visita[,2])
r7 <- (Prob_goles_casa[7,2]* Prob_goles_visita[,2])
r8 <- (Prob_goles_casa[8,2]* Prob_goles_visita[,2])
r9 <- (Prob_goles_casa[9,2]* Prob_goles_visita[,2])

#Data frame de la multiplicacion de los marginales 
mult <- rbind(r1,r2,r3,r4,r5,r6,r7,r8,r9)

#tabla de cocientes

cocientes <- Prob_conjunta/mult

mean(cocientes)

#bootstrap 

medias= numeric(1000)

for(i in 1:1000)
  {
  muestra=sample(cocientes, replace=T)
  medias[i]=mean(muestra)
}

hist(medias)

qqnorm(medias)

sd(medias)



boot()
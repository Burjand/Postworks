#Importa los datos de soccer de las temporadas 2017/2018, 2018/2019 y 2019/2020 de la primera
#división de la liga española a R, los datos los puedes encontrar en el siguiente enlace:
#https://www.football-data.co.uk/spainm.php

data1718 <- read.csv("https://www.football-data.co.uk/mmz4281/1718/SP1.csv")
data1819 <- read.csv("https://www.football-data.co.uk/mmz4281/1819/SP1.csv")
data1920 <- read.csv("https://www.football-data.co.uk/mmz4281/1920/SP1.csv")

#Obten una mejor idea de las características de los data frames al usar las funciones: str, head,
#View y summary

str(data1718); head(data1718); view(data1718); summary(data1718) #17-18

str(data1819); head(data1819); view(data1819); summary(data1819) #18-19

str(data1920); head(data1920); view(data1920); summary(data1920) #19-20

#Con la función select del paquete dplyr selecciona únicamente las columnas Date, HomeTeam,
#AwayTeam, FTHG, FTAG y FTR; esto para cada uno de los data frames. (Hint: también puedes usar
#                                                                    lapply).

library(dplyr)

Sdata1718 <- select(data1718,Date,HomeTeam,AwayTeam,FTHG,FTAG,FTR)
Sdata1819 <- select(data1819,Date,HomeTeam,AwayTeam,FTHG,FTAG,FTR)
Sdata1920 <- select(data1920,Date,HomeTeam,AwayTeam,FTHG,FTAG,FTR)

#Asegúrate de que los elementos de las columnas correspondientes de los nuevos data frames sean
#del mismo tipo (Hint 1: usa as.Date y mutate para arreglar las fechas). Con ayuda de la función
#rbind forma un único data frame que contenga las seis columnas mencionadas en el punto 3 (Hint 2:
#                                                      la función do.call podría ser utilizada).

class(Sdata1718$Date)
Sdata1718 <- mutate(Sdata1718, Date=as.Date(Date,"%d/%m/%Y"))

class(Sdata1819$Date)
Sdata1819 <- mutate(Sdata1819, Date=as.Date(Date,"%d/%m/%Y"))

class(Sdata1920$Date)
Sdata1920 <- mutate(Sdata1920, Date=as.Date(Date,"%d/%m/%Y"))

BigBertha1720 <- rbind(Sdata1718,Sdata1819,Sdata1920)

str(BigBertha1720); head(BigBertha1720); summary(BigBertha1720)

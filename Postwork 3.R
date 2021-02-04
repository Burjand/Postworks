#Ahora graficaremos probabilidades (estimadas) marginales y conjuntas para el número de goles que
#anotan en un partido el equipo de casa o el equipo visitante.

data1718 <- read.csv("https://www.football-data.co.uk/mmz4281/1718/SP1.csv")
data1819 <- read.csv("https://www.football-data.co.uk/mmz4281/1819/SP1.csv")
data1920 <- read.csv("https://www.football-data.co.uk/mmz4281/1920/SP1.csv")
library(dplyr)
Sdata1718 <- select(data1718,Date,HomeTeam,AwayTeam,FTHG,FTAG,FTR)
Sdata1819 <- select(data1819,Date,HomeTeam,AwayTeam,FTHG,FTAG,FTR)
Sdata1920 <- select(data1920,Date,HomeTeam,AwayTeam,FTHG,FTAG,FTR)
Sdata1718 <- mutate(Sdata1718, Date=as.Date(Date,"%d/%m/%Y"))
Sdata1819 <- mutate(Sdata1819, Date=as.Date(Date,"%d/%m/%Y"))
Sdata1920 <- mutate(Sdata1920, Date=as.Date(Date,"%d/%m/%Y"))
BigBertha1720 <- rbind(Sdata1718,Sdata1819,Sdata1920)

#Con el último data frame obtenido en el postwork de la sesión 2, elabora tablas de frecuencias
#relativas para estimar las siguientes probabilidades:
#  La probabilidad (marginal) de que el equipo que juega en casa anote x goles (x=0,1,2,)

(home <- (table(BigBertha1720$FTHG)/dim(BigBertha1720)[1])*100)

#  La probabilidad (marginal) de que el equipo que juega como visitante anote y goles (y=0,1,2,)

(visitor <- (table(BigBertha1720$FTAG)/dim(BigBertha1720)[1])*100)

#  La probabilidad (conjunta) de que el equipo que juega en casa anote x goles y el equipo que juega
#  como visitante anote y goles (x=0,1,2,, y=0,1,2,)

(joint <- (table(BigBertha1720$FTHG, BigBertha1720$FTAG)/dim(BigBertha1720)[1])*100)

#Realiza lo siguiente:
#   Un gráfico de barras para las probabilidades marginales estimadas del número de goles que anota
#   el equipo de casa

plot(home, type="h", xlab="# Goles",ylab="ProbMarg")

#   Un gráfico de barras para las probabilidades marginales estimadas del número de goles que anota
#   el equipo visitante.

plot(visitor, type="h", xlab="# Goles",ylab="ProbMarg")

#   Un HeatMap para las probabilidades conjuntas estimadas de los números de goles que anotan el
#   equipo de casa y el equipo visitante en un partido.

library(ggplot2)

joint <- as.data.frame(joint)
joint<-rename(joint,GolesLocal = Var1, GolesVisitante = Var2,Probabilidad = Freq)

ggplot(joint,aes(x=GolesLocal, y=GolesVisitante, fill = Probabilidad),) +
              geom_tile(color = "white") +
              scale_fill_gradient2(low = "yellow", high = "lightblue",
                                     mid = "lightgreen", midpoint = .06, limit = c(0,.12),
                                     space = "Lab")


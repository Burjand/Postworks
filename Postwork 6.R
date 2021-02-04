#Importe el conjunto de datos match.data.csv a R y realice lo siguiente:

data <- read.csv("match.data.csv")
head(data)

#Agrega una nueva columna sumagoles que contenga la suma de goles por partido.

sumagoles <- list()

for (i in 1:length(data[,1])){
  sumagoles[i] <- (data$home.score[i] + data$away.score[i])
}

library(dplyr)

(data <- mutate(data, sumagoles))

#Obtén el promedio por mes de la suma de goles.

library(lubridate)

str(data)

data$date = ymd(data$date)

time_serie <- data %>% 
  group_by(Year=year(date), Month=month(date)) %>%
  summarise(sumagolesMean = mean(sumagoles))

#Crea la serie de tiempo del promedio por mes de la suma de goles hasta diciembre de 2019.

ts19 <- filter(time_serie, Year <= 2019)

ts19plot <- ts(ts19$sumagolesMean, start=c(2010, 8), end=c(2019, 12), frequency=12)

#Grafica la serie de tiempo.

plot(ts19plot, ylab = "Promedio Goles", xlab = "Tiempo", 
     main = "Promedio Goles Mensual", 
     sub = "2010-2019")


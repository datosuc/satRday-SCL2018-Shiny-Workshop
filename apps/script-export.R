if(!require(forecast)) install.packages("forecast")
if(!require(xts)) install.packages("xts")
if(!require(tradestatistic)) install.packages("tradestatistic")
if(!require(ggplot2)) install.packages("ggplot2")

library(forecast)
library(xts)
library(tradestatistics)
library(dplyr)
library(ggplot2)

pais <- "chn"

data <- ots_create_tidy_data(years = 1990:2018, reporters = pais, table = "yr")

valores <- data$export_value_usd
fechas <- as.Date(paste0(data$year, "0101"), format = "%Y%m%d",)

serie <- xts(valores, order.by = fechas)
prediccion <- forecast(serie, h = 5)

# IMPORTANTE: estas predicciones no *son las mas mejores* la idea  
# del ejercicio es imaginar que tenemos un proceso el 
# cual transformaremos en una app
autoplot(prediccion)


if(!require(forecast)) install.packages("forecast")
if(!require(xts)) install.packages("xts")
if(!require(tradestatistics)) install.packages("tradestatistics")
if(!require(ggplot2)) install.packages("ggplot2")

library(forecast)
library(xts)
library(tradestatistics)
library(ggplot2)


pais  <- "chn"  # seteo pais
rango <- 1990:2015
data <- ots_create_tidy_data(years = rango, reporters = pais , table = "yr")

str(data)

valores <- data$export_value_usd
fechas <- as.Date(paste0(data$year, "0101"), format = "%Y%m%d",)

serie <- xts(valores, order.by = fechas) # creo la serie de tiempo para la fucion forecast

prediccion <- forecast(serie, h = 5) # realizo automágicamente una predicción

prediccion

# IMPORTANTE: estas predicciones no *son las mas mejores* la idea  
# del ejercicio es imaginar que tenemos un proceso el 
# cual transformaremos en una app
autoplot(prediccion) + labs(title = pais, x = rango)

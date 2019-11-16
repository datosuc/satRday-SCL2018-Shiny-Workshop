if(!require(forecast)) install.packages("forecast")
if(!require(xts)) install.packages("xts")
if(!require(tradestatistic)) install.packages("tradestatistic")

library(forecast)
library(xts)
library(tradestatistics)
library(dplyr)


View(tradestatistics::ots_countries)

pais <- "chn"

yr <- ots_create_tidy_data(years = 1990:2018, reporters = pais, table = "yr")
yr

valores <- yr$export_value_usd
fechas <- as.Date(paste0(yr$year, "0101"), format = "%Y%m%d",)

serie <- xts(valores, order.by = fechas)

plot(serie)

prediccion <- forecast(serie, h = 5)

plot(prediccion)

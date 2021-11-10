if(!require(forecast)) install.packages("forecast")
if(!require(xts))      install.packages("xts")
if(!require(ggplot2))  install.packages("ggplot2")
if(!require(dplyr))    install.packages("dplyr")
if(!require(remotes))  install.packages("remotes")
if(!require(tradestatistics))  remotes::install_github("ropensci/tradestatistics")

library(forecast) # forecast autoplot
library(xts) # xts
library(tradestatistics) # ots_create_tidy_data 
library(ggplot2) # autoplot
library(dplyr) # glimpse %>% group_by summarise

pais <- "can"  # seteo pais, usa, can

data <- ots_create_tidy_data(years = 1990:2018, reporters = pais, table = "yrp")

glimpse(data)

data <- data %>% 
  group_by(year, reporter_iso) %>% 
  summarise(exportaciones = sum(trade_value_usd_exp))

valores <- data$exportaciones

fechas <- as.Date(paste0(data$year, "0101"), format = "%Y%m%d")

serie <- xts(valores, order.by = fechas) # creo la serie de tiempo para la fucion forecast

prediccion <- forecast(serie, h = 5) # realizo automágicamente una predicción

autoplot(prediccion)

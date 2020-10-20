if(!require(tidyverse)) install.packages("tidyverse")
if(!require(mindicador)) install.packages("mindicador")
if(!require(highcharter)) install.packages("highcharter")
if(!require(DT)) install.packages("DT")

library(tidyverse)
library(lubridate)
library(ggplot2)

d <- mindicador::mindicador_importar_datos("uf", anios = 2015:2020)

hchart(d, "line", hcaes(fecha, valor))

d %>% 
  group_by(year(fecha)) %>% 
  summarise(valor_mean = mean(valor)) %>% 
  DT::datatable()

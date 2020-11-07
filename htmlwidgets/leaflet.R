if(!require(rvest)) install.packages("rvest")
if(!require(leaflet)) install.packages("leaflet")
if(!require(tidyverse)) install.packages("tidyverse")

library(rvest)
library(tidyverse)
library(leaflet)

pag <- read_html("http://www.sismologia.cl/links/ultimos_sismos.html")
sismos <- html_table(pag)[[1]]

sismos

glimpse(sismos)

leaflet(sismos) %>% 
  addTiles() %>% 
  addMarkers(~Longitud, ~Latitud, popup = ~as.character(Magnitud),
             label = ~as.character(Magnitud))

sismos <- sismos %>% 
  mutate(
    Magnitud = as.numeric(str_remove(Magnitud, "Ml"))
  )

glimpse(sismos)

leaflet(sismos) %>%
  addTiles() %>%
  addCircles(lng = ~Longitud, lat = ~Latitud, weight = 0,
             radius = ~sqrt(Magnitud) * 30000, popup = ~Magnitud 
  )



# luego de `library(shiny)` podemos cargar otros paquetes
# a utilizar como también definir datos (por ejemplo)
library(shiny)
library(rvest)
library(DT)
library(leaflet)
library(dplyr)
library(stringr)

url <- "http://www.sismologia.cl/ultimos_sismos.html"

datos <- read_html(url) %>% 
  html_table() %>% 
  first() 

datos <- datos %>% 
  mutate(
    Magnitud = str_remove(Magnitud, "Ml|Mw"),
    Magnitud = as.numeric(Magnitud)
  )

ui <- fluidPage(
  sliderInput("rango", label = "Magnitud", min = 0, max = 10, value = c(3, 5)),
  
  fluidRow(
    column(6, DTOutput("tabla", height = "300px")),
    column(6, leafletOutput("mapa", height = "300px")),
  )
)

server <- function(input, output) {
  
  output$tabla <- renderDT({ 
    datos
  })
  
  output$mapa <- renderLeaflet({ 
    
    datos_filtrados <- datos %>% 
      filter(input$rango[1] < Magnitud) %>% 
      filter(Magnitud < input$rango[2])
    
    leaflet(datos_filtrados) %>%
      addTiles() %>%  
      addMarkers(
        lng = ~Longitud, 
        lat = ~Latitud,
        popup = ~as.character(Magnitud),
        label = ~as.character(`Referencia Geográfica`)
      )
  })
  
}

shinyApp(ui, server)

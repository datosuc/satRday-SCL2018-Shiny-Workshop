library(shiny)
library(tidyverse)
library(leaflet)
library(readxl)

# CTRL + SHIFT + F10
ruta <- "http://datos.gob.cl/dataset/f0fad229-d59a-4992-8c7a-489d1e9ff58c/resource/2d177f41-08f9-471a-af5c-bc949267f053/download/retail20200122oficio-47702013.xlsx"
archivo <- tempfile()
download.file(ruta, archivo, mode = "wb")
data <- readxl::read_excel(archivo, skip = 10)
data <- data %>% 
  mutate(
    LONGITUD = as.numeric(LONGITUD),
    LATITUD = as.numeric(LATITUD)
  )

lista_comunas <- unique(data$COMUNA)

ui <- fluidPage(
  # textInput("comuna", "Comuna a buscar:"),
  selectInput("comuna", "Comuna", choices = lista_comunas, width = "100%", selected = "LAMPA", multiple = TRUE),
  leafletOutput("mapa", height = "800px")
)

server <- function(input, output, session) {
  
  output$mapa <- renderLeaflet({
    # c de comuna
    c_de_comuna <- toupper(input$comuna)
    
    dcomuna <- data %>% 
      filter(COMUNA %in% c_de_comuna)
    
    leaflet(data = dcomuna) %>%
      addTiles() %>%
      addProviderTiles(providers$CartoDB.Positron) %>% 
      addMarkers(~LONGITUD, ~LATITUD, popup = ~as.character(DIRECCION), label = ~as.character(DIRECCION))
    
    
  })
  
}

shinyApp(ui, server)

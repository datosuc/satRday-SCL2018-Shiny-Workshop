library(shiny)
library(readxl)
library(dplyr)
library(janitor)
library(leaflet)
library(ggplot2)
library(shinythemes)
library(thematic)

# dos caminos:
# 1. descargar el archivo manualmente y
# 2. leer dede la ruta de internet :(
# url <- "https://datos.gob.cl/dataset/c2969d8a-df82-4a6c-a1f8-e5eba36af6cf/resource/cbd329c6-9fe6-4dc1-91e3-a99689fd0254/download/pcma_20211117_oficio-4770_2013.xlsx"
datos <- readxl::read_xlsx("pcma_20211117_oficio-4770_2013.xlsx", skip = 8)

datos <- datos %>% 
  mutate(
    LONGITUD = as.numeric(LONGITUD),
    LATITUD = as.numeric(LATITUD)
  )

datos <- clean_names(datos)

opciones_comuna  <- unique(datos$comuna)

ui <- fluidPage(
  theme = shinytheme("paper"),
    titlePanel("Puntos Bip!"),
    sidebarLayout(
        sidebarPanel(
          width = 2,
          selectizeInput("comuna",
                        label = "Seleccione comuna(s)",
                        choices = opciones_comuna,
                        multiple = TRUE,
                        selected = "MAIPU",
                        options = list(maxItems = 6))
        ),
        mainPanel(
          width = 10,
          
          fluidRow(
            column(6, leafletOutput("mapa")),
            column(6, plotOutput("plot"))
            )
        )
    )
)

server <- function(input, output) {
  
  # definir expresión reactiva
  data_comunas <- reactive({
    # Sys.sleep(5)
    dcomuna <- datos %>% 
      filter(comuna == input$comuna)
    dcomuna
  })
  
  output$mapa <- renderLeaflet({
    # 0. verificar si existe alguna opcion en input$comuna,
    #    si es nula mostrar un mapa en blanco centrado en santiago
    # 1. la logica de filtrar la tabla con la comuna seleccionada.
    # 2. con dicha data filtrada generar mapa.
    if(length(input$comuna) == 0) {
     
      mapa <- leaflet() %>% 
        addTiles() %>%  
        setView(lng = -70.66148, lat = -33.44764, zoom = 11)
      
    } else {
      
      dcomuna <- data_comunas()
      
      mapa <- leaflet(dcomuna) %>%
        addTiles() %>%  
        addMarkers(
          lng = ~longitud, 
          lat = ~latitud,
          popup = ~as.character(direccion),
          label = ~as.character(nombre_fantasia)
        )
    }
    
    mapa
    
  })
  
  output$plot <- renderPlot({
    
    dcomuna <- data_comunas()
    
    ggplot(dcomuna) +
      geom_bar(aes(comuna), fill = "gray80")
    
  })
  
}

thematic_shiny()

shinyApp(ui, server)

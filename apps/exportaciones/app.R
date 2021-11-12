library(shiny)
library(forecast) # forecast autoplot
library(xts) # xts
library(tradestatistics) # ots_create_tidy_data 
library(ggplot2) # autoplot
library(dplyr) # glimpse %>% group_by summarise
library(shinythemes)
tradestatistics::ots_countries

ui <- fluidPage(
  theme = shinytheme("superhero"),
  sidebarLayout(
    sidebarPanel(
      selectInput("pais", label = "Seleccionar país", choices = c("arg", "can", "usa"))
    ),
    mainPanel(
      plotOutput("grafico")
    )
  )
)


server <- function(input, output) {
  
  output$grafico <- renderPlot({
    
    pais <- input$pais  # seteo pais, usa, can
    
    data <- ots_create_tidy_data(years = 1990:2018, reporters = pais, table = "yrp")
    
    glimpse(data)
    
    data <- data %>% 
      group_by(year, reporter_iso) %>% 
      summarise(exportaciones = sum(trade_value_usd_exp))
    
    valores <- data$exportaciones
    
    fechas <- as.Date(paste0(data$year, "0101"), format = "%Y%m%d")
    
    serie <- xts(valores, order.by = fechas) # creo la serie de tiempo para la fucion forecast
    
    prediccion <- forecast(serie, h = 5) # realizo automágicamente una predicción
    
    nombrepais <- tradestatistics::ots_countries %>% 
      filter(country_iso == input$pais) %>% 
      pull(country_name_english)
    
    autoplot(prediccion) 
    
    
  })
}

shinyApp(ui = ui, server = server)

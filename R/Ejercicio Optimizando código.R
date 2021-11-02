library(shiny) # fluidPage titlePanel sidebarLayout sidebarPanel selectInput checkboxInput mainPanel shinyApp
library(forecast) # forecast %>%
library(xts) # xts
library(tradestatistics) # ots_create_tidy_data
library(dplyr) # %>% mutate
library(ggplot2) # ggplot geom_line aes geom_ribbon scale_y_continuous labs scale_y_log10
library(scales) # comma
library(plotly) # plotlyOutput renderPlotly ggplotly 
library(shinythemes) # shinytheme

formatear_monto <- function(monto){
  paste("$", comma(monto/1e6, accuracy = .01), "MM")
}

lista_paises <- setNames(ots_countries$country_iso, ots_countries$country_name_english)

ui <- fluidPage(
  theme = shinytheme("cyborg"), 
  titlePanel("Ahora si que sí"),
  sidebarLayout(
    sidebarPanel(
      selectInput("pais", "Seleccionar un país:", choices = lista_paises, selected = "chl"),
      checkboxInput("log", label = "Escala en log")    #<<
    ),
    mainPanel(
      plotlyOutput("grafico")
    )
  )
)

server <- function(input, output) {
  output$grafico <- renderPlotly({
    pais <- input$pais
    data <- ots_create_tidy_data(years = 1990:2018, reporters = pais, table = "yr")
    data <- mutate(data, year = as.numeric(year))
    valores <- data$trade_value_usd_exp
    fechas <- as.Date(paste0(data$year, "0101"), format = "%Y%m%d",)
    serie <- xts(valores, order.by = fechas) 
    prediccion <- forecast(serie, h = 5) 
    dfpred <- as.data.frame(prediccion)
    dfpred <- dfpred %>% mutate(anio = 2018 + 1:5)
    
    plt <- ggplot(data) +
      geom_line(aes(x = year, y = trade_value_usd_exp), group = 1) +
      geom_line(aes(x = anio, y = `Point Forecast`), group = 1, data = dfpred, color = "darkred", size  = 1.2) +
      geom_ribbon(aes(x = anio, ymin = `Lo 95`, ymax = `Hi 95`), data = dfpred, alpha = 0.25) +
    scale_y_continuous(labels = formatear_monto) +
      labs(x = "Año", y = NULL, title = pais, subtitle = "Acá va un subtitulo",
           caption = "Datos provenientes del paquete {tradestatistics}.")
    
    if(input$log){                    #<<
      plt <- plt + scale_y_log10()    #<<
    }
    
    ggplotly(plt)
    
  })
  
}

shinyApp(ui = ui, server = server)

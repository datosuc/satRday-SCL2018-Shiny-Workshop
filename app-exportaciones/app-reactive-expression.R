library(shiny)
library(forecast)
library(xts)
library(tradestatistics)
library(ggplot2)
library(scales)
library(plotly)
library(shinythemes)

formatear_monto <- function(monto){
    
    paste("$", comma(monto/1e6, accuracy = .01), "MM")
    
}


lista_paises <- setNames(
  ots_countries$country_iso,
  ots_countries$country_name_english
)


ui <- fluidPage(
    theme = shinytheme("cyborg"), 
    titlePanel("Ahora si que sí"),
    sidebarLayout(
        sidebarPanel(
            selectInput(
                "pais",
                "Seleccionar un país:",
                choices = lista_paises,
                selected = "chl"
                ),
            checkboxInput("log", label = "Escala en log")
        ),
        mainPanel(
          plotlyOutput("grafico"),
          tableOutput("tabla")
        )
    )
)


server <- function(input, output) {
  
    dataExport <- reactive({
      
      pais <- input$pais
      
      data <- ots_create_tidy_data(years = 1990:2018, reporters = pais, table = "yr")
      
      data
      
    })
    
    output$tabla <- renderTable({ dataExport()  })

    output$grafico <- renderPlotly({
        
        data <- dataExport()
        
        valores <- data$export_value_usd
        fechas <- as.Date(paste0(data$year, "0101"), format = "%Y%m%d",)
        serie <- xts(valores, order.by = fechas) 
        prediccion <- forecast(serie, h = 5) 
        
        dfpred <- as.data.frame(prediccion)
        dfpred <- dfpred %>% 
          mutate(anio = 2018 + 1:5)
        
        plt <- ggplot(data) +
          geom_line(aes(x = year, y = export_value_usd)) +
          geom_line(aes(x = anio, y = `Point Forecast`), data = dfpred, color = "darkred", size  = 1.2) +
          geom_ribbon(
            aes(x = anio, ymin = `Lo 95`, ymax = `Hi 95`),
            data = dfpred, 
            alpha = 0.25
            ) +
            scale_y_continuous(labels = formatear_monto) +
            labs(
                x = "Año",
                y = NULL,
                subtitle = "Acá va un subtitulo",
                caption = "Datos provenientes del paquete {tradestatistics}."
            )
        
        if(input$log){
          plt <- plt + scale_y_log10(labels = formatear_monto)
        }
        
        ggplotly(plt)
      
    })
    
}


shinyApp(ui = ui, server = server)

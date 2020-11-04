library(shiny)
library(tidyverse)
library(forecast)
library(xts)
library(tradestatistics)
library(highcharter)
library(shinythemes)
library(memoise)
library(DT)

ots_create_tidy_data2 <- memoise(ots_create_tidy_data)

formatear_monto <- function(monto){
    
    paste("$", comma(monto/1e6, accuracy = .01), "MM")
    
}

lista_paises <- setNames(
  ots_countries$country_iso,
  ots_countries$country_name_english
)


ui <- fluidPage(
    theme = shinytheme("paper"), 
    titlePanel("¿Qué más podemos hacer?"),
    fluidRow(
      class = "well",
      column(
        width = 4,
        selectInput("pais", NULL, choices = lista_paises, selected = "chl", width = "100%")
      ),
      column(
        width = 2,
        checkboxInput("log", label = "Escala en log")
      )
    ),
    fluidRow(
      column(width = 8, highchartOutput("grafico", height = 600)),
      column(width = 4, dataTableOutput("tabla", height = 600))
    )
)


server <- function(input, output) {
  
    dataExport <- reactive({
      
      pais <- input$pais
      
      data <- ots_create_tidy_data2(years = 1990:2018, reporters = pais, table = "yr")
      
      data <- as_tibble(data)
      
      data <- data %>% 
        mutate(export_value_usd = export_value_usd/1e6)
      
      data
      
    })
    
    output$tabla <- renderDataTable({
      data <- dataExport()  
      
      data %>% 
        select(Año = year, Exportaciones = export_value_usd) %>% 
        datatable(rownames = NULL, options = list(dom = 't')) %>% 
        formatCurrency(2, '$ USD ')
    })

    output$grafico <- renderHighchart({
        
        data <- dataExport()
        
        valores <- data$export_value_usd
        fechas <- as.Date(paste0(data$year, "0101"), format = "%Y%m%d",)
        serie <- xts(valores, order.by = fechas) 
        prediccion <- forecast(serie, h = 5) 
        
        dfpred <- as.data.frame(prediccion)
        dfpred <- dfpred %>% 
          mutate(anio = 2018 + 1:5) 
        
        taxis <- ifelse(input$log, "logarithmic", "linear")
        
        hchart(data, "line", hcaes(x = year, y = export_value_usd), name = names(which(lista_paises == input$pais))) %>% 
          hc_add_series(
            data = dfpred,
            type = "line",
            hcaes(x = anio, y = `Point Forecast`), 
            showInLegend = TRUE,
            name = "Forecast"
          ) %>% 
          hc_add_series(
            data = dfpred,
            type = "arearange",
            hcaes(x = anio, low = `Lo 95`, high = `Hi 95`),
            linkedTo = ":previous",
            name = "Intervalo de confianza al 95%",
            color = hex_to_rgba("gray", .05),
            zIndex = -1
          ) %>% 
          hc_yAxis(type = taxis, title = list(text = "Exportaciones (MM)"), min = 0) %>% 
          hc_add_theme(hc_theme_smpl()) %>% 
          hc_tooltip(valueDecimals = 2, valueSuffix = " Millones", shared = TRUE)
        
    })
    
}


shinyApp(ui = ui, server = server)

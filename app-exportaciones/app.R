library(shiny)
library(forecast)
library(xts)
library(tradestatistics)
library(ggplot2)
library(scales)

formatear_monto <- function(monto){
    
    paste("$", comma(monto/1e6, accuracy = .01), "MM")
    
}

ui <- fluidPage(
    sidebarLayout(
        sidebarPanel(
            selectInput("pais", "Seleccionar un país:", choices = c("chn", "chl", "arg"))
        ),
        mainPanel(
            plotOutput("grafico")
        )
    )
)


server <- function(input, output) {

    output$grafico <- renderPlot({
        
        # plot(1:10, main = input$pais)

        pais <- input$pais
        # pais <- "chl"        
        
        data <- ots_create_tidy_data(years = 1990:2018, reporters = pais, table = "yr")
        
        valores <- data$export_value_usd
        fechas <- as.Date(paste0(data$year, "0101"), format = "%Y%m%d",)
        
        serie <- xts(valores, order.by = fechas) 
        
        prediccion <- forecast(serie, h = 5) 
        
        plt <- autoplot(prediccion) 
           
        plt +
            scale_y_continuous(labels = formatear_monto) +
            labs(
                x = "Año",
                y = NULL,
                title = pais,
                subtitle = "Acá va un subtitulo",
                caption = "Datos provenientes del paquete {tradestatistics}."
            )
      
    })
}


shinyApp(ui = ui, server = server)

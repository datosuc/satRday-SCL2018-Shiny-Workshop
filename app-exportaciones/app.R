library(shiny)

ui <- fluidPage(
    sidebarLayout(
        sidebarPanel(
            selectInput("pais", "Seleccionar un país:", choices = c("chn", "chi", "arg"))
        ),
        mainPanel(
            plotOutput("grafico")
        )
    )
)


server <- function(input, output) {

    output$grafico <- renderPlot({
        
        plot(1:10, main = input$pais)
      
    })
}


shinyApp(ui = ui, server = server)

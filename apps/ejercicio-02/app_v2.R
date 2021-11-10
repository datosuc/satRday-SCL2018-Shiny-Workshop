library(shiny)

ui <- fluidPage(
    titlePanel("Mi super calculadora 3mil"),
    sidebarLayout( 
        sidebarPanel(
            sliderInput("numero1", "Numero 1:", min = 1, max = 50, value = 30),
            numericInput("numero2", "Ingrese el siguiente número:", value = 0)
        ),
        mainPanel(
            textOutput("salida1"),
            textOutput("salida2"),
            textOutput("salida3")
        )
    )
)

server <- function(input, output) {
    
    output$salida1 <- renderText({
        message("por aquí")
        v <- input$numero1
        v
    })
    
    output$salida2 <- renderText({
        message("por acá")
        b <- input$numero2
        b
    })
    
    output$salida3 <- renderText({
        message("acullá")
        n1 <- input$numero1
        n2 <- input$numero2
        suma <- n1 + as.numeric(n2)
        suma
    })
    
}

shinyApp(ui = ui, server = server)

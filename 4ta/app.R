library(shiny)

ui <- fluidPage(
    sidebarLayout(
        sidebarPanel(
            sliderInput("n1", "Número 1", value = 2, min = 1, max = 10),
            numericInput("n2", "Número 2", value = 3)
        ),
        mainPanel(
            "Primer numero elegido: ", textOutput("salida1", inline = TRUE),
            "Segundo numero elegido: ", textOutput("salida2", inline = TRUE),
           textOutput("salida3")
        )
    )
)

server <- function(input, output) {

   output$salida1 <- renderText({
       input$n1
    })
   
   output$salida2 <- renderText({
       input$n2
   })
   
   output$salida3 <- renderText({
       x <- "Suma de los dos numeros: "
       y <- input$n1 + as.numeric(input$n2)
       paste(x, y)
   })
   
}

shinyApp(ui = ui, server = server)

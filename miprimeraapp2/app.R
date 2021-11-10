library(shiny)

ui <- fluidPage(
    titlePanel("Old Faithful Geyser Data"),
    sidebarLayout(
        sidebarPanel(
            sliderInput("numero1", "Número uno:", min = 1, max = 50, value = 30),
            numericInput("numero2", label = "Numero dos:", value = 23)
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
    input$numero1
  })
  
  output$salida2 <- renderText({
    
    if(is.na(input$numero2)) {
      
      s <- "algo anda mal (n2)"  
      
    } else {
      
      s <- input$numero2
    }
    
    s
    
    
  })
  
  output$salida3 <- renderText({
    
    if(is.na(input$numero2)) {
     
      s <- "algo anda mal"  
    
    } else {
      
      s <- input$numero1 + input$numero2
    }
    
    s
    
  })
  
}

shinyApp(ui = ui, server = server)

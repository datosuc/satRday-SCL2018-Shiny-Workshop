library(shiny)


ui <- fluidPage(
    sidebarLayout(
        sidebarPanel(
          sliderInput ("slider", NULL, min = 0, max = 10, value = 2),
          textInput("text", NULL)
        ),
        mainPanel(
          textOutput("out1"),
          textOutput("out2"),
          textOutput("out3")
        )
    )
)


server <- function(input, output) {

    output$out1 <- renderText({ input$slider })
    
    output$out2 <- renderText({ input$text })
    
    output$out3 <- renderText({ input$slider + as.numeric(input$text) })
    
}


shinyApp(ui = ui, server = server)

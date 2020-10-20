library(shiny)

ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      sliderInput("nrand", "Simulaciones", min = 50, max = 100, value = 70),
      selectInput("col", "Color", c("red", "blue", "black")),
      checkboxInput("punto", "Puntos:", value = FALSE)
    ),
    mainPanel(
      plotOutput("outplot"),
      verbatimTextOutput("salida")
      )
)
)

server <- function(input, output) {
  
  output$outplot <- renderPlot({
    set.seed(123)
    message("estoy por aquí!")
    x <- rnorm(input$nrand)
    t <- ifelse(input$punto, "b", "l")
    plot(x, type = t, col = input$col)
  })
  
  output$salida <- renderPrint({
    set.seed(123)
    x <- rnorm(input$nrand)
    message("estoy por acá!")
    summary(x)
  })

  
  
}

shinyApp(ui, server)